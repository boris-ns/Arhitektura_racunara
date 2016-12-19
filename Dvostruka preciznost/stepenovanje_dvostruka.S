# Program za stepenovanje u dvostrukoj preciznosti
.section .data
	broj: .quad 0x10001000100
	broj2: .quad 0x0		# Broj u kome pamtimo pocetnu vrednost broja
	step: .long 0x2			# Stepen
	rez:  .quad 0x0			# Rezultat
	greska: .byte 0

.section .text
.globl main
main:
	movl broj+4, %ebx
	movl broj, %eax	
	movl %ebx, broj2+4
	movl %eax, broj2

	cmpl $1, step
	je premestiRez
	cmpl $0, step
	je nulaStepen
	
	jmp stepenovanje	
	
stepenovanje:
	decl step
	cmpl $0, step
	je premestiRez
	movl broj+4, %edx
	movl %edx, broj2+4
	movl broj, %edx
	movl %edx, broj2
	jmp mnozi

mnozi:
	addl broj, %eax
	adcl broj+4, %ebx
	jc vanOpsega
	
	decl broj2
	cmpl $0, broj2
	je stepenovanje
	

vanOpsega:
	incb greska
	jmp premestiRez

premestiRez:
	movl %ebx, rez+4
	movl %eax, rez
	jmp kraj

nulaStepen:
	movl $0, rez+4
	movl $1, rez
	jmp kraj

kraj:	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
