.equ _SYS_EX, 93

.global _start

.include "mergesort.s"

.section .rodata
    size: .byte 5               # set this accordingly to testArray size
.section .data
    testArray: .byte  5, 3, 8, 2,  20#, 18, 9, 1


.section .text
_start:
    la a0, testArray            # Load testArray address  in a0
    lb t0, size                 # Load the array lenght
    #slli t0, t0, 3              # Array Lenght * 8 (the size of the elements) 
    add a1, a0, t0              # Calculate the last array element address
    jal ra, mergesort           # Call mergesort

    li a7, _SYS_EX              
    ecall
    
          