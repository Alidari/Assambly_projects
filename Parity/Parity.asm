
;Ana bellekte bir bolgeye 10 tane (keyfi) DoubleWord (32 bitlik sayi) pes pese yerlestirip daha sonra bellekte 0700:0300'den
;baslayarak bu 10 tane 32 bitlik sayilarin her birinin tek eslik olanlara karsilik (bir bayt) 01h, cift eslik olanlara karsilik (bir bayt)
;00h yerlestirmeniz istenmektedir. Daha sonra Emu8086 programýndaki sanal giris portu (Simple) dan yapilacak 1-10 arasindaki girisler icin 
;cikis portu (LED_Display) kullanarak ilgili DoubleWord sayinin parity bilgisi kullaniciya yansitilmak isteniyor.


org 100h ; Programin baslangicç adresi

; Bellek adreslerini tanimla
MOV BX,500h ; Cift veya tek durumlari icin 10 tane 32-bitlik sayiyi iceren bellek bolgesinin baslangic adresi
PORTA EQU 110 ; Giris portu adresi
PORTB EQU 199 ; Cikis portu (LED_Display) adresi

; 10 adet 32-bitlik sayiyi bellege yerlestir
MOV WORD PTR [BX],    0000 0000b
MOV WORD PTR [BX+2],  0000 0001b
MOV WORD PTR [BX+4],  0000 0000b
MOV WORD PTR [BX+6],  0000 0110b
MOV WORD PTR [BX+8],  10
MOV WORD PTR [BX+10], 10
MOV WORD PTR [BX+12], 10
MOV WORD PTR [BX+14], 10
MOV WORD PTR [BX+16], 10
MOV WORD PTR [BX+18], 10
MOV WORD PTR [BX+20], 0000 0011b
MOV WORD PTR [BX+22], 0000 0010b
MOV WORD PTR [BX+24], 10
MOV WORD PTR [BX+26], 10
MOV WORD PTR [BX+28], 10
MOV WORD PTR [BX+30], 10
MOV WORD PTR [BX+32], 10
MOV WORD PTR [BX+34], 10
MOV WORD PTR [BX+36], 10
MOV WORD PTR [BX+38], 10

; Baska bir bellek bolgesine 10 adet 8-bitlik sayiyi (bayt) sifirla
MOV BX,300h
MOV [BX],0
MOV [BX+1],0
MOV [BX+2],0
MOV [BX+3],0
MOV [BX+4],0
MOV [BX+5],0
MOV [BX+6],0
MOV [BX+7],0
MOV [BX+8],0
MOV [BX+9],0

MOV BP, 0 ; 32-bitlik sayi sayisini saymak icin bir sayaç
MOV DL,2 ; 32-bitlik sayiyi 8-bitlik baytlara bolmek icin bir sayi

; 10 adet 32-bitlik sayiyi isle
j1:
   MOV BX,500h
   MOV CX, 32 ; 32-bitlik sayinin uzunlugu
   MOV AX,0 ; Tasima islemi icin kullanilan gecici register

   clc
   j2:
    MOV SI,BP
    RCR WORD PTR [BX+SI],1 ; Sasa dondurme (Rotate through Carry Right) ile 32-bitlik sayilari isle
    ADD SI,2
    RCR WORD PTR[BX+SI],1 
    JNC CARRY0 ; Bit kontrolu yapilir

    INC AX ; Bit varsa Sayaci arttir
                          
CARRY0:
   DEC CX
   CMP CX,0
   JNZ j2 ; 32-bitlik sayinin tum bitleri islenene kadar devam et
   
   ; 32-bitlik sayinin cift veya tek olma durumuna bagli olarak bir bayt degeri (01h veya 00h) ayarla
   MOV BX,300h
   DIV DL ; DL degeri ile bol, kalani AH'ye ve bolme sonucunu AL'ye yerlestir

   CMP AH,0
   JZ cift ; AH sifirsa cift duruma git

   ; Tek durum
   tek:
   MOV byte ptr [BX+DI],00 ; 32-bitlik sayinin tek oldugunu belirten bayti (00h) ayarla
   inc DI
   jmp devam ; Isleme devam et

   ; cift durum
   cift:
   MOV byte ptr [BX+DI],01 ; 32-bitlik sayinin cift oldugunu belirten bayti (01h) ayarla
   inc DI
   jmp devam ; Isleme devam et

devam:
   ADD BP,4 ; Sonraki 32-bitlik sayiya gecç
   CMP BP,40 ; Toplamda 10 adet 32-bitlik sayi islendi mi kontrol et
   JNZ j1 ; Henuz islenmemisse tekrar basa don

; LED ekranina cift veya tek durumlarina gore 32-bitlik sayilari yazdirma
MOV AL,0   
yazdir: 
    MOV BX,300h
    IN AL,110 ; Giris portundan kullanicinin girdigi sayiyi al
    
    CMP AL,10h ; Giris sayisi 10 mu kontrol et
    JNZ case1 ; 10 degilse diger duruma git
    MOV AX,[BX+9] ; 32-bitlik sayinin 48-64 bitini AX'e atayin
    jmp sonuc ; Sonucu yazdirmaya git

case1:
    CMP AL,9
    JNZ case2
    MOV Ah,[BX+8]
    jmp sonuc

    case2:
    CMP AL,8
    JNZ case3
    MOV Ah,[BX+7]
    jmp sonuc

    case3:
    CMP AL,7
    JNZ case4
    MOV Ah,[BX+6]
    jmp sonuc

    case4:
    CMP AL,6
    JNZ case5
    MOV Ah,[BX+5]
    jmp sonuc

    case5:
    CMP AL,5
    JNZ case6
    MOV Ah,[BX+4]
    jmp sonuc

    case6:
    CMP AL,4
    JNZ case7
    MOV Ah,[BX+3]
    jmp sonuc

    case7:
    CMP AL,3
    JNZ case8
    MOV Ah,[BX+2]
    jmp sonuc

    case8:
    CMP AL,2
    JNZ case9
    MOV Ah,[BX+1]
    jmp sonuc

    case9:
    CMP AL,1
    jnz sonuc2
    MOV Ah,[BX]
    jmp sonuc

sonuc2:
   MOV Ax,0     
   OUT 119,AX ; Sonucu yazdir
   JMP yazdir ; Surekli dinleme islemi icin sonsuz donguye git

sonuc:
   MOV AL,AH
   MOV AH,0    
   OUT 199,AX ; Sonucu yazdir
   JMP yazdir ; Surekli dinleme islemi icin sonsuz donguye git

ret ; Programi sonlandir




