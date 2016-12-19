# Program za pronalazenje minimalnog elementa u nizu
.section .data
	DUZINA = 5
	niz: .long 2,3,5,1,2
	min: .long 0

.section .text
.globl main
main:
	movl $0, %esi # Indeks
	movl niz, %eax # Stavljamo da je 1. element minimum
	
nadji_min:
	cmpl %eax, niz(,%esi,4)
	jl novi_minimum

	incl %esi
	cmpl $DUZINA, %esi
	jl nadji_min
	jmp kraj

novi_minimum:
	movl niz(,%esi,4), %eax

	incl %esi
	cmpl $DUZINA, %esi
	jl nadji_min

kraj:
	movl %eax, min

	movl $0, %eax
	movl $1, %ebx
	int $0x80
