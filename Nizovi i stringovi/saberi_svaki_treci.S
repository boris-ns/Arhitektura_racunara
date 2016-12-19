# Program koji svaki 3. clan niza sabere sa 10, a svaki 2. sa 12, indeksno adresiranje
.section .data
	duzina: .long 10
	niz: .long 0,0,0,0,0,0,0,0,0,0
	
.section .text
.globl main
main:
	movl $2, %esi

	cmpl $3, duzina
	jae saberi_trece
	
	cmpl $2, duzina
	jne kraj

	movl $1, %esi
	jmp saberi_druge

saberi_trece:
	addl $10, niz(,%esi,4)
	addl $3, %esi
	cmpl duzina, %esi
	jb saberi_trece
	
	movl $1, %esi
	jmp saberi_druge

saberi_druge:
	addl $12, niz(,%esi,4)
	addl $2, %esi
	cmpl duzina, %esi
	jb saberi_druge
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
