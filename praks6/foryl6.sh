#!/bin/bash
# foryl6: loob failid a.txt, b.txt, c.txt ja väljastab kataloogis olevate .txt failide nimed
touch a.txt b.txt c.txt
for fail in *.txt; do
    echo "Leidsin faili: $fail"
done
