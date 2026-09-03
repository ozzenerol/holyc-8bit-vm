fun main 0x0000:
    MOVI    R0, #5
    MOVI    R1, #1
    CALL    ADD_SUB         ; push return addr, jump to subroutine
    CLR     R0
    STORE   0x0010, R1
    JMP     HALT

fun ADD_SUB:
    ADD     R1, R0
    RET                     ; pop return addr, jump back

fun LOOP:
    JMP     HALT            ; spin forever
