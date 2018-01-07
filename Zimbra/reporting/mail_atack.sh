#!/bin/bash

track=`grep "failure" /var/log/zimbra.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq -c`
track_sort=`echo $track`

echo $track_sort

exit 35

