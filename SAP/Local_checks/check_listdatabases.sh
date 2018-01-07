#!/bin/bash

#lss=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | sed -e '$ d' | tr -d ' ')
lss=$(/usr/sap/hostctrl/exe/saphostctrl -function ListDatabases | sed -e '$ d' |sed -e '1,1d' | tr -d ' ')

#printf "$lss\n" #| sed 's/[defzi].*//'
        #status=0
        #statustxt=OK;

for line in $(printf "$lss\n")
do
    if echo $line |grep 'Running' > /dev/null ; then
        status=0
        statustxt=OK
    elif echo $line |grep 'Warning' > /dev/null ; then
        status=1
        statustxt=WARNING
    else
        status=2
        statustxt=CRITICAL
    fi
        echo "$status SAPHANA_Procs_"`echo $line | sed 's/[(HDB].*//'`" varname=2;crit $statustxt $line";
done