MODEL small
   .STACK 100h

.DATA



.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla



       
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
END