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


putchar:
  mov ah, 0x0e
  int 10h
  ret

getchar:
  mov ah, 0x00
  int 16h
  ret


reverse:             
  mov di, si
  xor cx, cx          
  .loop1:             
    lodsb
    cmp al, 0
    je .endloop1
    inc cl
    push ax
    jmp .loop1
  .endloop1:
  .loop2:              
    pop ax
    stosb
    loop .loop2
  ret

tostring:             
  push di
  .loop1:
    cmp ax, 0
    je .endloop1
    xor dx, dx
    mov bx, 10
    div bx            
    xchg ax, dx      
    add ax, 48       
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


_fim:                        
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
		pop ax
		jmp start
