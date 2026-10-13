#!/bin/bash
# Sisseehitatud (nested) if lause näide
# Valik "1" kontrollitakse välimises if-is. Kui valik ei ole 1, jõuab töö else harusse,
# kus sisemine if kontrollib valikut "2". Kõik muud valikud jõuavad sisemise if-i else harusse.

osch=0
echo "1. Unix (Sun Os)"
echo "2. Linux (Red Hat)"

echo -n "Select your os choice [1 or 2]? "
read osch

if [ $osch -eq 1 ] ; then
    echo "You Pick up Unix (Sun Os)"
else #### nested if i.e. if within if ######
    if [ $osch -eq 2 ] ; then
        echo "You Pick up Linux (Red Hat)"
    else
        echo "What you don't like Unix/Linux OS."
    fi
fi
