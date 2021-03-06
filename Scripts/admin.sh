#!/bin/bash

if [ $# -ne 2 ]; then
    echo -n -e '\e[41m'
    echo usage: admin filename sortcriteria
    echo -n -e '\e[0m'
    exit 1
elif [ ! -f "$1" ]; then
    echo -n -e '\e[41m'
    echo $1: No such filename
    echo -n -e '\e[0m'
    exit 2
elif [ "$2" != "id" ] && [ "$2" != "name" ]; then
    echo -n -e '\e[41m'
    echo $2: No such option
    echo -n -e '\e[0m'
    exit 3
else
    echo -n > ./accounts
    echo
    for op in $(cat $1); do
        currentOp=$(echo $op | cut -c1,2,3)

	if [ "$currentOp" = "del" ]; then
             id=$(echo $op | cut -d: -f2)
	     ./del.sh $id
        elif [ "$currentOp" = "add" ]; then
	    id=$(echo $op | cut -d: -f2)
	    name=$(echo $op | cut -d: -f3)
            ./add.sh $id $name
        else
	    echo -n -e '\e[41m'
            echo $(echo $op | cut -d: -f1): unknown option
	    echo -n -e '\e[0m'	    
        fi
    done

    if [ "$2" = "id" ]; then
	echo -e '\n\n\e[40;38;5;82m--> User information sorted by \e[30;48;5;82mid\e[40;38;5;82m is:\e[0m'
	echo -n -e '\e[1m'
	sort -k2 -t" " -n ./accounts
	echo -n -e '\e[0m'
    elif [ "$2" = "name" ]; then
	echo -e '\n\n\e[40;38;5;82m--> User information sorted by \e[30;48;5;82mname\e[40;38;5;82m is:\e[0m'
	echo -n -e '\e[1m'
	sort -k3 -t" " ./accounts
	echo -n -e '\e[0m'
    fi
    
    echo
fi
