#!/usr/bin bash
#This script sleeps for the amount of seconds indicated by the user.

DELAY=$1
if [ -z $DELAY ]
then
	echo "You must supply an integer in order to delay."
	exit 1
fi

echo "Sleeping for $DELAY seconds"
sleep $DELAY
echo "Finished sleeping."
exit 0
