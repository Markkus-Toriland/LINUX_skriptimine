# for-tsüklid - kontrollküsimuste vastused

1. **Milline on for-tsükli põhisüntaks Bashis?**
   `for muutuja in loend; do käsud; done` - muutuja saab järjest iga loendi väärtuse ja iga väärtusega täidetakse do ja done vahel olevad käsud.

2. **Mis vahe on lihtsate väärtuste ja jutumärkides väärtuste vahel tsüklis?**
   Ilma jutumärkideta jagatakse loend tühikute kohalt eraldi väärtusteks. Jutumärkides olev tekst (nt `"Tere maailm"`) on üks väärtus ka siis, kui selles on tühikuid.

3. **Mida teeb käsu asendamine (command substitution) tsüklis? Too näide.**
   `$(käsk)` asendatakse käsu väljundiga ja tsükkel käib väljundi väärtused ükshaaval läbi, nt
   `for kasutaja in $(cut -d: -f1 /etc/passwd); do echo $kasutaja; done`.

4. **Milleks kasutatakse muutujat IFS?**
   IFS (Internal Field Separator) määrab, milliste märkide kohalt shell teksti sõnadeks jagab. Vaikimisi on need tühik, tabulaator ja reavahetus; nt `IFS=';'` jagab stringi semikooloni kohalt.

5. **Miks ei ole soovitatav kasutada `for file in $(ls)`? Mis on parem lahendus?**
   `ls` väljund jagatakse tühikute kohalt, seega tühikuga failinimed lähevad tükkideks. Parem on kasutada mustrit, nt `for file in *.txt`, või `find` käsku.

6. **Kuidas näeb välja C-stiilis for-tsükkel Bashis?**
   `for (( i=1; i<=5; i++ )); do echo $i; done` - algväärtus, jätkamise tingimus ja samm on topeltsulgudes.

7. **Kuidas panna C-stiilis tsükkel lugema ainult paarisarve?**
   Alustada paarisarvust ja suurendada sammu kahe võrra: `for (( i=2; i<=20; i+=2 )); do echo $i; done`.

Harjutuste skriptid: `foryl1.sh` - `foryl7.sh` ja `fcbyl1.sh` - `fcbyl3.sh` selles kaustas.
