;sintaxis para un macor
MODEL small
   .STACK 100h
   
   
   INCLUDE procs.inc
   
			LOCALS
	mCopiaMem2Mem  MACRO direcFuente,direcDestino

		push word ptr[direcFuente]
		pop word ptr [direcDestino]

		ENDM


	mDespilegaCadena MACRO cadena
		push dx
		mov dx,offset cadena
		call puts
		pop dx
		
		ENDM
	.DATA 
	mens db 'hola mundo',0 
	data db 32 dup(0)
	.CODE
	
	Principal PROC
		mov ax,@data
		mov ds,ax
		call clrscr
		
		 mDespilegaCadena [mens]
		 mCopiaMem2Mem [mens],[data]
		 mDespilegaCadena [data]
		
		@@fin:
		mov ah,04ch
		mov al,0
		int 21h
	
	ENDP
	

	
END
	
	