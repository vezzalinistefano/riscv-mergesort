.section .bss
   L: .byte
   R: .byte

.section .text
##
# MERGESORT(*testArray, first, last)
# param a0 -> first element address
# param a1 -> last element address
## 
mergesort:

   # Stack management
   addi sp, sp, -32              # Adjust stack pointer
   sd ra, 0(sp)                  # Load return address
   sd a0, 8(sp)                  # Load first element address
   sd a1, 16(sp)                 # Load last element address

   
   # Base case
   li t1, 8                      # Size of one element
   sub t0, a1, a0                # Calculate number of elements * 8
   ble t0, t1, mergesort_end     # If only one element remains in the array, return

   srli  t0, t0, 1               # Divide array size to get half of the element
   add a1, a0, t0                # Calculate array midpoint address
   sd a1, 24(sp)                 # Store it on the stack

   jal mergesort             # Recursive call on first half of the array

   ld a0, 24(sp)                 # Load midpoint back from the stack
   ld a1, 16(sp)                 # Load last element address back from the stack

   jal mergesort             # Recursive call on second half of the array

   ld a0, 8(sp)                  # Load first element address back from the stack
   ld a1, 24(sp)                 # Load midpoint address back form the stack
   ld a2, 16(sp)                 # Load last element address back from the stack

   jal merge                 # Merge two sorted sub-arrays

mergesort_end:
   ld ra, 0(sp)
   addi sp, sp, 32
   ret

##
# Merge(*testArray, first, midpoint, last)
# param a0 -> first address of first array   
# param a1 -> first address of second array
# param a2 -> last address of second array
##
merge:

   # Stack management
   addi sp, sp, -32              # Adjust stack pointer
   sd ra, 0(sp)                  # Load return address
   sd a0, 8(sp)                  # Load first element address
   sd a1, 16(sp)                 # Load last element address
   sd a2, 24(sp)                 # Load midpoint element address

   mv s0, a0                     # First half address copy 
   mv s1, a1                     # Second half address copy

   merge_loop:

      mv t0, s0               # Load first half position address
      mv t1, s1               # Load second half position address
      lb t0, 0(t0)               # Load first half position value
      lb t1, 0(t1)               # Load second half position value   

      bgt t1, t0, shift_skip     # If lower value is first, no need to perform operations

      mv a0, s1                  # a0 -> element to move
      mv a1, s0                  # a1 -> address to move it to
      jal shift                  # jump to shift 
      
      shift_skip: 

            addi s0, s0, 8          # Increment first half index and point to the next element
            lb a2, 24(sp)           # Load back last element address

            bge s0, a2, merge_loop_end
            bge s1, a2, merge_loop_end
            ret

      ##
      # Shift array element to a lower address
      # param a0 -> address of element to shift
      # param a1 -> address of where to move a0
      ##
      shift:

         ble a0, a1, shift_end      # Location reached, stop shifting
         addi t3, a0, -8            # Go to the previous element in the array
         ld t4, 0(a0)               # Load current position pointer
         ld t5, 0(t3)               # Load previous position pointer
         sd t4, 0(t3)               # Save current pointer to previous address
         mv a0, t6 
         j shift

      shift_end:

         ret

   merge_loop_end:

      ld ra, 0(sp)
      addi sp, sp, 32
      ret
