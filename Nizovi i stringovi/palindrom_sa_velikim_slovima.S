# Palindrom koji radi sa mixom malih i velikih slova
.section .data
	string: .ascii "AnavoliMilovana\0"
	palindrom: .byte 1 # 0-nije palindrom, 1-jeste palindrom

.section .text
.globl main
main:
	movl $string, %eax
	movl $string, %ebx

pripremi_string:
	

nadji_kraj:
	cmpb $0, (%ebx)
	je pripremi
	incl %ebx
	jmp nadji_kraj 

pripremi:
	decl %ebx
	jmp provera

provera:
	movl %eax, %ecx	
	cmpb $'Z', (%eax)
	jle prebaci_u_mala
	
	movl %ebx, %ecx
	cmpb $'Z', (%ebx)
	jle prebaci_u_mala

	# ako nije znak

	movb (%ebx), %cl
	cmpb (%eax), %cl
	jne nije_palindrom
	
	incl %eax
	decl %ebx
	cmpl %eax, %ebx
	ja provera
	jmp kraj

prebaci_u_mala:
	addl $32, (%ecx)
	jmp provera
	

nije_palindrom:
	decl palindrom
	jmp kraj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
