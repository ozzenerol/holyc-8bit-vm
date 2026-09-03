#include "Log.hc"
#include "Memory.hc"
#include "Processor.hc"

U0 Main() {
    LogInfo("Hello from 8 Bit Virtual machine made in Holy C!");

    Memory *memory = MAlloc(sizeof(Memory));
    if (!memory) {
        LogError("Error while allocating space for Memory *memory");
        return;
    }

    Memory_Init(memory);

    Processor *processor = MAlloc(sizeof(Processor));
    if (!processor) {
        LogError("Error while allocating space for Processor *processor");
        return;
    }

    Processor_Init(processor);
    
    /* Temporary. It will be set to true before executing a program */
    processor->running = TRUE;

    U8 out;
    Processor_Fetch(processor, memory, &out);
}
