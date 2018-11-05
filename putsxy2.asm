MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA
    
    inicio db "Metodo Putsxy",13,10,'$'
    cad db "Hola mundo",13,10,'$'

.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        lea dx,inicio
        mov ah,09h
        int 21h

        lea dx,cad
        mov bh,5
        mov bl,5
        call putsxy
       
        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
    
    ENDP
        
    putsxy PROC
        push ax
		push cx
		push di
		push bp
		push si 
		
		push ds
		pop es 
		
		mov di,0
		mov bp,0
		mov cx,0
		mov si,dx
        
        @@ncad:
		mov al,byte ptr[si]
		mov ES:[di],al
		inc si
		inc di
		inc cx
		cmp byte ptr[si],'$'
		jz @@imp
		jmp @@ncad
		
        @@imp:	
		
		mov ah,13h 
		mov al,1
		mov dh,bl
		mov dl,bh
		mov bh,0 
		mov bl,3
 		
		int 10h
		
		pop si
		pop bp
		pop di
		pop cx
		pop ax

		ret
    ENDP
END