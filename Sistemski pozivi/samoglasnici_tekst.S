.section .data
	poruka1: .ascii "Unesite string\: \0"
	poruka1_len = . - poruka1
	
	poruka2: .ascii "Rezultat\: \0"
	poruka2_len = . - poruka2

	tekst_max = 81
	tekst: .fill tekst_max, 1, 0
	#tekst: .ascii "aa bb\n\0"
	
	best: .long 0
	
	dec_br_max = 10
	dec_br: .fill dec_br_max, 1, 0
	baza: .long 10

.section .text

.macro ispisi tekst, tekst_len
	movl $4, %eax
	movl $1, %ebx
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80
.endm

.macro unesi tekst, tekst_len
	movl $3, %eax
	movl $0, %ebx
	leal \tekst, %ecx
	movl \tekst_len, %edx
	int $0x80 
.endm

.globl main
main:
	ispisi poruka1, $poruka1_len
	unesi tekst, $tekst_max
	
	leal tekst, %edi

postavi_mala:
	cmpb $10, (%edi)
	je priprema
	orb $32, (%edi)
	incl %edi
	jmp postavi_mala
	
priprema:
	xorl %ecx, %ecx # brojac
	leal tekst, %edi
	jmp petlja1
	
pocetak:
	xorl %ecx, %ecx
	incl %edi
	
petlja1:
	cmpb $10, (%edi) #kraj
	je kraj_algoritma
	
	cmpb $97, (%edi)
	jb proveri_max
	cmpb $122, (%edi)
	ja proveri_max
	
	cmpb $'a', (%edi)
	je samoglasnik
	cmpb $'e', (%edi)
	je samoglasnik
	cmpb $'i', (%edi)
	je samoglasnik
	cmpb $'o', (%edi)
	je samoglasnik
	cmpb $'u', (%edi)
	je samoglasnik
	
	incl %edi
	jmp petlja1
	
samoglasnik:
	incl %ecx
	incl %edi
	jmp petlja1
	
proveri_max:
	cmpl best, %ecx
	jna pocetak
	
	movl %ecx, best
	xorl %ecx, %ecx
	incl %edi
	jmp petlja1
	
kraj_algoritma:
	cmpl best, %ecx
	jna konverzija
	
	movl %ecx, best

konverzija:
	movl best, %eax
	movl baza, %ebx
	leal dec_br, %edi
	
dec_cifra:
	xorl %edx, %edx
	divl %ebx
	addb $'0', %dl
	movb %dl, (%edi)
	incl %edi
	andl %eax, %eax
	jnz dec_cifra
	movb $0, (%edi)
	decl %edi
	leal dec_br, %esi
	
reverse:
	cmpl %edi, %esi
	jae ispis_rezultat
	movb (%esi), %cl
	movb (%edi), %ch
	movb %cl, (%edi)
	movb %ch, (%esi)
	decl %edi
	incl %esi
	jmp reverse
	
ispis_rezultat:
	ispisi poruka2, $poruka2_len
	ispisi dec_br, $dec_br_max	

kraj:
	movl $1, %eax
	movl best, %ebx
	int $0x80
