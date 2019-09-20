#!/usr/bin/ bash
#This script prints all of the user input names using the $@ array and using a for loop.

NAMES=$@

for NAME in $NAMES
do
	if [ $NAME = 'Tracy' ]
	then
		#break
		continue
	fi
	echo "Hello $NAME!"
done

echo "For loop terminated."
exit 0
