# Za niz 15bit brojeva(najvisi bit je bit pariteta) odrediti horizontalni paritet i
# prebrojati koliko elemenata ima 'jedinicu' za bit pariteta. Broj elemenata niza je 10
# u promenljivu 'jedinice' upisati rezultat i vratiti rezultat operativnom sistemu.
.section .data
	br_elemenata = 10
	niz: .word	0b0010001010010100
		 .word	0b0010001010010100
		 .word	0b0010001010010100
		 .word	0b0010001010010100
		 .word	0b0010001010010100
		 .word	0b0010001010010101
		 .word	0b0010001010010101
		 .word	0b0010001010010101
		 .word	0b0010001010010101
		 .word	0b0010001010010101

	jedinice: .long 0

.section .text
.globl main
main:
	xorl %ecx, %ecx		# Brojac 'jedinica'	
	leal niz, %edi

proveri:
	cmpl $niz+br_elemenata*2, %edi
	ja kraj
	movw (%edi), %ax
	xorb %dl, %dl		# Brojac 'jedinica' jednog elementa

petlja:
	andw %ax, %ax
	jz sl_element

	testw $0b0000000000000001, %ax
	jnz jedinica

	shrw $1, %ax
	jmp petlja

jedinica:
	incb %dl
	shrw $1, %ax
	jmp petlja

sl_element:
	testb $0b00000001, %dl
	jnz postavi_paritet
	addl $2, %edi
	jmp proveri

postavi_paritet:
	orw $0b1000000000000000, (%edi)
	incl %ecx
	addl $2, %edi
	jmp proveri

kraj:
	movl %ecx, jedinice
	movl $1, %eax
	movl %ecx, %ebx
	int $0x80