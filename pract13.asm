MODEL small
	   .STACK 100h

.DATA
	cad 	db 	"Cadena ingresada: ",0

.CODE
	Principal	PROC
					push ds 			; Metes la dirección del PSP a la pila
					push @data 	; Metes la dirección del segmento de datos
					pop ds
					pop es
					
					;clrscr
					mov al,03h				;modo de video 03h
					mov ah,00h				;servicio 00h
					int 10h						;limpiar pantalla
							
					mov bx,82h		;como la cadena empieza en 81h, y es un espacio en blanco, se omite y se inicia en el primer caracter de la cadena que seria el 82h
					
					xor cx,cx 			;registro para la cantidad de numeros
					xor ax,ax			;al tomaria como "n", se inicializa en 0 el registro 

@regresa:	xor dx,dx										;se limpia el registro 
					cmp byte ptr es:[bx],0dh				;compara con un enter
					je @cantidad
					cmp byte ptr es:[bx],'0'
					jb @fin
					cmp byte ptr es:[bx],'9'
					ja @fin
					mov dl,10d			;multiplicador
					mul dl	
					sub byte ptr es:[bx],30h      
					mov dl,byte ptr es:[bx]
					add ax,dx
					inc bx
					jmp @regresa
					
					
@cantidad: mov cx,ax									;se le pasa el parametro numerico al registro que nos servira como cantidad de numeros triangulares
					call numerosTriangulares			;cuando ya detecte el enter, se va a realizar la func para calcular los numeros triangulares
					
					
		@fin:	mov ax,4c00h
					int 21h
					ENDP
					
;-----------procedimiento para calcular los numeros triangulares----------------					
numerosTriangulares PROC
									;push cx				;guardamos en la pila el valor original de cx=15								
									xor ax,ax
									xor bx,bx
									xor dx,dx
									
									mov dx,1				;inicializamos nuestro registro que funcionara como nuestra "n"
									
					@inicio:		
									
									mov ax,dx			
									add ax,1
									mov bh,dl			;se le pasa el valor de "n" para que este sea nuestro operando para multiplicar 
									mul bh					;se multiplica por el valor de nuestro registro cx que funciona como "n"
									mov bl,2				;entre 2 se divira el resultado de la multiplicacion
									div bl

									xor bx,bx			;limpiamos nuestro registro
									mov bx,10			;base 10
									call printNumBase
									
									push dx			;se guarda en la pila el valor original de dx porque lo vamos a modificar en el salto de linea 
									mov ah,02h      ;salto de linea
									mov dl,0ah 		;
									int 21h
									pop dx
									
									inc dx
													;regresamos el valor de nuestro contador y verificamos que aun no se pase de la cantidad especificada de numeros triangulares
									loop @inicio
									;pop cx		
				@finProc:	ret
									ENDP
					
;-----------procedimiento para imprimir--------------------------------------
	printNumBase		PROC
					
							push ax
							push bx
							push cx
							push dx
										
							mov dx,0
							mov cx,0
								
		;procedimiento de separar los dígitos
			@sepr:	mov dx,0    		;limpiamos el residuo de cada jmp
							div bx       	 		;dividimos nuestro numero(ax) entre nuestra base (bx)
							push dx     	  		;guardamos el residuo en la pila
							inc cx					;incrementamos en 1 la cantidad de digitos
							cmp ax,0     		;revisamos si todavia hay algo que dividir
							jne @sepr			;volvemos a dividir si AX no es 0
								
			@sacar:   pop dx					;sacamos el residuo de la pila
							cmp dx,9 			;verificamos si el num que tenemos es menor a 10
							jbe @num
							add dx,07h
			
			@num:		add dx,30h
							mov ah,02h
							int 21h
							loop @sacar        ;repetimos hasta que cs sea 0

							pop dx
							pop cx
							pop bx
							pop ax	

							ret							
	ENDP					
		
END
