# Program za mnozenje 2 broja preko sabiranja i rotiranja
# Rezultat se smesta u paru registara edx:eax
.section .data
	prvi_broj: .long 5
	drugi_broj: .long 3

.section .text
.globl main
main:
	movl prvi_broj, %ebx
	movl drugi_broj, %eax
	movl %eax, %ecx

	xorl %eax, %eax
	xorl %edx, %edx
	xorl %esi, %esi

	andl %ebx, %ebx				# Provera da li je prvi broj jednak nuli
	jz kraj

proveri:
	jecxz kraj					# Provera da li je drugi broj jednak nuli
	testl $1, %ecx
	jz uvecaj
	addl %ebx, %eax
	adcl %esi, %edx

uvecaj:
	addl %ebx, %ebx
	adcl %esi, %esi
	shrl $1, %ecx
	jmp proveri

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80