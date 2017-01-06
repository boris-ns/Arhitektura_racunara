# Program za prebrojavanje svih nula u 32bit broju
.section .data
.section .text
.globl main
main:
	movl $8, %eax		# Broj
	movl $0, %ecx		# Brojac

petlja:
	cmpl $0, %eax		# Uslov za kraj
	je kraj

	testl $1, %eax
	jnz jedinica
	incl %ecx
	jmp jedinica

jedinica:
	shrl $1, %eax
	jmp petlja

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80