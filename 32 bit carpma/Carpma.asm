
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

PORTA EQU 110
PORTB EQU 199

org 100h


MOV BX,300H

MOV [BX], 1200H     ;Carpilanin alt 16 biti
MOV [BX+2],1000H    ;Carpilanin ust 16 biti

MOV [BX+4], 2003H   ;Carpanin alt 16 biti                
MOV [BX+6], 1200H   ;Carpanin ust 16 biti   

MOV [BX+8], 0000H     ;CARPIM 0-16 bit
MOV [BX+10],0000H     ;CARPIM 16-32 bit
MOV [BX+12],0000H     ;CARPIM 32-48 bit 
MOV [BX+14],0000H     ;CARPIM 48-64 bit

MOV SI,32             ;Dongu tekrar sayisi

j1:
    MOV AX, [BX+4]    ; Carpanin ilk 16 biti ataniyor
    AND AX, 01H       ; Ilk bit 1 mi 0 mi kontrolu
    CMP AX,0          ; 1 veya 0 olmasina gore islem ataniyor
    JZ  kaydir        ; 0'sa topla etiketine girmeden kaydirma islemi yapiliyor
                                                                
    topla:
    MOV DX, [BX]      ; Carpilanin alt biti carpim'in 32-48 bitlerine eklenir
    ADD [BX+12],DX
    
    MOV DX, [BX+2]    ; Carpilanin ust biti carpim'in 48-64 bitlerine eklenir
    ADC [BX+14], DX
    
    kaydir:
    clc
    MOV DI,[BX+14]    ; Carpimin 48-64 bitini bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+14],DI
    
    MOV DI,[BX+12]    ; Carpimin 32-48 bitini bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+12],DI
    
    MOV DI,[BX+10]    ; Carpimin 16-32 bitini bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+10],DI
    
    MOV DI,[BX+8]     ; Carpimin 0-16 bitini bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+8],DI
    
    clc                ; yeni kaydirma islemi oncesi carry temizlenir
    
    MOV DI,[BX+6]     ; Carpanin ust biti bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+6],DI
    
    MOV DI,[BX+4]     ; Carpanin alt biti bir saga kaydirma islemi
    RCR DI,1
    MOV [BX+4],DI
    
    DEC SI
    CMP SI,0          ;Dongu degiskenini azaltip kontrol etme islemi
    JNZ j1         

yazdir:
    IN AL,PORTA       ;Al'ye port adresi yaziliyor
    
    CMP AL,04h        ;girilen sayi 4 mu kontrolu yapiliyor
    JNZ case1         ;degilse diger duruma geciliyor
    MOV AX,[BX+14]    ;4'se Sonucun 48-64 biti AX'e ataniyor
    jmp sonuc         ;yazdirma islemine geciliyor
    
case1:
   CMP AL,03h         ;girilen sayi 3 mu kontrolu yapiliyor
   JNZ case2          ;degilse diger duruma geciliyor
   MOV AX,[BX+12]     ;3'se Sonucun 32-48 biti AX'e ataniyor
   jmp sonuc          ;yazdirma islemine geciliyor
   
case2:
   cmp AL,02h         ;girilen sayi 2 mi kontrolu yapiliyor
   JNZ case3          ;degilse diger duruma geciliyor
   MOV AX,[BX+10]     ;2'yse Sonucun 16-32 biti AX'e ataniyor
   jmp sonuc          ;yazdirma islemine geciliyor
   
case3:
   cmp AL,01h         ;girilen sayi 1 mi kontrolu yapiliyor
   JNZ case4          ;degilse diger duruma geciliyor
   MOV AX,[BX+8]      ;1'se Sonucun 0-16 biti AX'e ataniyor
   jmp sonuc          ;yazdirma islemine geciliyor

case4:
   MOV AX,00          ;default ve diger durum sonuclari
   
sonuc:
        
   OUT PORTB,AX       ;yazdiriyor
   JMP yazdir         ;surekli dinleme islemi icin sonsuz dongu
ret




