# Program koji sluzi za mnozenje 2 broja preko sabiranja
.section .data
.section .text
.globl main
main:
	movl $5, %eax
	movl $3, %ebx
	movl $0, %ecx

pomnozi:
	addl %ebx, %ecx
	subl $1, %eax
	je kraj
	jmp pomnozi

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
