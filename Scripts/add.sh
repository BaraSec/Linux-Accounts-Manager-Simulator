#!/bin/bash

tempId=$1

if [[ ! $1 =~ [0-9]{4,4}$ ]] || [ ${#tempId} -ne 4 ]; then
    echo -n -e '\e[41m'    
    echo $1: wrong id format
    echo -n -e '\e[0m'
    exit 4
elif [[ ! $2 =~ [A-Za-z].{2,}_.{3,}[A-Za-z] ]]; then
    echo -n -e '\e[41m'
    echo $2: wrong name format
    echo -n -e '\e[0m'
    exit 5
else
    group=$(cut -d" " -f2 ./accounts)
    res=$(grep $1 ./accounts | wc -l)

    if [ $res -ne 0 ]; then
	echo -n -e '\e[41m'
	echo $1: User id already exists
        echo -n -e '\e[0m'
	exit 6
    else
	c1=$(echo -n $2 | head -c1)
	c2=$(echo -n $2 | tail -c1)
	nums=$(echo -n $1 | cut -c2,3)
	username=$c1$nums$c2

	until [ $(grep $username ./accounts | wc -l) -eq 0  ]; do
		((nums++))
		username=$c1$nums$c2
	done

	echo $username $1 $(echo $2 | tr _ " ") >> ./accounts
	echo -n -e '\e[40;38;5;82m'
	echo added: $username
	echo -n -e '\e[0m'
	exit 0
    fi
fi

