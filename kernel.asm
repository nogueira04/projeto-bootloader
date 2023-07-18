org 0x7e00
jmp 0x0000:start

%include "menu_winner_loser_functions.asm"

%macro print_errors 1
    pusha

    mov si, erroimage

    cmp %1, 1
    je .umerro

    cmp %1, 2
    je .doiserros

    cmp %1, 3
    je .treserros

    .umerro:  
        mov cx,68
        mov dx,60
        jmp .printerr
    
    .doiserros:
        mov cx,84
        mov dx,60
        jmp .printerr
    
    .treserros:
        mov cx,100
        mov dx,60
        jmp .printerr
 
    .printerr:
        call printimage
        popa
    
%endmacro


%macro check_if_won 2
;%1 = tracejado
;%2 = self

    pusha

    mov si, %1 ; move a string tracejada para si
    mov bl, 1  ; flag para saber se achou "_"
    .loopcheck:
        lodsb
        cmp al, 8 ; checa se a string acabou
        je .endcheck
        cmp al, 95 ; checa se o char é _
        je .found_underscore
        jmp .loopcheck
    
    .found_underscore: ; se achar o underscore significa que não ganhou, já que a string não tá completa
        xor bl, bl ;zera a flag
        jmp .endcheck
    
    .endcheck:
        cmp bl, 1 
        je %2.continue ;passa pra próxima logo
        popa
        

%endmacro

%macro charcmp 2
;1 ==  mov di,stringtracejada(mc) 
;2 == mov si,stringresposta(mcdonalds)
    pusha
    mov di, %1
    mov si, %2

    mov dl, 0 ;  flag para saber se foi acertado a tentativa
    mov bl, al ; move o caractere pego no getchar e armazena em bl
    sub bl, 32 ; transformar minúsculo em maiúsculo
    .loopcmp:
        lodsb ; move o byte[si] para al e incrementa si(string com resposta)
        cmp al, 8 ; verifica se acabou a string
        je .endloop
        cmp al, bl ;compara o byte[di] com o caractere do getchar
        je .equal
        jne .notequal
        .equal:
            inc dh ;dh seria o score, que vai ser comparado com o tamanho da string
            inc dl 
            mov byte[di], bl ;move o caractere para o slot da string tracejada
            inc di ; incrementa a posição da string pontilhada
            jmp .loopcmp
        .notequal:
            inc di  ; incrementa a posição da string pontilhada
            jmp .loopcmp
        .endloop:
            ;update_score dh
            print %1,[branco],5,10
            cmp dl, 0
            jne .gotright
            je .gotwrong
        .gotwrong:
            inc cx ;errou a tentativa, cl seria o número de erros
            print_errors cx
            pusha
            ;ret                            VELHOS
            popa                   ;; pusha -> di, sp, bp, bx, dx, cx, ax  ->> push cx
                                   ;; pusha -> di, sp, bp, bx, dx, NOVO cx, ax
                                   ;; popa -> 1 -> di, 2 -> sp, 3 -> bp 4 -> bx, 5-> dx 6-> cx, 7 -> ax
        .gotright:
            pusha
            popa
            ;ret
%endmacro

%macro game 5
; %1 = logo
; %2 = tracejado
; %3 = resposta
; %4 = próx função (ou mesma)
; %5 = frase da fase

    pusha

    call set_mode
    mov si, %1
    call printimage
    print %5, [branco], 0, 0
    xor cx, cx

    %%loop:
        cmp cx, 3
        je %%lost

        call getchar
        charcmp %2, %3
        check_if_won %2, %4 
        jmp %%loop

    %%lost:
        call loserscreen
        popa



%endmacro

logo1:
    game mc25, mctracejado, mcresposta, logo1, fase1
    .continue:
        call delay
        xor cx, cx
        call limpaTela
        score 1
    

logo2:
    game pepsi25, pepsitracejado, pepsiresposta, logo2, fase2
    .continue:
        call delay
        xor cx, cx
        call limpaTela
        score 2 

logo3:
    game linkedin25, linkedintracejado, linkedinresposta, logo3,fase3
    .continue:
        call delay
        xor cx, cx
        call limpaTela
        score 3

logo4:
    game volks25, volkstracejado, volksresposta, logo4,fase4
    .continue:
        call delay
        xor cx, cx
        call limpaTela
        score 4

logo5:
    game giorgioarmani25, giorgioarmani, giorgioarmaniresposta,logo5 ,fase5
    .continue:
        call delay
        xor cx, cx
        call limpaTela
        score 5

logo6:
    game robocin50, robocintracejado, robocinresposta,logo6 ,fase6
    .continue:
        score 6
        call delay
        call winnerscreen

start:
    xor ax, ax  
    mov ds, ax  
    mov cx, ax 
    mov es, ax
    mov dx, ax
    call set_mode ;chamar modo de vídeo
    call delay 
    call menu
   ; call game

fim:
    jmp $

