# Program koji svaki clan niza pomnozi sa 2
.section .data
	DUZINA = 5
	prvi_niz:  .long 2,3,4,5,0
	drugi_niz: .long 0,0,0,0,0

.section .text
.globl main
main:
	movl $0, %esi		# Indeks
	movl $2, %ebx

pomnozi:
	movl prvi_niz(,%esi,4), %eax
	mull %ebx
	movl %eax, drugi_niz(,%esi,4)

	incl %esi
	cmpl $DUZINA, %esi
	jl pomnozi
	jmp kraj 

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
