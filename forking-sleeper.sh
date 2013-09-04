#!/bin/bash

#echo "The whole purpose of this is to spawn sub processes"
#
#read -p "How many processes do you want to run? " TOTAL
#read -p "How many processes do you want to run at once? " SAME

COUNT=0
CONCURRENT=1
SAME=15
echo "same: $SAME"
TOTAL=`wc -l $1 | awk '{print $1}'`
echo "total: $TOTAL"
SSHHOST=(`cat $1`)
#echo ${SSHHOST[5]}
#exit

while [ $COUNT -lt $TOTAL ]
do
    CONCURRENT=`jobs | wc -l | sed -e 's/ //g'`
    if [ $CONCURRENT -le $SAME ]
    then
        echo "Starting ${SSHHOST[$COUNT]} $COUNT / $TOTAL ($CONCURRENT)"
#	ssh -o StrictHostKeyChecking=no ${SSHHOST[$COUNT]} 'your command here' >> /tmp/output 2>&1 &
 
        CONCURRENT=`jobs | wc -l | sed -e 's/ //g'`
        COUNT=`echo "$COUNT + 1" | bc`
    fi
done

