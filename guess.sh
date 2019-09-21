#!/usr/bin/ bash
#This script is a game where the user must guess the number. Script will indicate
#if user is too high or too low.

COMPUTER=36 #This is the number the user must guess
VALID=0

while [ $VALID -eq 0 ]
do
	read -p "Please guess a number between 1 and 50: " GUESS 
	if [[ ! $GUESS =~ ^[0-9]+$ ]] # =~ matches the regular expression
	then
		echo "Non alpha characters detected [$NAME]"
		continue
	elif [ $GUESS -gt $COMPUTER ]
	then
		echo "Your guess of $GUESS was too high!"
		continue
	elif [ $GUESS -lt $COMPUTER ]
	then
		echo "Your guess of $GUESS was too low!"
		continue
	else
		echo "You won! The number was $COMPUTER."
	fi
	VALID=1
done

exit 0
