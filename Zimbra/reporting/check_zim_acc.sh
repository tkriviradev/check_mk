#!/bin/bash
output="/tmp/accountusage"
lockout="/tmp/acc_locked"
domain="styxsolutions.net"

rm -f $output
touch $output

server=`/opt/zimbra/bin/zmhostname`
/opt/zimbra/bin/zmprov gqu $server|awk {'print $1" "$3" "$2'}|sort|while read line
do
user=`echo $line|cut -f1 -d " "`
status=`/opt/zimbra/bin/zmprov ga $user | grep  ^zimbraAccountStatus | cut -f2 -d " "`
echo "$user ($status account)" >> $output
done

cat $output |grep lock > $lockout

scp $lockout root@10.10.10.201:/var/www/html/mailboxes/vmail2_lock.txt

exit

