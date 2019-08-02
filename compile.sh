
riscv64-unknown-elf-as -g -o main.o main.s
riscv64-unknown-elf-as -g -o mergesort.o mergesort.s
riscv64-unknown-elf-ld -o mergesort main.o mergesort.o
rm -r *.o
