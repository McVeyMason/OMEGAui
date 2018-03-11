:startup
::hope your using notepad++
::life tips:
::put quotes around all variables to prevent crashing
::Thanks to all you on stack overflow
@echo off
set "build=0.9.0"
set "title=OMEGA %build%"
::sets file director to current directory
set "file=%~dp0"
::sets real username to %username%
set "ruser=%username%"
title %title%
color 03
::sets color constants
set "textf=36"
set "textb=0"
::adds backlist file
IF NOT EXIST %file%\Users\BLACKLIST\ md %file%\Users\BLACKLIST\
::exits for a blacklisted computer username 
IF EXIST %file%\Users\BLACKLIST\%ruser%.txt exit
goto :start
--------------------------------------------------------------------------------------------------
:start

cls
echo OMEGAui build version %build%
echo:
cmd /C %file%\ProgramFiles\Symbol.cmd
echo [32mAre you sure you want to run OMEGA? [%textb%;%textf%m
echo This program can be dangerous to your computer.

::using simple boolean system
set "boolean="
set /p boolean=
IF "%boolean%"=="yes" (
	cmd /C %file%\ProgramFiles\Login.cmd
	set "miss=0"
	IF NOT EXIST %file%\ProgramFiles\perm.temp set "miss=1"
	IF NOT EXIST %file%\ProgramFiles\permnum.temp set "miss=1"
	IF NOT EXIST %file%\ProgramFiles\user.temp set "miss=1"
	IF NOT EXIST %file%\ProgramFiles\now.temp set "miss=1"
	IF NOT EXIST %file%\ProgramFiles\creator.temp set "miss=1"
	IF "miss"=="1" exit
	IF EXIST %file%\Users\BLACKLIST\%ruser%.txt exit
	
	set /p perm=<%file%\ProgramFiles\perm.temp
	set /p permnum=<%file%\ProgramFiles\permnum.temp
	set /p user=<%file%\ProgramFiles\user.temp
	set /p now=<%file%\ProgramFiles\now.temp
	set /p creator=<%file%\ProgramFiles\creator.temp
	
	del %file%\ProgramFiles\perm.temp
	del %file%\ProgramFiles\permnum.temp
	del %file%\ProgramFiles\user.temp
	del %file%\ProgramFiles\now.temp
	del %file%\ProgramFiles\creator.temp
	goto :menu
	title %title%
)
IF "%boolean%"=="no" exit

::error script
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :start
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:menu

::setup for restrictions
::op=option
set "op=0"

::Main selector
cls
echo OMEGAui build version %build%
echo:
echo OMEGAui Main Menu
echo Options:
::adds one if user has the required permission level
::all numbers are fluid no matter the permission level
::all permissions
echo %op%.  Exit OMEGAui.
set /a op=%op%+1
::all permissions
echo %op%.  Logout.
set /a op=%op%+1
::all permissions
echo %op%.  Refresh OMEGAui build version %build%.
set /a op=%op%+2
::all permissions
echo %op%.  Open program selector.
set /a op=%op%+1
::only shows fork bomb menu to users with permissions above 2
IF "%permnum%" GTR "2" (
	echo %op%.  Open the fork bomb menu.
	set /a op=%op%+2
) 
::only shows the sever menu to users with permissions above 3
IF "%permnum%" GTR "3" (
	echo %op%.  Open the servers menu.
	set /a op=%op%+1
)
::only shows the site servers menu to users with permissions above 1
IF "%permnum%" GTR "1" (
	echo %op%.  Open the web servers menu.
	set /a op=%op%+1
)
::all permissions
echo %op%.  Open the [31mc[32mo[33ml[34mo[35mr[36m s[37me[91ml[92me[93mc[94mt[95mo[96mr[97m.[%textb%;%textf%m
set /a op=%op%+1
::all permission
echo %op%. Change my password.

echo:
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set "op=0"

IF "%choice%"=="%op%" (
	:logout
	::saves log
	echo.[%time%]:Logged out >> %file%\Users\%user%\logs\%now%.txt  
	::deletes the live log
	Exit
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logout of computer and omega
	shutdown -l
	goto :logout
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::starts new session and creates a log
	start OMEGAui.bat
	goto :logout
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:Found option 3, user is Observant. >> %file%\Users\%user%\logs\%now%.txt  
	::Rick roll
	cmd /C %file%\ProgramFiles\TOP_SECRET.cmd
	goto :menu
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	echo.[%time%]:Opened program menu. >> %file%\Users\%user%\logs\%now%.txt 
	set menu=0
	goto :programs
)

::permission level 3+ only
IF "%permnum%" GTR "2" (
	IF "%choice%"=="%op%" (
		::goes to fork selector
		echo.[%time%]:Opened fork bomb menu. >> %file%\Users\%user%\logs\%now%.txt
		goto :fork
	)
)

set /a op=%op%+1
::permission level 4+ only
IF "%permnum%" GTR "3" (
	IF "%choice%"=="%op%" (
		::Logging servers
		echo.[%time%]:Opened server menu. >> %file%\Users\%user%\logs\%now%.txt  
		goto :servers
	)
	set /a op=%op%+1
)
::permission level 2+ only
IF "%permnum%" GTR "1" (
	IF NOT "%permnum%"=="2" (
		IF "%choice%"=="%op%" (
			::starts powershell, a better cmd
			echo.[%time%]:Started powershell. >> %file%\Users\%user%\logs\%now%.txt  
			start PowerShell.exe
			goto :menu
		)
		set /a op=%op%+1
	)
)
::permission level 2+ only
IF "%permnum%" GTR "1" (
	IF "%choice%"=="%op%" (
		::goes to the web server selector
		echo.[%time%]:Opened web server menu. >> %file%\Users\%user%\logs\%now%.txt  
		goto :webserver
	)
	set /a op=%op%+1
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::goes to the colour  selector
	echo.[%time%]:Changed the color. >> %file%\Users\%user%\logs\%now%.txt  
	goto :color
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::goes to the password changer.
	echo.[%time%]:Changing their password. >> %file%\Users\%user%\logs\%now%.txt  
	goto :password
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::do anything
)
::error script
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:programs
::Opens the selected options menu
cmd /C %file%\ProgramFiles\ProgramsStart\Option%menu%.cmd

echo:
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

echo.false> %file%\ProgramFiles\ProgramsStart\success.temp
::interprets the entered choice 
cmd /C %file%\ProgramFiles\ProgramsStart\Choice%menu%.cmd
set /p success=<%file%\ProgramFiles\ProgramsStart\success.temp
del %file%\ProgramFiles\ProgramsStart\success.temp >nul
IF "%success%"=="true" goto :programs
IF "%success%"=="1" (
	set "menu=1"
	goto :programs
)
IF "%success%"=="2" (
	set "menu=2"
	goto :programs
)
IF "%success%"=="3" (
	set "menu=3"
	goto :programs
)
IF "%success%"=="4" (
	set "menu=4"
	goto :programs
)
IF "%menu%" GTR "0" (
	IF "%success%"=="exit" (
		set "menu=0"
		goto :programs
	)
)
IF "%success%"=="exit" goto :menu
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :programs
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:fork
::setup for permissions
set "op=0"

cls
echo OMEGAui build version %build%
echo:
echo Welcome to the fork bomb selector.
echo Options:
echo %op%. Back.
set /a op=%op%+1
::copier only for permissions of 4+
IF "%permnum%" GTR "3" (
	echo %op%. Fork bomb copier menu.
	set /a op=%op%+1
)
echo %op%. Run standard fork bomb.
set /a op=%op%+1
echo %op%. Run rick bomb fork bomb.
set /a op=%op%+1
echo %op%. Run internet explorer fork bomb.
set /a op=%op%+1
echo %op%. Run file explorer fork bomb.
echo:
echo|set /p="[32mPlease enter your choice: [%textb%;%textf%m"
set "choice="
set /p choice=

::setup for permissions
set "op=0"

IF "%choice%"=="%op%" (
	::goes to main menu
	echo.[%time%]:----Closed fork menu. >> %file%\Users\%user%\logs\%now%.txt
	goto :menu
)
set /a op=%op%+1
IF "%permnum%" GTR "3" (
	IF "%choice%"=="%op%" (
		::goes to fork copier menu
		echo.[%time%]:----Opened copy menu. >> %file%\Users\%user%\logs\%now%.txt
		goto :forkcopy
	)
	set /a op=%op%+1
)
IF "%choice%"=="%op%" (
	::runs a standard fork bomb
	echo.[%time%]:----Started Regular fork bomb. >> %file%\Users\%user%\logs\%now%.txt
	start %file%\ProgramFiles\Fork.bat
	goto :fork
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::runs a rickrolling fork bomb
	echo.[%time%]:----Started rick fork bomb. >> %file%\Users\%user%\logs\%now%.txt
	start %file%\ProgramFiles\RickFork.bat
	goto :fork
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::runs a Internet explorer fork bomb
	echo.[%time%]:----Started Internet explorer fork bomb. >> %file%\Users\%user%\logs\%now%.txt
	start %file%\ProgramFiles\IEXFork.bat
	goto :fork
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::runs a File explorer fork bomb
	echo.[%time%]:Started file explorer fork bomb. >> %file%\Users\%user%\logs\%now%.txt
	start %file%\ProgramFiles\EXFork.bat
	goto :fork
)

cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :fork
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:forkcopy
::setup for permissions
set "op=0"

cls
echo OMEGAui build version %build%
echo:
echo Welcome to the fork bomb copier.
echo All files will be copied to H:/Fork
echo Options:
echo 0. Back
echo 1. Copy all.
echo 2. Copy standar fork bomb.
echo 3. Copy rick fork bomb.
echo 4. Copy internet explorer fork bomb.
echo 5. Copy file explorer fork bomb.
IF "%permnum%" GTR "4" (
	echo 6. Open fork bomb folder.
)
echo:
echo|set /p="[32mPlease enter your choice: [%textb%;%textf%m"
set "choice="
set /p choice=
IF "%choice%"=="0" (
	::goes to main fork selector
	echo.[%time%]:----++++Exited fork copy menu. >> %file%\Users\%user%\logs\%now%.txt
	goto :fork
)
IF "%choice%"=="1" (
	IF NOT EXIST H:/Fork (
		::creates dir if it doesn't exist
		md H:/Fork
	)
	::downloads all fork bombs
	echo.[%time%]:----++++Copied all. >> %file%\Users\%user%\logs\%now%.txt 
	ROBOCOPY %file%\ProgramFiles\Fork\Fork.bat H:/Fork /s >nul
	ROBOCOPY %file%\ProgramFiles\Fork\RickFork.bat H:/Fork /s >nul
	ROBOCOPY %file%\ProgramFiles\Fork\IEXFork.bat H:/Fork /s >nul
	ROBOCOPY %file%\ProgramFiles\Fork\EXFork.bat H:/Fork /s >nul
	goto :forkcopy
)
IF "%choice%"=="2" (
	IF NOT EXIST H:/Fork (
		::creates dir if it doesn't exist
		md H:/Fork
	)
	::downloads a standard fork bomb
	echo.[%time%]:----++++Copied regular. >> %file%\Users\%user%\logs\%now%.txt 
	ROBOCOPY %file%\ProgramFiles\Fork\Fork.bat H:/Fork /s >nul
	goto :forkcopy
)
IF "%choice%"=="3" (
	IF NOT EXIST H:/Fork (
		::creates dir if it doesn't exist
		md H:/Fork
	)
	::downloads a rickrolling fork bomb
	echo.[%time%]:----++++Copied rick. >> %file%\Users\%user%\logs\%now%.txt 
	ROBOCOPY %file%\ProgramFiles\Fork\RickFork.bat H:/Fork /s >nul
	goto :forkcopy
)
IF "%choice%"=="4" (
	IF NOT EXIST H:/Fork (
		::creates dir if it doesn't exist
		md H:/Fork
	)
	::downloads a internet explorer fork bomb
	echo.[%time%]:----++++Copied internet explorer. >> %file%\Users\%user%\logs\%now%.txt 
	ROBOCOPY %file%ProgramFiles\Fork\IEXFork.bat H:/Fork /s >nul
	goto :forkcopy
)
IF "%choice%"=="5" (
	IF NOT EXIST H:/Fork (
		::creates dir if it doesn't exist
		md H:/Fork
	)
	::downloads a file explorer fork bomb
	echo.[%time%]:Copied file explorer. >> %file%\Users\%user%\logs\%now%.txt 
	ROBOCOPY %file%ProgramFiles\Fork\EXFork.bat H:/Fork /s >nul
	goto :forkcopy
)
IF "%permnum%" GTR "4" (
	IF "%choice%"=="6" (
		echo.[%time%]:----++++Opened file. >> %file%\Users\%user%\logs\%now%.txt
		start %file%ProgramFiles\Fork
		goto :forkcopy
	)
)
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :forkcopy
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:servers
::setup for permissions
set "op=0"

cls
echo OMEGAui build version %build%
echo:
echo What server do you want to open?
echo Options:
echo %op%. Back.
set /a op=%op%+1
echo %op%. \\snocwindcp02 -Domain Controller
set /a op=%op%+1
::only for permissions over 3
IF "%permnum%" GTR "3" (
	echo %op%. \\spnhfp01 -Hazel Wolf Files
	set /a op=%op%+1
)
echo %op%. \\snocdc01 -Domain Controller
set /a op=%op%+1
echo %op%. \\snocdc02 -Domain Controller
set /a op=%op%+1
echo %op%. \\snocdc04 -Domain Controller
set /a op=%op%+1
echo %op%. \\snocdc05 -Domain Controller
set /a op=%op%+1
echo %op%. \\SNOCDCR1 -Domain Controller

echo:
echo|set /p="[32mPlease enter your choice: [%textb%;%textf%m"
set "choice="
set /p choice=
set op=0

IF "%choice%"=="%op%" (
	::goes to main menu
	::ending sever log
	set "log=%log%\"
	echo.[%time%]:----Exited sever menu. >> %file%\Users\%user%\logs\%now%.txt
	goto :menu
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened sever \\snocwindcp02. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\snocwindcp02
	::Domain controller 
	start \\snocwindcp02 >nul
	goto :servers
)
set /a op=%op%+1
IF "%permnum%" GTR "3" (
	IF "%choice%"=="%op%" (
		::logging sever
		echo.[%time%]:----Opened sever \\spnhfp01. >> %file%\Users\%user%\logs\%now%.txt
		::opens \\spnhfp01
		::Hazel Wolf Files
		start \\spnhfp01 >nul
		goto :servers
	)
	set /a op=%op%+1
)
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened sever \\snocdc01. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\snocdc01
	::Domain controller
	start \\snocdc01 >nul
	goto :servers
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened server \\snocdc02. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\snocdc02
	::Domain controller
	start \\snocdc02 >nul
	goto :servers
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened server \\snocdc04. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\snocdc04
	::Domain controller
	start \\snocdc04 >nul
	goto :servers
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened server \\snocdc05. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\snocdc05
	::Domain controller
	start \\snocdc05 >nul
	goto :servers
)
set /a op=%op%+1
IF "%choice%"=="%op%" (
	::logging sever
	echo.[%time%]:----Opened server \\SNOCDCR1. >> %file%\Users\%user%\logs\%now%.txt
	::opens \\SNOCDCR1
	::Domain controller
	start \\SNOCDCR1 >Nul
	goto :servers
)
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :servers
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:webserver
::all seaches uses google search advanced options
cls
echo OMEGAui build version %build%
echo:
echo What server do you want to open?
echo Options:
echo 0. Back
echo 1. #6-facilities?
echo 2. #9730-hazel wolf
echo 3. #543-forms?
echo 4. #10683-ingrahm
echo 5. #11227-JAMS
echo 6. #741-Rhs

echo:
echo|set /p="[32mPlease enter your choice: [%textb%;%textf%m"
set "choice="
set /p choice=

IF "%choice%"=="0" (
	::goes to main menu
	::ending web sever log
	echo.[%time%]:----Closed web sever menu. >> %file%\Users\%user%\logs\%now%.txt
	goto :menu
)
IF "%choice%"=="1" (
	::logging sever number
	echo.[%time%]:----Opened web sever #6. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?q=site:%3A%22seattleschools.org%22+inurl:%3A%2FUserFiles%2FServers%2FServer_37&ie=utf-8&oe=utf-8#safe=strict&q=site:%22seattleschools.org%22+inurl:%2FUserFiles%2FServers%2FServer_6
	start chrome.exe "https://goo.gl/ELzdiz"
	goto :webserver
)
IF "%choice%"=="2" (
	::logging sever number
	echo.[%time%]:----Opened web sever #9730. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?q=site:%3A%22seattleschools.org%22+inurl:%3A%2FUserFiles%2FServers%2FServer_37&ie=utf-8&oe=utf-8#q=site:%22seattleschools.org%22+inurl:/UserFiles/Servers/Server_9730&safe=strict&filter=0
	start chrome.exe "https://goo.gl/tj1SFh"
	goto :webserver
)
IF "%choice%"=="3" (
	::logging sever number
	echo.[%time%]:----Opened web server #543. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?safe=strict&biw=845&bih=544&noj=1&q=site%3A%22seattleschools.org%22+inurl%3A%2FUserFiles%2FServers%2FServer_543&oq=site%3A%22seattleschools.org%22+inurl%3A%2FUserFiles%2FServers%2FServer_543&gs_l=serp.3...139232.140142.0.140580.3.3.0.0.0.0.85.207.3.3.0....0...1c.1.64.serp..0.0.0.W1TNaRcapbA
	start chrome.exe "https://goo.gl/RKiU5D"
	goto :webserver
)
IF "%choice%"=="4" (
	::logging sever number
	echo.[%time%]:----Opened web server #10683. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?sclient=psy-ab&safe=strict&biw=845&bih=544&q=site:%22seattleschools.org%22+inurl:%2FUserFiles%2FServers%2FServer_10683&oq=site:%22seattleschools.org%22+inurl:%2FUserFiles%2FServers%2FServer_10683&gs_l=serp.3...3482.22789.1.24148.8.8.0.0.0.0.261.737.6j1j1.8.0....0...1c.1.64.psy-ab..0.0.0.yE7EEs6ULYI&pbx=1&bav=on.2,or.&bvm=bv.139782543,d.cGc&ech=1&psi=T9FBWKDBG4jOjwPjjobYBQ.1480708432565.5&ei=W9FBWOWhHsSJ0wLArpjoBA&emsg=NCSR&noj=1
	start chrome.exe "https://goo.gl/t8Vrfj"
	goto :webserver
)
IF "%choice%"=="5" (
	::logging sever number
	echo.[%time%]:----Opened web server #11227. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?sclient=psy-ab&safe=strict&biw=845&bih=544&noj=1&q=site%3A%22seattleschools.org%22+inurl%3A%2FUserFiles%2FServers%2FServer_11227&oq=site%3A%22seattleschools.org%22+inurl%3A%2FUserFiles%2FServers%2FServer_11227&gs_l=serp.3...22426.24308.1.24797.5.5.0.0.0.0.306.585.4j3-1.5.0....0...1c.1.64.serp..0.0.0.WZP8tfEI2MI
	start chrome.exe "https://goo.gl/EwFKgl"
	goto :webserver
)
IF "%choice%"=="6" (
	::logging sever number
	echo.[%time%]:----Opened web server #741. >> %file%\Users\%user%\logs\%now%.txt
	::opens website https://www.google.com/search?q=site:%5E22seattleschools.org%5E22+inurl:/UserFiles/Servers/Server_7419%5Esafe=strict%5Ebiw=845%5Ebih=544%5Enoj=1%5Efilter=0&safe=active&ssui=on#safe=strict&q=site:seattleschools.org+inurl:%2FUserFiles%2FServers%2FServer_7419
	start chrome.exe "https://goo.gl/OcqA5C"
	goto :webserver
)

cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :webserver
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:color
::pretty self explanatory
cls
echo OMEGAui build version %build%
echo:
echo ERROR: Please pay $0.99 to unlock this feature.
timeout 3 >nul 
echo JK, press any key to continue to the [31mc[32mo[33ml[34mo[35mr[36m s[37me[91ml[92me[93mc[94mt[95mo[96mr[97m.[%textb%;%textf%m
pause >nul
goto :bc
--------------------------------------------------------------------------------------------------
:bc
cls
echo OMEGAui build version %build%
echo:
echo Welcome to the [31mc[32mo[33ml[34mo[35mr[36m s[37me[91ml[92me[93mc[94mt[95mo[96mr[97m.[%textb%;%textf%m
echo To begin select a background color.
echo:
echo Background colors:
echo 0 = Black (default)
echo 1 = Blue
echo 2 = Green	 
echo 3 = Aqua
echo 4 = Red
echo 5 = Purple
echo 6 = Yellow
echo 7 = White
echo 8 = Gray
echo 9 = Light Blue
echo A = Light Green
echo B = Light Aqua
echo C = Light Red
echo D = Light Purple
echo E = Light Yellow
echo F = Bright White
echo:
echo|set /p="Please select a background color:"
::sets background color
set "bc="
set /p bc=
IF "%bc%"=="0" (
	set "textb=40"
	goto :fc
)
IF "%bc%"=="1" (
	set "textb=44"
	goto :fc
)
IF "%bc%"=="2" (
	set "textb=42"
	goto :fc
)
IF "%bc%"=="3" (
	set "textb=46"
	goto :fc
)
IF "%bc%"=="4" (
	set "textb=41"
	goto :fc
)
IF "%bc%"=="5" (
	set "textb=45"
	goto :fc
)
IF "%bc%"=="6" (
	set "textb=43"
	goto :fc
)
IF "%bc%"=="7" (
	set "textb=37"
	goto :fc
)
IF "%bc%"=="8" (
	set "textb=100"
	goto :fc
)
IF "%bc%"=="9" (
	set "textb=104"
	goto :fc
)
IF "%bc%"=="A" (
	set "textb=102"
	goto :fc
)
IF "%bc%"=="B" (
	set "textb=106"
	goto :fc
)
IF "%bc%"=="C" (
	set "textb=101"
	goto :fc
)
IF "%bc%"=="D" (
	set "textb=105"
	goto :fc
)
IF "%bc%"=="E" (
	set "textb=103"
	goto :fc
)
IF "%bc%"=="F" (
	set "textb=107"
	goto :fc
)
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid Color. Please use capitals. [%textb%;%textf%m
goto :bc
--------------------------------------------------------------------------------------------------
:fc
cls
echo OMEGAui build version %build%
echo:
echo Now select a foreground color.
echo:
echo Foreground colors:
echo 0 = Black	
echo 1 = Blue
echo 2 = Green	 
echo 3 = Aqua (default)
echo 4 = Red
echo 5 = Purple
echo 6 = Yellow
echo 7 = White
echo 8 = Gray
echo 9 = Light Blue
echo A = Light Green
echo B = Light Aqua
echo C = Light Red
echo D = Light Purple
echo E = Light Yellow
echo F = Bright White
echo:
echo|set /p="Please enter a Foreground color:"
::sets foreground color
set "fc="
set /p fc=
IF "%fc%"=="0" (
	set "textf=30"
	goto :setc
)
IF "%fc%"=="1" (
	set "textf=34"
	goto :setc
)
IF "%fc%"=="2" (
	set "textf=32"
	goto :setc
)
IF "%fc%"=="3" (
	set "textf=36"
	goto :setc
)
IF "%fc%"=="4" (
	set "textf=31"
	goto :setc
)
IF "%fc%"=="5" (
	set "textf=35"
	goto :setc
)
IF "%fc%"=="6" (
	set "textf=33"
	goto :setc
)
IF "%fc%"=="7" (
	set "textf=37"
	goto :setc
)
IF "%fc%"=="8" (
	set "textf=90"
	goto :setc
)
IF "%fc%"=="9" (
	set "textf=94"
	goto :setc
)
IF "%fc%"=="A" (
	set "textf=92"
	goto :setc
)
IF "%fc%"=="B" (
	set "textf=96"
	goto :setc
)
IF "%fc%"=="C" (
	set "textf=91"
	goto :setc
)
IF "%fc%"=="D" (
	set "textf=95"
	goto :setc
)
IF "%fc%"=="E" (
	set "textf=93"
	goto :setc
)
IF "%fc%"=="F" (
	set "textf=97"
	goto :setc
)
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid Color. Please use capitals. [%textb%;%textf%m
goto :fc
--------------------------------------------------------------------------------------------------
::sets color to background color, foreground color
:setc
color %bc%%fc%
cls
echo OMEGAui build version %build%
echo:
echo Color changed!
timeout 2 >nul
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:password
cls
echo OMEGAui build version %build%
echo:
echo [32mAre you sure you want to change your password?[%textb%;%textf%m

::using simple boolean system
set "boolean="
set /p boolean=
IF "%boolean%"=="yes" (
	goto :auth
)
IF "%boolean%"=="no" (
	goto :menu
)
cls
echo OMEGAui build version %build%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :password
--------------------------------------------------------------------------------------------------
:auth
cls
echo OMEGAui build version %build%
echo:
echo Type exit to exit.
set "psCommand=powershell -Command "$pword = read-host '[32mPlease enter your password[%textb%;%textf%m' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
		[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set "password=%%p" 
set /p RP=<%file%\Users\%user%\pass.txt
for /f "usebackq delims=" %%I in (`powershell "\"%password%\".toUpper()"`) do set "password=%%~I"
set "pass=password=%password%"
set pass=%pass: =%
set RP=%RP: =%
IF "%RP%"=="%pass%" (
	goto :change
)
IF "exit"=="%password%" (
	goto :menu
)
cls
echo OMEGAui build version %build%
echo:
echo [91mWrong password. [%textb%;%textf%m
timeout 2 >nul
goto :auth
--------------------------------------------------------------------------------------------------
:change
cls
echo OMEGAui build version %build%
echo:
echo Please enter new password:
set "npass0="
set /p npass0=
for /f "usebackq delims=" %%I in (`powershell "\"%npass0%\".toUpper()"`) do set "npass0=%%~I"
cls
echo OMEGAui build version %build%
echo:
echo Please reenter new password:
set "npass1="
set /p npass1=
for /f "usebackq delims=" %%I in (`powershell "\"%npass1%\".toUpper()"`) do set "npass1=%%~I"
IF "%npass0%"=="%npass1%" (
	goto :editfiles
)
cls
echo OMEGAui build version %build%
echo:
echo [91mPasswords do not match. Please try again. [%textb%;%textf%m
timeout 2 >nul
goto :change
--------------------------------------------------------------------------------------------------
:editfiles
::fetching raw permnum
set /P permraw=<%file%\Users\%user%\permnum.txt
set permraw=%permraw: =%
del %file%\Users\%user%\pass.txt
echo.password=%npass0% > %file%\Users\%user%\pass.txt
cd %file%\Users\ALL\
findstr /v "%user%:" "Userdat.txt" > UserdatGood.txt
del Userdat.txt
ren UserdatGood.txt Userdat.txt
cd %file%
echo.%user%:%perm%,permnum=%permraw%,password=%npass0%,%creator% >> %file%\Users\ALL\Userdat.txt
cls
echo OMEGAui build version %build%
echo:
echo [92mPassword changed. [%textb%;%textf%m
echo.[%time%]:----Password changed. >> %file%\Users\%user%\logs\%now%.txt
timeout 2 >nul
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
pause