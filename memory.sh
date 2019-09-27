#!/usr/bin/ bash
#This script reports amount of virtual memory utilized by the user machine by determining how much is being utilized
#as a fraction of the users total virtual memory. sysctl -a is utilized to determine total system memory. 
#As a metric, the script also determines the machines physical memory.

#Physical memory
TOTALHARDWAREMEM=`sysctl -a | awk '/hw.m/{print $2}'`


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

echo Free VMEM: $FREEVMEM Mi
echo VMEM Total: $TOTALVMMEM Mi

echo Total VM Percent: $FREEVMEMPERCENTAGE%

exit 0
