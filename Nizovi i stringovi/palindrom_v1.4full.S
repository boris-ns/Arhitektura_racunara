# Palindrom full verzija
.section .data	
	strimg: .ascii "a\0"
    pomocni_string: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	greska: .byte 0
.section .text
.global main
main:
	movl $strimg, %esi
    movl $0, %ecx               #-- index za rad sa slovima
    movl $0, %edx               #-- index pomocnog stringa
na_kraj:                        # pomjera pokazivac do kraja stringa
	cmpb $0, 1(%esi)
	je je_li_slovo
	incl %esi
	jmp na_kraj
je_li_slovo:                      #----rad sa slovima i punjenje pomocnog stringa-------#
    cmpb $0, strimg(,%ecx,1)
    je pripremi_pomocni
    cmpb $'A' , strimg(,%ecx,1)      
    jb nije_slovo              #ako je trenutni karakter manji od 65 onda nije slovo 
    cmpb $'Z' , strimg(,%ecx,1)
    jbe veliko_slovo            #ako je trenutni karakter manji od 90 onda je veliko slovo 
    cmpb $'z' , strimg(,%ecx,1)
    ja nije_slovo               #ako je trenutni karakter veci od 122 onda nije slovo
    cmpb $'a' , strimg(,%ecx,1)
    jae malo_slovo              #ako je trenutni karakter veci od 97 onda je malo slovo
    jmp nije_slovo              #slucaj brojeva izmedju 90 i 97
veliko_slovo:
    addb $32, strimg(,%ecx,1)   #pretvori karakter u malo slovo i posalji ga u pomocni string
    jmp napuni_pomocni
malo_slovo:
    jmp napuni_pomocni         #samo ga posalji u pomocni string
nije_slovo:
    incl %ecx                   #uvecaj index ecx i skoci nazad u petlju provjere slova
    jmp je_li_slovo
napuni_pomocni:
    movb strimg(,%ecx,1), %al          #prebaci validan karakter u %al pa ga prebaci u pomocni string     
    movb %al, pomocni_string(,%edx,1)
    incl %edx    #uvecaj adresu pomocnog indeksa za sljedeci validan karakter
    incl %ecx    # uvecaj adresu standardnog indeksa
    jmp je_li_slovo
pripremi_pomocni:                       #rad sa pomocnim stringom
    movl $pomocni_string, %esi
na_kraj_p:                       
	cmpb $0, 1(%esi)
	je set_pointers_p
	incl %esi
	jmp na_kraj_p
set_pointers_p:                   
	movl %esi, %edi
	movl $pomocni_string, %esi              
provjera:                               #---------glavni mehanizam-----------
    movb (%esi), %al
	movb (%edi), %bl
	cmpb %bl, %al
	je update
	jmp igreska
update:
	cmpl %edi, %esi
	jae kraj                
	incl %esi
	decl %edi
	jmp provjera                        #---------glavni mehanizam------------
igreska: 
	incb greska                  
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
	
	
