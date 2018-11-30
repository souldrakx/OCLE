dosseg
.model small
.code
    public _mynum

    _mynum PROC
        push bp
        ;push ax
        ;push bx
        ;push cx
        ;push dx

        xor ax,ax
        mov bx,10
        mov cx,0 ;initialize counter in cero
       
        mov bp,sp
        mov al,[bp+4]

        @@nxt:	
        xor dx,dx 
        div bx  ;divide DX:AX/BX
        push dx 
        inc cx
        cmp ax,0
        jne @@nxt

        @@verif:
        pop ax
        cmp ax,0ah ; check if the quotient of ax is less than 10
        jb @@less
        add ax,07h
            
        @@less: 
        add ax,30h ;convert quotient to ASCII

        mov dl,al
        mov ah,02h
        int 21h
            
        loop @@verif

        ;pop dx
        ;pop cx
        ;pop bx
        ;pop ax
        pop bp
        
        ret
    _mynum ENDP


END