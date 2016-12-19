# Program za izracunavanje sume elemenata preko indirektnog adresiranja
.section .data
	DUZINA = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0

.section .text
.globl main
main:
	movl $niz, %esi
	movl suma, %eax

petlja:
	addl (%esi), %eax
	addl $4, %esi
	cmpl $niz+DUZINA*4, %esi
	jl petlja

kraj:
	movl %eax, suma	

	movl $1, %eax
	movl $0, %ebx
	int $0x80
