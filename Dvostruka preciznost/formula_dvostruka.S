# Program za izracunavanje a=2*b + c/3, a,b,c su u dvostrukoj preciznosti
.section .data
	a: 	  .quad 0x0
	b: 	  .quad 0xBBBBBBBBBB
	c: 	  .quad 0x0000000003	
	prviDeo:  .quad 0x0
	drugiDeo: .quad 0x0
	ostatak:  .long 0x0
	greska:   .byte 0x0

.section .text
.globl main
main:
	movl $2, %eax		# Racunanje prvog dela formule
	mull b
	#jc greska
	movl %edx, prviDeo+4
	movl %eax, prviDeo

	movl c+4, %edx		# Racunanje drugog dela formule
	movl c, %eax
	movl $3, %ecx
	divl %ecx
	movl %eax, drugiDeo
	movl %edx, ostatak

	movl prviDeo, %eax	# Racunanje konacne vrednosti formule
	movl prviDeo+4, %ebx
	addl drugiDeo, %eax
	adcl drugiDeo+4, %ebx
	#jc vanOpsega
	jmp kraj


vanOpsega:
	incb greska
	jmp kraj

kraj:
	movl %eax, a
	movl %ebx, a+4

	movl $1, %eax
	movl $0, %ebx
	int $0x80
