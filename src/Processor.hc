#include "Log.hc"
#include "Memory.hc"
#include "Common.hc"

#define CONTEXT "processor"

#define REGISTERS_SIZE 8

class Processor {
    U8 R[REGISTERS_SIZE];
    U16 PC;
    U16 SP;
    Bool running;
};

private U0 Executor_Parse(Processor *processor, Memory *memory);

U0 Processor_Init(Processor *processor) {
    MemSet(&processor->R, 0, REGISTERS_SIZE);
    LogDebug("Processor registers set to 0 [R0-R%d]", REGISTERS_SIZE - 1);
    
    processor->PC = 0;
    LogDebug("Processor PC set to 0");

    processor->SP = STACK_SPACE_START;
    LogDebug("Processor SP set to address 0x%04X", processor->SP);

    processor->running = FALSE;
    
    LogDebug("Processor initialized successfully");
}

U0 Processor_Exec(Processor *processor, Memory *memory) {
    try {
        Executor_Parse(processor, memory); 
    } catch {
        Common_ThrowError(CONTEXT);
    }
}
