#include "ring.h"

bool ring64_init(ring64_t *ring, size_t capacity)
{
    if (capacity == 0) {
        return false;
    }
    ring->buffer = (uint64_t *)calloc(capacity, sizeof(uint64_t));
    if (!ring->buffer) {
        return false;
    }
    ring->capacity = capacity;
    ring->head = 0;
    ring->tail = 0;
    ring->count = 0;
    pthread_mutex_init(&ring->mutex, NULL);
    pthread_cond_init(&ring->not_empty, NULL);
    pthread_cond_init(&ring->not_full, NULL);
    return true;
}

void ring64_destroy(ring64_t *ring)
{
    if (!ring) return;
    pthread_mutex_destroy(&ring->mutex);
    pthread_cond_destroy(&ring->not_empty);
    pthread_cond_destroy(&ring->not_full);
    free(ring->buffer);
    ring->buffer = NULL;
    ring->capacity = ring->head = ring->tail = ring->count = 0;
}

bool ring64_push(ring64_t *ring, uint64_t value)
{
    pthread_mutex_lock(&ring->mutex);
    while (ring->count == ring->capacity) {
        pthread_cond_wait(&ring->not_full, &ring->mutex);
    }
    ring->buffer[ring->head] = value;
    ring->head = (ring->head + 1) % ring->capacity;
    ring->count++;
    pthread_cond_signal(&ring->not_empty);
    pthread_mutex_unlock(&ring->mutex);
    return true;
}

bool ring64_pop(ring64_t *ring, uint64_t *out_value)
{
    pthread_mutex_lock(&ring->mutex);
    while (ring->count == 0) {
        pthread_cond_wait(&ring->not_empty, &ring->mutex);
    }
    *out_value = ring->buffer[ring->tail];
    ring->tail = (ring->tail + 1) % ring->capacity;
    ring->count--;
    pthread_cond_signal(&ring->not_full);
    pthread_mutex_unlock(&ring->mutex);
    return true;
}

bool ring64_try_pop(ring64_t *ring, uint64_t *out_value)
{
    bool success = false;
    pthread_mutex_lock(&ring->mutex);
    if (ring->count > 0) {
        *out_value = ring->buffer[ring->tail];
        ring->tail = (ring->tail + 1) % ring->capacity;
        ring->count--;
        pthread_cond_signal(&ring->not_full);
        success = true;
    }
    pthread_mutex_unlock(&ring->mutex);
    return success;
}

