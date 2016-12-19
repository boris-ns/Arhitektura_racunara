# Program za uklanjanje praznih mesta sa kraja stringa i pocetka stringa
.section .data
	string: .ascii "  abcd  \0"

.section .text
.globl main
main:
	movl $string, %eax

kraj_s:
	cmpb $0, (%eax)
	je razmaci
	incl %eax
	jmp kraj_s

razmaci:
	cmpb $' ', -1(%eax)
	jne izbaci
	decl %eax
	jmp razmaci

izbaci:
	movb $0, (%eax)

razmaci_pocetak:
	movl $string, %eax
	cmpb $' ', (%eax)
	jne kraj	

izbaci_pocetak:
	cmpb $0, (%eax)
	je razmaci_pocetak
	movb 1(%eax), %bl
	movb %bl, (%eax)
	incl %eax
	jmp izbaci_pocetak

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
