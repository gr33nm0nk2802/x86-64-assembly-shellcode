// To compile use gcc -fno-stack-protector -z executable shellcode.c -o shellcode
#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"SHELLCODE";


main()
{
	printf("Shellcode length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}