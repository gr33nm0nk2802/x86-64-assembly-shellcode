; Author: d4rk-c1ph3r
; A program to illustrate the various looping instructions

; Assembling: nasm -f elf32 -o loop.o loop.asm
; linking:    ld -m elf_i386 -o loop loop.o

	section .data
	global _start
_start:

	mov ecx, 10

printmsg:
	push ecx
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, msglen
	int 0x80

	pop ecx
	
	; executes while ecx is not zero. 
	; also automatically decrements ecx
	; we can also use loope loopne loopz loopnz
	; loope  - ecx non-zero and zero flag set
	; loopne - ecx non-zero and zero flag not set.
	; loopz  - ecx decrements and zero flag is set
	; loopnz - ecx decrements and zero flag is not set.

	loop printmsg	

	; exit gracefully
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80



	section .data
msg:    db  "Hello", 0xa
msglen: equ $-msg