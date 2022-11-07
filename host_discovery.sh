#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

if [ -z $1 ]
then
    echo -e "${RED}[*] Syntax: <NETWORK/S TO SCAN> Format: 192.168.0 ${ENDCOLOR}"
    exit 1
fi

if [[ $# =~ 1 ]]
then
   hosts=($1)
   echo -e "${GREEN}List of Networks: ${ENDCOLOR}"$hosts
fi

if [[ $# =~ 2 ]]
then
   hosts=($1 $2)
   echo -e "${GREEN}List of Networks: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}
fi

if [[ $# =~ 3 ]]
then
   hosts=($1 $2 $3)
   echo -e "${GREEN}List of Networks: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}
fi

if [[ $# =~ 4 ]]
then
   hosts=($1 $2 $3 $4)
   echo -e "${GREEN}List of Networks: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}
fi

for host in ${hosts[@]}; do
	echo -e "\n${YELLOW}[*] Enumerating Network: $host${ENDCOLOR}\n"
	for i in $(seq 1 254); do
		timeout 1 bash -c "ping -c 1 $host.$i" &> /dev/null && echo "[+] HOST $host.$i ACTIVE" &
        done; wait
done
