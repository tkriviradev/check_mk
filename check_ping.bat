set "host=8"
ping -n 1 "%host%" | findstr /r /c:"[0-9] *ms"
if %errorlevel% == 0 (
    cls
    echo 0 ping_host varname=2;crit host.
) else (
	cls
    echo 2 ping_host varname=2;crit host.
)