# Program za generisanje bit-maske. n je redni broj bita kojeg treba postaviti 
# na vrednost V (svi ostali bitovi se postavljaju na suprotnu vrednost)
# V moze imati vrednost 0 ili 1, a n moze biti od 0-31. 
# Ukoliko su za n i v unete vrednosti van njihovih opsega vratiti gresku(maska=0)
# Za n=3 i v=1 program vraca 0000....001000
# Za n=3 i v=0 program vraca 1111....110111
# Za n ili v van opsega program vraca 00000....0000000
.section .data
	n: .long 4
	v: .long 0
	maska: .long 1

.section .text
.globl main
main:
	movl n, %ecx			# n -> %cl

	testl $0b11111111111111111111111111111110, v    	# Provera ispravnosti za v
	jnz maska_greska

	testl $0b11111111111111111111111111100000, %ecx		# Provera ispravnosti za n. Mora biti u opsegu [0, 31]
	jnz maska_greska

	movl maska, %eax
	shll %cl, %eax										# Pomeranje jedinice za n mesta u levo

	testl $1, v 										# Ako je v=0 potrebno je okrenuti sve bite (uraditi not)
	jnz maska_kraj										# inace program je gotov sa generisanjem maske

	notl %eax
	jmp maska_kraj

maska_kraj:
	movl %eax, maska
	jmp kraj

maska_greska:
	movl $0, maska
	movl $0, n
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80