#! /bin/bash

mapfile -t lines < <(rostopic list)
now=$(date)
host=$(hostname)
echo $now
echo "Topic, Bandwidth, Rate, Published Locally?, Subscribed Locally?"
for (( i=0; i<${#lines[@]}; i++ )); do 
    echo -n ${lines[i]} ", "
    read VAL1 <<< $(timeout 1s rostopic bw ${lines[i]} | awk '/average:/ { print $0}')
    echo -n ${VAL1} ", "
    read VAL1 <<< $(timeout 1s rostopic hz ${lines[i]} | awk '/rate:/ { print $0}')
    echo -n ${VAL1} ", "
    read VAL1 <<< $(rostopic info ${lines[i]})
    read VAL1 <<< $(rostopic info ${lines[i]})
    VAL1=${VAL1//'*'/-} # Bodge to prevent * from throwing everything
    sub=${VAL1##*'Subscribers:'}
    pub=${VAL1##*'Publishers:'}
    pub=${pub%%'Subscribers:'*}
    if [[ $pub = *$host* ]]; then
        echo -n "yes, "
    fi
    if [[ $sub = *$host* ]]; then
        echo "yes"
    fi
done
