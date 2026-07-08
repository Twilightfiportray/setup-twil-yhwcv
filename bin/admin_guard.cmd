@echo off
setlocal DisableDelayedExpansion
net session >nul 2>&1
if %errorlevel%==0 exit /b 0
set "BAT_PATH=%~f1"
set "BAT_DIR=%~dp1"
powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "Start-Process -FilePath $env:BAT_PATH -Verb RunAs -WorkingDirectory $env:BAT_DIR"
exit /b 1
