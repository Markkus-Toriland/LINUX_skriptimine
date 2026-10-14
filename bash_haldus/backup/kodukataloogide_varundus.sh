#!/bin/bash
# Kõikide kasutajate kodukataloogide varundamine.
# Iga /home all olev kodukataloog arhiveeritakse ja pakitakse eraldi failiks
# kujul kasutaja.PP.KK.AAAA.tar.gz ning salvestatakse kataloogi /home_bcp.
# Skript töötab sõltumata sellest, millisest kataloogist see käivitatakse.
# Kasutamine: sudo ./kodukataloogide_varundus.sh

KODUD="/home"
SIHT="/home_bcp"
KUUPAEV=$(date +%d.%m.%Y)

if [ "$(id -u)" -ne 0 ]
then
    echo "Viga: kõigi kodukataloogide lugemiseks on vaja root-õigusi (käivita sudo abil)."
    exit 1
fi

# varukoopiate kataloog luuakse, kui seda veel pole; ligipääs ainult root kasutajale
mkdir -p "$SIHT"
chmod 700 "$SIHT"

for kataloog in "$KODUD"/*/
do
    kasutaja=$(basename "$kataloog")
    arhiiv="$SIHT/$kasutaja.$KUUPAEV.tar.gz"
    # -C /home abil salvestatakse arhiivi suhteline tee (kasutaja/...), mitte absoluutne
    if tar -czf "$arhiiv" -C "$KODUD" "$kasutaja"
    then
        echo "OK: $kasutaja -> $arhiiv ($(du -h "$arhiiv" | cut -f1))"
    else
        echo "VIGA: kasutaja $kasutaja kodukataloogi varundamine ebaõnnestus."
    fi
done

echo
echo "Varukoopiad kataloogis $SIHT:"
ls -lh "$SIHT"
