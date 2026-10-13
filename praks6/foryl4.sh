#!/bin/bash
# foryl4: väljastab kõik süsteemi kasutajanimed failist /etc/passwd (cut + käsu asendamine)
for kasutaja in $(cut -d: -f1 /etc/passwd); do
    echo "Kasutaja: $kasutaja"
done
