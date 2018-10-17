MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA
    dureza db 51
    carbono db 6
    malea db 57         ;Variables

    men1 db 'Grado 10',0
    men2 db 'Grado 9',0
    men3 db 'Grado 8',0
    men4 db 'Grado 7',0
    men5 db 'Grado 6',0
    men6 db 'Grado 5',0     ;Mensajes

.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        cmp byte ptr[dureza],50
        ja @@x
        cmp byte ptr[carbono],7
        jb @@y
        cmp byte ptr[malea],56
        ja @@z              ;Compara con cada uno de las variables

        lea dx,men6         ;Al no cumplir ninguna de las condiciones muestra grado 5
        jmp @@Fin

    @@x:
        cmp byte ptr[carbono],7
        jb @@xy
        cmp byte ptr[malea],56
        ja @@xz
        lea dx,men5         ;Si cunple con x solamente se impreme grado 6
        jmp @@Fin

    @@xy:
        cmp byte ptr[malea],56
        ja @@xyz
        lea dx,men2         ;Si cumples solo con 2 condiciones (1y2) imprime grado 9
        jmp @@Fin
    
    @@xz:
        lea dx,men4
        jmp @@Fin           ;Imprime al cumplir (1y3) grado 7
    
    @@xyz:
        lea dx,men1
        jmp @@Fin           ;Si las tras condiciones estan activas mustra grado 10

    @@y:
        cmp byte ptr[malea],56
        ja @@yz
        lea dx,men5
        jmp @@Fin           ;Solo esata activo 2 mustra grado 6

    @@yz:
        lea dx,men3
        jmp @@Fin           ;Si esta activo(2y3) imprime grado 8

    @@z:
        lea dx,men5
        jmp @@Fin           ;Si esta activo 3 imprime grado 5

    @@Fin:
        call puts

        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
        ENDP
END