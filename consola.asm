.MODEL small
	.STACK 100h

.DATA

.CODE
	Principal PROC
		push ds 			; Metes la dirección del PSP a la pila
		push @data 	; Metes la dirección del segmento de datos
		pop ds
		pop es
				
		mov si,82h		;Apartir de esta direccion se encuentra la cadena
		mov bx ,10
		xor ax,ax
				
		@@cadnum:
		cmp byte ptr es:[si],0dh	;compara si en la cadena hay un ENTER
		je @@fin
		;Convierte una cadena a numeros
		mov cl,es:[si]
		mul bx
		sub cl ,30h
		xor ch,ch
		add ax,cx
		inc si
		jmp @@cadnum

		@@fin:
		call numtraingular

		mov ax,4c00h
		int 21h
	ENDP

	numtraingular PROC
		push ax
		push bx
		push cx
		push dx
		mov cx,ax
		xor ax,ax
		mov bx,1
		mov bp,2
		
		@@tria:
		mov ax,bx
		
		inc bx
		mul bl
		div bp
		;xor ah,ah

		call printNumBase
		call saltoL

		loop @@tria

		pop dx
		pop cx
		pop bx
		pop ax

		ret
	ENDP

	saltoL PROC
        push ax
        push dx
        mov dl,13
        mov ah,02h
        int 21h
        mov dl,10
        int 21h
        pop dx
        pop ax
        ret
    ENDP

	printNumBase PROC
        push ax
		push bx
		push cx
		push dx

        mov bx,10


        mov cx,0 ;initialize counter in cero
        @@nxt:	
        xor dx,dx 
        div bx  ;divide DX:AX/BX
        push dx 
        inc cx
        cmp ax,0
        jne @@nxt

        @@verif:
        pop ax
        cmp ax,0ah ; check if the quotient of ax is less than 10
        jb @@less
        add ax,07h
            
        @@less: 
        add ax,30h ;convert quotient to ASCII

        mov dx,ax
        mov ah,02h
        int 21h
            
        loop @@verif

		pop dx
		pop cx
		pop bx
		pop ax
        

        ret
    ENDP
END