.equ _SYS_EX, 93

.global _start

.include "mergesort.s"

.section .rodata
    size: .byte 7               # set this accordingly to testArray size
.section .data
    #testArray: .byte  5, 3, 8, 2,  20
    #testArray: .byte 1
    testArray: .byte 10, 9, 8, 7, 6, 5, 4 


.section .text
_start:
    la a0, testArray            # Load testArray address  in a0
    lb t0, size                 # Load the array lenght
    add a1, a0, t0              # Calculate the last array element address
    jal ra, mergesort           # Call mergesort

    li a7, _SYS_EX              
    ecall
    
          