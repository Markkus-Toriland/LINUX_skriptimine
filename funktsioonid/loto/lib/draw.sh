#!/bin/bash
# Failide ettevalmistamise ja loosimise funktsioonid

# clear_files fail1 fail2 ... - loob või tühjendab antud failid
clear_files() {
    local file
    for file in "$@"
    do
        > "$file"
    done
}

# generate_lottery_numbers fail kogus min max - loosib erinevad numbrid faili
generate_lottery_numbers() {
    local file="$1"
    local amount="$2"
    local min="$3"
    local max="$4"
    local nr
    while [ $(wc -l < "$file") -lt $amount ]
    do
        nr=$((RANDOM % (max - min + 1) + min))
        if ! grep -qx "$nr" "$file"      # duplikaadi korral genereeritakse uus number
        then
            echo "$nr" >> "$file"
        fi
    done
}
