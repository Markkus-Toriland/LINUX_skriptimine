#!/bin/bash
# fcbyl3: pesastatud tsüklid - kui sisemine tsükkel jõuab 5-ni, katkestatakse mõlemad tsüklid (break 2)
for (( i=1; i<=3; i++ )); do
    for (( j=1; j<=10; j++ )); do
        if [ $j -eq 5 ]; then
            echo "j jõudis 5-ni - katkestan mõlemad tsüklid"
            break 2
        fi
        echo "i = $i, j = $j"
    done
done
echo "Pärast tsükleid"
