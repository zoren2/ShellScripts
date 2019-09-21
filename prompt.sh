#!/usr/bin/ bash
#This script takes input from the user and prints a useful message.

#-p prompts the user without a new line character. NAME will hold the user name
read -p "What is your first name: " NAME
echo "Your name is: $NAME"
exit 0
