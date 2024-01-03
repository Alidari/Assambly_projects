
;----PROBLEM----

;DL registerinde ust limiti verilen degere kadar olan asal
;sayilari hesaplayip bellekte 0700:0200H adresinden
;itibaren yerleºtiren programi yaziniz.

;--------------------------------------


org 100h

MOV DL,20
MOV BX,200H


J1: 
    MOV CH,2
    MOV CL,0
    J2:
       MOV DH,0
       MOV AX, DX
       DIV CH
       CMP AH,0
       JNZ kalan_var
       inc CL ; Kalan tutucu
       kalan_var:
       inc CH ;
       cmp CH,DL
       JNZ J2:
       
       
       cmp CL,0
       JNZ asal_degil
       
       MOV [BX],DL
       inc BX              
       asal_degil:              
                     
       dec DL
       cmp DL,2
       JNZ J1
       
       MOV [BX],2
       
ret




