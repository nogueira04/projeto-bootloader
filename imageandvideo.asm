
; FUNÇÕES DE VÍDEO E PRINTAR IMAGEM
%macro print 4 
   pusha 
 
   mov ah, 02h
   mov bh, 0
   mov dh, %3 
   mov dl, %4
   int 10h  
 
   mov si, %1
   mov bl, %2
   call print_string
 
   popa  
%endmacro

printimage:                   

	push dx
	push cx
	

	.loop:
		lodsb   
		cmp al,'0'
		je .fim

		cmp al,'.'	
		je .next_line

		.next_pixel:
			call printpixel
			inc cx
			jmp .loop	
		
		.next_line:	
			
			pop cx      		
			push cx

			inc dx
			lodsb
			jmp .next_pixel
		
		.fim:
			pop cx
			pop dx
			ret 

%macro stoi 1:                ; mov si, string
    

    mov si, score_n
    .loop1:
      push %1
      lodsb
      mov cl, al
      pop %1
      cmp cl, 0        ; check EOF(NULL)
      je .endloop1
      sub cl, 48       ; '9'-'0' = 9
      mov bx, 10
      mul bx           ; 999*10 = 9990
      add %1, cx       ; 9990+9 = 9999
      jmp .loop1
    .endloop1:
      

%endmacro

printpixel:      	  		
        mov ah, 0ch
        mov bh, 0
        int 10h
        ret

set_mode:
  mov ah, 0 
  mov al, 13h 
  int 10h

  mov ah, 0xb 
  mov bh, 0
  mov bl, 3 
  int 10h

  mov ah, 0xe 
  mov bh, 0   
  mov bl, 0xf 
  ret

print_string:
   lodsb
   cmp al,8
   je doneprint
 
   mov ah, 0xe
   mov bh, 0
   int 10h
 
   jmp print_string
 
   doneprint:
       mov ah, 0eh
       mov al, 0xd
       int 10h
       mov al, 0xa
       int 10h
    ret

check_char:
 	mov ah, 01h
	int 16h
	ret

flush:                ; apaga o buffer do teclado
 	mov ah, 05h
	int 16h
	ret


clear:
        mov ah, 0
        mov al, 10h
        int 10h
        ret

strcmp:                             ; compara duas lihas armazanadas em si e di
	.loop1:
		lodsb
		cmp byte[di], 0
		jne .continue
		cmp al, 0
		jne .done
		stc
		jmp .done
		
		.continue:
			cmp al, byte[di]
    			jne .done
			clc
    			inc di
    			jmp .loop1

		.done:
			ret

putchar:
  mov ah, 0x0e
  int 10h
  ret

getchar:
  mov ah, 0x00
  int 16h
  ret

endl:
  mov al, 0x0a          ; line feed
  call putchar
  mov al, 0x0d          ; carriage return
  call putchar
  ret

prints:             ; mov si, string
  .loop:
    lodsb           ; bota character em al 
    cmp al, 0
    je .endloop
    call putchar
    jmp .loop
  .endloop:
  ret

reverse:              ; mov si, string
  mov di, si
  xor cx, cx          ; zerar contador
  .loop1:             ; botar string na stack
    lodsb
    cmp al, 0
    je .endloop1
    inc cl
    push ax
    jmp .loop1
  .endloop1:
  .loop2:             ; remover string da stack        
    pop ax
    stosb
    loop .loop2
  ret

tostring:              ; mov ax, int / mov di, string
  push di
  .loop1:
    cmp ax, 0
    je .endloop1
    xor dx, dx
    mov bx, 10
    div bx            ; ax = 9999 -> ax = 999, dx = 9
    xchg ax, dx       ; swap ax, dx
    add ax, 48        ; 9 + '0' = '9'
    stosb
    xchg ax, dx
    jmp .loop1
  .endloop1:
  pop si
  cmp si, di
  jne .done
  mov al, 48
  stosb
  .done:
  mov al, 0
  stosb
  call reverse
  ret

printline:            

	.loop1:
		lodsb	
		cmp al, 0
		je .fim
		call putchar
		jmp .loop1
	
	.fim:
		ret



_fim:                          ; finaliza e retorna para o kernel
	.wait:
		call .getchar
		cmp al, 13
		je .fim
		jmp .wait

	.getchar:
	 	mov ah, 00h
		int 16h
		ret

	.fim:	
		;call _clear
		;ret

		pop ax
		jmp start
