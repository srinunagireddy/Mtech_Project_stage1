#include "common.h"
#include "ring.h"
#include "protocol.h"

typedef struct user_thread_args_s {
    uint8_t user_id;
    size_t messages_to_send;
    ring64_t *user_to_daemon_ring;
} user_thread_args_t;

typedef struct daemon_args_s {
    ring64_t *user_to_daemon_rings; // array of 4 rings
    size_t ring_stride;             // sizeof(ring64_t)
    size_t num_users;
    size_t total_messages;
    ring64_t *daemon_to_ic_ring;
} daemon_args_t;

typedef struct interconnect_args_s {
    ring64_t *daemon_to_ic_ring;
    uint16_t *memory_array;
    size_t memory_size;
} interconnect_args_t;

static void *user_thread_fn(void *arg)
{
    user_thread_args_t *args = (user_thread_args_t *)arg;
    unsigned int seed = (unsigned int)time(NULL) ^ ((unsigned int)args->user_id * 0x9E3779B9u);
    for (size_t i = 0; i < args->messages_to_send; ++i) {
        bool is_write = true; // write only for simplicity
        uint32_t address = (uint32_t)(rand_r(&seed));
        uint32_t payload = (uint32_t)(rand_r(&seed) & 0x1FFFFFFFu);
        uint64_t msg64 = user64_pack(args->user_id, is_write, address, payload);
        ring64_push(args->user_to_daemon_ring, msg64);
        if (VERBOSE_LOG) {
            printf("USER%u -> 0x%016llx\n", args->user_id, (unsigned long long)msg64);
        }
    }
    return NULL;
}

static void *daemon_thread_fn(void *arg)
{
    daemon_args_t *args = (daemon_args_t *)arg;
    size_t consumed = 0;
    size_t idx = 0;
    while (consumed < args->total_messages) {
        bool got = false;
        for (size_t n = 0; n < args->num_users; ++n) {
            size_t k = (idx + n) % args->num_users;
            ring64_t *ring = (ring64_t *)((uint8_t *)args->user_to_daemon_rings + k * args->ring_stride);
            uint64_t word64 = 0;
            if (ring64_try_pop(ring, &word64)) {
                uint8_t user_id; bool is_write; uint32_t address; uint32_t payload29;
                user64_unpack(word64, &user_id, &is_write, &address, &payload29);
                bus49_fields_t f;
                f.user_id = user_id;
                f.is_write = is_write;
                f.address = address;
                f.data14 = (uint16_t)(payload29 & 0x3FFFu);
                uint64_t word49 = bus49_pack(f);
                ring64_push(args->daemon_to_ic_ring, word49);
                if (VERBOSE_LOG) {
                    printf("DAEMON: 64->49 uid=%u op=%c addr=0x%08x data=0x%04x\n",
                           f.user_id, f.is_write ? 'W' : 'R', f.address, f.data14);
                }
                consumed++;
                idx = (k + 1) % args->num_users;
                got = true;
                break;
            }
        }
        if (!got) {
            sleep_for_us(100);
        }
    }
    // send sentinel to interconnect and exit
    ring64_push(args->daemon_to_ic_ring, BUS49_SENTINEL);
    return NULL;
}

static void *interconnect_thread_fn(void *arg)
{
    interconnect_args_t *args = (interconnect_args_t *)arg;
    for (;;) {
        uint64_t word49 = 0;
        ring64_pop(args->daemon_to_ic_ring, &word49);
        if ((word49 & BUS49_MASK) == BUS49_SENTINEL) {
            if (VERBOSE_LOG) {
                printf("IC: received sentinel, exiting.\n");
            }
            break;
        }
        bus49_fields_t f = bus49_unpack(word49);
        size_t addr_index = (size_t)f.address % args->memory_size;
        if (f.is_write) {
            args->memory_array[addr_index] = (uint16_t)(f.data14 & 0x3FFFu);
        } else {
            volatile uint16_t readback = args->memory_array[addr_index];
            (void)readback;
        }
        if (VERBOSE_LOG) {
            printf("IC: %c A[%zu]=0x%04x\n", f.is_write ? 'W' : 'R', addr_index, (unsigned)args->memory_array[addr_index]);
        }
    }
    return NULL;
}

int main(int argc, char **argv)
{
    size_t messages_per_user = 1000;
    if (argc > 1) {
        long v = strtol(argv[1], NULL, 10);
        if (v > 0) messages_per_user = (size_t)v;
    }

    const size_t num_users = 4;
    const size_t memory_size = 1u << 16; // 64K entries of 14-bit data (stored in 16 bits)

    // Allocate memory model
    uint16_t *memory_array = (uint16_t *)calloc(memory_size, sizeof(uint16_t));
    if (!memory_array) {
        fprintf(stderr, "Failed to allocate memory model\n");
        return 1;
    }

    // Create rings: 4 user->daemon rings and 1 daemon->ic ring
    ring64_t user_to_daemon[4];
    ring64_t daemon_to_ic;
    const size_t ring_capacity = 1024;
    for (size_t i = 0; i < num_users; ++i) {
        if (!ring64_init(&user_to_daemon[i], ring_capacity)) {
            fprintf(stderr, "Failed to init ring %zu\n", i);
            return 1;
        }
    }
    if (!ring64_init(&daemon_to_ic, ring_capacity * 4)) {
        fprintf(stderr, "Failed to init daemon_to_ic ring\n");
        return 1;
    }

    // Spawn interconnect thread
    pthread_t ic_thread;
    interconnect_args_t ic_args = {
        .daemon_to_ic_ring = &daemon_to_ic,
        .memory_array = memory_array,
        .memory_size = memory_size,
    };
    pthread_create(&ic_thread, NULL, interconnect_thread_fn, &ic_args);

    // Spawn daemon thread
    pthread_t daemon_thread;
    daemon_args_t d_args = {
        .user_to_daemon_rings = &user_to_daemon[0],
        .ring_stride = sizeof(ring64_t),
        .num_users = num_users,
        .total_messages = messages_per_user * num_users,
        .daemon_to_ic_ring = &daemon_to_ic,
    };
    pthread_create(&daemon_thread, NULL, daemon_thread_fn, &d_args);

    // Spawn user threads
    pthread_t user_threads[4];
    user_thread_args_t u_args[4];
    for (size_t i = 0; i < num_users; ++i) {
        u_args[i].user_id = (uint8_t)i;
        u_args[i].messages_to_send = messages_per_user;
        u_args[i].user_to_daemon_ring = &user_to_daemon[i];
        pthread_create(&user_threads[i], NULL, user_thread_fn, &u_args[i]);
    }

    // Join users
    for (size_t i = 0; i < num_users; ++i) {
        pthread_join(user_threads[i], NULL);
    }

    // Join daemon and ic
    pthread_join(daemon_thread, NULL);
    pthread_join(ic_thread, NULL);

    // Basic verification: count non-zero memory entries
    size_t nonzero = 0;
    for (size_t i = 0; i < memory_size; ++i) {
        if (memory_array[i] != 0) nonzero++;
    }
    printf("Simulation complete. Non-zero memory entries: %zu\n", nonzero);

    // Cleanup
    for (size_t i = 0; i < num_users; ++i) {
        ring64_destroy(&user_to_daemon[i]);
    }
    ring64_destroy(&daemon_to_ic);
    free(memory_array);
    return 0;
}

