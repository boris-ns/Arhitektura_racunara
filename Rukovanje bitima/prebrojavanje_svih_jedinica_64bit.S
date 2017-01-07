# Program za prebrojavanje svih jedinica u 64bit broju
.section .data
	broj: .quad 0xfffffffffffffffe	# Broj u kome prebrojavamo jedinice
	brojac: .long 0

.section .text
.globl main
main:
	movl broj, %eax
	movl broj+4, %edx
	xorl %ebx, %ebx		# Brojac

petlja:
	cmpl $0, %eax
	je kraj

	testl $1, %eax
	jz nula
	incl %ebx
	jmp nula

nula:
	shrl $1, %edx
	rcrl $1, %eax
	jmp petlja

kraj:
	movl %ebx, brojac

	movl $1, %eax
	movl $0, %ebx
	int $0x80