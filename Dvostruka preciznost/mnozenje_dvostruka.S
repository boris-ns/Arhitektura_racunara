# Program za mnozenje brojeva preko sabiranja u dvostrukoj preciznosti
.section .data
	a: .quad 0x10
	b: .quad 0x10000000001
	rez: .quad 0x0
	greska: .byte 0

.section .text
.globl main
main:
	movl b, %eax
	movl b+4, %ebx

proveri:
	cmpl $0, a
	jne pomnozi
	cmpl $0, a+4
	je kraj

pomnozi:
	addl %eax, rez
	adcl %ebx, rez+4
	jc prekoracenje
	subl $1, a
	jmp proveri

prekoracenje:
	incb greska
	jmp kraj

kraj:
	movl rez, %ebx
	movl $1, %eax
	movl $0, %ebx
	int $0x80
