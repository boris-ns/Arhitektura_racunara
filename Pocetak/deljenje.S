# Program za deljenje brojeva preko oduzimanja
.section .data
.section .text
.globl main
main:
	movl $10, %eax 		# deljenik
	movl $2, %ebx 		# delilac
	movl $0, %ecx 		# kolicnik
	movl $0, %edx		# ostatak

proveriUlaz:
	cmpl %ebx, %eax		# Proveri da li je ebx vece od eax, ako jeste idi na kraj.
	ja podeli
	jmp kraj

podeli:
	addl $1, %ecx				
	subl %ebx, %eax
	je kraj
	jmp proveriOstatak
	jmp podeli

proveriOstatak:			# Provera ostatka. Ako je rezultat negativan broj onda se u eax 
	cmpl %ebx, %eax		# nalazi ostatak i njega pamtimo u edx
	je podeli
	ja podeli
	movl %eax, %edx
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
