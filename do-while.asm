MODEL small
   .STACK 100h


 INCLUDE procs.inc
 
       LOCALS

	.DATA
   
   
   
	.CODE
   
	Principal	PROC
				
				mov ax,@data
				mov ds,ax
				call clrscr
				
				mov cx,5
				mov ax,'e'
				mov bl,0
				
	 @while:	call putchar
				dec al
				inc bl
				cmp cl,bl
				jnz @while
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0         ;
				int 21h          ; 
			
			EndP

; incluir procedimientos	
; ejemplo:
; funcionX PROC ; < -- Indica a TASM el inicio del un procedimiento
;               ; 
;               ; < --- contenido del procedimiento
;           ret
;           ENDP; < -- Indica a TASM el fin del procedimiento

    END