#! /bin/bash

mapfile -t lines < <(rostopic list)
for (( i=0; i<${#lines[@]}; i++ )); do 
    echo ${lines[i]}
    read VAL1 <<< $(timeout 1s rostopic bw ${lines[i]} | awk '/average:/ { print $0}')
    echo ${VAL1}
    read VAL1 <<< $(timeout 1s rostopic hz ${lines[i]} | awk '/rate:/ { print $0}')
    echo ${VAL1}

done
