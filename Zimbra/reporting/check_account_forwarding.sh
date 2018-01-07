#!/bin/sh

output="/tmp/forwarded_acc.txt"

rm -f $output
touch $output

for account in `/opt/zimbra/bin/zmprov -l gaa`; do
        forwardingaddress=`/opt/zimbra/bin/zmprov ga $account |grep 'zimbraPrefMailForwardingAddress' |sed 's/zimbraPrefMailForwardingAddress: //'`
        if [ "$forwardingaddress" != "" ]; then
                echo "$account is forwarded to $forwardingaddress" >> $output
        else
                forwardingaddress="" 
        fi
done

scp $output root@10.10.10.201:/var/www/html/mailboxes/vmail2_forwarded_acc.txt
