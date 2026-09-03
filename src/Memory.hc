#include "Log.hc"
#include "Common.hc"

#define CONTEXT "memory"

#define MEMORY_SIZE            65536
#define STACK_START_ADDRESS    65436

class Memory {
    U8 data[MEMORY_SIZE];
};

U0 Memory_Init(Memory *memory) {
    MemSet(&memory->data, 0, MEMORY_SIZE);
    LogInfo("Memory initialized. Set all %d bytes to 0\n", MEMORY_SIZE);
}

private U0 Memory_ValidateParams(Memory *memory, U16 address) {
    if (!memory) {
        throw("Memory pointer is NULL");
    }

    if (address >= STACK_START_ADDRESS) {
        throw("Address 0x%04X is invalid as it's trying to write in a stack memory protected area", address);
    }
}

U0 Memory_Write(Memory *memory, U16 address, U8 value) {
    try {
        Memory_ValidateParams(memory, address);
      
        memory->data[address] = value;

        LogInfo("Wrote value %d at memory address 0x%04X", value, address);
    } catch {
        Common_ThrowError(CONTEXT);
    }
}

U0 Memory_Read(Memory *memory, U16 address, U8 *out) {
    try {
        Memory_ValidateParams(memory, address);

        *out = memory->data[address];

        LogInfo("Fetched value %d from memory address 0x%04X", *out, address);
    } catch {
        Common_ThrowError(CONTEXT);
    }
}

