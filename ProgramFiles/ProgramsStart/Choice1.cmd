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
::CHROME
IF "%permnum%" GTR "0" (
	IF "%choice%"=="%op%" (
		::Starts CHROME
		echo.[%time%]:----++++Started CHROME.>>%file%\Users\%user%\logs\%now%.log
		start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk"
		echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
	)
	set /a op=%op%+1
)
::FIREFOX
IF "%permnum%" GTR "1" (
	IF "%choice%"=="%op%" (
		::Starts FIREFOX
		echo.[%time%]:----++++Started FIREFOX.>>%file%\Users\%user%\logs\%now%.log
		start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Mozilla Firefox.lnk"
		echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
	)
	set /a op=%op%+1
)
