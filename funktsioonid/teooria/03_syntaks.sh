#!/bin/bash
# 3. Funktsiooni süntaks
# Kursusel kasutame kuju nimi() { ... }, aga Bash tunneb ka function võtmesõnaga kuju.

hello() {
    echo "Hello!"
}

function hello2 {
    echo "Hello! (function võtmesõnaga kuju)"
}

hello
hello2
