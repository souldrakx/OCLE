dosseg
.model small
.code
    public _mycoll

    _mycoll PROC
        push bp

        xor ax,ax
        xor si,si
        xor cx,cx
        
        mov bx,2
        mov dx,3
       
        mov bp,sp
        mov al,[bp+4]

        @@return:
        mov si,ax
        div bl

        cmp al,1
        
        je @@fin
        cmp ah,0
        jne @@impar
        inc cx
        
        jmp @@return

        @@impar:
        mov ax,si
        
        mul dl
        
        inc ax
        inc cx
        jmp @@return

        @@fin:
        inc cx
        xor ax,ax
        mov ax,cx
        
        pop bp
        
        ret
    _mycoll ENDP

    
END