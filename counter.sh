#!/usr/bin bash
#This script counts from the number 1 to the number entered by the user using a while loop.

USER_NUM=$1
FROM=1

while [ $FROM -le $USER_NUM ]
do
	echo Current Value = $FROM
	((FROM++))
done

echo Loop finished.
exit 0
