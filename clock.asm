MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
      mens       db  'Hola Mundo',0
	contador db 0
	bandera  db 0
	
	segundos	dw 50
	minutos		dw 59
	horas		dw 23
	puntos		db ':',0
	salto		db 13,10,0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,0
				mov ds,ax
				mov bx,70h
				mov word ptr[bx],offset RSI
				mov [bx+2],cs
				
	
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				;mov ax,segundos
				
				@@while:
					cmp bandera,1
					jne @@while
						
						
					;=====================================	
						mov ax,horas
						call printDec
						
						mov dx,offset puntos
						call puts
					;=====================================	
						mov ax,minutos
						call printDec
						
						mov dx,offset puntos
						call puts
					;======================================
						mov ax,segundos
						call printDec
					
						mov dx,offset salto
						call puts
					;======================================
					
						cmp segundos,59						
						jb @@segs
						cmp minutos,59
						jb @@minuto
						cmp horas,23
						jb @@hora
						jmp @@dia
					
					;======================================	
						
				
				@@segs:
						inc segundos
						mov ax,segundos
						mov contador,0
						mov bandera,0
						jmp @@while
						
					;=====================================	
				@@minuto:
						mov segundos,0
						inc minutos
						mov contador,0
						mov bandera,0
						call clrscr
						jmp @@while
						
				@@hora:
						mov minutos,0
						mov segundos,0
						inc horas
						mov contador,0
						mov bandera,0
						jmp @@while
					;=======================================
				@@dia:
						mov horas,0
						mov segundos,0
						mov minutos,0
						jmp @@while
					;======================================	
					
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 

                ENDP
				
				RSI 		PROC ;Int 1CH
						inc contador
						cmp contador,18
						jne @@falso
						
						mov bandera,1
						
				@@falso:
						iret
				ENDP
				
				printDec PROC
							push ax
							push bx
							push cx
							push dx
							mov cx,2
							mov bx,10
							mov ah,0
					@@nxt:  mov dx,0
							div bx
							add al,'0'
							call putchar
							mov ax,dx
							push ax
							mov dx,0
							mov ax,bx
							mov bx,10
							div bx
							mov bx,ax
							pop ax
							loop @@nxt
							pop dx
							pop cx
							pop bx
							pop ax 
							ret
				ENDP
   END
