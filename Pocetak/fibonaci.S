# Program za izracunavanje n-tog clana Fibonacijevog niza
.section .data
.section .text
.globl main
main:
	movl $0, %eax
	movl $1, %ebx
	movl $7, %ecx	

	cmpl $0, %ecx
	je prvi
	cmpl $1, %ecx
	je drugi
	
	subl $2, %ecx
	jmp fibonaci

prvi:
	movl $0, %ebx
	jmp kraj

drugi:
	movl $1, %ebx
	jmp kraj

fibonaci:
	movl %ebx, %edx
	addl %eax, %ebx
	movl %edx, %eax
	
	decl %ecx
	cmpl $0, %ecx
	je kraj
	jmp fibonaci		

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

