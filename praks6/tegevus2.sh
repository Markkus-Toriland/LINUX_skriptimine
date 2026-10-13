#!/bin/bash
# ryanstutorials tegevus 2: võtab argumendiks kataloogi ja väljastab selle sisu.
# Faili korral näidatakse faili suurust, kataloogi korral selles olevate kirjete arvu.
if [ $# -ne 1 ] || [ ! -d "$1" ]
then
    echo "Kasutamine: $0 kataloog"
    exit 1
fi

for kirje in "$1"/*
do
    if [ -f "$kirje" ]
    then
        echo "$kirje - fail, suurus $(stat -c %s "$kirje") baiti"
    elif [ -d "$kirje" ]
    then
        echo "$kirje - kataloog, $(ls -A "$kirje" | wc -l) kirjet"
    fi
done
