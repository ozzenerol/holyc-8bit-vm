SUB SET_LOC:
    ADD_SUB  0x0050
    LOOP     0x0100
    JMP      MAIN   

SUB MAIN:
    MOVI    R0, #5
    MOVI    R1, #1
    CALL    ADD_SUB         ; push return addr, jump to subroutine
    CLR     R0
    STORE   0x0010, R1
    JMP     LOOP

SUB ADD_SUB:
    ADD     R1, R0
    RET                     ; pop return addr, jump back

SUB LOOP:
    JMP     MAIN            ; spin forever
