#!/bin/bash
# 12. local - funktsiooni lokaalne muutuja
# local muutuja on olemas ainult funktsiooni sees.

test() {
    local nimi="Mari"
    echo "$nimi"
}

test
echo "Väljaspool funktsiooni: nimi='$nimi' (tühi, sest muutuja oli local)"

# hea tava: argumentidest tehakse kohe lokaalsed muutujad
tervita() {
    local nimi="$1"

    echo "Tere, $nimi!"
}

kasutaja_info() {
    local nimi="$1"
    local vanus="$2"

    echo "Nimi: $nimi"
    echo "Vanus: $vanus"
}

tervita "Mari"
kasutaja_info "Jüri" 20
