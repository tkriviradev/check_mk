@echo off
set "host=yahoo.com" >nul
ping -n 1 "%host%" | findstr /r /c:"[0-9] *ms" >nul
if %errorlevel% == 0 (
    echo 0 ping_host varname=2;crit host
) else (
    echo 2 ping_host varname=2;crit host
)

pause>nul
exit