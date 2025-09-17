#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>
#include <time.h>

#ifndef VERBOSE_LOG
#define VERBOSE_LOG 0
#endif

#define ARRAY_LEN(a) (sizeof(a)/sizeof((a)[0]))

// Bus specifics
#define BUS49_WIDTH 49
#define BUS49_MASK ((UINT64_C(1) << BUS49_WIDTH) - UINT64_C(1))
#define BUS49_SENTINEL (BUS49_MASK)

static inline void sleep_for_us(unsigned int microseconds)
{
    struct timespec ts;
    ts.tv_sec = microseconds / 1000000u;
    ts.tv_nsec = (microseconds % 1000000u) * 1000u;
    nanosleep(&ts, NULL);
}

#endif // COMMON_H

