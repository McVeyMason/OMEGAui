@echo off
title OMEGA %build%
::setup for permissions
set op=0

IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----++++Closed Browser menu. >> %file%\Users\%user%\logs\%now%.txt
	echo.exit> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1