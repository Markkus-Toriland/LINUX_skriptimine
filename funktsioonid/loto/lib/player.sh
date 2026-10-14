#!/bin/bash
# Mängijaga seotud funktsioonid: nime ja numbrite lugemine ning sisendi kontroll

# read_player - väljastab mängija nime (tühja sisendi korral Unknown)
read_player() {
    local name
    read -r -p "Sisesta oma nimi: " name
    if [ -z "$name" ]
    then
        name="Unknown"
    fi
    echo "$name"
}

# validate_number number fail - return 0, kui number sobib, muidu 1
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

# read_player_numbers fail - küsib 5 korrektset numbrit ja salvestab need faili
read_player_numbers() {
    local file="$1"
    local count=0
    local nr
    echo "Vali 5 erinevat numbrit vahemikust 1-50."
    while [ $count -lt 5 ]
    do
        echo -n "Number $((count + 1)): "
        read -r nr
        if validate_number "$nr" "$file"
        then
            echo "$((10#$nr))" >> "$file"
            count=$((count + 1))
        fi
    done
}
