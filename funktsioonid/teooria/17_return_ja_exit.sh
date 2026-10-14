#!/bin/bash
# 17. return ja exit ei ole sama asi
# return lõpetab ainult funktsiooni, exit lõpetab kogu skripti.

kontroll() {
    if [ ! -f "$1" ]; then
        echo "Faili pole."
        return 1
    fi

    echo "Fail leitud."
}

kontroll "/tmp/test.txt"

echo "Skript jätkab tööd."

lopeta() {
    echo "exit lõpetab kogu skripti (olekukood 3)."
    exit 3
}

lopeta
echo "Seda rida ei kuvata."
