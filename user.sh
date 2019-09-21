#!/usr/bin/ bash
#This script takes user input after running the script and returns the user name
#and age.

VALID=0

while [ $VALID -eq 0 ]
do
	read -p "Please enter your name and age: " NAME AGE
	if [[ ( -z $NAME ) || ( -z $AGE ) ]]
	then
		echo "Not enough parameters passed"
		continue
	elif [[ ! $NAME =~ ^[A-Za-z]+$ ]] # =~ matches the regular expression
	then
		echo "Non alpha characters detected [$NAME]"
		continue
	elif [[ ! $AGE =~ ^[0-9]+$ ]]
	then
		echo "Non digit characters detected [$AGE]"
		continue
	fi
	VALID=1
done
echo "Name = $NAME, Age = $AGE"
exit 0
