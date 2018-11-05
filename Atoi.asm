MODEL small
   .STACK 100h



 INCLUDE procs.inc
 
       LOCALS
		CR EQU 13
		LF EQU 10
		
   .DATA
	  inicio     db    'Programa ATOI',13,10,0
	  original 	 db    'String: ',0
	  conversion db	   'Resultado: ',0
	  cadena	 db    '1234',0
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				mov dx,offset inicio
				call puts
				mov dx,offset original
				call puts 
				mov dx,offset cadena
				mov bx,dx
				call puts
				mov al,10
				call putchar
				mov dx,offset conversion
				call puts
				mov dx,bx
				
				
				mov ax,CR
				call putchar
				mov ax,LF
				call putchar
				
				call atoi
				
				
				mov bx,16 ;    BASE 
				call printNumBase
				
				mov ah,04ch	  
				mov al,0             
				int 21h              

                ENDP

				
	atoi		PROC
				push di
				push bx
				push cx
								

				mov ax,0
				mov cx,0
				mov di,10

	@@repeat:   cmp byte ptr[bx],0
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
	
	
	printNumBase	PROC ;inicio del la funcion
				push ax
				push bx
				push cx
					
					
					mov cl,0  ;contador para el tamaño de la pila
					cmp bx,1
					jle @@final
					
	@@while:		cmp ax,bx ;comparacionmientras el dato sea menor que la base
					jl @@out
					
					div bx
					push dx		;se guarda el valor "residuo" de la division
					mov dx,0
					
					inc cl		;incrementa el contador
					jmp @@while
	
	@@out:			cmp al,10	;compara al con 10, si es menor debe saltar caso contrario se le suma 7
					jb @@print
					add al,7
					
	@@print:		add al,30H 	;se le agrega un 30 en hexadecimal para tener el varlo de "al" al imprimirse
					call putchar;impresion del residuo
					
					cmp cl,0	;compara el contador si es 0 entonces se termina el programa, caso contrario, sigue
					jz @@final	;haciendo pops 
					
					pop ax
					dec cl		;se decrementa el contador por cada pop efectuado
					jmp @@out
	@@final:					;fin de programa
					
				pop cx
				pop bx
				pop ax
				ret
		ENDP	
	



         END
