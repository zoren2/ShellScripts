#!/usr/bin/ bash
#This script reports how much free space (in percentage) how much free space the users disk contains.

MEMORY=`df -h | awk '$NF=="/"{printf "%s\t\t\n", $5}' | grep -Eo "[0-9]+"`

echo $MEMORY
exit 0
