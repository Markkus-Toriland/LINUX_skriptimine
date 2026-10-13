#!/bin/bash
# Skript väljastab iseenda lähtekoodi tagurpidi:
# $0 on käivitatud skripti fail, tac pöörab ridade järjekorra ja rev pöörab iga rea märgid.
# LC_ALL=C.UTF-8 tagab, et rev käsitleb täpitähti (õ, ä, ö, ü) õigesti.
tac "$0" | LC_ALL=C.UTF-8 rev
