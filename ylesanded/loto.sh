#!/bin/bash
# Loto: genereerib 5 erinevat pseudojuhuslikku numbrit vahemikus 1-50.
# Genereeritud numbrid hoitakse ajutises failis, et kontrollida kordumist (massiive ei kasutata).
# Kasutaja valib, kas tulemus kuvatakse terminalis või lisatakse faili koos kuupäeva ja kellaajaga.

ajutine=$(mktemp)
tulemusfail="loto_tulemused.txt"

# genereerime numbreid seni, kuni failis on 5 erinevat numbrit
while [ $(wc -l < "$ajutine") -lt 5 ]
do
    nr=$(( RANDOM % 50 + 1 ))
    if ! grep -qx "$nr" "$ajutine"
    then
        echo "$nr" >> "$ajutine"
    fi
done

numbrid=$(sort -n "$ajutine" | tr '\n' ' ')
aeg=$(date '+%d.%m.%Y %H:%M:%S')
rm -f "$ajutine"

echo "Kuhu tulemus väljastada?"
echo "1 - terminali"
echo "2 - faili $tulemusfail"
echo -n "Sisesta valik: "
read valik

case $valik in
    1) echo "$aeg  Lotonumbrid: $numbrid" ;;
    2) echo "$aeg  Lotonumbrid: $numbrid" >> "$tulemusfail"
       echo "Tulemus lisati faili $tulemusfail" ;;
    *) echo "Vigane valik!"; exit 1 ;;
esac
