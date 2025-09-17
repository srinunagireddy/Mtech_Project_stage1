#ifndef PROTOCOL_H
#define PROTOCOL_H

#include "common.h"

// 64-bit user packet fields
// [63:62] user_id (2)
// [61]    op_write (1) 0=read,1=write
// [60:29] address (32)
// [28:0]  payload (29) (only lower 14 used on bus)

typedef struct bus49_fields_s {
    uint8_t user_id;     // 0..3
    bool is_write;       // true for write
    uint32_t address;    // 32-bit address
    uint16_t data14;     // 14-bit payload
} bus49_fields_t;

uint64_t user64_pack(uint8_t user_id, bool is_write, uint32_t address, uint32_t payload29);
void user64_unpack(uint64_t word64, uint8_t *user_id, bool *is_write, uint32_t *address, uint32_t *payload29);

uint64_t bus49_pack(bus49_fields_t f);
bus49_fields_t bus49_unpack(uint64_t word49);

#endif // PROTOCOL_H

