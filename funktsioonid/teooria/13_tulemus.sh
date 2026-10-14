#!/bin/bash
# 13. Funktsiooni tulemus
# Arvutatud väärtus väljastatakse echo abil ja salvestatakse muutujasse $( ) abil.

liida() {
    local a="$1"
    local b="$2"

    echo "$((a + b))"
}

tulemus=$(liida 10 20)

echo "Tulemus: $tulemus"
