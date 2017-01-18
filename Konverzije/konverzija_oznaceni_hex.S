# Program za konverziju oznacenih heksadecimalnih brojeva u znakovni oblik.
# Program treba da radi sa bilo kojom bazom od 2 do 36, sa proverom bafera.
.section .data
	broj: .long -0xabc123
	baza: .long 16

	dec_br_max = 20
	dec_br: .fill dec_br_max, 1, 0

	greska_str: .ascii "Greska\n\0"
	greska_str_len = . - greska_str

.section .text
.globl main
main:
	movl broj, %eax
	movl baza, %ebx
	leal dec_br, %edi
	movl %edi, %esi

	movl %edi, %ecx
	addl $dec_br_max-2, %ecx

	testl $0x80000000, %eax
	jz dec_cifra

	negl %eax
	movb $'-', (%edi)
	incl %edi
	incl %esi

dec_cifra:
	xorl %edx, %edx
	divl %ebx
	
	cmpl $10, %edx
	jb cifra

slovo:
	# addb $55, %dl     # za velika slova
	addb $87, %dl		# za mala slova
	jmp prebaci

cifra:
	addb $'0', %dl
	jmp prebaci

prebaci:
	cmpl %ecx, %edi
	jnb ispisi_gresku

	movb %dl, (%edi)
	incl %edi

	andl %eax, %eax
	jnz dec_cifra

	movb $10, (%edi)
	movb $0, 1(%edi)

	decl %edi

reverse:
	cmpl %edi, %esi
	jae ispisi

	movb (%edi), %cl
	movb (%esi), %ch
	movb %ch, (%edi)
	movb %cl, (%esi)

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