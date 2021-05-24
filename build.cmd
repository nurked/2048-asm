nasm -f win64 -gcv8 -l test.lst test.asm
gcc test.obj -o test.exe -ggdb
test
