# Program za optimizovano mnozenje brojeva preko sabiranja u dvostrukoj preciznosti
.section .data
	a: .quad 0x123456789abcdef
	b: .quad 0x10
	rez: .quad 0x0
	greska: .byte 0

.section .text
.globl main
main:
	movl b+4, %ebx
	movl b, %eax

veci:
	cmpl a+4, %ebx
	jg proveri
	jl zamena 
	
	cmpl a, %eax
	ja proveri
	jb zamena

zamena:
	xchgl a+4, %ebx
	xchgl a, %eax
	jmp proveri

proveri:
	cmpl $0, a
	jne pomnozi
	cmpl $0, a+4
	je kraj

pomnozi:
	addl %eax, rez
	adcl %ebx, rez+4
	subl $1, a
	jmp proveri

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
