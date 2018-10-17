.model small
.stack 64
.data
inicio db 'Repetir Texto..',10,13,'$'
ingresar db 10,13,'Ingresa tu nombre', 10,13,'$'
nombre db 'Su nombre es: $'
repetir db 10,13,'Quiere repetir s/n?',10,13,'$'
;Declaracion del vector
vtext db 100 dup('$')

.code
    mov ax,@data
    MOV DS,AX
        lea dx,inicio
        mov ah,09
        int 21h

        lea dx,ingresar
        mov ah,09
        int 21h

;Iniciamos nuestro conteo de si en la posicion 0.
    mov si,00h
    leer:
        mov ax,0000
        mov ah,01h
        int 21h
;Guardamos el valor tecleado por el usuario en la posicion si del vector.
        mov vtext[si],al
        inc si   ;Incrementamos nuestro contador
        cmp al,0dh  ;Se repite el ingreso de datos hasta que se teclee un Enter.
        ja leer
        jb leer
        lea dx,nombre
        mov ah,09
        int 21h

    ver:
        mov dx,offset vtext  ;Imprime el contenido del vector con la misma instrucción de una cadena
        mov ah,09h
        int 21h        
        lea dx,repetir  ;imprime si quiere ver de nuevo el texto escrito.
        mov ah,09
        int 21h
        mov ah,01h
        int 21h
        cmp al,73h ;Si la tecla presiona es una s se repite la impresión del vector.
        je ver        
        
salir:
    mov ah,4ch
    int 21h            

end