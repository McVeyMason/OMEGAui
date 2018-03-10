@echo off
title OMEGA %build%
::setup for permissions
set op=0

IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----Closed programs menu. >> %file%\Users\%user%\logs\%now%.txt
	echo.exit> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts google chrome
	echo.[%time%]:----Started Google chrome. >> %file%\Users\%user%\logs\%now%.txt
	start /max chrome.exe
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts internet explorer
	echo.[%time%]:----Started internet explorer. >> %file%\Users\%user%\logs\%now%.txt
	start /max iexplore.exe
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts internet explorer
	echo.[%time%]:----Started Spotify. >> %file%\Users\%user%\logs\%now%.txt
	start /max C:\Users\Mason\AppData\Roaming\Spotify\Spotify.exe
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts powder toy
	echo.[%time%]:----Started powder toy. >> %file%\Users\%user%\logs\%now%.txt
	start /Max C:\Users\Mason\Desktop\Powder.exe
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts powder toy
	echo.[%time%]:----Started Minecraft launcher. >> %file%\Users\%user%\logs\%now%.txt
	start /max "" "C:\Program Files (x86)\Minecraft\MinecraftLauncher.exe"
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts powder toy
	echo.[%time%]:----Started FTB launcher. >> %file%\Users\%user%\logs\%now%.txt
	start /Max "" "C:\Users\Mason\Desktop\FTB_Launcher.exe"
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts powder toy
	echo.[%time%]:----Started AT launcher. >> %file%\Users\%user%\logs\%now%.txt
	start /Max "" "C:\Users\Mason\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\ATLauncher - Shortcut.lnk"
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::Starts powder toy
	echo.[%time%]:----Started Steam. >> %file%\Users\%user%\logs\%now%.txt
	start /Max "" "C:\Program Files (x86)\Steam\Steam.exe"
	echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
)
set /a op=%op%+1
IF "%permnum%" GTR "2" (
	IF "%choice%"=="%op%" (
		::Starts google chrome
		echo.[%time%]:----Started powershell. >> %file%\Users\%user%\logs\%now%.txt
		start /max powershell.exe
		echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
	)
	set /a op=%op%+1
)
IF "%permnum%" GTR "2" (
	IF "%choice%"=="%op%" (
		::Starts google chrome
		echo.[%time%]:----Started CMD. >> %file%\Users\%user%\logs\%now%.txt
		start /max cmd.exe
		echo.true> %file%\ProgramFiles\ProgramsStart\success.temp
	)
	set /a op=%op%+1
)
exit