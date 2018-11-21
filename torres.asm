MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS

 .DATA
	  disco     	 db    'Disco ',0 
	  flecha	 db    ' -> ',0
	  puntos	 db ': ',0
	  
		
  
  .CODE

   Principal  	PROC
					mov ax,@data 	;Inicializar DS al la direccion
					mov ds,ax     		; del segmento de datos (.DATA)
					
					call clrscr			;limpiar pantalla
					
					xor ax,ax			;se limpia el registro para ser utilizado
					
					;parametros de entrada
					mov al,3				;cantidad de discos a mover
					mov bl,'A'			;nombre del pilar de origen
					mov cl,'B'			;nombre del pilar auxiliar
					mov dl,'C'			;nombre del pilar destino
									
					call TorresDeHanoi
									
					mov ah,04ch	     ; fin de programa
					mov al,0            	 ;
					int 21h             	 ; 

					ENDP
	   
    TorresDeHanoi 	PROC
								push dx
								push ax
								push bx
								push cx
								
								cmp al,1
								je @imprimir
								
								;----------------towerOfHanoi(n-1, from_rod, aux_rod, to_rod);								
								push ax				;se salva el valor de los registros
								push cx				;se salva el valor de los registros
								push dx				;se salva el valor de los registros
								
								dec al
								xchg dl,cl
								call TorresDeHanoi

								pop dx					;se guarda el valor de los registros
								pop cx
								pop ax					;se guarda el valor de los registros
																
								jmp @imprimir       
								;---------------
								
								;----------------towerOfHanoi(n-1, aux_rod, to_rod, from_rod); 
								push ax				;se salva el valor de los registros
								push bx				;se salva el valor de los registros
								push cx				;se salva el valor de los registros
								;push dx
								
								dec al
								xchg bl,cl
								call TorresDeHanoi							

								;pop dx
								pop cx					;se guarda el valor de los registros
								pop bx
								pop ax					;se guarda el valor de los registros
								;---------------							
								jmp @finProc
								
								
		@imprimir:		;imprime Disco
								push dx			
								mov dx,offset disco
								call puts
								pop dx

								;num Disco
								call printNumBase

								;imprimir ':'
								push dx
								mov dx,offset puntos
								call puts
								pop dx
								
								;disco de origen
								push ax            	 ;salvar el valor del registro
								push bx			  	  ;salvar el valor del registro
								
								mov al,bl			  ;se modifica el registro
								call putchar		  ;se imprime el caracter
								
								pop bx				  ;se regresa el valor original del registro
								pop ax				  	  ;se regresa el valor original del registro
															
								; flecha
								push dx
								mov dx,offset flecha
								call puts
								pop dx
								
								;disco destino
								push ax				 ;salvar el valor del registro
								push dx				 ;salvar el valor del registro
								mov al,dl				 ;se modifica el registro
								call putchar			 ;se imprime el caracter
								
								;salto de linea
								mov al,10			
								call putchar				
								;salto de linea
								
								pop dx				     ;se regresa el valor original del registro
								pop ax				     ;se regresa el valor original del registro
								
								
		@finProc:		pop cx
								pop bx
								pop ax
								pop dx	
								
								ret		
								ENDP
								
;----------procedimiento para imprimir los numeros en decimal-----------------------------------------------------------------------------;
				
	printNumBase	PROC
							push ax
							push bx
							push cx
							push dx
									
							mov dx,0
							mov cx,0
							
							;procedimiento de separar los dígitos
		@sepr:		 mov dx,0    ;limpiamos el residuo de cada jmp
							div bx         ; dividimos nuestro numero(ax) entre nuestra base (bx)
							push dx       ;guardamos el residuo en la pila
							inc cx			;incrementamos en 1 la cantidad de digitos
							cmp ax,0     ;revisamos si todavia hay algo que dividir
							jne @sepr	;volvemos a dividir si AX no es 0
							
		@sacar:   	pop dx			;sacamos el residuo de la pila
							cmp dx,9 	;verificamos si el num que tenemos es menor a 10
							jbe @num
							add dx,07h
		@num:			add dx,30h
							mov ah,02h
							int 21h
							loop @sacar                 ;repetimos hasta que cs sea 0
											
							pop dx
							pop cx
							pop bx
							pop ax
							ret
							ENDP


END
