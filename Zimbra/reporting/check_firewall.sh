#!/bin/sh

output="/tmp/check_firewall.txt"

rm -f $output
touch $output

/usr/sbin/iptables -nvL >> $output

scp $output root@10.10.10.201:/var/www/html/mailboxes/vmail2_check_firewall.txt

