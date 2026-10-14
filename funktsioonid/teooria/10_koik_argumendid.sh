#!/bin/bash
# 10. Kõik argumendid - "$@"
# "$@" on kasulik siis, kui ei ole ette teada, mitu argumenti funktsioonile antakse.

naita() {
    echo "Funktsioonile anti:"

    for argument in "$@"
    do
        echo "$argument"
    done
}

naita "üks" "kaks" "kolm"
naita "tühikuga argument" "teine"
