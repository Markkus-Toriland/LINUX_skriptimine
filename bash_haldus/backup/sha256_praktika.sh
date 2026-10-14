#!/bin/bash
# SHA-256 kontrollsumma - mini-praktikum ja kontrollsummad varukoopiatele (~/praks2/backup).
# Kontrollsumma on faili "sõrmejälg": kui failis muutub kasvõi 1 bait, muutub ka summa.
# Käivitamine: ./sha256_praktika.sh 2>&1 | tee sha256_praktika.log

PRAKTIKA="$HOME/praks2/sha256"
BACKUP="$HOME/praks2/backup"

pealkiri() {
    echo
    echo "===== $1 ====="
}

mkdir -p "$PRAKTIKA"
cd "$PRAKTIKA" || exit 1

pealkiri "1) Loon väikese faili ja arvutan kontrollsumma"
echo "hello" > demo.txt
sha256sum demo.txt > demo.txt.sha256
cat demo.txt.sha256

pealkiri "2) Kontroll - peab tulema OK"
sha256sum -c demo.txt.sha256

pealkiri "3) Rikun faili (echo x >> demo.txt) - peab tulema FAILED"
echo "x" >> demo.txt
sha256sum -c demo.txt.sha256
echo "olekukood: $?"
sha256sum demo.txt

pealkiri "4) Kontroll vales kaustas - faili ei leita"
cd /tmp || exit 1
sha256sum -c "$PRAKTIKA/demo.txt.sha256"
echo "olekukood: $?"

pealkiri "5) Uusima arhiivi kontrollsumma (failinimi ilma teeta, et kontroll töötaks ka teises masinas)"
ARCHIVE="$(ls -1t "$BACKUP"/src_2*.tar.zst 2>/dev/null | head -n1)"
if [ -z "$ARCHIVE" ]; then
    echo "Kaustas $BACKUP ei ole src_*.tar.zst arhiive."
    exit 1
fi
NIMI="$(basename "$ARCHIVE")"
cd "$BACKUP" || exit 1
sha256sum "$NIMI" > "$NIMI.sha256"
cat "$NIMI.sha256"

pealkiri "6) Kontroll hiljem: cd ~/praks2/backup ja sha256sum -c"
cd "$HOME" || exit 1
cd "$BACKUP" || exit 1
sha256sum -c "$NIMI.sha256"

pealkiri "7) Kõigi arhiivide kontrollsummad failis checksums.txt"
find . -maxdepth 1 -type f -name 'src_*.tar.*' ! -name '*.sha256' -print0 | xargs -0 sha256sum > checksums.txt
cat checksums.txt
sha256sum -c checksums.txt
echo "olekukood: $?"
