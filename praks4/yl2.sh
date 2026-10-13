#!/bin/bash
# Bussiekskursiooni abiline: arvutab, mitu bussi on kokku vaja
# Kui mõni reisija täisbussidesse ei mahu, lisatakse veel üks buss

echo -n "Sisesta reisijate arv: "
read reisijad
echo -n "Sisesta kohtade arv bussis: "
read kohad

bussid=`expr $reisijad / $kohad`
maha=`expr $reisijad % $kohad`
if [ $maha -gt 0 ]
then
    bussid=`expr $bussid + 1`
fi

echo
echo "Kokku on vaja $bussid bussi"
