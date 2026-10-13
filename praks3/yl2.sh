#!/bin/bash
# Küpsisetordi kalkulaator: arvutab, mitu pakki küpsiseid tuleb poest osta
# Arvutused tehakse expr käsuga (täisarvud, osaliselt kasutatud küpsis loetakse terveks)

echo -n "Sisesta aluskandiku pikkus (cm): "
read kandik_pikkus
echo -n "Sisesta aluskandiku laius (cm): "
read kandik_laius
echo -n "Sisesta küpsise pikkus (cm): "
read kypsis_pikkus
echo -n "Sisesta küpsise laius (cm): "
read kypsis_laius
echo -n "Mitu kihti tordil on: "
read kihid
echo -n "Mitu küpsist on ühes pakis: "
read pakis

# küpsiste arv ühes reas ja ridade arv (ümardame üles)
reas=`expr \( $kandik_pikkus + $kypsis_pikkus - 1 \) / $kypsis_pikkus`
ridu=`expr \( $kandik_laius + $kypsis_laius - 1 \) / $kypsis_laius`
kihis=`expr $reas \* $ridu`
kokku=`expr $kihis \* $kihid`
# pakkide arv (ümardame üles)
pakke=`expr \( $kokku + $pakis - 1 \) / $pakis`

echo
echo "Ühte kihti läheb $kihis küpsist, kokku $kokku küpsist."
echo "Poest tuleb osta $pakke pakki küpsiseid."
