@echo off
title OMEGA %build%
::setup for permissions
set op=0

IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----++++Closed Browser menu. >> %file%\Users\%user%\logs\%now%.log
	echo.exit> %file%\ProgramFiles\Temp\success.temp
)
set /a op=%op%+1
