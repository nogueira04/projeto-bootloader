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

    pusha

    mov si, %1 
    mov bl, 1  
    .loopcheck:
        lodsb
        cmp al, 8 
        je .endcheck
        cmp al, 95 
        je .found_underscore
        jmp .loopcheck
    
    .found_underscore: 
        xor bl, bl 
        jmp .endcheck
    
    .endcheck:
        cmp bl, 1 
        je %2.continue 
        popa
        

%endmacro

%macro charcmp 2
    pusha

    mov di, %1
    mov si, %2

    mov dl, 0 
    mov bl, al
    sub bl, 32 
    .loopcmp:
        lodsb 
        cmp al, 8
        je .endloop
        cmp al, bl 
        je .equal
        jne .notequal
        .equal:
            inc dh
            inc dl 
            mov byte[di], bl 
            inc di 
            jmp .loopcmp
        .notequal:
            inc di  
            jmp .loopcmp
        .endloop:
            print %1,[branco],5,10
            cmp dl, 0
            jne .gotright
            je .gotwrong
        .gotwrong:
            inc cx 
            print_errors cx
            pusha                          
            popa                  
        .gotright:
            pusha
            popa
           
%endmacro

%macro game 5

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
    call set_mode 
    call delay 
    call menu


fim:
    jmp $

