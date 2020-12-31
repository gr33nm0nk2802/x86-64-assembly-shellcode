; Author: d4rk-c1ph3r
; A program to illustrate the use of libc library

; Assembling: nasm -f elf32 -o libcnasm.o libcnasm.asm
; linking:    gcc -m32 -no-pie -o libcnasm libcnasm.o

; All the libc functions to be used must be defined with extern command
extern printf
extern exit

	global main
	section .text
main:
	
	push message
	call printf
	add esp,0x4		; increment the stack pointer 

	mov eax, 0x0
	call exit

	section .data
message: db  "Hello World", 0xa
msglen:  equ $-message
