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

        mov cx,01h
        mov al,01h      ;Se inicializan cx y al
        
    @@piram:
        add al,30h      ;Suma a al 30h para imprimir en ascii '1'
        call putchar    ;Funcion putchar
        sub al,30h      ;Se resta a al 30h
        
        loop @@piram    ;ciclo siempre y cuando cx sea mayor a 0 se encarga de imprimir las repeticiones(22,333,4444)
        
        inc al          ;Se incrementa al para poder imprimir el siguiente numero
        push ax         ;SE guarda ax en la pila
        
        mov ah,02h  ;Salto de linea
        mov dl,0ah  ;
        int 21h     ;

        pop ax          ;Se recupera ax

        mov cl,al       ;El valor de al pasa hacia cl
        cmp cx,09h      ;Si el valor de cl es menor a9 salta hacia la etiqueta
        jbe @@piram     ; en caso contrario sale del ciclo



        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
        ENDP
END