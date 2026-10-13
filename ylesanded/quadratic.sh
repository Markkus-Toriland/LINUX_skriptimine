#!/bin/bash
# Ruutvõrrandi Ax^2 + Bx + C = 0 lahendamine.
# Kordajad antakse käsurea argumentidena: ./quadratic.sh A B C
# Arvutused tehakse bc -l abil, tulemused väljastatakse viie komakohaga.

if [ $# -ne 3 ]
then
    echo "Kasutamine: $0 A B C   (näiteks: $0 1 -3 2)"
    exit 1
fi

A=$1
B=$2
C=$3

if [ $(echo "$A == 0" | bc -l) -eq 1 ]
then
    echo "A ei tohi olla 0 - see ei ole ruutvõrrand."
    exit 1
fi

# diskriminant D = B^2 - 4AC
D=$(echo "($B)^2 - 4*($A)*($C)" | bc -l)
printf "Diskriminant D = %.5f\n" "$D"

if [ $(echo "$D < 0" | bc -l) -eq 1 ]
then
    echo "Reaalarvulisi lahendeid ei ole."
elif [ $(echo "$D == 0" | bc -l) -eq 1 ]
then
    x=$(echo "-($B) / (2*($A))" | bc -l)
    printf "Võrrandil on üks lahend: x = %.5f\n" "$x"
else
    x1=$(echo "(-($B) + sqrt($D)) / (2*($A))" | bc -l)
    x2=$(echo "(-($B) - sqrt($D)) / (2*($A))" | bc -l)
    printf "Võrrandil on kaks lahendit: x1 = %.5f, x2 = %.5f\n" "$x1" "$x2"
fi
