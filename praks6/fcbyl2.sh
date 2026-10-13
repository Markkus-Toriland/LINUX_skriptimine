#!/bin/bash
# fcbyl2: küsib numbreid seni, kuni kasutaja sisestab 0
# negatiivsed numbrid jäetakse continue abil vahele, positiivsed liidetakse kokku
summa=0
while true; do
    echo -n "Sisesta number (0 lõpetab): "
    read nr
    if [ $nr -eq 0 ]; then
        break
    fi
    if [ $nr -lt 0 ]; then
        echo "Negatiivne number - jätan vahele"
        continue
    fi
    summa=$((summa + nr))
    echo "Lisasin $nr, summa on nüüd $summa"
done
echo "Positiivsete numbrite summa: $summa"
