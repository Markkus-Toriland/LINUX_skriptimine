#!/bin/bash
# while tsükkel (ryanstutorials): väljastab arvud 1 kuni 10
loendur=1
while [ $loendur -le 10 ]
do
    echo $loendur
    ((loendur++))
done
echo "Kõik tehtud"
