#!/bin/bash
# foryl5: IFS abil jagame stringi semikooloni kohalt sõnadeks
tekst="koer;kass;hiir"
IFS=';'
for sona in $tekst; do
    echo "$sona"
done
