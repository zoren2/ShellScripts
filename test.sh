#!/bin/bash
#A simple script that echoes a message, sleeps, then echoes again for the purpose
#of testing redirection and process watching.

echo "This script ran at $(date +%B%d,%T)" 
echo
sleep 5
echo "The script has finished."
