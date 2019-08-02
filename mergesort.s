# MERGESORT(*testArray, first, last)
# testArray in a1
# first in a2
# last in a3
.section .text
mergesort:
   bge a2, a3, mergesort_end

   # stack management
   addi sp, sp, -32
   sd ra, 0(sp)         # space for return address
   sd s2, 8(sp)         # first will be in s2
   sd s3, 16(sp)        # last will be in s3
   sd s4, 24(sp)        # k will be in s4

   # first and last copy
   mv s2, a2            # s2 = a2
   mv s3, a3            # s3 = a3

   # calculating k
   add t0, s2, s3       # t0 = s2 + s3
   srli t0, t0, 1
   mv s4, t0

   # Mergesort(*testarray, first, k)
   mv a3, s4            # k in a3
   jal ra, mergesort

   # Mergesort(*testarray, k + 1, last)
   mv a2, s4            # k + 1 in a2
   mv a3, s3            # last in a3
   jal ra, mergesort

   # Merge(*testArray, first, k, last)
   mv a2, s2            # first in a2
   mv a3, s4            # k in a3
   mv a4, s3            # last in a4
   jal ra, merge

   # load stuff back from the stack
   ld ra, 0(sp)
   ld s2, 8(sp)
   ld s3, 16(sp)
   ld 4, 24(sp)
   addi sp, sp, 32

mergesort_end:
   ret

# Merge(*testArray, first, k, last)
# *testArray in a1
# first in a2
# k in a3
# last in a4
merge:
   # n1 in t0
   # n1 = k - first + 1
   sub t0, a3, a2          # t0 = a3 - a2
   addi t0, t0, 1

   # n2 in t1
   # n2 = last - k
   sub t1, a4, a3

   li t3, 0
   addi t0, t0, -1
   merge_first_loop:
      