; Author: d4rk-c1ph3r
; A program to demonstrate printing of message using jump call pop technique

	section .text
	global _start

_start:

	xor eax, eax
	mov al, 0x4
	xor ebx, ebx
	mov bl, 0x1
	xor edx, edx
	push edx
	push 0x0a72656b
	push 0x63614820
	push 0x6f6c6c65
	push byte 0x48	
	
	mov ecx, esp	

	mov dl, 17
	int 0x80

	; gracefull exit
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x13
	int 0x80

