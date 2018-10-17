MODEL small
.STACK 100H

.DATA

	msg db 10,13,7,"Ingresa una numero: ","$"
	msg1 db 10,13,7,"Numero: ","$"
	num db ?

.CODE
	main proc

		mov ax, @data 
		mov ds,ax

		mov dx,offset msg
		mov ah, 09h
		int 21h

		mov ah,01h
		int 21h
		sub al,30h
		mov num,al

		mov dx,offset msg1
		mov ah, 09h
		int 21h

		mov ah,02h
		mov dl,num
		add dl,30h
		int 21h




		mov ah,4ch
		mov al,0
		int 21h
	endp

END