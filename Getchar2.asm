MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA

    cad db 100 dup(?)

    inicio db 'Metodo GETS',13,10,0
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

        mov si,offset cad
        ;mov bx,dx
        
        ;mov si,dx

    @@leer:
    
        mov ax,0000
        mov ah,01h
        int 21h

        cmp al,08h
        je @@backspace

        cmp al,0dh
        je @@print

        cmp al,20h
        je @@cap

        cmp al,41h
        jb @@ncap
        cmp al,7Ah
        ja @@ncap
        cmp al,5Ah
        jbe @@cap
        cmp al,61h
        jb @@ncap

        

    @@cap:
        mov [si],al
        inc si

        jmp @@leer

    @@backspace:
        mov dx,offset cad
        cmp dx,si 
        je @@back2

        push ax

        mov ah,02h
        mov dl,20h
        int 21h
        mov dl,08h
        int 21h

        dec si
        mov [si],al
        pop ax

        

        jmp @@leer

        

    @@back2:
        mov ah,02h
        mov dl,20h
        int 21h

        jmp @@leer

    @@ncap:
        mov ah,02
        mov dl,8
        int 21h
        mov dl,32
        int 21h
        mov dl,8
        int 21h
        
        jmp @@leer

        


    @@print:    
        mov dx,offset mens1
        call puts


        mov dx,offset cad
        call puts


       
        mov ah,4ch	     ; fin de programa
		mov al,0h            ;
		int 21h              ; 
        
        
        ENDP
END