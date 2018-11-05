MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA
    inicio db "Metodo Erase",13,10,0
    men db "Cadena principal: ",0
    men1 db "Cadena resultado: ",0
    cad db "Hola Mundo",13,10,0



.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        mov dx,offset inicio
        call puts

        mov dx,offset men
        call puts
        
        mov dx,offset cad
        call puts


        mov al,2
        mov cl,4
        call erase

    

        lea dx,men1
        call puts

        lea dx,cad
        call puts

       
        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
    ENDP  
        ;-----Erase--------------------

    erase PROC
        push di
        push dx
        push bx
        push si

        mov ah,0
        mov ch,0
        mov bx,0
        mov di,0

        ;----------------------------
        push ax
        @@comp:             ;Mide el tama;o de la cadena y lo
                            ;compara con el valor de al
        mov ah,cad[bx]      ; si purea el tamanio de la cadena
        cmp ah,0            ;se sale
        
        inc bx
        inc di
        jne @@comp

        pop ax

        mov bx,ax
        mov si,ax

        cmp ax,di
        ja @@retur
        mov ah,-1
        jb @@fin
        ;---------------------------
        
        
        @@retur:
        mov cad[bx],20h ;Limpia los espacios a modificar
        inc bx
        loop @@retur

        @@retur2:
        mov ah,cad[bx]  ;copia el contenido de la cadena 
        inc bx
        mov cad[si],ah  ; y lo pasa a la posicion que se limpio anteriormente
        inc si

        cmp ah,0
        jne @@retur2

        @@fin:
        pop si
        pop bx
        pop dx
        pop di

        ret
    ENDP
    ;----Fin_Erase-----------------


END