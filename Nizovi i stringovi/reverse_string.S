# Obrtanje stringa
.section .data
	string: .ascii "abcdef\0"

.section .text
.globl main
main:
	movl $string, %eax	# Pokazivac na pocetak
	movl $string, %ebx	# Pokazivac na kraj

nadji_kraj:
	cmpb $0,(%ebx)
	je reverse
	incl %ebx
	jmp nadji_kraj

reverse:
	cmpl %eax, %ebx
	jle kraj

	decl %ebx

	movb (%eax), %cl
	movb (%ebx), %ch

	movb %cl, (%ebx)
	movb %ch, (%eax)

	incl %eax

	jmp reverse

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
