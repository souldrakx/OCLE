MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS
		CR EQU 13
		LF EQU 10
		
   .DATA
	  mens	 db    'Mostrando con interrupcion 21h, servicio 9',CR,LF,'$' ;47 caracteres
	  mens2	 db    'Mostrando con interrupcion 10h, servicio 13h',0dh,0ah,'$' ;48 caracteres
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
				call clrscr
				call prnt21
				call prntBIOS
				

				
				
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 

                ENDP

prnt21   PROC
		push dx
		push ax
		mov dx,offset mens
		mov ah,09 
		int 21h  
		pop ax
		pop dx
		ret		
		ENDP
				
prntBIOS PROC
				push bx
				push es
				push di
				push bp
				push ax
				push cx
				push dx
				mov bx,offset mens2
				
				push ds
				pop es
				mov di,0
				mov bp,0
				mov cx,0
	@@ciclo:	mov al,byte ptr[bx]
				mov ES:[di],al
				inc bx
				inc di
				inc cx 
				cmp byte ptr[bx],'$'
				jz @@int10
				jmp @@ciclo
				
	@@int10:	
				
				mov ah,13h ; Servicio 13
				mov al,0
				mov bh,0 
				mov bl,2 
				
				mov dh,1
				mov dl,0
				int 10h
				
				pop dx
				pop cx
				pop ax
				pop bp
				pop di
				pop es
				pop bx

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
