#!/bin/bash

queuelength=`/opt/zimbra/postfix/sbin/mailq -bp | tail -n1 | awk '{print $5}'`
queuecount=`echo 0$queuelength`

if [ "$queuecount" -lt 5 ]; then
        status=0
        statustxt= echo "$status mail_queue varname=2;crit $statustxt e-mails in queue $queuecount";

elif [ "$queuecount" -lt 10 ];

then
      status=1
      statustxt1= echo "$status mail_queue varname=2;crit $statustxt e-mails in queue $queuecount";

else
        status=2
        statustxt=CRITICAL;

                  echo "$status mail_queue varname=2;crit $statustxt; e-mails in queue $queuecount"

fi
exit 35
