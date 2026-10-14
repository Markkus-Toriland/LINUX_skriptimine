#!/bin/bash
# 7. Funktsioonile argumentide andmine
# Funktsiooni sees on $1 funktsioonile antud esimene argument, mitte skripti oma.

tervita() {
    echo "Tere, $1!"
}

tervita "Mari"
tervita "Jüri"
tervita "Anna"

echo "Pärast funktsiooni on skripti enda esimene argument: ${1:-puudub}"
