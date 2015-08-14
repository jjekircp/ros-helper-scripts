#!/bin/bash

sudo apt-get install sysbench mbw -y
dd if=/dev/zero of=/tmp/output bs=8k count=1000k >& results.txt
sed -i '1s/^/\n\nDisk Write-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ \n\n/' results.txt
rm -f /tmp/output 
echo -e "\n\nDisk Read-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ \n" >> results.txt
sudo hdparm -Tt /dev/sda >> results.txt
echo -e "\n\nRAM Access-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ \n" >> results.txt
mbw -n 2 2000 >> results.txt
echo -e "\n\nCPU Single Thread Performance-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_\n" >> results.txt
sysbench --test=cpu --num-threads=1 --cpu-max-prime=50000 run >> results.txt
echo -e "\n\nCPU Multi Thread Performance-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_ \n" >> results.txt
sysbench --test=cpu --num-threads=8 --cpu-max-prime=50000 run >> results.txt
