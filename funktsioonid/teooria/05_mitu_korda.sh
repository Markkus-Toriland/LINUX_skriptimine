#!/bin/bash
# 5. Funktsiooni võib kutsuda mitu korda, ka tsükli seest

hello() {
    echo "Tere tulemast!"
}

hello
hello
hello

tere() {
    echo "Tere!"
}

for i in {1..5}
do
    tere
done
