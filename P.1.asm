MODEL small
   .STACK 100h

.DATA



.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        xor ax,ax
        mov ax,17

        call ConjCollatz

        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
          
    ENDP

    clrscr PROC
        mov ah,02h
        mov dx,0000h
        int 10h

        mov ax,0600h
        mov bh,07
        mov cx,0000h
        mov dx,194fh
        int 10h

        ret
    ENDP

    saltoL PROC
        push ax
        mov dl,13
        mov ah,02h
        int 21h
        mov dl,10
        int 21h
        pop ax
        ret
    ENDP

    ConjCollatz PROC

        
        mov bx,02h

        @@return:
        mov cx,ax
        div bl

        cmp ah,0
        jne @@impar

        cmp al,


        @@impar:
        mov ax,cx
        mul ax,3
        inc ax
        jmp@@return




    ENDP
END