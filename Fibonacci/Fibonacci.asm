
; DL registerinde verilen sayiya en yakin iki Fibonacci sayisini bulan
; programi yaziniz
; Sonuc BH (Fibo_kucuk) ve BL(Fibo_buyuk) de tutulur

org 100h

MOV DL,15          ;Istenilen deger

MOV BH,0           ; Fibonacci kucuk
MOV BL,1           ; Fibonacci buyuk

J1:
    CMP BL,DL      ; Istenilen degere ulasildi mi kontrolu
    JB devam       ; Ulasilmadiysa devam
    JMP bitir      ; Ulasildiysa bitir 
    
    devam:
        MOV AL,BL  ; BL'yi yedekle
        ADD BL,BH  ; BL = BH + BL
        MOV BH,AL  ; BH'a BL'nin eski degerini ata
        jmp J1     ; donguyu basa al
    
    bitir:    
ret




