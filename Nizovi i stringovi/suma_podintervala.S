# Program za racunanje sume elemenata u nekom podintervalu
.section .data
	DUZINA = 10
	niz: .long 1,2,3,4,5,6,7,8,9,10
	suma: .long 0
	prvi: .long 2
	poslednji: .long 7

.section .text
.globl main
main:
	# Bilo bi dobro napraviti proveru da pocetak ili kraj nisu veci od DUZINA
	# Ako jesu javiti gresku
	movl prvi, %esi   # Indeks
	movl suma, %eax # U eax se nalazi rezultat sumiranja

saberi:
	addl niz(,%esi,4), %eax
	incl %esi
	cmpl poslednji, %esi
	jle saberi
	jmp kraj

kraj:
	movl %eax, suma

	movl $1, %eax
	movl $0, %ebx
	int $0x80
