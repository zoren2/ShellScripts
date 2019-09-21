#!/usr/bin/ bash
#This script takes the first three lines of an input file and outputs it to the
#user.

COUNT=3
FROM=0

while IFS='' read -r LINE
do
	echo "Current Count $FROM: $LINE"
	((FROM++))
	if [ $FROM -eq $COUNT ]
	then
		break;
	fi
done < "$1"

exit 0
