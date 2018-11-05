MODEL small
   .STACK 100h

 INCLUDE procs.inc
		
		LOCALS

		contador  	EQU 	0
		segundos  	EQU 	0
		minutos    	EQU 	0
		horas   	 	EQU 	0
		bandera 	 	EQU	0
		

   .DATA
      ;mens1      db  'Grado 10',0  ;--se cumplen las 3 


	  
   .CODE
	
	;codigo para que apunte al vector de interrupciones
	mov ax,0
	mov ds,ax
	mov ax,cs
	mov bx,1ch
	mov cl,2
	shl bx,cl
	mov word ptr[bx],offset reloj   ;direccion de mi procedimiento reloj se pasa a la direccion apuntada por BX
	mov word ptr[bx+2],ax				;segmento de codigo, en el cual esta mi direccion (segmento y desplazamiento)	
	
	
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				
				;empiezan inicializaciones
					
				call reloj
		 
	 @fin: 		
				mov ah,04ch	     ; fin de programa
				mov al,0             
				int 21h               

                ENDP
				
		reloj   PROC
					;se hacen los procedimientos para contar
			       
				   inc contador       		;se incrementa el contador para checar los ticks
				   cmp contador,18  	;la interrupcion se ejecuta 18 veces por segundo
				   je @segundos
				   
				   
	@segundos: 	
					mov contador,0		;se reinicia el contador, una vez que ya llegó a 18
					inc segundos   			;se incrementan los segundos
					cmp segundos,60
					je @minutos
					jmp @finProc
					
	@minutos:
					inc minutos    			;se incrementan los minutos
					mov segundos,0		;se reinician los segundos
					cmp minutos,60
					je @horas
					jmp @finProc
					
	@horas:	
					inc horas					;se incrementan las horas
					mov segundos,0		;se reinician los segundos
					mov minutos,0			;se reinician los minutos
					cmp horas,24
					je @reiniciar
					jmp @finProc
					
	@reiniciar:
					mov segundos,0
					mov minutos,0
					mov horas,0
					
	@finProc:
					iret  					;para finalizar el procedimiento
					ENDP

    END

