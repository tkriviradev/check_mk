#!/bin/bash

### Geenral configs
hostnm="$(hostname)"
MK_VARDIR="/var/lib/check_mk_agent"
sapoverview=$(cat $MK_VARDIR/cache/sap_systemoverview.cache |grep 'WARNING|ERROR')

### This is the first try to locate hdb isntance
lss=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $9}' | tr -d "|" |grep HDB)

###TEST
#echo "test start"
#printf "$lss\n"

for line in $(printf "$lss\n")
do
        #echo $line
        #echo $(ls -ld $line |awk '{print $3}')
        #sudo -u $(ls -ld $line |awk '{print $3}') /bin/bash -c "source ~/.profile; python $line/python_support/systemOverview.py"

    if sudo -u $(ls -ld $line |awk '{print $3}') /bin/bash -c "source ~/.profile; python $line/python_support/systemOverview.py" | sed '$ d' |grep 'OK' > $MK_VARDIR/cache/sap_systemoverview.cache ; then
        status=0
        statustxt=OK
    elif sudo -u $(ls -ld $line |awk '{print $3}') /bin/bash -c "source ~/.profile; python $line/python_support/systemOverview.py" | sed '$ d'|grep 'WARNING' > $MK_VARDIR/cache/sap_systemoverview.cache ; then
        status=1
        statustxt=WARNING
    else
        status=2
        statustxt=CRITICAL
   fi
        echo "$status SAPHANA_Overview_"`echo $line`" varname=2;crit $statustxt $sapoverview";
done

exit