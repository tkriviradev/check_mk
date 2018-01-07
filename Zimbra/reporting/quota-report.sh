#!/bin/bash

input=/tmp/quota-report-temp.txt
output=vmail2_quota_report.txt

date=$(date +"%a, %d %b %Y %H:%M:%S %z (%Z)")
datef="$(date +%F)"

/usr/bin/rm -rf ${output}

/opt/zimbra/bin/zmprov getQuotaUsage `/opt/zimbra/bin/zmhostname` | awk {'print $1" "$3" "$2'} | head -25 > /tmp/quota-report-temp.txt

cat $input | sort -rn -k 2 | head -25 | while read line
do
	usage=`echo $line | cut -f2 -d " "`
	quota=`echo $line | cut -f3 -d " "`
	user=`echo $line | cut -f1 -d " "`
	echo "`expr $usage / 1024 / 1024` of `expr $quota / 1024 / 1024` MB $user" >> ${output}
done

scp ${output} 10.10.10.201:/var/www/html/mailboxes/${output}

exit
