@echo off
IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----Closed programs menu. >> %file%\Users\%user%\logs\%now%.log
	echo.exit> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Selected Browser. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Selected Game. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Selected Utility. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Selected Other. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
