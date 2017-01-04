# Domaci zadatak 2 iz Makro-a. Napisati makro poziv za ispis na ekran. Makro ima 1 arg, string
# koji ispisuje na ekran, duzina stringa se odredjuje u samom makrou
.section .data
	unos_tekst: 	.ascii "Unesite string \0"
	ispis_tekst: 	.ascii "Vas string je \0"
	duzina:		.long 0	
	str_max		= 40
	str:		.fill str_max, 1, 0

.section .text

.macro ispisi tekst				# Makro za sistemski poziv ispisivanja stringa na ekran
	leal \tekst, %eax
	movl $0, duzina	

	1:	cmpb $0, (%eax)			# Labela koja odredjuje duzinu stringa
		je 2f
		incl %eax
		incl duzina
		jmp 1b

	2:	movl $4, %eax			# Sistemski poziv za ispis na ekran
		movl $1, %ebx
		leal \tekst, %ecx	
		movl duzina, %edx
		int $0x80	
.endm

.macro unesi_tekst str_unos, str_unos_max	# Makro za sistemski poziv unosa stringa
	movl $3, %eax
	movl $0, %ebx
	leal \str_unos, %ecx
	movl \str_unos_max, %edx
	int $0x80
.endm

.globl main
main:
	ispisi unos_tekst
	unesi_tekst str, $str_max
	ispisi ispis_tekst
	ispisi str

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
