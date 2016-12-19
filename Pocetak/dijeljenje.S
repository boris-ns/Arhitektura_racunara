.section .data
.section .text
.global main
main:
    movl $20, %eax      #djeljenik
    movl $3, %ebx       #djelilac
    movl $0, %ecx       #kolicnik
    movl $0, %edx       #ostatak
provjera:
    cmpl %ebx, %eax
    jb kraj
djeljenje:
    cmpl %ebx, %eax
    jc izrac_ostatak
    subl %ebx, %eax
    incl %ecx
    jmp djeljenje
izrac_ostatak:
    subl %eax, %ebx
    movl %ebx, %edx
kraj:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
