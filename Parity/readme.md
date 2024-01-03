**PROBLEM**

*Ana bellekte bir bölgeye 10 tane (keyfi) DoubleWord (32 bitlik sayı) peş peşe yerleştirip daha sonra bellekte 0700:0300’den başlayarak
bu 10 tane 32 bitlik sayıların her biri için tek eşlik olanlara karşılık (bir bayt) 01h, çift eşlik olanlara karşılık (bir bayt) 
00h yerleştirmeniz istenmektedir. Daha sonra Emu8086 programındaki sanal giriş portu (Simple) dan yapılacak 1-10 arasındaki girişler
için çıkış portu (LED_Display) kullanarak ilgili DoubleWord sayının parity bilgisi kullanıcıya yansıtılmak isteniyor.

![image](https://github.com/Alidari/Assambly_projects/assets/92364056/966d5978-a44a-4319-ad35-09ea2a0cd27f)
![image](https://github.com/Alidari/Assambly_projects/assets/92364056/829ac1fa-50f1-4999-a127-05c0e7ed2df5)

Örn. bellekte ilk DoubleWord olarak 33310013H olduğu durumda ekran görüntüsü yukarıdaki gibi olmalıdır
