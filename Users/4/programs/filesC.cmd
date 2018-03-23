@echo off
IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----Closed file menu. >> %file%\Users\%user%\logs\%now%.log
	echo.exit> cmd /C %file%\Users\%user%\programs\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Added file to menu. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> cmd /C %file%\Users\%user%\programs\success.temp
)
set /a op=%op%+1
