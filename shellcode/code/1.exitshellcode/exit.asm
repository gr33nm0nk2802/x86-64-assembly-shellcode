; Author: d4rk-c1ph3r
; Exit Shellcode

; assemble: nasm -f elf32 exit.asm -o exit.o
; linking:  ld -m elf_i386 exit.o -o exit


section .text
global _start
_start:
	
	xor eax,eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x5
	int 0x80
