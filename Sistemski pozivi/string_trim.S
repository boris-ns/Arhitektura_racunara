# Program za trimovanje stringa (uklanjanje praznih mesta sa pocetka i kraja stringa)
.section .data
	unos_tekst: 	.ascii "Unesite string\: \0"
	unos_tekst_len	= . - unos_tekst

	ispis_tekst:	.ascii "Trimovan string\:\0"
	ispis_tekst_len = . - ispis_tekst

	tacka:		.ascii ".\0"

	str_max		= 40	
	str:		.fill str_max, 1, 0 
	nova_duzina:	.long 0

.section .text

.macro ispisi tekst, tekst_len=$0		# Makro za sistemski poziv ispisa na ekran
	movl $4, %eax
	movl $1, %ebx
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80
.endm

.macro unesi tekst, tekst_len=$0		# Makro za sistemski poziv unosa stringa
	movl $3, %eax
	movl $0, %ebx
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80
.endm

.globl main
main:
	ispisi unos_tekst, $unos_tekst_len
	unesi str, $str_max

	leal str, %eax

nadji_kraj:
	cmpb $'\n', (%eax)
	je ukloni_sa_kraja
	
	cmpb $'\t', (%eax)			# Uklanjanje tabulatora, tj. zamena sa ' '
	je tabulator

	incl %eax
	jmp nadji_kraj

tabulator:
	movb $' ', (%eax)
	incl %eax
	jmp nadji_kraj

ukloni_sa_kraja:				# Uklanjanje praznih mesta sa kraja
	cmpb $' ', -1(%eax)
	jne izbaci	

	decl %eax
	jmp ukloni_sa_kraja

izbaci:
	movb $0, (%eax)
	jmp razmaci_pocetak

razmaci_pocetak:				# Uklanjanje praznih mesta sa pocetka
	leal str, %eax
	cmpb $' ', (%eax)
	jne nadji_novu_duzinu
		
	jmp izbaci_pocetak

izbaci_pocetak:
	cmpb $0, (%eax)
	je razmaci_pocetak
	movb 1(%eax), %bl
	movb %bl, (%eax)
	incl %eax
	jmp izbaci_pocetak

nadji_novu_duzinu:				# Pronalazenje duzine novog stringa
	cmpb $0, (%eax)
	je rezultat
	incl nova_duzina
	incl %eax
	jmp nadji_novu_duzinu

rezultat:					# Ispis rezultata na ekran
	ispisi ispis_tekst, $ispis_tekst_len
	ispisi str, nova_duzina
	ispisi tacka, $1

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
