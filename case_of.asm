MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS
		
		CR EQU 13
		LF EQU 10
		
   .DATA
      mens1 	 db  'Presiona a,b,c o d',CR,LF,0
	  mens2 	 db  'Opcion ',0

   .CODE


    Principal  	PROC
				
				mov ax,@data
				mov ds,ax
				call clrscr

				
	@fallo:	mov  dx,offset mens1
				
				call puts
				
				call getch
				
				mov  dx,offset mens2
				cmp al,'a'
				jz @@case1
				
				cmp al,'b'
				jz @@case2
				
				cmp al,'c'
				jz @@case3
				
				cmp al,'d'
				jz @@case4
				jmp @fallo
	
	@@case1:    mov al,'a'
				jmp @@out
	
	@@case2:    mov al,'b'
				jmp @@out
	
	@@case3:    mov al,'c'
				jmp @@out
	
	@@case4:    mov al,'d'
				
	@@out:		call puts
				call putchar

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