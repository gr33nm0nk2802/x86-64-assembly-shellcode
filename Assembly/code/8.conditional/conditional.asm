; Author: d4rk-c1ph3r
; A program to illustrate the various conditional and unconditional jumps

; Assembling: nasm -f elf32 -o conditional.o conditional.asm
; linking:    ld -m elf_i386 -o conditional conditional.o

	section .data
	global _start
_start:
	jmp bottom

alone:
	mov eax, 0x10

bottom:
	mov eax, 0x20

loop:
	push eax
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, msglen
	int 0x80
	pop eax
	dec eax
	jnz loop

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80



	section .data
msg:    db  "Hello", 0xa
msglen: equ $-msg