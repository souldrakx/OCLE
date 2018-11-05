%TITLE "TIME_DISPLAY_VER_1" 
;program that displays the current time 
    IDEAL 
    MODEL small 
    .STACK 100h 

INCLUDE procs.inc
    LOCALS

    DATASEG 
TIME_BUF DB '00:00:00$'   ;time buffer hr:min:sec 
    CODESEG 
Start: 
    mov AX,@data 
    mov DS,AX             ;initialize DS

    call clrscr

    @@again: 
;get and display time 
    lea BX,[TIME_BUF]     ;BX points to TIME_BUF 
    call GET_TIME         ;put current time in TIME_BUF 
    lea DX,[TIME_BUF]     ;DX points to TIME_BUF 
    mov AH,09h            ;display time 
    int 21h 
    jmp @@again
;exit 
    mov AH,4Ch            ;return 
    int 21h               ;to DOS
;Procedure GET_TIME
PROC GET_TIME NEAR 
;get time of day and store ASCII digits in time buffer 
;input: BX = address of time buffer 
    mov AH,2Ch            ;gettime 
    int 21h               ;CH = hr, CL = min, DH = sec 
;convert hours into ASCII and store 
    mov AL,CH             ;hour 
    call CONVERT          ;convert to ASCII 
    mov [BX],AX           ;store 
;convert minutes into ASCII and store 
    mov AL,CL             ;minute 
    call CONVERT          ;convert to ASCII 
    mov [BX+3],AX         ;store 
;convert seconds into ASCII and store 
    mov AL,DH             ;second 
    call CONVERT          ;convert to ASCII 
    mov [BX+6],AX         ;store 
    ret
ENDP GET_TIME

;Procedure CONVERT
PROC CONVERT 
;converts byte number (0-59) into ASCII digits 
;input: AL = number 
;output: AX = ASCII digits, AL = high digit, AH = low digit 
    mov AH,0             ;clear AH 
    mov DL,10            ;divide AX by 10 
    div DL               ;AH has remainder, AL has quotient 
    or AX,3030h          ;convert to ASCII, AH has low digit 
    ret                  ;AL has high digit 
ENDP CONVERT 
;
END Start