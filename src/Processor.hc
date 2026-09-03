#include "Log.hc"
#include "Memory.hc"
#include "Common.hc"
#include "Executor.hc"

#define CONTEXT "processor"

#define REGISTERS_SIZE 16

class Processor {
    U8 R[REGISTERS_SIZE];
    U16 PC;
    U16 SP;
    Bool running;
};

U0 Processor_Init(Processor *processor) {
    MemSet(&processor->R, 0, REGISTERS_SIZE);
    processor->PC = 0;
    processor->SP = STACK_START_ADDRESS;
    processor->running = FALSE;
}

U0 Processor_Fetch(Processor *processor, Memory *memory, U8 *out) {
    if (!processor->running) {
        throw("Processor is not running");
    }

    try {
        Memory_Read(memory, processor->PC, out);
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);    
    }
}

U0 Processor_Exec(Processor *processor, Memory *memory) {
    if (!processor->running) {
        throw("Processor is not running");
    }

    try {
       Executor_Parse(processor, memory); 
    } catch {
        processor->running = FALSE;
        Common_ThrowError(FALSE);
    }
}
