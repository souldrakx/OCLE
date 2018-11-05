MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS
		CR EQU 13
		LF EQU 10
		
   .DATA
	  ;cadena	 db    '65389',0
	  cadena	 db    '1234',0
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				mov dx,offset cadena
				mov bx,offset cadena
				call puts			
				mov ax,CR
				call putchar
				mov ax,LF
				call putchar
				call str2dec
				mov bx,16 ;    BASE 
				call printNumBase
				mov ah,04ch	  
				mov al,0             
				int 21h              

                ENDP

				
	str2dec		PROC
				push di
				push bx
				push cx
								

				mov ax,0
				mov cx,0
				mov di,10

@@repeat:		cmp byte ptr[bx],0
				jz @@out
				mul di
				mov cl,[bx]
				sub cx,48
				add ax,cx
				mov cx,0
				
				inc bx
				jmp @@repeat

@@out:							
				pop cx
				pop bx
				pop di
				
				ret
				ENDP
	
	
	printNumBase	PROC
					push ax
					push bx
					push cx
					push dx
										
					mov dx,0
					mov cl,0
					cmp bx,1
					jle @@fin
					
	@@while:		cmp ax,0
					jz @@out
					div bx
					push dx
					mov dx,0000
					inc cl
					jmp @@while
	
	@@out:			pop ax
					cmp ax,10
					jb @@num
					add ax,7
	@@num:			add ax,48
					call putchar
					cmp cl,1
					jz @@fin
					dec cl
					jmp @@out
	@@fin:		
					pop dx
					pop cx
					pop bx
					pop ax
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
