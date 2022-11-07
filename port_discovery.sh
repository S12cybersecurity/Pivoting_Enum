#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

if [ -z $1 ]
then
    echo -e "${RED}[*] Syntax: <IP HOST/S TO SCAN>  MAX. 10${ENDCOLOR}"
    exit 1
fi

if [[ $# =~ 1 ]]
then
   hosts=($1)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"$hosts
fi

if [[ $# =~ 2 ]]
then
   hosts=($1 $2)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}
fi

if [[ $# =~ 3 ]]
then
   hosts=($1 $2 $3)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}
fi

if [[ $# =~ 4 ]]
then
   hosts=($1 $2 $3 $4)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}
fi


if [[ $# =~ 5 ]]
then
   hosts=($1 $2 $3 $4 $5)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}
fi


if [[ $# =~ 6 ]]
then
   hosts=($1 $2 $3 $4 $5 $6)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}", "${hosts[5]}
fi

if [[ $# =~ 7 ]]
then
   hosts=($1 $2 $3 $4 $5 $6 $7)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}", "${hosts[5]}", "${hosts[6]}
fi

if [[ $# =~ 8 ]]
then
   hosts=($1 $2 $3 $4 $5 $6 $7 $8)  
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}", "${hosts[5]}", "${hosts[6]}", "${hosts[7]}
fi

if [[ $# =~ 9 ]]
then
   hosts=($1 $2 $3 $4 $5 $6 $7 $8 $9)
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}", "${hosts[5]}", "${hosts[6]}", "${hosts[7]}", "${hosts[8]}
fi

if [[ $# =~ 10 ]]
then
   hosts=($1 $2 $3 $4 $5 $6 $7 $8 $9 ${10})
   echo -e "${GREEN}List of Hosts: ${ENDCOLOR}"${hosts[0]}", "${hosts[1]}", "${hosts[2]}", "${hosts[3]}", "${hosts[4]}", "${hosts[5]}", "${hosts[6]}", "${hosts[7]}", "${hosts[8]}", "${hosts[9]}
fi

for host in ${hosts[@]}; do
	echo -e "\n${YELLOW}[*] Scanning Ports on: $host${ENDCOLOR}\n"
	for port in $(seq 1 10001); do
		timeout 1 bash -c "echo '' > /dev/tcp/$host/$port" 2> /dev/null && echo -e "\t[+] PORT $host:$port OPEN" &
        done; wait
done
