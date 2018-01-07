#!/bin/bash

lss=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | sed -e '$ d' | tr -d ' ')


#printf "$lss\n" | sed 's/[defzi].*//'

        status=0
        statustxt=Inventory;

for line in $(printf "$lss\n")
do
        echo "$status SAPInst_"`echo $line | sed 's/[defzi].*//'`" varname=2;crit $statustxt $line";
done