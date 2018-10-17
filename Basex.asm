MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA

    mens db "Resultado: " ,0

.CODE

    Principal  	PROC
		mov ax,@data 	;Inicializar DS al la direccion
		mov ds,ax     	; del segmento de datos (.DATA)

		call clrscr     ;limpiar pantalla


        mov ax,94Ah ;numero a convertir
        mov bx,8    ;base
        

        mov dx,offset mens
        call puts
        call printNumBase
       
        mov ah,04ch	     ; fin de programa
		mov al,0             ;
		int 21h              ; 
        
        
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
		call putchar 
		loop @@verif
        ret
    ENDP
END