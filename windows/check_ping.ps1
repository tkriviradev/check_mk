$servers = "dc1"

Foreach($s in $servers)

{
  if(!(Test-Connection -Cn $s -BufferSize 16 -Count 1 -ea 0 -quiet))
  { 
  $status = $Crit
  $statustxt = "CRITICAL"
  $currentstatus = "Host is down"
  echo "$status ping_host - $statustxt - $currentstatus" 
   } # end if

  else {
  $status = $OK
  $statustxt = "OK"
  $currentstatus = "Host is alive"
  echo "$status ping_host - $statustxt - $currentstatus"
  exit
  } #end if
} # end foreach