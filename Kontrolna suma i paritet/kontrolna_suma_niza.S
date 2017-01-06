# Program koji racuna kontrolnu sumu za niz 32bit brojeva
.section .data
	br_elem = 6
	niz: 	.long 0b10101010100101010001010100111111
			.long 0b10101010110111110101010101000101
			.long 0b11111111110000000001111111000000
			.long 0b11101001010110100101101010101010
			.long 0b00010101010100101010101010100101
			.long 0b11000101001010001001000100101010
	checksum: .long 0

.section .text
.globl main
main:
	xorl %eax, %eax				# checksum
	movl $1, %edx				# maska

sledeci_bit:
	xorl %ecx, %ecx				# brojac bita
	xorl %esi, %esi				# brojac elemenata niza

sledeci_el:
	movl niz(,%esi,4), %ebx
	andl %edx, %ebx				# Provera vrednosti bita
	jz bit_nula
	incl %ecx

bit_nula:
	incl %esi
	cmpl $br_elem, %esi			# Provera da li smo dosli do kraja niza
	jb sledeci_el

	shrl $1, %ecx				# parnost
	rcrl $1, %eax
	shll $1, %edx				# pomeranje maske
	jnc sledeci_bit				# obradjeni svi biti?
	movl %eax, checksum

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80