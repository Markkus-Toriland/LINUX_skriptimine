#!/bin/bash
# Pesastatud tsüklite näited (linuxconfig.org "Nested loops in Bash scripts" põhjal)

echo "1) Korrutustabel 1-5 (for tsükkel for tsükli sees):"
for i in {1..5}
do
    for j in {1..5}
    do
        printf "%4d" $((i * j))
    done
    echo
done

echo
echo "2) while tsükkel for tsükli sees:"
for taht in a b c
do
    loendur=1
    while [ $loendur -le 3 ]
    do
        echo -n "$taht$loendur "
        ((loendur++))
    done
    echo
done

echo
echo "3) Kataloogide sisu loendamine (kataloogid /etc/default ja /etc/skel):"
for kataloog in /etc/default /etc/skel
do
    arv=0
    for fail in "$kataloog"/* "$kataloog"/.[!.]*
    do
        [ -e "$fail" ] && arv=$((arv + 1))
    done
    echo "$kataloog: $arv kirjet"
done
