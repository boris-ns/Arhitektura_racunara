# Program za prebrojavanje svih jedinica u 32bit broju
.section .data
.section .text
.globl main
main:
	movl $10, %eax			# Broj
	movl $0, %ecx			# Brojac

petlja:
	cmpl $0, %eax			# Uslov za kraj prebrojavanja
	je kraj

	testl $1, %eax			# Provera da li je na poslednjoj poziciji 0 ili 1
	jz nula
	incl %ecx
	jmp nula

nula:
	shrl $1, %eax
	jmp petlja

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80