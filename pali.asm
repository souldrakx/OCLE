dosseg
	.model small
	.code
	public _pali
	
	
	_pali PROC
						 push bp
						 mov bp,sp
						 
						 mov bx,[bp+4]				;para acceder a los parametros
						 xor ax,ax
						 xor cx,cx
						 xor si,si
						 
						 ;------------------------para transformar a minusculas todo----------------;
	@whileMayusculas:
					cmp byte ptr[bx+si],' '			;checar espacios
					je @incMinus
					cmp byte ptr[bx+si],0			;fin de cadena
					je @meterPila
					cmp byte ptr[bx+si],41h		;compara con 'A' mayuscula
					jl @noEs
					cmp byte ptr[bx+si],5Ah		;compara con 'Z' mayuscula
					jg	 @minusculas						;salta si es mayor
					add byte ptr[bx+si],20h		;se le suma 20 para convertir a su equivalente en minuscula la letra
					jmp @whileMayusculas

	@minusculas:
					cmp byte ptr[bx+si],61h		;se compara ya que se encuentre en el rango de valores, en este caso con 'a'
					jl @noEs
					cmp byte ptr[bx+si],7Ah		;se compara con 'z'
					jg @noEs									;si es mayor 		
					
	@incMinus:	
					inc si 
					jmp @whileMayusculas
;---------------------para transformar a minusculas todo----------------;
	
	@meterPila:
					xor si,si 			;volver a reiniciar nuestro indice a su valor original
	
	@whilePila:
					cmp byte ptr[bx+si],0
					je @cadenaterminada
					cmp byte ptr[bx+si],' '
					je @incremento
					mov al,byte ptr[bx+si]			;se le pasa la letra que queremos a AL
					push ax
					inc cx					;contador para saber cuantos push hemos hecho 
					jmp @incremento
					
	@incremento:
					inc si 
					jmp @whilePila
					
	@cadenaterminada:
					xor si,si
	@whileComparacion:
					cmp byte ptr[bx+si],0				;cuando se acaba la cadena
					je @siEs
					cmp byte ptr[bx+si],' '				;si es espacio se incrementa nuestro indice, ignorando este espacio
					je @incrementoPalin
					pop ax											;empezamos a sacar letra por letra
					cmp byte ptr[bx+si],al
					jne @noEs
					dec cx
					jmp @incrementoPalin
				
	@incrementoPalin:
					inc si 								
					jmp @whileComparacion
			
	@noEs:	mov ah,30h				;imprime 0 si no es pali
					cmp cx,1					;valor del contador, se compara con un 31h = 1 porque nunca se llega a 0
					je @final
					pop ax						;se limpia la pila
					dec cx						;decrementamos nuestro contador
					jmp @noEs
				
	@siEs:		mov ah,31h				;imprime 1 si si es pali
					jmp @final
			
	@final:	mov al,ah
					mov ah,0
					mov bx,ax				;regresa en bx lo que hay en ax
					pop bp						
					ret
	
	_pali ENDP
	
END