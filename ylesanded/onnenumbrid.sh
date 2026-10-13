#!/bin/bash
# Õnnenumbrid: leiab kõik arvud vahemikus 1000-9999, mille numbrite korduval
# liitmisel (kuni jääb ühekohaline arv) saadakse tulemuseks 7.
# Numbrid eraldatakse arvutuslikult (% 10 ja / 10), funktsioone ega teisendust tekstiks ei kasutata.

for (( arv = 1000; arv <= 9999; arv++ ))
do
    summa=$arv                      # algne arv jääb muutujasse arv alles
    while [ $summa -gt 9 ]          # liidame numbreid seni, kuni summa on ühekohaline
    do
        jaak=$summa
        summa=0
        while [ $jaak -gt 0 ]
        do
            summa=$(( summa + jaak % 10 ))   # viimane number
            jaak=$(( jaak / 10 ))            # eemaldame viimase numbri
        done
    done
    if [ $summa -eq 7 ]
    then
        echo $arv
    fi
done
