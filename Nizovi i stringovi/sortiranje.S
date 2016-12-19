# Program za sortiranje 16-bitnih elemenata niza. Bubble sort. Indeksno adresiranje
.section .data
	duzina: .long 7
	niz: 	.word 3,2,5,2,1,4,3

.section .text
.globl main
main:
	movl $0, %esi		# Indeks 1
	movl $1, %eax		# Indeks 2

sortiraj:
	movw niz(,%esi,2), %bx  # i - ti element ce biti u bx,a j-ti element ostaje u nizu
	cmpw %bx, niz(,%eax,2)
	jl zameni

	incl %esi
	incl %eax
	cmpl duzina, %eax
	je sl_ciklus
	ja kraj

	jmp sortiraj

sl_ciklus:
	movl $0, %esi
	movl $1, %eax
	decl duzina
	cmpl $0, duzina
	je kraj
	jmp sortiraj

zameni:					
	movw niz(,%eax,2), %cx		
	movw %bx, niz(,%eax,2)
	movw %cx, niz(,%esi,2)

	incl %esi
	incl %eax
	cmpl duzina, %eax
	je sl_ciklus
	ja kraj

	jmp sortiraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
