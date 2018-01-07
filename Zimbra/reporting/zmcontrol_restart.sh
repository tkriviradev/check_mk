#!/bin/bash

/sbin/runuser -l zimbra -c '/opt/zimbra/bin/zmcontrol stop'

/usr/bin/sleep 60s

/sbin/runuser -l zimbra -c '/opt/zimbra/bin/zmcontrol start'

exit
