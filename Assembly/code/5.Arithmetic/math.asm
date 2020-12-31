; Author: d4rk-c1ph3r
; A program to demonstrate addtion, substraction
; increment and decrement instructions

; Assembling: nasm -f elf32 -o math.o math.asm
; linking:    ld -m elf_i386 -o math math.o

	section .text
	global _start
_start:
	; initialization of registers
	mov eax, 0x5
	mov ebx, 0x4
	mov ecx, 0x2
	mov edx, 0x8

	; add and sub instructions
	add ecx, edx
	sub eax, ebx

	; increment and decrement instructions
	inc eax
	dec ebx

	; add carry and sub borrow instructions
	adc dword [var1], 0x10
	sbb dword [var1], 0x10

	; exit gracefully
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

section .data
	var1: dd 0x00000005
