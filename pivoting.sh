#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

hostname=$(hostname)

echo -e "${GREEN}[+] Basic Information on $hostname machine${ENDCOLOR}"


echo -e "\n${YELLOW}List of Machine Local IP's:${ENDCOLOR}"
ifconfig | awk '{print $(NF - -4), $NF}' | grep "172."  | cut -c 2-
ifconfig | awk '{print $(NF - -4), $NF}' | grep "192." | cut -c 2-
ifconfig | awk '{print $(NF - -4), $NF}' | grep "10." | cut -c 2- | grep -v "0x10<host>"

echo -e "\n${YELLOW}Utilities:${ENDCOLOR}"

which aws
which netcat
which nc.traditional
which curl
which ping
which gcc
which g++
which make
which gdb
which base64
which socat
which python
which python2
which python3
which perl
which php
which ruby
which xterm
which sudo
which wget
which nc 
which nmap
which fping

echo -e "\n"

echo -e "${GREEN}[+] Network Recon\n${ENDCOLOR}"

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
		timeout 0.5 bash -c "ping -c 1 $host.$i" &> /dev/null
		a=$(echo $?)
		if [[ $a =~ 0 ]]
		then
			array[${#array[@]}]=$host.$i
			echo $host.$i >> hosts.txt
			b=$(ping -c 1 $host.$i | grep 'ttl' | awk '{print $(NF - 2), $NF}' | cut -c 5-7)
			if [[ $b =~ 64 ]] || [[ $b =~ 63 ]] || [[ $b =~ 62 ]]
                	then
				echo "[+] HOST $host.$i  ACTIVE  [OS=Linux]"
			
			elif [[ $b =~ 128 ]] || [[ $b =~ 127 ]] || [[ $b =~ 126 ]]
			then
				echo "[+] HOST $host.$i  ACTIVE  [OS=Windows]"
			else
				echo "[+] HOST $host.$i  ACTIVE  [OS=UNDETECTED]"
			fi
		fi
        done; wait
done

for host in ${array[@]}; do
        echo -e "\n${YELLOW}[*] Scanning Ports on: $host${ENDCOLOR}\n"
        for port in $(seq 1 10001); do
                timeout 1 bash -c "echo '' > /dev/tcp/$host/$port" 2> /dev/null && echo -e "\t[+] PORT $host:$port OPEN" &
        done; wait
done
