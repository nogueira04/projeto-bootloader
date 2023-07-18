%include "data.asm"
%include "imageandvideo.asm"

%macro transition 0
;macro pra fazer transicao de tela, pisca uma tela vermelha, depois reseta
   pusha
 
   call limpaTela
 
   mov ah, 0xb
   mov bh, 0  
   mov bl, [cinza] 
   int 10h 
 
   call delay
 
   mov ah, 0xb
   mov bh, 0
   mov bl, [preto]
   int 10h
 
   popa
%endmacro

%macro score 1
    pusha

    mov ax, %1

    mov di, score_n
    call tostring
    mov si, score_n

    popa
%endmacro

end:
   call limpaTela
   jmp $
menu:
   call limpaTela
   score 0
   mov ah, 0xb
   mov bh, 0
   mov bl, [preto]
   int 10h
 
   print titulo, [verde], 10,0
   print play, [cinza], 15, 15
   print quit, [cinza], 16, 15
   print sobre, [cinza], 28, 0


 
   call getchar
   cmp al, 0x08 ;leitura de backspace. Al é registrador padrão de leitura
   je end
   cmp al, 0x20 ;leitura do valor do espaço
   je logo1
   jmp menu

reset:
   ;reseta as string do jogo para tracejado novamente
   xor cx, cx 
  
   .loopreset1:
       cmp byte[di], 8
       je .donereset
       mov al, '_' 
       stosb 
       jmp .loopreset1  
 
   .donereset:
   ret
loserscreen:
   call delay
   call limpaTela
  
  
 
   mov ah, 0xb
   mov bh, 0
   mov bl, [preto]
   int 10h
 
   print loser, [branco], 10,0
   print backtomenu, [verde], 15, 3
   print exitgame, [vermelho], 16, 3
   print sobre, [cinza], 28, 0
   print score, [branco], 19, 3
   print score_n, [verde], 19, 9


   mov di,mctracejado
   call reset
   mov di,pepsitracejado
   call reset
   mov di, linkedintracejado
   call reset
   mov di, robocintracejado
   call reset
   mov di, volkstracejado
   call reset
   mov di, giorgioarmani
   call reset
   call getchar
   cmp al, 0x08 ;leitura de backspace. Al é registrador padrão de leitura
   je end
   cmp al, 0x20 ;leitura do valor do espaço
   je menu
   jmp loserscreen
winnerscreen:
   call delay
   call limpaTela
  
  
 
   mov ah, 0xb
   mov bh, 0
   mov bl, [preto]
   int 10h
 
   print winner, [branco], 10,0
   print backtomenu, [verde], 15, 3
   print exitgame, [vermelho], 16, 3
   print sobre, [cinza], 28, 0
   print score, [branco], 19, 3
   print score_n, [verde], 19, 9




   mov di,mctracejado
   call reset
   mov di,pepsitracejado
   call reset
   mov di, linkedintracejado
   call reset
   mov di, robocintracejado
   call reset
   mov di, volkstracejado
   call reset
   mov di, giorgioarmani
   call reset
   call getchar
   cmp al, 0x08 ;leitura de backspace. Al é registrador padrão de leitura
   je end
   cmp al, 0x20 ;leitura do valor do espaço
   je menu
   jmp winnerscreen

delay:
   mov bx, 2000 ;pegado o registrador inteiro
   mov cx, 2000
 
   .delayloop:
       dec bx
       nop
       jnz .delayloop
   dec cx
   jnz .delayloop
   ret
 
limpaTela:
   ;coloca o cursor na posicao (0,0)
   mov dx, 0
   mov bh, 0    
   mov ah, 0x2
   int 0x10
 
   ;printa 2500 caracteres em branco para limpar os caracteres da tela
   mov cx, 2500
   mov bh, 0
   mov al, 0x20
   mov ah, 0x9
   int 0x10
 
   ;retorna o cursor para a posicao (0,0)
   mov dx, 0
   mov bh, 0    
   mov ah, 0x2
   int 0x10
   ret
