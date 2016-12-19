# Program koji sluzi za mnozenje 2 broja preko sabiranja
.section .data
.section .text
.globl main
main:
	movl $4, %eax
	movl $7, %ebx
	movl $0, %ecx

uporediUlaz:
	cmpl %eax, %ebx
	je pomnozi
	ja pomnozi
	jmp zameni

zameni:
	xchgl %eax, %ebx
	jmp pomnozi

pomnozi:
	addl %ebx, %ecx
	subl $1, %eax
	je kraj
	jmp pomnozi

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
