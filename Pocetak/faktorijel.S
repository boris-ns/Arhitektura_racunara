# Program za izracunavanje faktorijala nekog broja
.section .data
.section .text
.globl main
main:
	movl $6, %eax		# Broj od kog trazimo faktorijal
	movl $0, %ecx		# Rezultat izracunavanja

postaviB:			# Postavljanje broja B (ebx) za prvo mnozenje	
	movl %eax, %edx		# edx je pomocna promenljiva koja cuva koliko mnozenja treba da napravimo
	subl $1, %edx
	je kraj

	movl %edx, %ebx

pomnozi:
	addl %eax, %ecx 
	subl $1, %ebx
	je postaviSledeciKrug
	jmp pomnozi	

postaviSledeciKrug:             # Smanjivanje brojeva za 2
	movl %ecx, %eax
	movl $0, %ecx
        subl $1, %edx
	
	cmpl $1, %edx		# Ukoliko 2. cinilac dodje do 1, njega nema potrebe dodavati(u stvarnosti)
        je kraj			# u programu ce duplirati konacan rezultat pa se zbog toga radi ovaj if
	movl %edx, %ebx

	jmp pomnozi
	
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
