
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

MOV BX, 200h

MOV [BX],   55h
MOV [BX+1], 66h
MOV [BX+2], 54h
MOV [BX+3], 11h
MOV [BX+4], 87h
MOV [BX+5], 33h
MOV [BX+6], 75h
MOV [BX+7], 05h
MOV [BX+8], 5Fh
MOV [BX+9], 23h

MOV CX,1 ; Dongu degiskeni 1'den 10'a kadar gidecek
MOV AH,[BX] ;en kucuk degeri tutacak degisken
MOV DX,0 ; Degerin indexini tutacak degisken                                                  
dongu1:
    MOV SI,CX
    MOV AL, [BX+SI] ; o anki sayiyi tutacak degisken
    CMP AH,AL
    JNA daha_kucuk; AH AL'den daha buyuk degilse
    daha_buyuk:
        MOV AH,AL ; AL daha kucukse degiskeni degistir
        MOV DX,SI ; Indexini de ata
    daha_kucuk:
        inc CX    ;Dongu degiskenini arttir
        CMP CX,10 ;Dongu degiskenini kontrol et                                                   
        JNZ dongu1
 ret



