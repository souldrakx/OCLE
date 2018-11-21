MODEL small
   .STACK 100h

.DATA

    flecha db "->",'$'
    disco db "Disco ",'$'
    p db ": ",'$'
    salto db " ",13,10,'$'


.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call myclrscr     ;limpiar pantalla

        xor ax,ax
        xor bx,bx
        xor cx,cx
        xor dx,dx

        mov al,3        ;Cantidad de discos
        mov bl,'A'      ;Comienzo
        mov cl,'B'      ;Auxiliar
        mov dl,'C'      ;Fin

        call TorresDeHanoi  ;Llama la funcion

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

    TorresDeHanoi PROC
        push ax
        push bx
        push cx
        push dx

        cmp al,1    ;Pregunta si al es 1
        jne @@else  ;caso contrio salta

        call Impcad ;Imprime printf("Disco %d: %c->%c\n",n,com,fin);
                    ;Realice el codigo en c para tener una idea de como funciona
        call saltoL ;Salto de linea
            
        jmp @@fin   ;Termina el procedimineto

    
        @@else:

        push ax
        push bx
        push cx
        push dx     ;Se guardadn los valores antes de la recurcividad
                
        dec al      ;Al ser mayor a 1 se decrementa el valor de al
        xchg cl,dl  ;Y se intecambian los valores de B y C

        call TorresDeHanoi ;TorresDeHanoi(n-1,com,fin,aux);

        pop dx
        pop cx
        pop bx
        pop ax
        
        call Impcad ;Imprime printf("Disco %d: %c->%c\n",n,com,fin);
        
        call saltoL ;Salto de linea

        push ax
        push bx
        push cx
        push dx     ;Se guardadn los valores antes de la recurcividad


        dec al      ;Al ser mayor a 1 se decrementa el valor de al
        xchg cx,bx  ;Y se intecambian los valores de A y B


        call TorresDeHanoi ;TorresDeHanoi(n-1,aux,com,fin);

        pop dx
        pop cx
        pop bx
        pop ax

        @@fin:
        pop dx
        pop cx
        pop bx
        pop ax

        ret     ;Fin del procedimiento
    ENDP

    printNumBase PROC
        mov bx,10
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

    Impcad PROC ;printf("Disco %d: %c->%c\n",n,com,fin);

        push ax
        push bx
        push cx
        push dx

        push ax
        push dx

        mov dx,offset disco
        mov ah,09h
        int 21h

        pop dx
        pop ax

        push ax
        push bx
        push cx
        push dx

        call printNumBase

        mov dx,offset p
        mov ah,09h
        int 21h

        pop dx
        pop cx
        pop bx
        pop ax

        mov dh,dl
        mov dl,bl
        mov ah,02h
        int 21h
            
        push ax
        push dx

        mov dx,offset flecha
        mov ah,09h
        int 21h

        pop dx
        pop ax

        mov dl,dh
        int 21h 

        pop dx
        pop cx
        pop bx
        pop ax
                        
        ret
    ENDP

END