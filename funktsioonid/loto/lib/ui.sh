#!/bin/bash
# Kasutajaliidese funktsioonid: pealkiri, numbrite ja tulemuse kuvamine

show_header() {
    echo "=============================="
    echo "          LOTO MÄNG"
    echo "=============================="
}

# show_numbers "pealkiri" fail - kuvab faili numbrid ühel real
show_numbers() {
    local title="$1"
    local file="$2"
    echo
    echo "$title: $(tr '\n' ' ' < "$file")"
}

# show_result nimi tabamused hinnang
show_result() {
    local name="$1"
    local matches="$2"
    local result="$3"
    echo
    echo "Mängija: $name"
    echo "Tabamusi: $matches / 5"
    echo "$result"
}
