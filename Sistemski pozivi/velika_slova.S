# Program koji mala slova unetog stringa pretvara u velika
.section .data
	unos_tekst: .ascii "Unesite string\: \0"
	unos_tekst_len = . - unos_tekst
	
	str_len = 40
	str: .fill str_len,1,0

	rezultat_tekst: .ascii "Rezultujuci string\: \0"
	rezultat_tekst_len = . - rezultat_tekst

.section .text
.globl main
main:
	movl $4, %eax			# Ispis unos_tekst
	movl $1, %ebx
	leal unos_tekst, %ecx
	movl $unos_tekst_len, %edx
	int $0x80

	movl $3, %eax			# Unos stringa
	movl $0, %ebx
	leal str, %ecx
	movl $str_len, %edx
	int $0x80
	movl %eax, %esi			# Velicina unetog stringa se smesta u %esi
	
	movl $str, %eax

provera:
	cmpb $0, (%eax)
	je ispisi_rez

	cmpb $97, (%eax)		# Provera da li je ASCII vrednost >= 97
	jae provera2

	incl %eax
	jmp provera

provera2:
	cmpb $122, (%eax) 		# Provera da li je ASCII vrednost <= 122
	jbe pretvori
	
	incl %eax
	jmp provera

pretvori:				# Pretvaranje malog slova u veliko
	movb (%eax), %bl
	subb $32, %bl
	movb %bl, (%eax)
	
	incl %eax
	jmp provera

ispisi_rez:				# Ispisivanje rezultat_tekst
	movl $4, %eax
	movl $1, %ebx
	leal rezultat_tekst, %ecx
	movl $rezultat_tekst_len, %edx
	int $0x80
	jmp ispisi_string

ispisi_string:				# Ispis novog stringa
	movl $4, %eax
	movl $1, %ebx
	leal str, %ecx
	movl %esi, %edx
	int $0x80

	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
