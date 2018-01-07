#!/bin/bash

zmstatus=`runuser -l zimbra -c '/opt/zimbra/bin/zmcontrol status' | grep -E 'not running'`
echostatus=`echo $zmstatus`

if [ "$echostatus" = "" ]; then
        status=0
        statustxt=OK_all_services_are_runnning;

                  echo "$status zmcontrol_status varname=2;crit $statustxt $echostatus $zmstatus";
else
        status=2
        statustxt=CRITICAL_some_services_not_running;

                  echo "$status zmcontrol_status varname=2;crit $statustxt $echostatus $zmstatus";
fi
exit 35

