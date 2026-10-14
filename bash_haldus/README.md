# BASH haldusskriptid

Aine Skriptimisvahendid BASH halduse praktikumid. Skriptid on tehtud Debian 13 masinas `sv-markkus`.
Juhendi soovituse järgi kasutasin `sudo`-t ja olemasolevat repositooriumi, mitte eraldi root-i repositooriumi.

## Kasutajate haldus (praks1)

| Skript | Ülesanne |
|--------|----------|
| `lisa_kasutaja` | 1 - loob kasutaja koos kodukataloogi ja peidetud failidega (`useradd -m`) |
| `kasutajad_failist` | 2 - loeb kasutajanimed failist ja kutsub `lisa_kasutaja` |
| `kasutajad_failist_parooliga` | 3 - read kujul `kasutaja:parool`, parool määratakse `chpasswd` abil |
| `kasutajad_ja_paroolid` | 4 - kasutajad ja paroolid kahes eraldi failis, teisi skripte ei kutsuta |
| `kasutajad_genereeritud_parooliga` | 5 ja 6 - genereerib paroolid `pwgen` abil, logib need ja lubab käivitada ainult root-il |
| `kustuta_kasutajad` | abiskript testkasutajate kustutamiseks |

Testfailid: `kasutajad`, `kasutajad_paroolid`, `kasutajad2` + `paroolid2`, `kasutajad3`.

## Varundamine (backup/)

- `kodukataloogide_varundus.sh` - kõigi `/home` kodukataloogide varundamine kujul `kasutaja.PP.KK.AAAA.tar.gz` kataloogi `/home_bcp`
- `backup_sammud.sh` - praktikumi sammud 1-11 (zstd arhiiv, kontroll, suurus, rotatsioon, välistused, kuiv jooks, logimine, vaba ruum, SHA-256, kompressorid, `.backupignore`)
- `backupexec.sh` - samm 12: kõik eelnev ühes skriptis (`mktemp` + `trap`, kontrollsumma, logi, kompressori valik, `-n` kuiv jooks)

## Teenused (teenused/)

- `apache_paigaldus.sh` - kontrollib `dpkg-query` abil, kas apache2 on paigaldatud; vajadusel paigaldab ja näitab teenuse olekut
