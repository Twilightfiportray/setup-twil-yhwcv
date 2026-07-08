@echo off
call "%~dp0..\service.bat" load_game_filter
call "%~dp0..\service.bat" load_user_lists
exit /b 0
