MODEL small
   .STACK 100h

.DATA

    noes db "No es palindromo",'$'
    sies db "Si es palindromo",'$'
    cad db 255 (?)
    

.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla
        xor ax,ax

        mov dx, offset cad
        call mygets

        call saltoL
        call toUpper

        call palin



        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
          
    ENDP

    clrscr PROC
        mov ah,02h
        mov dx,0000h
        int 10h

        mov ax,0600h
        mov bh,07
        mov cx,0000h
        mov dx,194fh
        int 10h

        ret
    ENDP

    saltoL PROC
        push ax
        push dx
        mov dl,13
        mov ah,02h
        int 21h
        mov dl,10
        int 21h
        pop dx
        pop ax
        ret
    ENDP

    mygets PROC
        push ax
        push bx
        push cx
        push dx

        mov si,dx

     @@leer:
    
        mov ax,0000
        mov ah,01h
        int 21h

        cmp al,20h
        je @@leer

        cmp al,08h
        je @@backspace

        cmp al,0dh
        je @@fin

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

        @@fin:

        mov al,'$'
        mov [si],al

        pop dx
        pop cx
        pop bx
        pop ax

        ret

    ENDP

    toUpper PROC
    push si
    push dx
    push ax

    xor ax,ax
    xor si,si

    mov si,offset cad

    @@lop:
    mov al,[si]
    cmp al,'$'
    je @@finU
    cmp al,61h
    jb @@mayus 
    inc si
    jmp @@lop

    @@mayus:
    add al,20h
    mov [si],al
    inc si
    jmp @@lop

    @@finU:

    pop ax
    pop dx
    pop si

    ret
    ENDP

    palin PROC

        push ax
        push bx
        push cx
        push dx
        push si

        mov dx, offset cad

        mov si,dx

        @@tamcad:
        mov al,[si]
        cmp al,'$'
        je @@cmpcad
        inc si
        jmp @@tamcad

        @@cmpcad:
        dec si
        mov bx,dx
        
        @@palin:
        mov al,[si]
 
        mov cl,[bx]

        cmp al,cl
        jne @@noes

        cmp si,bx
        jbe @@sies

        dec si
        inc bx
        jmp @@palin

        @@incal:
        dec si
        jmp @@palin
        
        @@inccl:
        inc bx
        jmp @@palin

        @@sies:

        mov dx,offset sies
        mov ah,09h
        int 21h
        jmp @@finp


        @@noes:
        mov dx,offset noes
        mov ah,09h
        int 21h

        @@finp:
        pop si
        pop dx
        pop cx
        pop bx
        pop ax

        

        ret
    ENDP
END