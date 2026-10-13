#!/bin/bash
# fcbyl1: loendab 1 kuni 10, aga katkestab tsükli break abil, kui jõuab 7-ni
for i in {1..10}; do
    if [ $i -eq 7 ]; then
        echo "Jõudsin 7-ni, katkestan tsükli"
        break
    fi
    echo "i = $i"
done
echo "Pärast tsüklit"
