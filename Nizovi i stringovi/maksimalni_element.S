# Program za pronalazenje maksimalnog elementa u nizu
.section .data
	DUZINA = 7
	niz: .long 0,2,6,2,1,1,10
	max: .long 0

.section .text
.globl main
main:
	movl $0, %esi # Indeks
	movl niz, %eax # Stavljamo da je prvi element maksimalni

nadji_max:
	cmpl %eax, niz(,%esi,4)
	jg novi_maksimum
	incl %esi
	cmpl $DUZINA, %esi
	jl nadji_max
	jmp kraj

novi_maksimum:
	movl niz(,%esi,4), %eax
	incl %esi
	cmpl $DUZINA, %esi
	jl nadji_max
	jmp kraj

kraj:
	movl %eax, max

	movl $1, %eax
	movl $0, %ebx
	int $0x80
