# Program za konverziju internog neoznacenog 32bit oktalnog broja
# u znakovni. Ukoliko rezultat ne moze da stane u bafer ispisati gresku.
.section .data
	broj: .long 01234567
	baza: .long 8

	dec_br_max = 10
	dec_br: .fill dec_br_max, 1, 0

	greska_str: .ascii "Greska\!\n\0"
	greska_str_len = . - greska_str

.section .text
.globl main
main:
	movl broj, %eax
	movl baza, %ebx
	leal dec_br, %edi

	movl %edi, %ecx				# Cuvanje granicne adrese bafera
	addl $dec_br_max-2, %ecx

dec_cifra:
	xorl %edx, %edx
	divl %ebx
	
	addb $'0', %dl

	cmpl %ecx, %edi
	jnl ispisi_gresku

	movb %dl, (%edi)
	incl %edi

	andl %eax, %eax
	jnz dec_cifra

	movb $10, (%edi)
	movb $0, 1(%edi)
	decl %edi
	leal dec_br, %esi

reverse:
	cmpl %edi, %esi
	je ispisi

	movb (%esi), %ah
	movb (%edi), %al
	movb %ah, (%edi)
	movb %al, (%esi)

	incl %esi
	decl %edi
	jmp reverse

ispisi_gresku:
	movl $4, %eax
	movl $1, %ebx
	leal greska_str, %ecx
	movl $greska_str_len, %edx
	int $0x80
	jmp kraj

ispisi:
	movl $4, %eax
	movl $1, %ebx
	leal dec_br, %ecx
	movl $dec_br_max, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80