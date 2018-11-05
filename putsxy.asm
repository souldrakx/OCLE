MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
		
   .DATA
	  mens	 db    'Hola Mundo',13,10,0 
	  
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
				call clrscr
				mov bh,5 ;x
				mov bl,5 ;y		
				mov dx,offset mens
				call putsxy
				
				
				mov ah,04ch	     ; fin de programa
				mov al,0            
				int 21h              

                ENDP


putsxy PROC
		push di
		push bp
		push ax
		push cx
		push si
		
		push ds
		pop es 
		
		mov di,0
		mov bp,0
		mov cx,0
		mov si,dx
@@ciclo:
		mov al,byte ptr[si]
		mov ES:[di],al
		inc si
		inc di
		inc cx
		cmp byte ptr[si],0
		jz @@int10
		jmp @@ciclo
		
@@int10:	
		
		mov ah,13h 
		mov al,1
		mov dh,bl
		mov dl,bh
		mov bh,0 
		mov bl,3
 		
		int 10h
		
		pop si
		pop cx
		pop ax
		pop bp
		pop di



		ret
		ENDP
	
	
; incluir procedimientos	
; ejemplo:
; funcionX PROC ; < -- Indica a TASM el inicio del un procedimiento
;               ; 
;               ; < --- contenido del procedimiento
;           ret
;           ENDP; < -- Indica a TASM el fin del procedimiento



         END
