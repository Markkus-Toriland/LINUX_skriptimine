#!/bin/bash
# ryanstutorials tegevus 1: väljastab arvud 1-10 ja iga arvu juures, kas see on paaris või paaritu
for i in {1..10}
do
    if [ $((i % 2)) -eq 0 ]
    then
        echo "$i - paaris"
    else
        echo "$i - paaritu"
    fi
done
