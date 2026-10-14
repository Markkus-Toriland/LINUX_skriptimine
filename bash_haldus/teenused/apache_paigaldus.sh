#!/bin/bash
# Skript kontrollib, kas veebiserver apache2 on paigaldatud.
# Kui ei ole, siis paigaldab selle; kui on, annab sellest teada ja näitab teenuse staatust.
# Kasutamine: sudo ./apache_paigaldus.sh

TEENUS="apache2"

if [ "$(id -u)" -ne 0 ]
then
    echo "Viga: paigaldamiseks on vaja root-õigusi (käivita sudo abil)."
    exit 1
fi

# dpkg-query väljastab paigaldatud paketi kohta "install ok installed";
# grep -c loeb, mitu sellist rida leiti (0 = ei ole paigaldatud)
paigaldatud=$(dpkg-query -W -f='${Status}' "$TEENUS" 2>/dev/null | grep -c "ok installed")

if [ "$paigaldatud" -eq 0 ]
then
    echo "$TEENUS ei ole paigaldatud - paigaldan..."
    apt-get update -q
    if apt-get install -y "$TEENUS"
    then
        echo "$TEENUS paigaldati edukalt."
    else
        echo "Viga: $TEENUS paigaldamine ebaõnnestus."
        exit 2
    fi
else
    echo "$TEENUS on juba paigaldatud."
fi

# teenuse staatus (kas töötab ja kas käivitub alglaadimisel)
echo
echo "Teenuse olek: $(systemctl is-active "$TEENUS"), automaatne käivitus: $(systemctl is-enabled "$TEENUS")"
systemctl status "$TEENUS" --no-pager | head -n 5
