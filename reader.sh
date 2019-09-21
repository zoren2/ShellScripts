#!/usr/bin/ bash

COUNT=1

#IFS is the internal field separator. -r indicates to not allow backslashes
#LINE is a placeholder for current line of text
while IFS='' read -r LINE
do
	echo "LINE $COUNT: $LINE"
	((COUNT++))
done < "$1" #Uses redirection for input (eg: user text file)

exit 0
