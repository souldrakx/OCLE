MODEL small
   .STACK 100h

   .DATA
      numero db "65535",'$'

   .CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr
        xor ax,ax

        call inverza


		mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 

    ENDP
          
          
    inverza PROC

        push ax
        push bx
        push dx
        push cx
                
        mov bx,offset numero
        mov dx,bx
        mov ah,09h
        int 21h

        mov si,0
                
        @@while:
        cmp byte ptr[bx+si],'$'
        je @@salto
        mov al,byte ptr[bx+si]
        push ax              
        inc cx
        inc si
        jmp @@while

        @@salto:
        mov al,10
        mov dl,al
        mov ah,02h
        int 21h
        @@impresion:
        cmp cx,0
        je @@fin2
        pop ax

        mov dl,al
        mov ah,02h
        int 21h
        mov ax,0
        dec cx
        jmp @@impresion
        @@fin2:

        pop cx
        pop dx
        pop bx
        pop ax

        ret
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


    END
