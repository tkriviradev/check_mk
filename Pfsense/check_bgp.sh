#!/bin/sh

showbgp=`bgpctl show summary | grep -E 'Idle|Active|Connect'`
echostatus=`echo $showbgp`

if [ "$echostatus" = "" ]; then
        status=0
        statustxt=OK_bgp_is_runnning;

                  echo "$status bgp_status varname=2;crit $statustxt $echostatus";
else
        status=2
        statustxt=CRITICAL;

                  echo "$status bgp_status varname=2;crit $statustxt $echostatus";
fi
exit 35
