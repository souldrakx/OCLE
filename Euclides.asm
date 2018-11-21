MODEL small
   .STACK 100h


.DATA


.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call myclrscr     ;limpiar pantalla

        xor ax,ax
        xor bx,bx   ;Limpiar registros

        mov al,78
        mov bl,36

        call mcd    ;Llamae funcion

        mov bx,10 ;base a transformar

        call printNumBase ;Imprime el mcd

        
       
        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
          
    ENDP

    myclrscr PROC
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

    mcd PROC
        push dx

        cmp bl,0 ;comprueba que el balor de l no sea 0
        je @@fin

        div bl      ;Divide AX entre BL
        cmp ah,0    ;Si el residuo es 0 se encontro el mcd
        je @@fin

                    ;Caso contrario intercambia valores  y vuelve a llamr a la funcion
        mov dx,ax   ;;Si no uso un registro extra no funciona, no se por que??????
        mov ax,bx
        mov bl,dh
        call mcd    ;Llama a la funcion
        jmp @@fin   ;Tambien si no le digo que termine se cilca el programa

        @@fin:

        pop dx

        ret

    ENDP

    printNumBase PROC
        mov cx,0 
        @@nxt:	
        mov dx,0 
		div bx  
		push dx 
		inc cx
		cmp ax,0
		jne @@nxt

        @@verif:
        pop ax
		cmp ax,10 
		jb @@less
		add ax,7
		
        @@less: 
        add ax,30h

        mov ah,02h
        mov dx,ax
        int 21h 
		loop @@verif
        ret
    ENDP
END