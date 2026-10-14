#!/bin/bash
# 19. Funktsioonide taaskasutamine
# Funktsioonid loetakse failist functions.sh. Skripti kausta järgi leitakse fail ka siis,
# kui skript käivitatakse teisest kaustast.

SKRIPTI_KAUST="$(cd "$(dirname "$0")" && pwd)"

source "$SKRIPTI_KAUST/functions.sh"
# või lühemalt: . "$SKRIPTI_KAUST/functions.sh"

show_user
show_host
