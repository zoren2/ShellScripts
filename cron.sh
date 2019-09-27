#!/bin/bash
#This script updates MySQL table to include a number of hardware performance statistics. This includes virtual memory,
#hard-wired memory, CPU usage (sampled over a period of time), and time of update.

##############################
##### Hard-Wired Memory ######
##############################

TOTALHARDWAREMEM=`sysctl -a | awk '/hw.m/{print $2}'`

##########################
##### Virtual Memory #####
##########################

#vm_stat is used to determine free virtual memory - macOSX "hack" to get output similar to linux "Free" from StackOverflow
FREEVMEM=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/free/ {print $2}'`

#Variables required to determine total Virtual Memory. As a note it is normal for small varaibility in VM memory in Mac OSX.
ACTIVEVMEM=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/^active/ {print $2}'`

INACTIVEVMEM=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/^inactive/ {print $2}'`

SPECULATIVEVMEM=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/^speculative/ {print $2}'`

WIREDVMEM=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/^wired/ {print $3}'`

PAGESOCCUPIEDBYCOMPRESSOR=`vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);' | awk '/^occupied/ {print $4}'`

#Adding all of the variables to determine total VM Memory.
TOTALVMMEM=$(echo $FREEVMEM+$ACTIVEVMEM+$INACTIVEVMEM+$SPECULATIVEVMEM+$WIREDVMEM+$PAGESOCCUPIEDBYCOMPRESSOR | bc )

#Divide Free Memory by Total V Memory to get percentage
FREEVMEMPERCENTAGE=$(echo "scale=2 ; $FREEVMEM / $TOTALVMMEM" | bc)


###############
##### CPU #####
###############

#Percent of user CPU used sampled over a short period of time.
NUMOFSAMPLES=5
CPU=`top -F -R -o cpu -l $NUMOFSAMPLES | awk '/CPU usage:/ {print $3}' | grep -Eo "[0-9]+\.[0-9]+"`
TOTAL=0

for SAMPLE in $CPU
do
	TOTAL=$(echo $TOTAL+$SAMPLE | bc ) #Adds the sampled number into TOTAL in order to find average.
done

CPUPERCENT=$(echo "scale=2; $TOTAL / $NUMOFSAMPLES" | bc)

#####################
##### Hard Disk #####
#####################

#Percent of user disk that is free for use.
DISKTOTAL=`df -h | awk '$NF=="/"{printf "%s\t\t\n", $2}' | grep -Eo "[0-9]+"`
DISKFREE=`df -h | awk '$NF=="/"{printf "%s\t\t\n", $3}' | grep -Eo "[0-9]+"`

################
##### Date #####
################

#Retrieve current date
CURRENTTIME=$(date +'%Y-%m-%d %H:%M:%S')

###############################################################################################
##### MySQL credentials.                                                                 ######
##### Edit user MySQL credentials in this section to match your environmental variables. ######
###############################################################################################
mysql -u root <<EOF
use performance
INSERT INTO performances(hard_drive_total,hard_drive_free,cpu_usage,vmem_total,vmem_free,created_at,updated_at) VALUES($DISKTOTAL,$DISKFREE,$CPUPERCENT,$TOTALVMMEM,$FREEVMEM,'$CURRENTTIME','$CURRENTTIME');
EOF

exit 0
