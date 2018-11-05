MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
      mens_directo   	db  13,10,'Desplegado de caracter en forma directa: ',0
	  mens_DOS			db  13,10,'Desplegado de caracter en forma DOS: ',0
	  mens_BIOS			db  13,10,'Desplegado de caracter usando BIOS: ',0
	  

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr

				mov  dx,offset mens_directo
				call puts
				mov al,'X'  					;Caracter a desplegar
				mov bh,41
				mov bl,0						;Posicion (41,0)
				call putcharxy					;Imprime caracter (DL) en posicion (x,y)
				
				mov dx,offset mens_DOS			
				call puts	
				mov dl,'Y'		;Caracter a desplegar
				mov ah,2		;servicio: desplegar caracter
				int 21h			;Llamada a DOS servicio 2
				
				mov dx,offset mens_BIOS
				call puts
				mov al,'Z'		;Caracater a desplegar
				mov ah,0Ah		;Servicio: desplegar caracter
				mov bx,0		;No. de pagina para desplegar
				mov cx,1		;numero de veces a desplegar
				int 10h			;Llamada a bios servicio 0Ah
				
				
				
				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 

                ENDP
				
		putcharxy PROC
			push ax			;Salvar valores de registros a utlizar
			push bx
			push cx
			push dx	
			push ds
			
			mov dx,ax 		;DL sera el caracter a desplegar
			mov ax,0b800h 	;hacer que ds apunte al segmento
			mov ds,ax		;de memoria de video
			mov cl,160		;calcular localidad en memoria segun
			mov al,bl		;posicion (x,Y)
			mul cl			;X: esta en BH y Y en B
			mov bl,bh		;Localidad en momoria = (x * 2) + (y + 160)
			mov bh,0		
			mov bx,1		;Se quiere BX = (Bl + 160 ) + ( BH * 2)
			mov bx,ax		
			mov [bx],dl		;Mover DL a la localidad ds:bx
			
			pop ds			; Recuperar valores originales de registros
			pop dx			; utilizados
			pop cx
			pop bx
			pop ax 
		ENDP
			


     END