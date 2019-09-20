#!/usr/bin/ bash
#This script prints out Linux environmental variables.

echo "The PATH is: $PATH"
echo "The terminal is: $TERM"

# -z checks for empty string
if [ -z $EDITOR ]
then
echo "The EDITOR environmental variable is not set."
else
echo "The editor is: $EDITOR"
fi
