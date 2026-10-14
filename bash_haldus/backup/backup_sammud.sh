#!/bin/bash
# Varundamise praktikumi sammud 1-11 käsuhaaval (ülesanne "Varukoopia kuupäevaga ja kontrolliga").
# Iga samm kuvab käsu tulemuse; samm 12 on eraldi skript backupexec.sh.
# Kasutamine: ./backup_sammud.sh 2>&1 | tee backup_sammud.log

P="$HOME/praks2"
B="$P/backup"
samm() { echo; echo "===== $1 ====="; }

# testandmed: alamkaustad docs, imgs ja bin
mkdir -p "$P/src/docs" "$P/src/imgs" "$P/src/bin" "$B" "$P/logs"
echo "Dokument" > "$P/src/docs/a.txt"
echo "Märkmed" > "$P/src/docs/notes.md"
echo "pilt" > "$P/src/imgs/b.jpg"
printf '#!/bin/bash\necho run\n' > "$P/src/bin/run.sh"

samm "1) Lihtne varukoopia .tar.zst"
ARHIIV="$B/src_$(date '+%F_%H-%M-%S').tar.zst"
tar -I 'zstd -19 -T0' -cf "$ARHIIV" -C "$P" src
ls -l "$B"

samm "2) Arhiivi kontrollimine"
tar -I 'zstd -d' -tf "$ARHIIV" | head -n 5

samm "3) Varukoopia suurus"
du -h "$ARHIIV" | awk '{print $1}'

samm "4) Ainult 3 viimast koopiat (teen 5 koopiat)"
for i in 1 2 3 4 5
do
    sleep 1
    tar -I 'zstd -19 -T0' -cf "$B/src_$(date '+%F_%H-%M-%S').tar.zst" -C "$P" src
done
echo "Enne: $(ls -1 "$B"/*.tar.zst | wc -l) faili"
cd "$B" && ls -1t src_*.tar.zst | tail -n +4 | xargs -r rm -f
echo "Pärast: $(ls -1 "$B"/*.tar.zst | wc -l) faili"
ls -1t "$B"

samm "5) Failide välistamine (*.jpg ja bin)"
tar -I 'zstd -19 -T0' --exclude='*.jpg' --exclude='bin' -cf "$B/src_valistatud.tar.zst" -C "$P" src
tar -I 'zstd -d' -tf "$B/src_valistatud.tar.zst"

samm "6) Kuiv jooks - uut arhiivi ei teki"
enne=$(ls -1 "$B" | wc -l)
tar -cf - -C "$P" src | tar -tvf -
echo "Faile backup kaustas enne: $enne, pärast: $(ls -1 "$B" | wc -l)"

samm "7) Logimine"
echo "[ $(date '+%F %T') ] BACKUP START" >> "$P/logs/backup.log"
tar -I 'zstd -19 -T0' -cf "$B/src_logiga.tar.zst" -C "$P" src
echo "[ $(date '+%F %T') ] BACKUP END" >> "$P/logs/backup.log"
cat "$P/logs/backup.log"

samm "8) Vaba ruumi kontroll"
vaja=$(du -sb "$P/src" | awk '{print $1}')
vaba=$(df -B1 "$B" | awk 'NR==2{print $4}')
echo "Kausta suurus: $vaja B, vaba ruum: $vaba B"
if [ "$vaja" -lt "$vaba" ]; then echo "Ruumi piisab - varundus võib alata."; else echo "Ruumi ei piisa - varundust ei tehta."; fi

samm "9) SHA-256 kontrollsumma"
ARHIIV="$(ls -1t "$B"/src_2*.tar.zst | head -n1)"
cd "$B"
sha256sum "$(basename "$ARHIIV")" > "$(basename "$ARHIIV").sha256"
cat "$(basename "$ARHIIV").sha256"
sha256sum -c "$(basename "$ARHIIV").sha256"

samm "10) Erinevad kompressorid"
tar -I 'zstd -19 -T0' -cf "$B/src_kompr.tar.zst" -C "$P" src
tar -czf "$B/src_kompr.tar.gz" -C "$P" src
tar -cJf "$B/src_kompr.tar.xz" -C "$P" src
ls -l "$B"/src_kompr.*

samm "11) .backupignore kasutamine"
printf 'imgs\n*.jpg\n' > "$P/src/.backupignore"
cat "$P/src/.backupignore"
tar -I 'zstd -19 -T0' --exclude-from="$P/src/.backupignore" -cf "$B/src_ignore.tar.zst" -C "$P" src
tar -I 'zstd -d' -tf "$B/src_ignore.tar.zst"
