#!/usr/bin bash
#This script sends a process to /dev/null and tells the user when a process has
#terminated. 
#Usage: ./proc.sh {PID}

STATUS=0

if [ -z $1 ]
then
	echo "Please supply a PID (process ID)."
	exit 1
fi

echo "Watching PID = $1"
while [ $STATUS -eq 0 ]
do
	ps $1 > /dev/null
	STATUS=$? #picks up status of the last command ran. In this case, ps $1 > /dev/null
done

echo "Process $1 has terminated"
exit 0
