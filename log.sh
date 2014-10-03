#!/bin/bash
#Develop by Joao Luiz Naufel


clusterLog="cluster/log"
array=( "server1" "server2" "server3" )

logEnter() {
	cat $clusterLog | while read LINE
	do
		userid=$(getUserId "$LINE")
		Write "$userid" "$LINE"
	done 
}

Write() {
	way=$(RandServer)/"$1"

	if [ -e ${array[1]}"/"$1 ] || [ -e ${array[2]}"/"$1 ] || [ -e ${array[3]}"/"$1 ];
	then
		if [ -e ${array[1]}"/"$1 ]
		then
			echo "$2" >> "${array[1]}"/"$1"
		fi 
		if [ -e ${array[2]}"/"$1 ]
		then
			echo "$2" >> "${array[2]}"/"$1"
		fi	
		if [ -e ${array[3]}"/"$1 ]
		then
			echo "$2" >> "${array[3]}"/"$1"
		fi	
	else 	
		echo "$2" >> "$way"
	fi
}

getUserId() {
	reg='.*\[([^ ]+).*userid=([0-9a-zA-Z\-]+)"'
	[[ "$1" =~ $reg ]]
	echo ${BASH_REMATCH[2]}
}

RandServer() {
	echo ${array[$((RANDOM %= $((${#array[@]}))))]}
}

logEnter