# Program koji u unetom stringu pretvara velika slova u mala i obrnuto.
# Svi ostali znaci ostaju nepromenjeni!
.section .data
	unos_str: .ascii "Unesite string\: \0"
	unos_str_len = . - unos_str
	ispis_str: .ascii "Novi string\: \0"
	ispis_str_len = . - ispis_str

	str_max = 32
	str: .fill str_max, 1, 0
	str_duzina: .long 0

.section .text

.macro ispisi tekst, duzina
	movl $4, %eax
	movl $1, %ebx
	leal \tekst, %ecx
	movl \duzina, %edx
	int $0x80
.endm

.macro unesi tekst, duzina
	movl $3, %eax
	movl $0, %ebx
	leal \tekst, %ecx
	movl \duzina, %edx
	int $0x80
	movl %eax, str_duzina
.endm

.globl main
main:
	ispisi unos_str, $unos_str_len
	unesi str, $str_max

	leal str, %eax
	movb $0b00100000, %cl 		# maska za proveru
	movb $0b11011111, %ch		# maska za okretanje

petlja:
	cmpb $'\n', (%eax)
	je kraj

	testb $0b00100000, (%eax)			# Provera da li je znak veliko ili malo slovo
	jz upper_to_lower					# Velika i mala slova se razlikuju po 6. bitu
	jmp lower_to_upper
	
sledeci:
	incl %eax
	jmp petlja

lower_to_upper:
	cmpb $'a', (%eax)					# Provera da li je u opsegu malih slova
	jb sledeci
	cmpb $'z', (%eax)
	ja sledeci

	andb %ch, (%eax)					# Prebacivanje u velika
	jmp sledeci

upper_to_lower:
	cmpb $'A', (%eax)					# Provera da li je u opsegu velikih slova
	jb sledeci
	cmpb $'Z', (%eax)
	ja sledeci

	orb %cl, (%eax)						# Prebacivanje u mala
	jmp sledeci

kraj:
	ispisi ispis_str, $ispis_str_len
	ispisi str, str_duzina

	movl $1, %eax
	movl $0, %ebx
	int $0x80