
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h




MOV BX,300H

MOV [BX]  , 22
MOV [BX+1], 10
MOV [BX+2], 35
MOV [BX+3], 01
MOV [BX+4], 63
MOV [BX+5], 10
MOV [BX+6], 11
MOV [BX+7], 03
MOV [BX+8], 90
MOV [BX+9], 45

MOV SI, 0
MOV DI, 0

MOV CL,0 ; ic dongu degisken
MOV CH,0 ; dis dongu degisken

j1:
    mov DL,CH ; en kucuk tutucu 
    mov CL,CH
    inc CL ; CL = CH+1
    mov AL,DL
    cbw
    MOV SI,AX ; smallest index
    j2:
        MOV AL,CL
        cbw
        MOV DI,AX   ; walker
        MOV DH, [BX+SI] ; karsilastirmak icin
        CMP [BX+DI],DH   ; en kucukten kucuk mu diye
        JNB esit_degil
        MOV AL,CL     ;kucukse bu islemler
        CBW
        MOV SI,AX 
        esit_degil:     
        inc CL
        CMP CL, 10
        JNZ j2         
        
        
        MOV DX,0
        MOV AL,CH       ;En sonda en kucuk sayiyla degisim yapiliyor
        CBW
        MOV DI,AX
        MOV DL,[BX+DI]
        MOV DH, [BX+SI]
        MOV [BX+DI],DH
        MOV [BX+SI],DL
        
        inc ch
        CMP CH, 9
        JNZ j1
         
        
         

ret




