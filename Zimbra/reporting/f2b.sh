#!/bin/bash


#awk '($(NF-1) = /Ban/){print $NF}' /var/log/fail2ban.log | sort | uniq -c | sort -n > vmail2.txt 
#/usr/bin/python Fail2BanGeo.py | cut -b15- | sort | uniq -c | sort -n > vmail2.txt

/usr/bin/python Fail2BanGeo.py | cut -b16- | sort | uniq -c | sort -n | awk '{$1=$1}{ print }' > vmail2.txt

cat /opt/zimbra/log/audit.log |egrep 'WARN'| cut -b1- | cut -c 1-114 | sort | awk '{gsub("security - cmd=Auth;", "");print}' | awk '{gsub("ImapServer-", "");print}' | awk '{gsub("WARN", "");print}' | awk '{gsub("account=", "");print}' | awk '{$1=$1}{ print }' > vmail2_audit_log.txt

cat /opt/zimbra/log/mailbox.log |egrep 'authentication failed for'| cut -b50- | cut -c 1-95 | sort | uniq -c | awk '{gsub("ttps://94.156.220.168:7071/service/admin/soap/", "");print}' | awk '{$1=$1}{ print }' >> vmail2_audit_log.txt

scp vmail2.txt 10.10.10.201:/var/www/html/mailboxes/vmail2.txt
scp vmail2_audit_log.txt 10.10.10.201:/var/www/html/mailboxes/vmail2_audit_log.txt


exit
