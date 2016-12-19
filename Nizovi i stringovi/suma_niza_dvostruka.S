# Program za izracunavanje sume elemenata niza u dvostrukoj preciznosti preko indeksnog adresiranja
.section .data
	DUZINA = 7
	niz:	.quad 0x111111111111
	     	.quad 0x111111111111
	 	.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
		.quad 0x111111111111
	suma:	.quad 0x0
	greska: .byte 0

.section .text
.globl main
main:
	movl $0, %esi			# Indeks
	movl suma, %eax			# Suma (nizi bajtovi)
	movl suma+4, %ebx		# Suma (visi bajtovi)
	
saberi:
	addl niz(,%esi,8), %eax
	adcl niz+4(,%esi,8), %ebx
	jc van_opsega
	
	incl %esi			# Provera da li smo dosli do kraja niza
	cmpl $DUZINA, %esi
	jl saberi
	jmp kraj

van_opsega:				# Greska se postavlja na 1 ako dodje do greske
	incl greska			# prilikom sabiranja visih bajtova elemenata
	jmp kraj

kraj:
	movl %eax, suma	
	movl %ebx, suma+4

	movl $1, %eax
	movl $0, %ebx
	int $0x80
