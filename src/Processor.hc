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

U0 Processor_Init(Processor *processor) {
    MemSet(&processor->R, 0, REGISTERS_SIZE);
    processor->PC = 0;
    processor->SP = STACK_START_ADDRESS;
    processor->running = FALSE;
}
