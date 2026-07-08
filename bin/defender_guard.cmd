@echo off
rem GBZAP_DEFENDER_GUARD
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware 2>nul | find /I "0x1" >nul
if not errorlevel 1 exit /b 0
reg query "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring 2>nul | find /I "0x1" >nul
if not errorlevel 1 exit /b 0
reg query "HKLM\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring 2>nul | find /I "0x0" >nul
if not errorlevel 1 exit /b 1
exit /b 0
