#!/usr/bin/ bash
#This script prints to the user numbers 0 to the numeric value of $1.

COUNT=$1
FROM=0

while [ $FROM -lt $COUNT ]
do
	echo "Current Value = $FROM"
	((FROM++))
done

echo "Loop Finished"
exit 0
