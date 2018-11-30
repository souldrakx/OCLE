dosseg
.model small
.code
    public _mypalin

    _mypalin PROC
        push bp
        
        mov bp,sp

        mov dx,[bp+4]

        mov si,dx

        xor ax,ax

        @@tamcad:
        mov al,[si]
        cmp al,0
        je @@cmpcad
        inc si
        jmp @@tamcad

        @@cmpcad:
        dec si
        mov bx,dx
        
        @@palin:
        mov al,[si]

        cmp al,20h
        je @@incal
 
        mov cl,[bx]
        cmp cl,20h
        je @@inccl

        cmp al,cl
        jne @@noes

        cmp si,bx
        jbe @@sies

        dec si
        inc bx
        jmp @@palin

        @@incal:
        dec si
        jmp @@palin
        
        @@inccl:
        inc bx
        jmp @@palin

        @@sies:
        mov al,31h
        jmp @@finp

        @@noes:
        mov al,30h

        @@finp:

        mov bx,ax
        

        pop bp
        
        ret
    _mypalin ENDP
    
END