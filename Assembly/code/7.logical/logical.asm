; Author: d4rk-c1ph3r
; A program to illustrate the bitwise and, or, xor , not, left shift, right shift etc.

; Assembling: nasm -f elf32 -o logical.o logical.asm
; linking:    ld -m elf_i386 -o logical logical.o


section .text
global _start
_start:

	; AND
	mov eax, 0x2	;00000010
	mov ebx, 0x4	;00000100 
	and eax, ebx	;00000000 
	
	; AND
	mov eax, 0x1167
	mov ebx, 0x1317		
	and eax, ebx		

	; OR
	mov eax, 0x1167	
	mov ebx, 0x1317	
	or eax, ebx		

	; XOR
	mov eax, 0x1167 
    mov ebx, 0x1317 
	push eax
	push ebx
	xor eax, ebx
	push eax
	pop dword [varC]
	pop dword [varB]
	pop dword [varA]
	mov eax, 0x0
	mov ebx, 0x0
	mov ecx, 0x0
	add eax, dword [varC]
	xor eax, dword [varB]	
	push eax
	mov eax, 0x0
	add eax, dword [varC]
	xor eax, dword [varA]  	
	push eax
	mov eax, 0x0
	mov eax, dword [varA]
	xor eax, dword [varB]	
	push eax
	
	; NOT
	mov eax, 0x1167 
	not eax	

	; SAR - Shift arithmetic right
	mov eax, 0xA245
	sar eax, 1

	; same as above, but SAR was meant for SIGNED divide r/m[8,16,32] by 2, xtimes
	mov eax, 0xffff5dbb
	sar eax, 1
	
	; SHR - UNSIGNED power-of-two division
	mov eax, 0xa245
	shr eax, 1	

	; ROL - Rotate left
	mov eax, 0xa245
	clc
	rol eax, 2

	; ROR - Rotate right
	mov eax, 0xa245
	clc
	ror eax, 2

	;exit
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80


section .data
	varA:		dd	0x0
	varB:		dd	0x0
	varC:		dd	0x0
