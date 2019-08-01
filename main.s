.equ _SYS_EX, 93

.global _start

.include "mergesort.s"

.section .rodata
    size: .byte 8               # set this accordingly to testArray size
.section .data
    testArray: .byte  12, 8, 9, 7, 20, 18, 9, 1

_start:
    la a1, testArray            # load testArray in a0
    li a2, 0
    lbu a3, size
    addi a3, a3, -1

    jal ra, mergesort

    li a7, _SYS_EX
    ecall
    
        