#!/usr/bin/env python
# Fail2BanGeo.py, improved
import os

import GeoIP
import pyparsing as pp

log_path = '/var/log/fail2ban.log'
if os.path.exists(log_path):
    log = open(log_path, 'r')
else:
    log = open('/var/log/messages', 'r')

geo = GeoIP.new(GeoIP.GEOIP_MEMORY_CACHE)
octet = pp.Word(pp.nums, min=1, max=3)
ip_matcher = pp.Combine(octet + ('.' + octet) * 3)

for line in log:
    if 'fail2ban' in line and 'Ban' in line:
        match = ip_matcher.searchString(line)
        if match:
            ip = match.pop()[0]
            code = geo.country_code_by_addr(ip)
            name = geo.country_name_by_addr(ip)
            if not code or not name:
                print "No GeoIP info for IP %s." % ip
            else:
                print "GeoIP info for %s:\t%s, %s" % (ip, code, name)
