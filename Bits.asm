MODEL small
   .STACK 100h

.DATA


.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla

        xor ax,ax
        xor cx,cx

        mov bx,2

        mov cx,1
        mov al,080h
        call printNumBase

        call saltoL

        call setBit
        call printNumBase

        call saltoL

        mov cx,2
        mov al,07eh
        call printNumBase

        call saltoL

        call clrBit
        call printNumBase
        
        call saltoL

        mov cx,3
        mov al,80h
        call printNumBase

        call saltoL

        call notBit
        call printNumBase

        call saltoL
        
        mov cx,7
        mov al,80h
        call printNumBase

        call saltoL

        call getBit
        call printNumBase

        call saltoL

       
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

    setBit PROC
        push dx

        mov dl,1
        sal dl,cl
        or al,dl

        pop dx
        ret
    ENDP

    clrBit PROC
        push dx

        mov dl,0feh
        rol dl,cl
        and al,dl

        pop dx
        ret
    ENDP

    notBit PROC
        push dx

        mov dl,1
        rol dl,cl
        xor al,dl

        pop dx
        ret
    ENDP

    getBit PROC
        push cx
        
        inc cl
        ror al,cl
        
        jnc @@nocarry
        mov al,1
        jmp @@fin
        
        @@nocarry: 
        mov al,0
        
        @@fin:
        pop cx
        ret
    ENDP

printNumBase PROC
    push ax
    push bx
    push cx
    push dx


	mov cx,0 ;initialize counter in cero
    @@nxt:	
    xor dx,dx 
	div bx  ;divide DX:AX/BX
	push dx 
	inc cx
	cmp ax,0
	jne @@nxt

    @@verif:
    pop ax
	cmp ax,0ah ; check if the quotient of ax is less than 10
	jb @@less
	add ax,07h
		
    @@less: 
    add ax,30h ;convert quotient to ASCII

    mov dx,ax
	mov ah,02h
    int 21h
        
	loop @@verif

    pop dx
    pop cx
    pop bx
    pop ax

	ret
ENDP

saltoL PROC
    push ax
    mov dl,13
    mov ah,02h
    int 21h
    mov dl,10
    int 21h
    pop ax
    ret
ENDP

END