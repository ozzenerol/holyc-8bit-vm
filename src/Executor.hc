#include "Log.hc"
#include "Memory.hc"
#include "Processor.hc"

#define CONTEXT "executor"

#define OP_MOVI     1   
#define OP_ADD      2   
#define OP_SUB      3
#define OP_MLP      4
#define OP_DIV      5
#define OP_FREE     6
#define OP_STORE    7
#define OP_LOAD     8
#define OP_JMP      9
#define OP_CALL     10
#define OP_RET      11

StrMap *Executor_BuildMnemonicTable() {
    StrMap *table = StrMapNew();
    StrMapSet(table, "MOVI",  OP_MOVI(U0*));
    StrMapSet(table, "ADD",   OP_ADD(U0*));
    StrMapSet(table, "SUB",   OP_SUB(U0*));
    StrMapSet(table, "MLP",   OP_MLP(U0*));
    StrMapSet(table, "DIV",   OP_DIV(U0*));
    StrMapSet(table, "FREE",  OP_FREE(U0*));
    StrMapSet(table, "STORE", OP_STORE(U0*));
    StrMapSet(table, "LOAD",  OP_LOAD(U0*));
    StrMapSet(table, "JMP",   OP_JMP(U0*));
    StrMapSet(table, "CALL",  OP_CALL(U0*));
    StrMapSet(table, "RET",   OP_RET(U0*));
    return table;
}

U8 Executor_LookupOpcode(StrMap *table, U8 *mnemonic) {
    if (!StrMapHas(table, mnemonic)) {
        throw("Unknown mnemonic '%s'", mnemonic);
    }
    return StrMapGet(table, mnemonic)(U8);
}

#define MATH_ADD    1
#define MATH_SUB    2
#define MATH_MLP    3
#define MATH_DIV    4

private U0 Executor_PerformMath(Processor *processor, Memory *memory, U8 mathOp);
private U0 Executor_PerformMovi(Processor *processor, Memory *memory);
private U0 Executor_PerformFree(Processor *processor, Memory *memory);
private U0 Executor_PerformStore(Processor *processor, Memory *memory);
private U0 Executor_PerformLoad(Processor *processor, Memory *memory);

U0 Executor_Parse(Processor *processor, Memory *memory) {
    if (!processor || !memory) {
        throw("You fucking moronic idiot");
    }

    U8 opcode;

    try {
        Memory_Read(memory, processor->PC++, &opcode);

        switch (opcode) {
            case OP_ADD:
                Executor_PerformMath(processor, memory, MATH_ADD);
                break;
            case OP_SUB:
                Executor_PerformMath(processor, memory, MATH_SUB);
                break;
            case OP_MLP:
                Executor_PerformMath(processor, memory, MATH_MLP);
                break;
            case OP_DIV:
                Executor_PerformMath(processor, memory, MATH_DIV);
                break;
            default:
                throw("Unknown or not yet implemented opcode 0x%02X", opcode);
        }
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

private U0 Executor_PerformMath(Processor *processor, Memory *memory, U8 mathOp) {
    U8 dest, src;

    try {
        Memory_Read(memory, processor->PC++, &dest);
        Memory_Read(memory, processor->PC++, &src);

        switch (mathOp) {
            case MATH_ADD:
                processor->R[dest] += processor->R[src];
                break;
            case MATH_SUB:
                processor->R[dest] -= processor->R[src];
                break;
            case MATH_MLP:
                processor->R[dest] *= processor->R[src];
                break;
            case MATH_DIV:
                processor->R[dest] /= processor->R[src];
                break;
        }
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

private U0 Executor_PerformMovi(Processor *processor, Memory *memory) {
    U8 dest, src;

    try {
        Memory_Read(memory, processor->PC++, &dest);
        Memory_Read(memory, processor->PC++, &src);
        
        processor->R[dest] = src;
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

private U0 Executor_PerformFree(Processor *processor, Memory *memory) {
    U8 param;

    try {
        Memory_Read(memory, processor->PC++, &param);
        
        processor->R[param] = 0;
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

private U0 Executor_PerformStore(Processor *processor, Memory *memory) {
    U8 dest, src;

    try {
        Memory_Read(memory, processor->PC++, &dest);
        Memory_Read(memory, processor->PC++, &src);
        
        memory->data[dest] = processor->R[src];
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

private U0 Executor_PerformLoad(Processor *processor, Memory *memory) {
    U8 dest, src;

    try {
        Memory_Read(memory, processor->PC++, &dest);
        Memory_Read(memory, processor->PC++, &src);

        processor->R[dest] = memory->data[src];
    } catch {
        processor->running = FALSE;
        Common_ThrowError(CONTEXT);
    }
}

