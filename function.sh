#!/usr/bin bash
#This script prints using  simple functions with the keyword function and without.
#Usage bash function.sh


function Hello() {
	local LNAME=$1 	#Scope of LNAME is inside Hello only.
	echo "Hello $LNAME"
}

Goodbye() {
	echo "Goodbye $1"
}

#Adding first parameter outside of Hello
echo "Calling the Hello function"
Hello Bob 

echo "Calling the Goodbye function"
Goodbye Robert

exit 0
