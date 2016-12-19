# Program za racunanje faktorijala sa mul naredbom
.section .data
.section .text
.globl main
main:
	movl $5, %eax
	movl %eax, %ebx
	subl $1, %ebx

faktorijel:
	mull %ebx
	
	subl $1, %ebx
	cmpl $0, %ebx
	je kraj
	jmp faktorijel

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
