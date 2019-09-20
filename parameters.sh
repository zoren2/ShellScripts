#!/usr/bin/ bash
#This script concatenates command line arguments into an output string.
#Usage: bash parameters.sh {name}

USER_NAME=$1
echo Hello $USER_NAME
echo $(date)
echo $(pwd)

exit 0
