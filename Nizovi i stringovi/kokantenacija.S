# Program koji spaja 2 stringa u treci
.section .data
	prvi: .ascii "abcd\0"
	drugi: .ascii "efgh\0"
	rez: .ascii "\0\0\0\0\0\0\0\0\0\0"

.section .text
.globl main
main:
	movl $prvi, %eax
	movl $rez, %ebx

prebaci_prvi:
	cmpb $0, (%eax)	
	je pripremi_drugi
	
	movb (%eax), %cl
	movb %cl, (%ebx)
	incl %eax
	incl %ebx
	jmp prebaci_prvi

pripremi_drugi:
	movl $drugi, %eax
	jmp prebaci_drugi

prebaci_drugi:
	cmpb $0, (%eax)
	je kraj
	
	movb (%eax), %cl
	movb %cl, (%ebx)	
	incl %eax
	incl %ebx
	jmp prebaci_drugi

kraj:
	movb $0, (%ebx)

	movl $1, %eax
	movl $0, %ebx
	int $0x80
