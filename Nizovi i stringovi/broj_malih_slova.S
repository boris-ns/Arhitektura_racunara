# Program za brojanje malih slova u stringu
.section .data
	string: .ascii "AbcDefG\0"
	brojac: .long 0			# Brojac za mala slova	

.section .text
.globl main
main:
	movl $string, %eax

provera:
	cmpb $0, (%eax)
	je kraj

	cmpb $92, (%eax)
	jae provera2
	
	incl %eax
	jmp provera

provera2:
	cmpb $122, (%eax)
	jle jeste

	incl %eax
	jmp provera

jeste:
	incl brojac
	incl %eax
	jmp provera

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
