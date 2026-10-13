#!/bin/bash
# Sisseehitatud for-tsüklite katsetus: välimine tsükkel annab rea (i), sisemine väljastab i väärtuse 5 korda
for (( i = 1; i <= 5; i++ ))      ### välimine tsükkel ###
do
    for (( j = 1 ; j <= 5; j++ )) ### sisemine tsükkel ###
    do
        echo -n "$i "
    done
    echo ""                       ### reavahetus ###
done
