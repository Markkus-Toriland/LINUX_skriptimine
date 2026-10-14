#!/bin/bash
# Loto mäng (versioon 3 - funktsioonid on jagatud loogiliselt eraldi failidesse kaustas lib/).
# See fail on programmi ainus käivitusfail: ./lottery.sh

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# funktsioonide failide laadimine
source "$BASE_DIR/lib/ui.sh"
source "$BASE_DIR/lib/player.sh"
source "$BASE_DIR/lib/draw.sh"
source "$BASE_DIR/lib/results.sh"

PLAYER_FILE="$BASE_DIR/player_numbers.txt"
LOTTERY_FILE="$BASE_DIR/lottery_numbers.txt"
RESULTS_FILE="$BASE_DIR/results.txt"

# ---------------- põhiprogramm ----------------
show_header
clear_files "$PLAYER_FILE" "$LOTTERY_FILE"
player_name=$(read_player)
read_player_numbers "$PLAYER_FILE"
show_numbers "Sinu numbrid" "$PLAYER_FILE"
generate_lottery_numbers "$LOTTERY_FILE" 5 1 50
show_numbers "Loositud numbrid" "$LOTTERY_FILE"
show_match_details "$PLAYER_FILE" "$LOTTERY_FILE"
matches=$(count_matches "$PLAYER_FILE" "$LOTTERY_FILE")
result=$(result_text "$matches")
show_result "$player_name" "$matches" "$result"
if save_result "$RESULTS_FILE" "$player_name" "$PLAYER_FILE" "$LOTTERY_FILE" "$matches" "$result"
then
    echo "Tulemus lisati faili results.txt"
else
    echo "Viga: tulemust ei õnnestunud salvestada."
fi
