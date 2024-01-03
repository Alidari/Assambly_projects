;---PROBLEM---
;EMU 8086'nin sanal portlarindan klavyedeen alinan artis
;miktarini bir sayacta biriktirerek sanal portlardan display
;portunda belirli bir gecikme ile yansitan program

org 100h


MOV CX,0 ;sayac
MOV AX,1


sayac:
IN AX,110
ADD CX,AX
MOV AX,CX                           
OUT 199,AX
CALL delay
jmp sayac 


DELAY PROC
    PUSH CX ; ana programda kullanilan registerlari yigina yedekle
    MOV CX,020H
    J1:
    NOP
    NOP
    LOOP J1
    POP CX ;yeeklenen reg yigindan geri cek
    RET
delay ENDP    


ret




