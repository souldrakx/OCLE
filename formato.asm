MODEL small
   .STACK 100h

INCLUDE procs.inc
 
    LOCALS

.DATA

.CODE

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
END