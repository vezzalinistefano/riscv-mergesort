
riscv64-unknown-elf-as -g -o $1.o $1.s
riscv64-unknown-elf-ld -o $1 $1.o
rm -rf *.o

