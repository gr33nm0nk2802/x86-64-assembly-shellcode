; Author: d4rk-c1pher
; Program to write hello in assembly and gracefully 
; exit the program using write and exit syscall

; compile:  nasm -f elf32 hello.asm -o hello.o
; linking:  ld -m elf_i386 hello.o -o hello

	; Data section for initialized variables

	section .data
msg: 	 db  "Hello Hacker", 0xA	; Label to point to string bytes defined
msg_len: equ $-msg	         	; Neat hack to calculate message length

	; Text section for actual code

	section .text
	global _start
_start:
	
	; Print the msg using the write syscall
	; Syscall for write is 4 and 
	;file descriptor used for write is 1
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, msg_len
	int 0x80
	
	; Graceful exit using exit syscall 1
	; and exit status 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80
	
	; verify exit status code using echo $?
