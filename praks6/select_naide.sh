#!/bin/bash
# select (ryanstutorials): lihtne menüü, mis kordub kuni valitakse "lõpeta"
nimed='Kyle Cartman Stan lõpeta'
PS3='Vali tegelane: '
select nimi in $nimed
do
    if [ "$nimi" == "lõpeta" ]
    then
        break
    fi
    echo "Valisid: $nimi"
done
echo "Head aega!"
