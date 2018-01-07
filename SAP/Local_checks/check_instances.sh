#!/bin/bash

### Geenral configs
hostnm="$(hostname)"

### This is the first try to locate all SAP isntances
lss=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $2}' | tr -d "|")
lss1=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $2, $9}' | tr -d "|" | tr -d ' ' | sed 's/[exe].*//')

###TEST
#printf "$lss1\n"

for line in $(printf "$lss1\n")
do

#echo $line | sed 's/[(/usr].*//' #| sed '/^$/d'
#       echo $line

    if /usr/sap/hostctrl/exe/sapcontrol -nr "`echo $line | sed 's/[(/usr].*//'`" -function GetProcessList |grep 'GREEN' > /dev/null ; then
        status=0
        statustxt=OK
    elif /usr/sap/hostctrl/exe/sapcontrol -nr "`echo $line | sed 's/[(/usr].*//'`" -function GetProcessList |grep 'YELLOW' > /dev/null ; then
        status=1
        statustxt=WARNING
    else
        status=2
        statustxt=CRITICAL
   fi
        echo "$status SAPInst_Procs_"`echo $line`" varname=2;crit $statustxt";
done


exit