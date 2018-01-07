#!/bin/bash

### Geenral configs
hostnm="$(hostname)"
logwatchcfg=/etc/check-mk-agent/logwatch.cfg

## SAP SYSTEMS BACKUP LOGS DB & APP
lss=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $9}' | sed 's/[exe].*//' | sed -e '$ d')
backup_path="$hostnm/trace/backup.log"

## Locate only HDB for Alert LOGS
lsshdb=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $9}' | sed 's/[exe].*//' | sed -e '$ d' |grep HDB)
log_path="$hostnm/trace/*alert_"$hostnm".trc"

## Print LSSAP and remove all lines with HDB
lssapp=$(/usr/sap/hostctrl/exe/lssap |sed -e '1,3d' | awk '{ print $9}' | sed 's/[exe].*//' | sed -e '$ d' | sed '/HDB*/d')
instlog_path="work/available.log"

### This is Available log section
for line in $(printf "$lssapp\n")
do

#echo $line$instlog_path

if grep "$line$instlog_path" $logwatchcfg > /dev/null
then
    echo "... found"
else
    echo "... not found"

echo "## SAP_DINST_LOG" >> $logwatchcfg
echo "$line$instlog_path" >> $logwatchcfg
echo "C Unavailable" >> $logwatchcfg

fi
done


### This is BACKUP log section
for line in $(printf "$lss\n")
do

if grep "$line$backup_path" $logwatchcfg > /dev/null
then
   echo "... found"
else
   echo "... not found"

echo "## SAP HANA_BACKUP_LOG" >> $logwatchcfg
echo "$line$backup_path" >> $logwatchcfg
echo "W WRN" >> $logwatchcfg
echo "C ERROR" >> $logwatchcfg
echo "C fatal" >> $logwatchcfg

fi
done

### TEST ONLY
#echo $lsshdb$log_path

### This is ALERT LOG Section
if grep "SAP_ALERT_LOG" $logwatchcfg > /dev/null
then
   echo "... found"
else

   echo "... not found"

echo "## SAP_ALERT_LOG" >> $logwatchcfg
echo "$lsshdb$log_path" >> $logwatchcfg
echo "W refused" >> $logwatchcfg
echo "C error" >> $logwatchcfg

fi

exit