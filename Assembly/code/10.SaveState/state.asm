; Author: d4rk-c1pher
; A program to demonstrate the state being saved onto the stack

; compile:  nasm -f elf32 state.asm -o state.o
; linking:  ld -m elf_i386 state.o -o state


	section .text
	global _start
	

helloworldproc:

	;function prolouge
	push ebp
	mov ebp, esp

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, msglen
	int 0x80

	; function epilouge
	leave
	ret


_start:

	mov ecx, 0x10

printmsg:
	
	; preserve registers and flags
	pushad
	pushfd

	call helloworldproc

	; restore the registers and flags
	popfd
	popad

	loop printmsg

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	section .data
msg:     db   "Hello duniya",0xa
msglen:  equ  $-msg