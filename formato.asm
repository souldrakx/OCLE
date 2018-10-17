MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

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
END