MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA

    inicio db "Interupciones",13,10,'$'

    men1 db "Captura int21",13,10,'$'
    men2 db "Captura int16",13,10,'$'
    men3 db "Desplegar cadena int21",13,10,'$'
    men4 db "Desplegar cadena int10",13,10,'$'

    men5 db "Ingresa un caracter: ",'$'
    men6 db "Caracter ingresado: ",'$'

    men7 db "Cadena a mostrar: ",'$'

    salto db " ",13,10,'$'

    cad db "Hola Mundo",13,10,'$'


.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        lea dx, men1
        mov ah,09h
        int 21h
        call INT21_01

        lea dx, salto
        mov ah,09h
        int 21h

        lea dx, men2
        mov ah,09h
        int 21h
        call INT16_10

        lea dx, salto
        mov ah,09h
        int 21h

        lea dx,men3
        mov ah,09h
        int 21h
        call INT21_09

        lea dx,salto
        mov ah,09h
        int 21h

        ;call clrscr

        lea dx,men4
        mov ah,09h
        int 21h
        call INT10_13



        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
    ENDP

    INT21_01   PROC
        push ax
        push bx
        push dx

        lea dx, men5
        mov ah,09h
        int 21h
        
        
        mov ah,01h
        int 21h

        mov bl,al

        mov ah,02h
        mov dl,0ah
        int 21h

        lea dx,men6
        mov ah,09h
        int 21h
        
        mov ah,02h 
        mov dl,bl
        int 21h

        mov ah,02h
        mov dl,0ah
        int 21h

        pop dx
        pop bx
        pop ax

        ret
    ENDP

    INT16_10   PROC
        push ax
        push bx
        push dx

        lea dx,men5
        mov ah,09h
        int 21h
        
        mov ah,10h
        int 16h

        mov bl,al

        mov ah,02h
        mov dl,0ah
        int 21h

        lea dx,men6
        mov ah,09h
        int 21h

        mov ah,02h 
        mov dl,bl
        int 21h

        mov ah,02h
        mov dl,0ah
        int 21h

        pop dx
        pop bx
        pop ax

        ret
    ENDP

    INT21_09   PROC
        push ax
        push dx
        
        lea dx, men7
        mov ah,09h
        int 21h
        
        lea dx, cad
        mov ah,09h
        int 21h

        lea dx, salto
        mov ah,09h
        int 21

        pop dx
        pop ax

        ret
    ENDP

    INT10_13   PROC

        push bx
		push es
		push di
		push bp
		push ax
        push cx
		push dx

        lea dx, men7
        mov ah,09h
        int 21h
				
        mov bx,offset cad
				
		push ds
		pop es
		
        mov di,0
		mov bp,0
		mov cx,0
	
        @@ncad:	
        mov al,byte ptr[bx]
		mov ES:[di],al
		inc bx
		inc di
		inc cx 
		cmp byte ptr[bx],'$'
		jz @@imp
		jmp @@ncad
				
	    @@imp:	
				
		mov ah,13h 
		mov al,0
		mov bh,0 
		mov bl,2 
		
		mov dh,12
		mov dl,18
		int 10h
				
		pop dx
		pop cx
		pop ax
		pop bp
		pop di
		pop es
		pop bx

			ret

        ret
    ENDP
END