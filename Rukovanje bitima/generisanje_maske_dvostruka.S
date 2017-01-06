# Program za generisanje bit-maske. n je redni broj bita kojeg treba postaviti 
# na vrednost V (svi ostali bitovi se postavljaju na suprotnu vrednost)
# V moze imati vrednost 0 ili 1, a n moze biti od 0-31. 
# Ukoliko su za n i v unete vrednosti van njihovih opsega vratiti gresku(maska=0)
# Za n=3 i v=1 program vraca 0000....001000
# Za n=3 i v=0 program vraca 1111....110111
# Za n ili v van opsega program vraca 00000....0000000
.section .data
	n: .long 62
	v: .long 0
	maska: .quad 1

.section .text
.globl main
main:
	movl n, %ecx			# n -> %cl
	movl $1, %eax			# maska
	movl $1, %edx			# maska+4

	testl $0b11111111111111111111111111111110, v 	# Provera ispravnosti promenljive v
	jnz maska_greska

	testl $0b11111111111111111111111111100000, %ecx	# Provera ispravnosti promenljive n
	jnz gornji_deo									# Ukoliko je n > 31 onda se proverava da li se promenljiva
													# n odnosi na gornje bite maske

	shll %cl, %eax									# Pomeranje donjeg dela za n pozicija u levo

	xorl %edx, %edx									# Postavljanje gornjih bitova maske na 0, jer se promenljiva
													# n odnosi na donje bitove

	testl $1, v
	jnz maska_kraj

	notl %eax										# Ukoliko je v=0 treba okrenuti sve bitove
	notl %edx
	jmp maska_kraj

gornji_deo:
	testl $0b11111111111111111111111111000000, %ecx	# Provera da li je n u opsegu 0-63
	jnz maska_greska

	subl $32, %ecx
	shll %cl, %edx									# Pomeranje gornjih bitova za n-32 mesta u levo									

	xorl %eax, %eax									# Postavljanje donjih bitova maske na 0 jer se prom. n
													# odnosi na gornje bitove
	testl $1, v
	jnz maska_kraj

	notl %eax										# Ukoliko je v=0 treba okrenuti sve bitove
	notl %edx
	jmp maska_kraj

maska_kraj:											# Prebacivanje rezultata maske u prom. maska
	movl %eax, maska
	movl %edx, maska+4
	jmp kraj

maska_greska:
	movl $0, maska
	movl $0, n
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80