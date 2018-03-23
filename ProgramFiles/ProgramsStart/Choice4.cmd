@echo off
IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----++++Closed Other Programs menu. >> %file%\Users\%user%\logs\%now%.log
	echo.exit> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
