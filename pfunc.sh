#!/usr/bin/ bash
#This script uses multiple functions to pipe linux commands and display piped
#output to the user.

GetFiles() {
	FIRSTTENFILES=`ls -1 | sort | head -10`
}

ShowFiles() {
	COUNT=1
	for FILE in $@
	do
		echo $FILE
		((COUNT++))
	done
}

GetFiles
ShowFiles $FIRSTTENFILES #"Passing" FIRSTTENFILES is possible in bashscripting

echo Functions terminated properly.
exit 0
