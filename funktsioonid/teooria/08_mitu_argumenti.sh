#!/bin/bash
# 8. Mitu argumenti - $1, $2, ...

kasutaja_info() {
    echo "Nimi: $1"
    echo "Vanus: $2"
}

liida() {
    echo "$(($1 + $2))"
}

kasutaja_info "Mari" 18
liida 10 5
