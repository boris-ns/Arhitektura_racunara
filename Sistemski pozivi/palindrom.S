# Program koji odredjuje da li je uneti string palindrom(osnovna verzija). Rezultat ispisuje na ekran.
.section .data
	str_unos:	.ascii "Unesite string\: \0"
	str_unos_len	= . - str_unos
	str_jeste:	.ascii "Jeste palindrom\n\0"
	str_jeste_len	= . - str_jeste
	str_nije:	.ascii "Nije palindrom\n\0"
	str_nije_len	= . - str_nije

	rec_max		= 25
	rec:		.fill rec_max, 1, 0 
	duzina:		.long 0

.section .text
.globl main
main:
	movl $4, %eax				# Ispis "Unesite string:"
	movl $1, %ebx
	leal str_unos, %ecx
	movl $str_unos_len, %edx
	int $0x80

	movl $3, %eax				# Sistemski poziv za unos
	movl $0, %ebx
	leal rec, %ecx
	movl $rec_max, %edx
	int $0x80

	movl %eax, duzina	
	leal rec, %eax				# U %eax se nalazi pokazivac na pocetak stringa
	leal rec, %ebx				# U %ebx ce se nalaziti pokazivac na kraj stringa
	
nadji_kraj:					# Postavljanje %ebx-a da pokazuje na kraj stringa
	cmpb $'\n', (%ebx)
	je provera
	incl %ebx
	jmp nadji_kraj

provera:					# Provera da li je rec palindrom
	movb (%eax), %cl
	cmpb %cl, -1(%ebx)
	jne nije_palindrom

	incl %eax
	decl %ebx

	cmpl %eax, %ebx
	jle jeste_palindrom
	jmp provera

nije_palindrom:					# Ispis na ekran da nije palindrom
	movl $4, %eax
	movl $1, %ebx
	leal str_nije, %ecx
	movl $str_nije_len, %edx
	int $0x80	
	jmp kraj

jeste_palindrom:				# Ispis na ekran da jeste palindrom
	movl $4, %eax
	movl $1, %ebx
	leal str_jeste, %ecx
	movl $str_jeste_len, %edx
	int $0x80
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
