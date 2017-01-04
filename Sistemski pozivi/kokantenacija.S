# Program koji 2 uneta stringa spaja u 1
.section .data
	unos_tekst1:	.ascii "Unesite prvi string\: \0"
	unos_tekst1_len = . - unos_tekst1
	unos_tekst2:	.ascii "Unesite drugi string\: \0"	
	unos_tekst2_len = . - unos_tekst2
	ispis_tekst:	.ascii "Rezultujuci string\: \0"
	ispis_tekst_len = . - ispis_tekst

	prvi_str_max	= 40
	prvi_len:	.long 0
	prvi_str:	.fill prvi_str_max, 1, 0
	drugi_str_max	= 40
	drugi_len:	.long 0
	drugi_str:	.fill drugi_str_max, 1, 0

	rez_str_max	= prvi_str_max + drugi_str_max
	rez_str:	.fill rez_str_max, 1, 0

.section .text

.macro ispisi tekst, tekst_len			# Makro za sistemski poziv ispisa na ekran
	movl $4, %eax
	movl $1, %ebx	
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80
.endm

.macro unesi tekst, tekst_len			# Makro za sistemski poziv unosa
	movl $3, %eax
	movl $0, %ebx
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80
	movl %eax, %esi						# Cuvanje duzine unetog stringa
.endm

.globl main
main:
	ispisi unos_tekst1, $unos_tekst1_len
	unesi prvi_str, $prvi_str_max
	movl %esi, prvi_len

	ispisi unos_tekst2, $unos_tekst2_len
	unesi drugi_str, $drugi_str_max
	movl %esi, drugi_len
	
	leal rez_str, %eax
	leal prvi_str, %ebx

prebaci_prvi:							# Prebacivanje prvog stringa u rezultat
	cmpb $'\n', (%ebx)
	je pripremi_drugi

	movb (%ebx), %cl
	movb %cl, (%eax)
	
	incl %eax
	incl %ebx
	jmp prebaci_prvi

pripremi_drugi:							# Prebacivanje drugog stringa u rezultat
	leal drugi_str, %ebx
	incl %eax
	jmp prebaci_drugi

prebaci_drugi:
	cmpb $'\n', (%ebx)
	je ispisi_rezultat

	movb (%ebx), %cl
	movb %cl, (%eax)

	incl %eax
	incl %ebx
	jmp prebaci_drugi

ispisi_rezultat:
	ispisi ispis_tekst, $ispis_tekst_len
	ispisi rez_str, $rez_str_max
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
