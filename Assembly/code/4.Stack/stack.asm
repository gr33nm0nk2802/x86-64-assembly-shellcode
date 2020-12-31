; Author: d4rk-c1ph3r
; A program to demonstrate the Working of a stack
; The function prolouge and function epilouge also the use of  procedures

; Assembling: nasm -f elf32 -o stack.o stack.asm
; linking:    ld -m elf_i386 -o stack stack.o

	section .data
msg1:    db "This is the outer function",0xa
msg1len: equ $-msg1
msg2:    db "This is inner function",0xa
msg2len: equ $-msg2

	section .text
	global _start
_start:
	; outer function
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg1
	mov edx, msg1len
	int 0x80

	call fun
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

fun:
	; function prolouge
	push ebp
	mov ebp, esp
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg2
	mov edx, msg2len
	int 0x80
	leave
	ret
