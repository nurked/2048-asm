nasm -f win64 -gcv8 -l test.lst test.asm
gcc -nostdlib test.obj -lkernel32 -o test.exe -ggdb
test
