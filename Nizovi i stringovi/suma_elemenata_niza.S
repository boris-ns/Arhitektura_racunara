# Program za izracunavanje sume elemenata niza
.section .data
	DUZINA = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0

.section .text
.globl main
main:
	movl $0, %esi
	movl $0, %eax

petlja:
	addl niz(,%esi,4), %eax
	incl %esi
	cmpl $DUZINA, %esi
	jl petlja

kraj:
	movl %eax, suma	

	movl $1, %eax
	movl $0, %ebx
	int $0x80
