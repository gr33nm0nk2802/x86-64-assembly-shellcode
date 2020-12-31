; Author: d4rk-c1ph3r
; A program to Inspect movement of data in assembly
; from register to register, register to memory, memory to register

; assembling:  nasm -f elf32 moving.asm -o moving.o
; linking:     ld  -m elf_i386 moving.o -o moving






	section .data
msg:    db  0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
msglen: equ $-msg

	section .bss
var1:	resb   30

	section .text
	global _start
_start:
	; moving data into registers
	mov eax, 0xffffffff
	mov ebx, 0xaaaa
	mov dl,  0xbb
	mov dh,  0xcc
	mov eax, 0x0
	mov eax, 0x1

	; moving data from register to register
	mov ebx, eax
	mov cl, dl
	mov ch, dh

	; moving from register to memory
	mov eax, 0x33445566
	mov byte [msg], al
	mov word [msg+5], 0xff	
	mov dword [msg], ebx

	; immediate value to mem
	mov dword [msg], 0xdeadbeef

	; load effective address
	lea eax, [msg]
	lea ebx, [eax]

	; xchg
	xchg ebx, [msg]
	xchg [msg], edx

	xor eax,eax
	; Exit syscall
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80
