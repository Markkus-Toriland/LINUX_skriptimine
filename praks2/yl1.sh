#!/bin/bash
# Skript tervitab kasutajat: "Tere, kasutajanimi!"

# 1. väljastame "Tere, " ilma reavahetuseta
echo -n "Tere, "
# 2. muutuja, mille väärtus on kasutaja nimi, väljastame ilma reavahetuseta
kasutaja=$(whoami)
echo -n "$kasutaja"
# 3. väljastame "!" koos reavahetusega
echo "!"
