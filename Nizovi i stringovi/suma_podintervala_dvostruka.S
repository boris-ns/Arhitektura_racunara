# Program za sabiranje elemenata podintervala niza u dvostrukoj preciznosti(indeksno adresiranje)
.section .data
	DUZINA = 7
	niz:	.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
	prvi:	   .long 4
	poslednji: .long 5
	suma:	   .quad 0x0
	greska:	   .byte 0

.section .text
.globl main
main:
	# Bilo bi dobro napraviti proveru za vrednosti prvi i poslednji
	# da li su u opsegu od 0 do DUZINA-1

	movl prvi, %esi			# Pocetni indeks
	movl suma, %eax			# Suma (nizi bitovi)
	movl suma+4, %ebx		# Suma (visi bitovi)

saberi:
	addl niz(,%esi,8), %eax	
	adcl niz+4(,%esi,8), %ebx
	jc van_opsega
	
	incl %esi			# Provera da li smo dosli do kraja niza
	cmpl poslednji, %esi
	jle saberi
	jmp kraj

van_opsega:
	incl greska
	jmp kraj

kraj:
	movl %eax, suma
	movl %ebx, suma+4

	movl $1, %eax
	movl $0, %ebx
	int $0x80 
