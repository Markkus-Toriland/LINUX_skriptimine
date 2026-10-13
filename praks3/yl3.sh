#!/bin/bash
# Bussiekskursiooni abiline: mitu bussi saab täis ja mitu inimest jääb maha
# Arvutused tehakse expr käsuga

echo -n "Sisesta reisijate arv: "
read reisijad
echo -n "Sisesta kohtade arv bussis: "
read kohad

taisbussid=`expr $reisijad / $kohad`
maha=`expr $reisijad % $kohad`

echo
echo "Täielikult täidetud busse: $taisbussid"
echo "Maha jäänud inimesi: $maha"
