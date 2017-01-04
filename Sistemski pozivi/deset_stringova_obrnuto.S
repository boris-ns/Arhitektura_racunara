# Program koji unetih 10 stringova(max duzina je 20) ispisuje u obrnutom redosledu
.section .data
	str_len = 20	# Max duzina svakog stringa
	str_num = 10	# Broj stringova koje unosimo

	strings:	.fill str_len*str_num, 1, 0 	# Prostor za cuvanje svih stringova
	currentn:	.long 0 			# Indeks tekuceg stringa
	currents:	.long 0				# Adresa tekuceg stringa
	
	str_lens:	.fill str_num, 4, 0		# Niz za smestanje duzina svakog stringa
	
	str_unos:	.ascii "Unesite string: \0"
	str_unos_len 	= . - str_unos
	str_ispis:	.ascii "Obrnuti stringovi:\n\0"
	str_ispis_len	= . - str_ispis

.section .text
.globl main
main:							# Unos stringova
	movl $0, currentn
	movl $strings, %eax
	movl %eax, currents

petlja1:
	movl $4, %eax					# Ispis poruke za unos stringa
	movl $1, %ebx
	movl $str_unos, %ecx
	movl $str_unos_len, %edx
	int $0x80
	
	movl $3, %eax					# Unos stringa
	movl $0, %ebx
	movl currents, %ecx
	movl $str_len, %edx
	int $0x80

	movl currentn, %esi				# Smestanje duzine stringa u niz
	movl %eax, str_lens(,%esi,4)
	addl $str_len, currents
	incl currentn
	cmpl $str_num, currentn
	jb petlja1
	jmp ispis

ispis:
	movl $4, %eax					# Ispis poruke za obrnute stringove
	movl $1, %ebx
	movl $str_ispis, %ecx
	movl $str_ispis_len, %edx
	int $0x80
	
	decl currentn
	subl $str_len, currents 			# Adresa poslednjeg stringa

petlja2:						# Ispis stringova u obrnutom redosledu
	movl currentn, %esi

	movl $4, %eax
	movl $1, %ebx
	movl currents, %ecx
	movl str_lens(,%esi,4), %edx
	int $0x80

	subl $str_len, currents
	decl currentn
	jns petlja2
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
