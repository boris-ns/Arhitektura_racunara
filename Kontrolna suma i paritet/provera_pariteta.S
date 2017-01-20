# Program koji proverava horizontalni paritet 15bit broja. Bit pariteta je 
# na 16. bit poziciji. U promenljivu 'ok' smestiti 1 ako je bit pariteta tacan,
# a 0 ako je netacan

.section .data
	vrednost: .word 0b0100000000000001	# Broj ciji paritet trazimo
	duzina = 15

	ok: .long 1

.section .text
.globl main
main:
	movw vrednost, %ax
	xorb %cl, %cl			# Brojac 'jedinica' u binarnom broju
	xorb %ch, %ch

petlja:
	cmpb $duzina, %ch			# Uslov za kraj petlje
	je provera

	testw $0b0000000000000001, %ax
	jnz jedinica

	shrw $1, %ax
	incb %ch
	jmp petlja

jedinica:
	incb %cl
	shrw $1, %ax
	incb %ch
	jmp petlja

provera:
	testw $0b1000000000000000, vrednost
	jz provera2
	testb $0b00000001, %cl
	jz greska
	jmp kraj

provera2:
	testb $0b00000001, %cl
	jnz greska
	jmp kraj

greska:
	movl $0, ok

kraj:
	movl $1, %eax
	movl ok, %ebx
	int $0x80