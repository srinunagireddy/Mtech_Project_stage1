#ifndef RING_H
#define RING_H

#include "common.h"

typedef struct ring64_s {
    uint64_t *buffer;
    size_t capacity;
    size_t head;
    size_t tail;
    size_t count;
    pthread_mutex_t mutex;
    pthread_cond_t not_empty;
    pthread_cond_t not_full;
} ring64_t;

bool ring64_init(ring64_t *ring, size_t capacity);
void ring64_destroy(ring64_t *ring);
bool ring64_push(ring64_t *ring, uint64_t value);
bool ring64_pop(ring64_t *ring, uint64_t *out_value);
bool ring64_try_pop(ring64_t *ring, uint64_t *out_value);

#endif // RING_H

