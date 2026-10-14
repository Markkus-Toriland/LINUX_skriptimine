#!/bin/bash
# backupexec.sh - kausta varundamine kuupäeva ja kontrollidega (ülesanne 12).
# Teeb kõik praktikumi sammud automaatselt:
#   vaba ruumi kontroll -> välistused (.backupignore) -> arhiveerimine ajutisse kausta ->
#   arhiivi kontroll (avaneb, sisaldab alamkaustu) -> SHA-256 kontrollsumma ->
#   teisaldamine backup kausta -> vanade koopiate kustutamine (alles jäävad 3) -> logimine.
#
# Kasutamine: ./backupexec.sh [-n] [-c zstd|xz|gzip] [lähtekaust]
#   -n   kuiv jooks: näitab, mis failid arhiivi läheks, arhiivi ei looda
#   -c   kompressori valik (vaikimisi parim olemasolev: zstd, siis xz, siis gzip)

ALLIKAS="$HOME/praks2/src"
SIHT="$HOME/praks2/backup"
LOGI="$HOME/praks2/logs/backup.log"
HOIA=3
KUIV=0
KOMPRESSOR=""

log() {
    mkdir -p "$(dirname "$LOGI")"
    printf '[ %s ] %s\n' "$(date '+%F %T')" "$1" | tee -a "$LOGI"
}

viga() {
    log "VIGA: $1"
    log "BACKUP END (ebaõnnestus)"
    exit 1
}

# ---- käsurea võtmed ----
while getopts "nc:" voti
do
    case $voti in
        n) KUIV=1 ;;
        c) KOMPRESSOR="$OPTARG" ;;
        *) echo "Kasutamine: $0 [-n] [-c zstd|xz|gzip] [lähtekaust]"; exit 1 ;;
    esac
done
shift $((OPTIND - 1))
[ -n "$1" ] && ALLIKAS="$1"

[ -d "$ALLIKAS" ] || { echo "Lähtekausta $ALLIKAS ei ole."; exit 1; }
ALLIKAS="$(cd "$ALLIKAS" && pwd)"
VANEM="$(dirname "$ALLIKAS")"
NIMI="$(basename "$ALLIKAS")"

# ---- kompressori valik ----
if [ -z "$KOMPRESSOR" ]
then
    if command -v zstd > /dev/null; then KOMPRESSOR="zstd"
    elif command -v xz > /dev/null; then KOMPRESSOR="xz"
    else KOMPRESSOR="gzip"
    fi
fi
case $KOMPRESSOR in
    zstd) TAR_PAKK=(-I 'zstd -19 -T0'); TAR_LAHT=(-I 'zstd -d'); LAIEND="tar.zst" ;;
    xz)   TAR_PAKK=(-J);                TAR_LAHT=(-J);           LAIEND="tar.xz" ;;
    gzip) TAR_PAKK=(-z);                TAR_LAHT=(-z);           LAIEND="tar.gz" ;;
    *) echo "Tundmatu kompressor: $KOMPRESSOR"; exit 1 ;;
esac
command -v "$KOMPRESSOR" > /dev/null || { echo "Kompressor $KOMPRESSOR ei ole paigaldatud."; exit 1; }

# ---- välistused: .backupignore ----
VALISTUS=()
if [ -f "$ALLIKAS/.backupignore" ]
then
    VALISTUS=(--exclude-from="$ALLIKAS/.backupignore")
fi

# ---- kuiv jooks ----
if [ $KUIV -eq 1 ]
then
    echo "Kuiv jooks: arhiivi läheksid järgmised failid (arhiivi ei looda):"
    tar "${VALISTUS[@]}" -cf - -C "$VANEM" "$NIMI" | tar -tvf -
    exit 0
fi

log "BACKUP START ($ALLIKAS, kompressor $KOMPRESSOR)"
mkdir -p "$SIHT"

# ---- vaba ruumi kontroll: vajalik ruum = kausta suurus (pakkimata) ----
vaja=$(du -sb "$ALLIKAS" | awk '{print $1}')
vaba=$(df -B1 "$SIHT" | awk 'NR==2 {print $4}')
if [ "$vaja" -ge "$vaba" ]
then
    viga "vaba ruumi ei ole piisavalt (vaja $vaja B, vaba $vaba B)"
fi
log "Vaba ruumi piisab: vaja $vaja B, vaba $vaba B"

# ---- arhiivi nimi; sama nimega arhiivi üle ei kirjutata ----
ARHIIV="${NIMI}_$(date '+%F_%H-%M-%S').$LAIEND"
[ -e "$SIHT/$ARHIIV" ] && viga "arhiiv $ARHIIV on juba olemas"

# ---- ajutine kaust, mis kustutatakse skripti lõpus igal juhul ----
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

tar "${TAR_PAKK[@]}" "${VALISTUS[@]}" -cf "$TMP/$ARHIIV" -C "$VANEM" "$NIMI" || viga "arhiivi loomine ebaõnnestus"

# ---- arhiivi kontroll: avaneb ja sisaldab alamkaustu ----
sisu=$(tar "${TAR_LAHT[@]}" -tf "$TMP/$ARHIIV") || viga "arhiiv ei avane"
alamkaustu=$(echo "$sisu" | grep -c "^$NIMI/.*/$")
[ "$alamkaustu" -gt 0 ] || viga "arhiivis ei ole alamkaustu"
log "Arhiiv avaneb: $(echo "$sisu" | grep -vc '/$') faili, $alamkaustu alamkausta"

# ---- teisaldamine ja SHA-256 kontrollsumma ----
mv "$TMP/$ARHIIV" "$SIHT/" || viga "arhiivi teisaldamine ebaõnnestus"
cd "$SIHT" || viga "kausta $SIHT ei saa avada"
sha256sum "$ARHIIV" > "$ARHIIV.sha256"
sha256sum -c "$ARHIIV.sha256" > /dev/null || viga "kontrollsumma ei klapi"
log "Kontrollsumma OK: $(cut -c1-16 "$ARHIIV.sha256")..."
log "Arhiiv: $SIHT/$ARHIIV ($(du -h "$ARHIIV" | awk '{print $1}'))"

# ---- alles jäävad ainult $HOIA kõige uuemat koopiat ----
kustutatud=$(ls -1t "${NIMI}"_20*.tar.* 2>/dev/null | grep -v '\.sha256$' | tail -n +$((HOIA + 1)))
if [ -n "$kustutatud" ]
then
    for fail in $kustutatud
    do
        rm -f "$fail" "$fail.sha256"
        log "Vana koopia kustutatud: $fail"
    done
fi

log "BACKUP END (edukas)"
