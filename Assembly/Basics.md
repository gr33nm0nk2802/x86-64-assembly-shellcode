# Introduction

[x86 Assembly Crash Course](https://www.youtube.com/watch?v=75gBFiFtAb8)

This video is a good starting point watch it before proceeding 


## What is a binary?

A binary or an executable is made up of a series of instructions/operation codes (opcodes) written in machine code that the machine executes. Our CPU understands these instructions or opcodes and carries out several tasks.

Linux executables are commonly called as ELF executables or binaries.


## How a C compiled binary is made?

The C file is read by the compiler that converts the code into a series of operations that will be executed by the computer. Each operation is comprised of a sequence of bytes called the operation codes or (OP code). Assembly is a language that will convert these instructions into human readable form from the OP codes.

Steps in compilation:

The source code is first preprocessed and then compiled by the compiler. The Assembler then  converts the assembly code to object code. Finally this object code is linked with the various libraries using the linker.

```
[source-file] =(preprocessor)=> [source.i] =(compiler)=> [source.s] =(assembler)=> [source.o] =(linker)=> [executable]

```


## System Organization Basics:

CPU(brain), I/O devices and Memory communicates using System Buses.

### CPU:

```

                                           `Registers`
`Control Unit` <->  `Execution Unit`  <->
                                           `Flags`

```

```

Control Unit   - Retrive/Decode Instructions, Retrive/Store data in memory.
Execution Unit - Main Execution. 
Registers      - Internal memory variables. Sections of memory accessed quickly on the CPU.
Flags          - Indicates events when execution is happening.

```

To view CPU information simply run `lscpu` (gives byte ordering information as well) or view `cat /proc/cpuinfo`. 

CPU modes:
----------

- Real Mode     : at powerups or reset, 1MB memory, no memory protection, Priviledge level (Kernel vs User-Space) is not possible.
- Protected Mode: upto 4GB memory,memory protection/multi-tasking/priviledge-level, supports virtual-8086 mode
- System Management Mode: Power management tasks.

Memory Models:
-------------

- Flat Memory      : address is linear across memory space.  Linear Address space. 
- Segmented Model  : uses segment selector and offset(effective address), Real-Address Mode Model. Linear Address space.
- Real-Address Mode: Linear Address space divided into equally sized segments.

In IA32 Linux, Segment Register points to segment descriptors GDT/LDT/IDT(Global/Local/Interrupt) Descriptor tables.

### Virtual Memory:
------------------

1. Every process is laid out in the same virtual memory space regardless of the actual physical memory.
2. OS,CPU does the abstraction so that every process runs independently and uses memory that no other process uses.

Program memory:

```

	high memory
	  --------(0xFFFFFFFF)
	 | Kernel |     Kernel Space
	  --------(0xC0000000)
	 |  Stack |     Storing function, arguments and local variables.
	  --------
	 | Shared |
	 |  lib   |
	 | mapping|
	 | Unused |     Unused memory.
	  --------
	 |  Heap  |     Dynamic memory malloc()
	  --------
	 | .bss   |     Uninitialized data.
	  --------
	 | .data  |     Initialized data.
	  --------
	 | .text  |     Code of the program.
	  --------(0x08048000)
	low memory(0x00000000)

```

Stack is a LIFO which grows from high memory to low memory. It supports push and pop operations.
ESP points to the top of the stack.



### Virtual Memory Organization:
------------------------------

`ggdb gstabs ggstabs` flags must be used during compilation to get proper gdb flags while debugging the program.

Process Oranization:
-------------------
`/proc` directory in linux holds the information about the runtime
Memory layout for the program can be accessed inside `/proc/[pid]/maps` this gives information about various segments of the virtual memory and to what they are assigned to. 

`pmap`

`(gdb)> info proc mappings`

```
558e67b58000-558e67b85000          r--p      00000000            08:08        3940580  /usr/bin/bash
(Start-End address of section) (permission)  (offset for the)   (Major/Minor) (Inode)  (File path)
                                 rwxp/s      (memory map file)  (of device)
```
Certain sections are anonymous and used by the mmap

`/proc/sys/kernel/randomize_va_space` allows virtual address randomization to stop various buffer overflow attacks.
(ASLR). ASLR is stopped when its value is set to 0


### What is a Heap?

Heap is an area in the memory designed for manual memory allocation. Its innner working can be complicated.Memory is allocated on the heap when functions such as malloc and calloc are called as well as when global and static variables are declared.


### What is Assembly Language?

It is a low level programming language with which we can communicate directly with the microprocessor and it is specific to the processor family. 

```
Assembly Language  =>  (Assembler+Linker)  =>  Machine Language
```

Different Assembly Language Syntax:
 * Intel
 * ATT

Different CPU types:
 * Intel
 * ARM
 * MIPS

Intel has the following architechtures.
 * IA-32
 * IA-64

# Lab Environment

Virtual Box/ VMware
Ubuntu VM(32-bit)


To assemble and link the program into executable we need the following:

```

sudo apt-get update
sudo apt-get install gcc
sudo apt-get install nasm build-essential
nasm -f elf32 -o [output.o] [input.asm]    # use -f elf32 for 32 bit linux assembly
ld -m elf_i386 -o [output] [output.o]      # use -m elf_i386 for 32 bit architechture. 
gcc	-o [output] [output.o]				   # for files using libc

# USE LD_PRELOAD environment variable for defining custom libc libraries

```


### What are Registers?

Registers (32-bit,64-bit)  - These are small storage areas in our processor. It is used to store addresses, values or anything which can be represented in 8 bytes or less.


```
Registers(32-bit):
------------------
General Purpose(8/32-bit):       EAX,EBX,ECX,EDX,          |  ESI,EDI,(ESP,EBP)
					             can be broken into 8bits  |  can be broken into 16bits

System Registers(6/16-bit):      CS(code segment),DS(data segment),SS(stack segment),ES(Data),FS(Data),GS(Data)
(Flat/Segmented memory model)    [ Protected Flat Memory model is used by linux ]

Instruction pointer(32-bit):     EIP

Control Register:                CR0,CR1,CR2,CR3,CR4

Reserved:                        ESP, EBP, EIP

EFlags :                         Stores the value for the various flags

Floating Point(x87) Units:       It has different data registers for manipulating floating point numbers and the size of these registers is 80 bits. These are named ST(0) to ST(7) and these data registers behave like a stack.
						
Single Instruction Multiple Data (SIMD):
 uses MMX and XMM registers.
 extension MMX, SSE, SSE2, SSE3

MMX(lower 64 bits in FPU MM0-7) XMM(128 bits in size XMM0-XMM7)

ESI and EDI - Data pointer registers for memory operations source index and destination index.
ESP -         Stack pointer.
EBP -         Stack frame Base Pointer.

EAX -         Primary accumulator, stores function for return value.
EBX -         Base pointer to data section.
ECX -         Count Register for strings and for loops
EDX -         Data Register, I/O pointers.

```
EAX, EBX, ECX, EDX (32-bit)

```
	__________________________________
	|				EAX				 |
	31                               0
	----------------------------------
					|		AX		 |
					------------------
					|15				0|
					------------------
					|	AH	 |  AL   |
					------------------
					|15		8|7		0|
					------------------
```

GDB  Commands:

`info registers`
`info all-registers`

`display /x $eax`
`display /x $ax`
`display /x $ah`
`display /x $al`
`display /1bx &label`

`disassemble $eip`

`set disassembly-flavor intel`

`define hook-stop`
`nexti`
`stepi`
`break [address]`
`del [breakpoint]`


```
Registers (64-bit):

rbp: Base Pointer, points to the bottom of the stack
rsp: Stack Pointer, points to the top of the stack
rip: Instruction Pointer, points to the instruction to be executed

General Purpose Registers
These can be used for a variety of different things
	rax:
	rbx:
	rcx:
	rdx:
	rsi:
	rdi:
	r8:
	r9:
	r10:
	r11:
	r12:
	r13:
	r14:
	r15:

```
In x64 linux arguments to a function are passed via registers. The first few args are passed by these registers:
```
	
	rdi:    First Argument
	rsi:    Second Argument
	rdx:    Third Argument
	r10:    Fourth Argument
	r8:     Fifth Argument
	r9:     Sixth Argument
	
```
With the x86 elf architecture, arguments are passed on the stack. Also one thing as you may know, in C function can return a value. In x64, this value is passed in the rax register. In x86 this value is passed in the eax register.


```
		
		+-----------------+---------------+---------------+------------+
		| 8 Byte Register | Lower 4 Bytes | Lower 2 Bytes | Lower Byte |
		+-----------------+---------------+---------------+------------+
		|   rbp           |     ebp       |     bp        |     bpl    |
		|   rsp           |     esp       |     sp        |     spl    |
		|   rip           |     eip       |               |            |
		|   rax           |     eax       |     ax        |     al     |
		|   rbx           |     ebx       |     bx        |     bl     |
		|   rcx           |     ecx       |     cx        |     cl     |
		|   rdx           |     edx       |     dx        |     dl     |
		|   rsi           |     esi       |     si        |     sil    |
		|   rdi           |     edi       |     di        |     dil    |
		|   r8            |     r8d       |     r8w       |     r8b    |
		|   r9            |     r9d       |     r9w       |     r9b    |
		|   r10           |     r10d      |     r10w      |     r10b   |
		|   r11           |     r11d      |     r11w      |     r11b   |
		|   r12           |     r12d      |     r12w      |     r12b   |
		|   r13           |     r13d      |     r13w      |     r13b   |
		|   r14           |     r14d      |     r14w      |     r14b   |
		|   r15           |     r15d      |     r15w      |     r15b   |
		+-----------------+---------------+---------------+------------+
		
```
A word is just two bytes of data. A dword is four bytes of data. A qword is eight bytes of data.


### What is the Stack?

```

Stack (push, pop)

Each element on the stack has a stack address.Every function is loaded into the stack frame.All local variables for that function is stored in that stack frame.

```

EBP - contains address of the base of the current stack frame. 
ESP - contains address of the current/top element of the stack frame.


First, value of the fuction pushed onto the stack then the return address of the function is pushed onto the stack. Return address is the 4 byte address of the instruction that will be executed as soon as the function is gone out of scope. Base pointer is pushed onto the stack. Base pointer is given the value of the stack pointer. Finally the stack pointer is decremented to make room for local variables. The number of bytes by which the stack pointer maybe decremented by is compiler specific. All space between the functions base pointer and stack pointer is the functions stack frame.This sequence of instruction is called the function prolog. The prolog is formed whenever a function is called.

ebp-0x4 4 bytes below the base pointer. 
value of our function arguments is stored 0x8 bytes above the function's stack frame. x86 calling convention, arguments to a function are pushed onto the stack in reverse order.

Function epilog is the process of returning control when esp is moved to ebp and ebp is popped off the stack and control is returned to the return address.

### Flags

There is one register that contains flags. A flag is a particular bit of this register. If it is set or not, will typically mean something. Here is the list of flags.

```

	00:     Carry Flag
	01:     always 1
	02:     Parity Flag
	03:     always 0
	04:     Adjust Flag
	05:     always 0
	06:     Zero Flag
	07:     Sign Flag
	08:     Trap Flag
	09:     Interruption Flag     
	10:     Direction Flag
	11:     Overflow Flag
	12:     I/O Privilege Field lower bit
	13:     I/O Privilege Field higher bit
	14:     Nested Task Flag
	15:     Resume Flag

```


### Instruction (Intel syntax)

Instruction Set:
---------------

- General Purpose Instruction
- x87 FPU Instruction
- MMX/SSE/SSE2/SSE3/SSE4 Instructions
- Other Instruction set Instructions

`/usr/include/i386-kubyx-gnu/asm/unistd32.h`
`/usr/include/x86_64-linux-gnu/asm/` directory has the syscalls inside the `unistdXXX.h` file


```

	fd input  0
	fd output 1
	fd error  2

```

`man 2 [command]` view documentation of various syscalls.


**Simple Exit**
```

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

```

**Write**
```

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, message
	mov edx, mlen
	int 0x80

```

`mlen equ $-message` works in nasm

`ehco $?` for the return code of the program

```

	lable: dx [data]

where dx is db, dw, dd, dq, dt etc.

```

```

	operation arg1
	operation arg1, arg2

```

```

	mov eax, ebp-0x8          # moves the address from ebp-0x8 to eax
	mov eax, [ebp-0x8]        # moves the value

```

```

add arg1,arg2    arg1=arg1+arg2
sub arg1,arg2    arg1=arg1-arg2

adc dst, src (carry)
sbb substract borrow (-1)

INC
DEC

clc 	- clear carry flag
stc     - set carry flag
cmc     - complement carry flag

```

```
(unsigned)
MUL
DIV


AL * r/m8    = AX
AX * r/m16   = DX AX
EAX* r/m32   = EDX EAX

if Upper half of result is non zero OF=1 CF=1


AX 			/ r/m8   = Q(AL) R(AH)
DX+AX  		/ r/m16  = Q(AX)  R(DX)
EDX+EAX  	/ r/m32  = Q(EAX)  R(EDX)


imul (signed)
idiv (signed)

```

```

AND
OR
XOR
NOT
SAR
SHR
ROR
ROL

```

```

PUSH ECX
LOOP
LOOPZ
LOOPNZ
LOOPE
LOOPNE
POP ECX

```

```

REP
REPE
REPNE

till ecx becomes 0

```

```

PUSHAD/POPAD
PUSHFD/POPFD

```

```

MOVS
CMPS
SCAS
LODS

from ESI and EDI using DF(direction flags)

std  - set
cld  - clear

```

```

push arg
pop reg

```
```

lea reg,addr

```

eip [address of currently being executed op]

```

cmp arg1, arg2       [sets a flag in the processor >/=/< 0]
cmp 1,3     => 1-3     flag < 0

jmp addr	[sets the eip to its argument unconditonal short jump -128 to 127 from current pos.]		  

je,jne,jg,jge,jl,jle,jz,jnz  [conditonal jump based on eflags]

call <func>   => push eip, jmp func   [ push the return address of the function onto the stack and mov eip to first instruction of the function ]

leave/ret  called at the end of every function.
leave destroys the current stack frame by first moving the esp to ebp and then popping ebp of the top of the stack.

ret adrr     it follows the leave instruction, it pops the return instruction from the top of the stack and set the eip to the return address.

```


# Reversing the Assembly

## Some General Commands

`df -h`
`free -h`
`ps -aux`
`id`
`shutdown now`


## objdump

`objdump -D [binary] -M intel | less`

`r2 -d -A [binary]`


## Ghidra 

```
https://www.youtube.com/watch?v=fTGTnrgjuGA
https://www.youtube.com/watch?v=OJlKtRgC68U
https://threatvector.cylance.com/en_us/home/an-introduction-to-code-analysis-with-ghidra.html
https://ghidra-sre.org/InstallationGuide.html
```
