// To compile use gcc -fno-stack-protector -z execstack shellcode.c -o shellcode
// This testing must be done on a 32-bit machine
#include<stdio.h>
#include<string.h>

const char code[] ="\x31\xc0\xb0\x01\x31\xdb\xb3\x05\xcd\x80";

void main()
{
	printf("Shellcode length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}
