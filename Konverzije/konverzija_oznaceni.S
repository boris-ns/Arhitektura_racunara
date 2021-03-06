# Program za konverziju oznacenog broja iz internog u znakovni oblik.
# Rezultat ispisati na ekran.
.section .data
	broj: .long -1234567890
	baza: .long 10

	dec_br_max = 20
	dec_br: .fill dec_br_max, 1, 0

.section .text
.globl main
main:
	movl broj, %eax
	movl baza, %ebx
	leal dec_br, %edi
	leal dec_br, %esi			# Koristi se za obrtanje ako je broj pozitivan

	testl $0x80000000, %eax		# Provera da li je broj pozitivan ili negativan
	jz dec_cifra				# ako je pozitivan odma pocinjemo konverziju

	negl %eax					# Priprema ako je broj negativan i 
	movb $'-', (%edi)			# dodavanje znaka '-' u niz
	incl %edi

	leal dec_br+1, %esi			# Koristi se za obrtanje ako je broj negativan

dec_cifra:
	xorl %edx, %edx
	divl %ebx
	addb $'0', %dl
	movb %dl, (%edi)
	incl %edi

	andl %eax, %eax				# Provera da li je eax = 0
	jnz dec_cifra

	movb $10, (%edi)
	movb $0, 1(%edi)

	decl %edi					# Priprema za obrtanje stringa
	# leal dec_br+1, %esi

reverse:						# Obrtanje stringa
	cmpl %edi, %esi
	jae ispisi

	movb (%esi), %ah
	movb (%edi), %al
	movb %ah, (%edi)
	movb %al, (%esi)

	incl %esi
	decl %edi
	jmp reverse

ispisi:							# Sistemski poziv za ispis na ekran
	movl $4, %eax
	movl $1, %ebx
	leal dec_br, %ecx
	movl $dec_br_max, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80