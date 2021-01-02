; Author: d4rk-c1ph3r
; A program to demonstrate printing of message using jump call pop technique

	section .text
	global _start

_start:
	
	jmp messageProcedure

printExit:
	xor eax, eax
	mov al, 0x4
	xor ebx, ebx
	mov bl, 0x1
	pop ecx
	xor edx, edx
	mov dl, 0x15
	int 0x80

	; gracefull exit
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x13
	int 0x80

messageProcedure:
	call printExit
	message: db "Hello Hackers!", 0xA
	mlen: equ $-message
