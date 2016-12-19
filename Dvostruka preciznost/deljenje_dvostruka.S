# Program za deljenje 2 boja u dvostrukoj preciznosti
.section .data
	a: .quad 0xFFFFFFFFFFFFF
	b: .quad 0x7FFFFF
	rez: .long 0
	ostatak: .quad 0
	greska: .byte 0
.section .text
.globl main
main:
	movl a+4, %ebx
	movl a, %eax
	jmp podeli

proveri:
	cmpl $0, %eax
	je kraj
	jmp podeli

podeli:
	cmpl b+4, %ebx
	jna postaviOstatak
	cmpl b, %eax
	jna postaviOstatak

	subl b, %eax
	sbbl b+4, %ebx

	incl rez
	jmp proveri


postaviOstatak:
	movl %eax, ostatak
	movl %ebx, ostatak+4
	
kraj:
	movl rez, %ecx
	movl $1, %eax
	movl $0, %ebx
	int $0x80
