#!/bin/bash
# 9. Argumentide arv - $#
# $# abil saab kontrollida, kas funktsioonile anti õige arv argumente.

kontrolli() {
    echo "Argumentide arv: $#"
}

liida() {
    if [ $# -ne 2 ]; then
        echo "Viga: sisesta kaks arvu!"
        return 1
    fi

    echo "$(($1 + $2))"
}

kontrolli üks kaks kolm
liida 10 20
liida 10
