MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA
    cad db 100 dup(?)

    inicio db 'Metodo GETNUM',13,10,0
    mens db 'Escribe una cadena: ',0
    mens1 db 'Tu cadena es: ',0


.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        mov dx,offset inicio
        call puts

        mov dx,offset mens
        call puts

        mov si,00h

        @@leer:
        mov ax,0000
        mov ah,01h
        int 21h
        
        cmp al,30h
        ja @@leer
        cmp al,39h
        jb @@leer

        
        @@cap:        
        mov cad[si],al
        inc si

        cmp al,0dh
        ja @@leer
        jb @@leer
        je @@print

        @@cmp1:
        



@@print:    
        mov dx,offset mens1
        call puts


        mov dx,offset cad
        call puts

       
        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
        ENDP
END