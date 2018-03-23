@echo off
IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----Closed website menu. >> %file%\Users\%user%\logs\%now%.log
	echo.exit> cmd /C %file%\Users\%user%\programs\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:----Added a website. >> %file%\Users\%user%\logs\%now%.log
	echo.%op%> cmd /C %file%\Users\%user%\programs\success.temp
)
set /a op=%op%+1
