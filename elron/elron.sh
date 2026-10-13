#!/bin/bash
# Elroni rongiinfo: kuvab valitud marsruudi rongide väljumisajad Elroni reaalaja API põhjal.
# Juba väljunud rongid kuvatakse punaselt, veel eesootavad roheliselt.
# Kasutab: read, case, if, curl, grep, cut, sed, sort ja toru |

# värvikoodid (ANSI escape-koodid)
PUNANE='\033[0;31m'
ROHELINE='\033[0;32m'
LAHTESTA='\033[0m'

# 1. marsruudi valimine
echo "ELRONI RONGIINFO"
echo "Vali marsruut:"
echo "1 - Tartu → Tallinn"
echo "2 - Tartu → Valga"
echo "3 - Tartu → Koidula"
echo -n "Sisesta valik: "
read valik

# 2. tühja sisendi kontroll
if [ -z "$valik" ]
then
    echo "Valik jäi sisestamata."
    exit 1
fi

# lähte- ja sihtjaam vastavalt valikule
case $valik in
    1) lahtejaam="Tartu"; sihtjaam="Tallinn" ;;
    2) lahtejaam="Tartu"; sihtjaam="Valga" ;;
    3) lahtejaam="Tartu"; sihtjaam="Koidula" ;;
    *) echo "Vigane valik! Vali 1, 2 või 3."; exit 1 ;;
esac

# 3. andmete pärimine Elroni API-st ja päringu õnnestumise kontroll
vastus=$(curl -s -f "https://elron.ee/live-map/stop/$lahtejaam")
if [ $? -ne 0 ] || [ -z "$vastus" ]
then
    echo "Elroni API päring ebaõnnestus."
    exit 1
fi

# 4.-5. iga rongi andmed on JSON-is eraldi {...} plokis - toome need eraldi ridadele
#       ja jätame alles ainult valitud sihtjaama rongid
rongid=$(echo "$vastus" | grep -o '{[^}]*}' | grep "\"sihtjaam\":\"$sihtjaam\"")

# 6. kas sobivaid ronge leiti
if [ -z "$rongid" ]
then
    echo "Sobivaid ronge ei leitud."
    exit 0
fi

# 7. väljumisajad: "plaaniline_aeg":"11:36" -> 11:36 (korduvad read eemaldame)
ajad=$(echo "$rongid" | grep -o '"plaaniline_aeg":"[0-9:]*"' | cut -d'"' -f4 | sed '/^$/d' | sort -u)
kokku=$(echo "$ajad" | wc -l)

# 8. praegune kellaaeg
praegu=$(date +%H:%M)
echo
echo "$lahtejaam → $sihtjaam"
echo "Praegune kellaaeg: $praegu"
echo "Väljumised:"

# 9.-10. iga väljumisaja võrdlemine praeguse kellaajaga (ilma tsüklita, iga aeg eraldi)
# Kellaaegu kujul HH:MM saab võrrelda tekstina, sest neil on alati sama pikkus.
aeg=$(echo "$ajad" | sed -n '1p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '2p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '3p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '4p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '5p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '6p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '7p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '8p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '9p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi
aeg=$(echo "$ajad" | sed -n '10p')
if [ -n "$aeg" ]; then
    if [ "$aeg" \< "$praegu" ]; then echo -e "${PUNANE}$aeg  rong on juba väljunud${LAHTESTA}"; else echo -e "${ROHELINE}$aeg  rong on veel ees${LAHTESTA}"; fi
fi

if [ $kokku -gt 10 ]
then
    echo "... ja veel $(expr $kokku - 10) väljumist"
fi
