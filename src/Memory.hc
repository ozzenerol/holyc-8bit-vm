#include "Log.hc"
#include "Common.hc"

#define CONTEXT "memory"

#define MEMORY_SIZE             0xFFFF  // 64 KiB total

#define SUBROUTINE_SPACE_START  0x0000  // 0th  KiB
#define SUBROUTINE_SPACE_END    0x9FFF  // 40th Kib

#define MAIN_SPACE_START        0xA400  // 41th KiB
#define MAIN_SPACE_END          0xEFFF  // 60th KiB

#define STACK_SPACE_START       0xF400  // 61th KiB
#define STACK_SPACE_END         0xFFFF  // 64th KiB

class Memory {
    U8 data[MEMORY_SIZE];
};

U0 Memory_Init(Memory *memory) {
    MemSet(&memory->data, 0, MEMORY_SIZE);
    LogDebug("Memory initialized. Set all %d bytes to 0\n", MEMORY_SIZE);
}

U0 Memory_Write(Memory *memory, U16 address, U8 value) {
    try {
        memory->data[address] = value;
        LogDebug("Wrote value %d at memory address 0x%04X", value, address);
    } catch {
        Common_ThrowError(CONTEXT);
    }
}

U0 Memory_Read(Memory *memory, U16 address, U8 *out) {
    try {
        *out = memory->data[address];
        LogDebug("Fetched value %d from memory address 0x%04X", *out, address);
    } catch {
        Common_ThrowError(CONTEXT);
    }
}

