#!/usr/bin/ bash
#This script will return a useful message if the user enters $1=blue and if the number entered is less than 50.

COLOR=$1
if [ $COLOR = "blue" ]
then
	echo "The color is blue"
else
	echo "The color is NOT blue"
fi

USER_GUESS=$2
COMPUTER=50

if [ $USER_GUESS -lt $COMPUTER ]
then
	echo "The value you entered is too low!"
elif [ $USER_GUESS -gt $COMPUTER ]
then
	echo "The value you entered is too high!"
else
	echo "You've guessed the value!"
fi
