#!/bin/bash
# 16. Funktsiooni kasutamine if-tingimuses
# Funktsiooni olekukood on viimase käsu ([ -f ]) olekukood, seega sobib see otse if-i.

fail_olemas() {
    [ -f "$1" ]
}

for fail in /etc/passwd /etc/olematu_fail
do
    if fail_olemas "$fail"; then
        echo "Fail $fail on olemas."
    else
        echo "Faili $fail ei leitud."
    fi
done
