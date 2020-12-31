; Author: d4rk-c1ph3r
; A program to use the various data types in assembly and
; to be used with gdb to debug for the various data types

; compile:  nasm -f elf32 datatypes.asm -o datatypes.o
; linking:  ld -m elf_i386 datatypes.o -o datatypes

	section .data
var1: 	db  0xaa					; define raw bytes 
var2: 	db  0xbb, 0xcc, 0xdd
var3:   dw  0xee					; define word 2 bytes
var4:   dd  0xAABBCCDD					; define double word 4 bytes
var5:   TIMES 5 db 0xff					; To repeat an instruction N times
var6:   dd  "This is a complete sentence", 0xa		; define double word
var7:   equ $-var6
var8:   dd    1.234567e20         ; floating-point constant 
var9:   dq    1.234567e20         			; double-precision float  (8 bytes) 
var10:  dt    1.234567e20         			; extended-precision float(8 bytes)
	
	;DT, DO, DY and DZ do not accept integer numeric constants as operands.

	section .bss
vara:	resb  100					; reserves 100 bytes
varb:   resw  20					; reserves 20 words 20*4=80 bytes

	section .text
	global _start
_start:
	; Just the exit syscall as we will be printing all values in GDB
	mov eax,0x1
	mov ebx,0x0
	int 0x80
