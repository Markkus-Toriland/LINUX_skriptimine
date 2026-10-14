#!/bin/bash
# Loto mäng (versioon 2 - programm on jagatud funktsioonideks).
# Mängija valib 5 erinevat numbrit vahemikust 1-50, programm loosib 5 erinevat
# võidunumbrit, võrdleb neid ja lisab tulemuse faili results.txt.

PLAYER_FILE="player_numbers.txt"
LOTTERY_FILE="lottery_numbers.txt"
RESULTS_FILE="results.txt"

show_header() {
    echo "=============================="
    echo "          LOTO MÄNG"
    echo "=============================="
}

# loob või tühjendab mängu failid (results.txt jääb alles)
clear_files() {
    > "$PLAYER_FILE"
    > "$LOTTERY_FILE"
}

# loeb mängija nime globaalsesse muutujasse player_name
read_player() {
    echo -n "Sisesta oma nimi: "
    read player_name
    if [ -z "$player_name" ]
    then
        player_name="Unknown"
    fi
}

# kontrollib ühte sisestatud numbrit; return 0 = korras, 1 = viga
validate_number() {
    local nr="$1"
    local file="$2"
    if [ -z "$nr" ]
    then
        echo "Viga: midagi ei sisestatud."
        return 1
    fi
    if ! [[ "$nr" =~ ^[0-9]+$ ]]
    then
        echo "Viga: sisesta täisarv."
        return 1
    fi
    nr=$((10#$nr))
    if [ $nr -lt 1 ] || [ $nr -gt 50 ]
    then
        echo "Viga: number peab olema vahemikus 1-50."
        return 1
    fi
    if grep -qx "$nr" "$file"
    then
        echo "Viga: number $nr on juba valitud."
        return 1
    fi
    return 0
}

# küsib mängijalt 5 korrektset numbrit ja salvestab need faili
read_player_numbers() {
    local count=0
    local nr
    echo "Vali 5 erinevat numbrit vahemikust 1-50."
    while [ $count -lt 5 ]
    do
        echo -n "Number $((count + 1)): "
        read nr
        if validate_number "$nr" "$PLAYER_FILE"
        then
            echo "$((10#$nr))" >> "$PLAYER_FILE"
            count=$((count + 1))
        fi
    done
}

# kuvab faili numbrid ühel real: show_numbers "pealkiri" fail
show_numbers() {
    local title="$1"
    local file="$2"
    echo "$title: $(tr '\n' ' ' < "$file")"
}

# loosib 5 erinevat numbrit; duplikaadi korral genereeritakse uus number
generate_lottery_numbers() {
    local nr
    while [ $(wc -l < "$LOTTERY_FILE") -lt 5 ]
    do
        nr=$((RANDOM % 50 + 1))
        if ! grep -qx "$nr" "$LOTTERY_FILE"
        then
            echo "$nr" >> "$LOTTERY_FILE"
        fi
    done
}

# võrdleb mängija numbreid loositud numbritega, tulemus muutujasse matches
check_matches() {
    local nr
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
}

# väljastab tabamuste arvule vastava hinnangu
result_text() {
    case $1 in
        5) echo "JACKPOT!" ;;
        4) echo "Väga hea tulemus!" ;;
        3) echo "Hea tulemus." ;;
        2) echo "Kaks tabamust." ;;
        1) echo "Üks tabamus." ;;
        *) echo "Seekord tabamusi ei olnud." ;;
    esac
}

show_result() {
    result=$(result_text "$matches")
    echo
    echo "Mängija: $player_name"
    echo "Tabamusi: $matches / 5"
    echo "$result"
}

# lisab mängu tulemuse ajaloofaili
save_result() {
    {
        echo "========================================"
        echo "Date: $(date)"
        echo "Player: $player_name"
        echo "Player numbers:"
        cat "$PLAYER_FILE"
        echo "Lottery numbers:"
        cat "$LOTTERY_FILE"
        echo "Matches: $matches"
        echo "Result: $result"
    } >> "$RESULTS_FILE"
    echo "Tulemus lisati faili $RESULTS_FILE"
}

# ---------------- põhiprogramm ----------------
show_header
clear_files
read_player
read_player_numbers
echo
show_numbers "Sinu numbrid" "$PLAYER_FILE"
generate_lottery_numbers
show_numbers "Loositud numbrid" "$LOTTERY_FILE"
echo
check_matches
show_result
save_result
