#!/bin/bash
# 11. Funktsiooni muutujad
# Ilma local-ita loodud muutuja jääb alles ka pärast funktsiooni lõppu (globaalne muutuja).
# NB! nimi test katab Bashi sisekäsu test - päris skriptis on parem valida teine nimi.

hello() {
    nimi="Mari"
    echo "Tere, $nimi!"
}

hello

unset nimi

test() {
    nimi="Mari"
}

test

echo "$nimi"
