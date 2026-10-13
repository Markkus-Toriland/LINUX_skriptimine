#!/bin/bash
# until tsükkel (ryanstutorials): töötab seni, kuni tingimus muutub tõeseks
loendur=1
until [ $loendur -gt 10 ]
do
    echo $loendur
    ((loendur++))
done
echo "Kõik tehtud"
