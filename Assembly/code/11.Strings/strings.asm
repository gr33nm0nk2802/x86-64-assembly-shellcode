; Author: d4rk-c1pher
; A program to demonstrate the usage of various string operations

; compile:  nasm -f elf32 strings.asm -o strings.o
; linking:  ld -m elf_i386 strings.o -o strings

	; Data section for initialized variables
	section .data
source:    		db  "Hello World!", 0xa
sourcelen: 		equ $-source
comparision: 	db  "Hello",0xa
result1: 		db  "Strings are equal",0xa
result1len: 	equ $-result1
result2: 		db  "Strings are unequal", 0xa
result2len: 	equ $-result2

	section .bss
destination: resb 100


	; Text section for actual code

	section .text
	global _start
_start:

	; copy a string from source to destination

	mov ecx, sourcelen	
	lea esi, [source]
	lea edi, [destination]

	cld
	rep movsb

	; Print hello world after copy

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, destination
	mov edx, sourcelen
	int 0x80

	; String comparision with cmpsb

	; compare source and destination
	mov ecx, sourcelen
	lea esi, [source]
	lea edi, [comparision]
	repe cmpsb

	jz strequal
	mov ecx, result2
	mov edx, result2len

strequal:
	mov ecx, result1
	mov edx, result1len

Print:

	mov eax, 0x4
	mov ebx, 0x1
	int 0x80
	
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80
	
