;Programe el procedimiento "substr" el cual almacena en una cadena una copia de una porción de otra cadena. 
;Recibe en SI un apuntador a una cadena fuente, en DI un apuntador a la cadena destino, 
;en AL la posición inicial a copiar y en CL la cantidad de caracteres.  
;Si la cadena es más corta que los caracteres solicitados en CL, el procedimiento copia todos los posibles. 
;Si la posición en AL es mayor que la longitud de la cadena, el procedimiento retorna un -1 en AH, caso contrario retorna 0. 





MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA
    cad2 db 100 dup(?)
    inicio db "Metodo SUBSTR",13,10,0
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


        mov si,offset cad
        mov di,offset cad2
        mov al,1
        mov cl,5
        call my_substr

        
        mov dx,offset men1
        call puts

        mov dx,offset cad2
        call puts

       
        mov ah,04ch	     ; fin de programa
		mov al,0         ;
		int 21h           ; 
        
        
    ENDP
    
    ;-----Substr--------------------
    my_substr PROC
        push di
        push si

        mov ah,0
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

        add si,ax   ;Indica donde empesara acopiar la cadena

        cmp ax,di
        ja @@retur
        mov ah,-1
        jb @@fin
    ;---------------------------

        
    @@retur:
        mov ah,[si]     ;Copia el contenido de la cadena fuente a ah 
        inc si          ;incrementa si
        mov [di],ah     ;Copia lo que contiene ah hacia la cadena destino
        inc di          ;incrementa di

        loop @@retur    ;repite deacuerdo al valor de cl

        @@fin:
        pop si
        pop di
        ret
    ENDP
    ;----Fin_Substr-----------------
END