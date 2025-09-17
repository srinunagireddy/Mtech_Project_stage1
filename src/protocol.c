#include "protocol.h"

uint64_t user64_pack(uint8_t user_id, bool is_write, uint32_t address, uint32_t payload29)
{
    uint64_t w = 0;
    user_id &= 0x3u;
    payload29 &= 0x1FFFFFFFu; // 29 bits
    w |= ((uint64_t)user_id & 0x3u) << 62;
    w |= ((uint64_t)(is_write ? 1u : 0u) & 0x1u) << 61;
    w |= ((uint64_t)address & 0xFFFFFFFFu) << 29;
    w |= ((uint64_t)payload29 & 0x1FFFFFFFu);
    return w;
}

void user64_unpack(uint64_t word64, uint8_t *user_id, bool *is_write, uint32_t *address, uint32_t *payload29)
{
    if (user_id) {
        *user_id = (uint8_t)((word64 >> 62) & 0x3u);
    }
    if (is_write) {
        *is_write = ((word64 >> 61) & 0x1u) != 0;
    }
    if (address) {
        *address = (uint32_t)((word64 >> 29) & 0xFFFFFFFFu);
    }
    if (payload29) {
        *payload29 = (uint32_t)(word64 & 0x1FFFFFFFu);
    }
}

uint64_t bus49_pack(bus49_fields_t f)
{
    uint64_t w = 0;
    uint64_t uid = (uint64_t)(f.user_id & 0x3u);
    uint64_t op = f.is_write ? 1ull : 0ull;
    uint64_t addr = (uint64_t)f.address & 0xFFFFFFFFull;
    uint64_t data = (uint64_t)f.data14 & 0x3FFFull; // 14 bits
    w |= (uid << 47);
    w |= (op << 46);
    w |= (addr << 14);
    w |= data;
    return (w & BUS49_MASK);
}

bus49_fields_t bus49_unpack(uint64_t word49)
{
    bus49_fields_t f;
    uint64_t w = (word49 & BUS49_MASK);
    f.user_id = (uint8_t)((w >> 47) & 0x3u);
    f.is_write = ((w >> 46) & 0x1u) != 0;
    f.address = (uint32_t)((w >> 14) & 0xFFFFFFFFu);
    f.data14 = (uint16_t)(w & 0x3FFFu);
    return f;
}

