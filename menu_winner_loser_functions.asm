%include "data.asm"
%include "imageandvideo.asm"

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
   cmp al, 0x08 
   je end
   cmp al, 0x20 
   je logo1
   jmp menu

reset:
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
   cmp al, 0x08
   je end
   cmp al, 0x20 
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
   cmp al, 0x08
   je end
   cmp al, 0x20 
   je menu
   jmp winnerscreen

delay:
   mov bx, 2000 
   mov cx, 2000
 
   .delayloop:
       dec bx
       nop
       jnz .delayloop
   dec cx
   jnz .delayloop
   ret
 
limpaTela:
   mov dx, 0
   mov bh, 0    
   mov ah, 0x2
   int 0x10
 
   mov cx, 2500
   mov bh, 0
   mov al, 0x20
   mov ah, 0x9
   int 0x10
 
   mov dx, 0
   mov bh, 0    
   mov ah, 0x2
   int 0x10
   ret
