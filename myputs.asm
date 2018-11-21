dosseg
.model small
.code
    public _myputs

    _myputs PROC
        push bp
        mov bp,sp
        mov bx,[bp+4]
        @@lop:
        
        mov dl,[bx]
        cmp dl,0
        je @@fin
        mov ah,02h
        int 21h
        inc bx
        jmp @@lop

        @@fin:
        pop bp
        
        ret
    _myputs ENDP
END