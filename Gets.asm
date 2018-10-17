MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA

    cad db 100 dup(?),10,13,0

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

        ;mov dx,offset cad

        mov si,dx

    @@leer:
        mov ax,0000
        mov ah,01h
        int 21h
       

        cmp al,08h
        je @@backspace

    @@cap:
        mov cad[si],al
        inc si

        cmp al,0dh
        ja @@leer
        jb @@leer
        je @@print

        

    @@backspace:

        cmp dx,si
        je @@leer
        
        push ax
        mov ah, 02h          
        mov dl, 20h          
        int 21h               
        mov dl, 08h         
        int 21h

        dec si
        pop ax
        mov cad[si],al
        
        jmp @@leer

    @@back2:
        mov ah,08h
        mov dl,08h
        int 21

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