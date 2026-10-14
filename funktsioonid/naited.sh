#!/bin/bash
# Funktsioonide teooria näited ühes õppimist abistavas skriptis.
# Käivita: bash naited.sh  või sammhaaval jälgimiseks: bash -x naited.sh

pealkiri() {
    echo
    echo "----- $1 -----"
}

# 1. lihtne funktsioon
tervita() {
    echo "Tere!"
    echo "Tänane kuupäev on: $(date +%d.%m.%Y)"
}

# 2. sama tegevus mitu korda
system_info() {
    echo "SÜSTEEMI INFO: $(hostname), kernel $(uname -r), kasutaja $(whoami)"
}

# 6. funktsioonid kutsuvad teisi funktsioone
show_user() { echo "Kasutaja: $(whoami)"; }
show_host() { echo "Arvuti: $(hostname)"; }
show_system() {
    show_user
    show_host
}

# 7.-8. argumendid
tere_nimi() { echo "Tere, $1!"; }
kasutaja_info() {
    local nimi="$1"
    local vanus="$2"
    echo "Nimi: $nimi, vanus: $vanus"
}

# 9. argumentide arv ja kontroll
liida() {
    if [ $# -ne 2 ]
    then
        echo "Viga: sisesta kaks arvu!"
        return 1
    fi
    echo "$(($1 + $2))"
}

# 10. kõik argumendid
naita() {
    echo "Funktsioonile anti $# argumenti:"
    for argument in "$@"
    do
        echo "  $argument"
    done
}

# 11.-12. globaalne ja lokaalne muutuja
globaalne() { nimi="Mari"; }
lokaalne() { local linn="Tartu"; echo "Funktsiooni sees: linn=$linn"; }

# 14.-16. return, $? ja funktsioon if-tingimuses
kontrolli_faili() {
    if [ ! -f "$1" ]
    then
        echo "Faili $1 ei leitud!"
        return 1
    fi
    echo "Fail $1 on olemas."
    return 0
}
fail_olemas() { [ -f "$1" ]; }

# ---------------- põhiprogramm ----------------
pealkiri "1. lihtne funktsioon"
tervita

pealkiri "2. ja 5. sama funktsioon mitu korda (ka tsüklist)"
for i in 1 2
do
    system_info
done

pealkiri "6. funktsioon kutsub teisi funktsioone"
show_system

pealkiri "7.-8. argumendid"
tere_nimi "Mari"
tere_nimi "Jüri"
kasutaja_info "Anna" 18

pealkiri "9. argumentide arv"
liida 10 5
liida 10

pealkiri "10. kõik argumendid \"\$@\""
naita "üks" "kaks kolm" "neli"

pealkiri "11.-12. muutujad"
globaalne
echo "Pärast funktsiooni globaalne: nimi=$nimi"
lokaalne
echo "Pärast funktsiooni lokaalne: linn=${linn:-(tühi, sest muutuja oli local)}"

pealkiri "13. funktsiooni väljundi salvestamine muutujasse"
tulemus=$(liida 10 20)
echo "Tulemus: $tulemus"

pealkiri "14.-15. return ja \$?"
kontrolli_faili /etc/passwd
echo "Olekukood: $?"
kontrolli_faili /olematu/fail
echo "Olekukood: $?"

pealkiri "16. funktsioon if-tingimuses"
if fail_olemas /etc/hostname
then
    echo "/etc/hostname on olemas."
else
    echo "/etc/hostname puudub."
fi

pealkiri "17. return ei lõpeta skripti (exit lõpetaks)"
kontrolli_faili /tmp/olematu.txt
echo "Skript jätkab tööd."
