#!/bin/bash
# Loto mäng (versioon 1 - üks pikk skript, funktsioone veel ei kasuta).
# Mängija valib 5 erinevat numbrit vahemikust 1-50, programm loosib 5 erinevat
# võidunumbrit, võrdleb neid ja lisab tulemuse faili results.txt.

PLAYER_FILE="player_numbers.txt"
LOTTERY_FILE="lottery_numbers.txt"
RESULTS_FILE="results.txt"

echo "=============================="
echo "          LOTO MÄNG"
echo "=============================="

# failide loomine või tühjendamine (results.txt jääb alles)
> "$PLAYER_FILE"
> "$LOTTERY_FILE"

# mängija nimi
echo -n "Sisesta oma nimi: "
read name
if [ -z "$name" ]
then
    name="Unknown"
fi

# mängija numbrid koos sisendi kontrolliga
echo "Vali 5 erinevat numbrit vahemikust 1-50."
count=0
while [ $count -lt 5 ]
do
    echo -n "Number $((count + 1)): "
    read nr
    if [ -z "$nr" ]
    then
        echo "Viga: midagi ei sisestatud."
        continue
    fi
    if ! [[ "$nr" =~ ^[0-9]+$ ]]
    then
        echo "Viga: sisesta täisarv."
        continue
    fi
    nr=$((10#$nr))
    if [ $nr -lt 1 ] || [ $nr -gt 50 ]
    then
        echo "Viga: number peab olema vahemikus 1-50."
        continue
    fi
    if grep -qx "$nr" "$PLAYER_FILE"
    then
        echo "Viga: number $nr on juba valitud."
        continue
    fi
    echo "$nr" >> "$PLAYER_FILE"
    count=$((count + 1))
done

echo
echo "Sinu numbrid: $(tr '\n' ' ' < "$PLAYER_FILE")"

# loosimine: 5 erinevat numbrit, duplikaadi korral genereeritakse uus number
while [ $(wc -l < "$LOTTERY_FILE") -lt 5 ]
do
    nr=$((RANDOM % 50 + 1))
    if ! grep -qx "$nr" "$LOTTERY_FILE"
    then
        echo "$nr" >> "$LOTTERY_FILE"
    fi
done
echo "Loositud numbrid: $(tr '\n' ' ' < "$LOTTERY_FILE")"
echo

# mängija numbrite võrdlemine loositud numbritega
matches=0
while read -r nr
do
    echo "Kontrollin numbrit $nr..."
    if grep -qx "$nr" "$LOTTERY_FILE"
    then
        echo "TABAMUS!"
        matches=$((matches + 1))
    else
        echo "Ei tabanud."
    fi
done < "$PLAYER_FILE"

echo
echo "Mängija: $name"
echo "Tabamusi: $matches / 5"

case $matches in
    5) result="JACKPOT!" ;;
    4) result="Väga hea tulemus!" ;;
    3) result="Hea tulemus." ;;
    2) result="Kaks tabamust." ;;
    1) result="Üks tabamus." ;;
    *) result="Seekord tabamusi ei olnud." ;;
esac
echo "$result"

# tulemuse lisamine mängude ajalukku
{
    echo "========================================"
    echo "Date: $(date)"
    echo "Player: $name"
    echo "Player numbers:"
    cat "$PLAYER_FILE"
    echo "Lottery numbers:"
    cat "$LOTTERY_FILE"
    echo "Matches: $matches"
    echo "Result: $result"
} >> "$RESULTS_FILE"
echo "Tulemus lisati faili $RESULTS_FILE"
