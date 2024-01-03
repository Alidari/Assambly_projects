
;ALT PROGRAM KULLANARAK FIBONACCI SERISINI OLUSTURMA

org 100h

MOV CX,10     ;Fibonacci serisinin ilk 10 elemani yazdirilcak 
MOV SI,0200H  ;RAM'de tutulacak adres --> DS:0200

MOV BH,0      ;Fibonacci ilk sayi
MOV BL,1      ;Fibonacci ikinci sayi

tekrar:
    call fibo         ;Fibonacci alt programini cagir
    MOV [SI], BL      ;Adres bolgesine fibo degerini yazdir
    inc SI            ;Adres bolgesini arttir
    loop tekrar       ;Donguye al




fibo PROC            ;  --Alt program--
    MOV AL,BL        ;BL registerini(Fibonaccininin ikinci elemani) yedekle
    ADD BL,BH        ;BL'registerini guncelle --> BL = BL + BH
    MOV BH,AL        ;Fibonaccinin eski degerini tut
    ret              ;Return 
fibo ENDP            ; --Alt Program Sonu--

ret




