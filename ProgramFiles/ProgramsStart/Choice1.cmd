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
::Chrome
IF "%permnum%" GTR "0" (
	IF "%choice%"=="%op%" (
		::Starts Chrome
		echo.[%time%]:----++++Started Chrome.>>%file%\Users\%user%\logs\%now%.txt
		start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
		echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
	)
	set /a op=%op%+1
)
::other 