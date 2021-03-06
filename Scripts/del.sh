#!/bin/bash

if [[ ! $1 =~ [0-9]{4,4}:* ]]; then
    echo -n -e '\e[41m'
    echo $1: No such id number
    echo -n -e '\e[0m'
    exit 7
else
    idFound=$(cut -d" " -f2 ./accounts | grep $1 | wc -l)

    if [ $idFound -eq 0 ]; then
	echo -n -e '\e[41m'
	echo $1: No such id number
	echo -n -e '\e[0m'
        exit 8
    else
	username=$(grep " $1 " ./accounts | cut -d" " -f1)  # " $1 " is to avoid deletion of other accounts with "$1" in their info.
        
	sed -i '/'$username'/d' ./accounts
        echo -n -e '\e[40;38;5;82m'
	echo deleted: $username
	echo -n -e '\e[0m'

        exit 0
    fi
fi

