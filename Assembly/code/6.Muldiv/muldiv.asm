; Author: d4rk-c1ph3r
; A program to demonstrate unsigned and signed multiplication and 
; signed and unsigned division

; Assembling: nasm -f elf32 -o muldiv.o muldiv.asm
; linking:    ld -m elf_i386 -o muldiv muldiv.o

	section .text
	global _start
_start:

	; unsigned r/m8 multiplication
	mov eax, 0x0
	mov al, 0x20
	mov bl, 0x3
	mul bl

	mov al, 0xff
	mul bl

	; unsigned r/m16 multiplication
	mov eax, 0x0
	mov ebx, 0x0
	mov ax, 0xff99
	mov bx, 0x0003
	mul bx
	
	; unsigned r/m32 multiplication
	mov eax, 0x0
	mov ebx, 0x0
	mov ecx, 0x0
	mov edx, 0x0
	mov eax, 0xffffffff
	mov ebx, 0x3
	mul ebx

	; signed multiplication
	mov eax, 0xffff0001
	mov ebx, 0x2
	imul eax, ebx


	; r/m8 division
	mov al, 0x13    
	mov bl, 0x2
	div bl
	
	; r/m16 division
	mov ax, 0x1123	
	mov bx, 0x2
	div bx		

	; r/m32 division
	mov eax, 0x113333  	
	mov ebx, 0x2
	mov edx, 0x0
	div ebx			
	
	; another EDXEAX / 32-bit
	mov eax, 0x23232323	
	mov ebx, 0x121112	
	mov ecx, 0x0
	mov edx, 0x0
	div ebx		

	; reset registers
	mov eax, 0x0
	mov ebx, 0x0
	mov ecx, 0x0
	mov edx, 0x0
	clc	;clear carry flag

	; signed division
	mov eax, 0xffff0001
	mov ebx, 0x2
	idiv ebx
	
	; reset registers
	mov eax, 0x0
	mov ebx, 0x0
	mov ecx, 0x0
	mov edx, 0x0
	clc	

	; divide signed;  
	mov eax, -26
	mov ebx, 2
	mov edx, -1 	
	idiv ebx	

	; reset registers
	mov eax, 0x0
	mov ebx, 0x0
	mov ecx, 0x0
	mov edx, 0x0
	clc

	; divide signed
	mov ax, -26
	mov bx, 2
	mov dx, -1 	
	idiv bx	

	; Gracefully exit
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80