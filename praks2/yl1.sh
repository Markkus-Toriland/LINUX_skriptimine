#!/bin/bash
# Skript tervitab kasutajat nii, et kasutajanimi algab suure tähega: "Tere, User!"

# 1. väljastame "Tere, " ilma reavahetuseta
echo -n "Tere, "
# 2. kasutaja nimi, mille esimene täht teeme suureks, väljastame ilma reavahetuseta
kasutaja=$(whoami)
esitaht=$(echo "${kasutaja:0:1}" | tr '[:lower:]' '[:upper:]')
echo -n "$esitaht${kasutaja:1}"
# 3. väljastame "!" koos reavahetusega
echo "!"
