#!/usr/bin/ bash
#This script samples NUMOFSAMPLE times what percentage of the users CPU is being used.

NUMOFSAMPLES=5
CPU=`top -F -R -o cpu -l $NUMOFSAMPLES | awk '/CPU usage:/ {print $3}' | grep -Eo "[0-9]+\.[0-9]+"`
TOTAL=0

for SAMPLE in $CPU
do
	TOTAL=$(echo $TOTAL+$SAMPLE | bc ) #Adds the sampled number into TOTAL in order to find average.
done

echo "scale=2; $TOTAL / $NUMOFSAMPLES" | bc
exit 0
