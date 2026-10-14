#!/bin/bash
# 14. return
# return lõpetab funktsiooni töö, skript jätkab väljakutsele järgnevast käsust.
# return 0 - tegevus õnnestus, return 1 - tekkis probleem

kontrolli_faili() {
    if [ ! -f "$1" ]; then
        echo "Faili ei leitud!"
        return 1
    fi

    echo "Fail on olemas."
    return 0
}

kontrolli_faili "/etc/passwd"
kontrolli_faili "/etc/olematu_fail"
echo "Skript jätkab pärast funktsiooni."
