# Program za prebrojavanje svih nula u 64bit broju
.section .data
	broj: .quad 0xffeffeffeffffefe	# Broj u kome prebrojavamo nule
	brojac: .long 0

.section .text
.globl main
main:
	movl broj, %eax
	movl broj+4, %edx
	xorl %ebx, %ebx 	# Brojac

petlja:
	testl $0xffffffff, %eax
	jz kraj

	testl $1, %eax
	jnz jedinica
	incl %ebx

jedinica:
	shrl $1, %edx
	rcrl $1, %eax
	jmp petlja

kraj:
	movl %ebx, brojac

	movl $1, %eax
	movl $0, %ebx
	int $0x80