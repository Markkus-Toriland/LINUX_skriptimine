#!/bin/bash
# 2. Miks funktsioone kasutada?
# Sama tegevus kirjutatakse üks kord funktsiooni sisse ja kutsutakse välja nii mitu korda, kui vaja.

echo "### Ilma funktsioonita - samad read on kirjutatud kaks korda"
echo "===================="
echo "SÜSTEEMI INFO"
echo "===================="
hostname
uname -r
whoami

echo "===================="
echo "SÜSTEEMI INFO"
echo "===================="
hostname
uname -r
whoami

echo
echo "### Sama funktsiooniga - kood on kirjas ainult ühes kohas"
system_info() {
    echo "===================="
    echo "SÜSTEEMI INFO"
    echo "===================="
    hostname
    uname -r
    whoami
}

system_info
system_info
