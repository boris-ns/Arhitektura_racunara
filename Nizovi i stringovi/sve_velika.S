# Program koji pretvara sva slova u velika
.section .data
	string: .ascii "asdfghij\0"

.section .text
.globl main
main:
	movl $string, %eax

prolaz:
	cmpb $0, (%eax)
	je kraj

	cmpb $'a', (%eax)
	jae pretvori 

	incl %eax
	jmp prolaz

pretvori:
	subb $32, (%eax)
	incl %eax
	jmp prolaz

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
