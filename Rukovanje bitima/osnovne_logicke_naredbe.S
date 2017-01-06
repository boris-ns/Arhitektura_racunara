# Koriscenje osnovnih logickih naredbi
.section .data
.section .text
.globl main
main:
	# Koriscenje 'and' naredbe
	# Postavljanje najnizeg bita registra %al na 0
	movb $0b11010011, %al
	andb $0b11111110, %al

	# Postavljanje najviseg bita registra %al na 0
	andb $0b01111111, %al

	# Koriscenje 'or' naredbe
	# Postavljanje najnizeg bita registra %al na 1
	movb $0b11010010, %al
	orb  $0b00000001, %al

	# Postavljanje treceg bita registra %al na 1
	orb	 $0b00100000, %al

	# Koriscenje 'xor' naredbe
	# Menjanje sadrzaja poslednja 2 bita registra %al
	movb $0b11010010, %al
	xorb $0b00000011, %al

	# Koriscenje 'not' naredbe
	not %al

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80