#!/bin/bash
# 4. Funktsioon tuleb enne kasutamist defineerida
# Bash loeb skripti ülevalt alla, seega esimese väljakutse ajal funktsiooni veel ei ole.

echo "Probleemne: kutsun funktsiooni enne defineerimist"
hello
echo "Olekukood: $? (127 - käsku ei leitud)"

hello() {
    echo "Hello!"
}

echo "Õige: kutsun funktsiooni pärast defineerimist"
hello
