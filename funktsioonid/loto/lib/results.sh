#!/bin/bash
# Tulemuse kontrollimise, hindamise ja salvestamise funktsioonid

# show_match_details mangija_fail loosi_fail - kuvab iga numbri kohta, kas see tabas
show_match_details() {
    local player_file="$1"
    local lottery_file="$2"
    local nr
    echo
    while read -r nr
    do
        echo "Kontrollin numbrit $nr..."
        if grep -qx "$nr" "$lottery_file"
        then
            echo "TABAMUS!"
        else
            echo "Ei tabanud."
        fi
    done < "$player_file"
}

# count_matches mangija_fail loosi_fail - väljastab tabamuste arvu
count_matches() {
    grep -cxFf "$2" "$1"
}

# result_text tabamused - väljastab tulemusele vastava hinnangu
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

# save_result tulemuste_fail nimi mangija_fail loosi_fail tabamused hinnang
# lisab mängu tulemuse ajaloofaili; return 1, kui kirjutamine ebaõnnestus
save_result() {
    local results_file="$1"
    local name="$2"
    local player_file="$3"
    local lottery_file="$4"
    local matches="$5"
    local result="$6"
    {
        echo "========================================"
        echo "Date: $(date)"
        echo "Player: $name"
        echo "Player numbers:"
        cat "$player_file"
        echo "Lottery numbers:"
        cat "$lottery_file"
        echo "Matches: $matches"
        echo "Result: $result"
    } >> "$results_file" 2>/dev/null || return 1
    return 0
}
