# Program koji odredjuje horizontalni paritet 15bit broja i postavlja
# ga na njegovu najznacajniju poziciju (16. bit)
.section .data
	vrednost: .word 1234	# Broj ciji paritet trazimo

.section .text
.globl main
main:
	movw vrednost, %ax
	xorb %cl, %cl			# Brojac 'jedinica' u binarnom broju

petlja:
	andw %ax, %ax			# Uslov za kraj petlje
	jz postavi_paritet

	testw $0b0000000000000001, %ax
	jnz jedinica

	shrw $1, %ax
	jmp petlja

jedinica:
	incb %cl
	shrw $1, %ax
	jmp petlja

postavi_paritet:
	movw vrednost, %ax
	testb $0b00000001, %cl
	jz kraj
	orw $0x8000, %ax	# Postavljanje jedinice na bit pariteta

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80