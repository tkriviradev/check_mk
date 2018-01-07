#!/usr/bin/python
# Sven Holter
# rbl check

import dns.resolver
import dns.exception
import sys
import netifaces

print '<<<rbl_check>>>'

dnbl= ["cbl.abuseat.org", "b.barracudacentral.org", "zen.spamhaus.org", "ix.dnsbl.manitu.net"]
#"b.barracudacentral.org", "dnsbl.sorbs.net", "http.dnsbl.sorbs.net", "dul.dnsbl.sorbs.net", "misc.dnsbl.sorbs.net", "smtp.dnsbl.sorbs.net", "socks.dnsbl.sorbs.net", "spam.dnsbl.sorbs.net", "web.dnsbl.sorbs.net", "zombie.dnsbl.sorbs.net", "dnsbl-1.uceprotect.net", "dnsbl-2.uceprotect.net", "dnsbl-3.uceprotect.net", "pbl.spamhaus.org", "sbl.spamhaus.org", "xbl.spamhaus.org", "zen.spamhaus.org", "bl.spamcannibal.org", "psbl.surriel.com", "ubl.unsubscore.com", "dnsbl.njabl.org", "combined.njabl.org", "rbl.spamlab.com", "dnsbl.ahbl.org","ircbl.ahbl.org", "dyna.spamrats.com", "noptr.spamrats.com", "spam.spamrats.com", "cbl.anti-spam.org.cn", "cdl.anti-spam.org.cn", "dnsbl.inps.de","drone.abuse.ch", "httpbl.abuse.ch", "dul.ru", "korea.services.net", "short.rbl.jp", "virus.rbl.jp", "spamrbl.imp.ch", "wormrbl.imp.ch", "virbl.bit.nl", "rbl.suresupport.com", "dsn.rfc-ignorant.org", "ips.backscatterer.org", "spamguard.leadmon.net", "opm.tornevall.org", "netblock.pedantic.org", "multi.surbl.org", "ix.dnsbl.manitu.net", "tor.dan.me.uk", "rbl.efnetrbl.org", "relays.mail-abuse.org", "blackholes.mail-abuse.org", "rbl-plus.mail-abuse.org", "dnsbl.dronebl.org", "access.redhawk.org", "db.wpbl.info", "rbl.interserver.net", "query.senderbase.org", "bogons.cymru.com", "csi.cloudmark.com")

def check_rbl(ip, dnsbl):
        if ip == '127.0.0.1':
                return
        revip = ".".join(reversed(ip.split('.')))

        # print dnsbl, revip

        data = False

        try:
                data = dns.resolver.query(revip + '.' + dnsbl + '.')
                # print data
        except dns.exception.DNSException:
                pass

        if data:
                print ip, dnsbl, "found"
        else:
                print ip, dnsbl, "notfound"



for interface in netifaces.interfaces():
        if netifaces.AF_INET in netifaces.ifaddresses(interface):
                for ip in map(lambda x: x['addr'], netifaces.ifaddresses(interface)[netifaces.AF_INET]):
                        for name in dnbl:
                                check_rbl(ip, name)

for name in dnbl:
        check_rbl("127.0.0.2", name)
