:startup
::setup
@echo off 
cls
set "build=0.5"
set "title=OMEGA USER MANAGER %build%"
set "header=User Manager v%build%"
set "file=%~dp0"
cd %file%
cd..
set "file=%cd%"
set "ruser=%username%"
title %title%
::tests if color is already set
IF "%textf%"=="" (
	IF "%textb%"=="" (
		::sets initial color
		color 03
		::sets color constants
		::textf is foreground color
		set "textf=36"
		::textb is background color
		set "textb=0"
		::textq is the question color
		set "textq=32"
		::texte is the error color
		set "texte=91"
	)
)
::exits for a blacklisted computer username 
IF EXIST %file%\Users\BLACKLIST\%username%.dat exit
::sets the current variable
set /p current=<%file%\current.temp
set current=%current: =%
del %file%\current.temp
::Check if the user is logged in
IF "%loggedin%" == "y" (
	IF "%current%"=="EXIT" exit
	set "miss=0"
	IF "%perm%"=="" set "miss=1"
	IF "%permnum%"=="" set "miss=1"
	IF "%user%"=="" set "miss=1"
	IF "%now%"=="" set "miss=1"
	IF "%creator%"=="" set "miss=1"
	IF "%miss%"=="1" goto :start
	
	REM cls
	REM echo %header%
	REM echo:
	REM echo Current session is %current%
	REM echo Host is %host%
	REM pause
	
	IF NOT EXIST %file%\Users\%user% (
		goto :start
	)

	::checking if this is the correct program to be in
	IF NOT "%current%"=="USER" (
		::if its another go to that program
		IF "%current%"=="OMEGA" (
			cmd /C %file%\OMEGAui.bat
			goto :startup
		)
		IF "%current%"=="PROGRAM" (
			cmd /C %file%\ProgramFiles\ProgramAdd.bat
			goto :startup
		)
		IF "%current%"=="EXIT" (
			exit
		)
		cls
		echo %header%
		echo:
		echo [%texte%mError in current program.[%textb%;%textf%m
		echo Current program is set to %current%
		timeout 2 >nul
		goto :start
	)
	goto :menu
)
goto :start
--------------------------------------------------------------------------------------
:start
cls
echo %header%
echo:
cmd /C %file%\ProgramFiles\Symbol.cmd
echo:
echo Welcome to the OMEGAui user cration system.
pause >nul
goto :logon
--------------------------------------------------------------------------------------
:logon
cmd /K %file%\ProgramFiles\Login.cmd

del %file%\Users\%user%\logs\%now%.dat

set "miss=0"
	IF NOT EXIST %file%\ProgramFiles\perm.temp set "miss=1"
IF NOT EXIST %file%\ProgramFiles\permnum.temp set "miss=1"
IF NOT EXIST %file%\ProgramFiles\user.temp set "miss=1"
IF NOT EXIST %file%\ProgramFiles\now.temp set "miss=1"
IF NOT EXIST %file%\ProgramFiles\creator.temp set "miss=1"
IF "miss"=="1" exit
IF EXIST %file%\Users\BLACKLIST\%ruser%.dat exit

set /p perm=<%file%\ProgramFiles\perm.temp
set /p permnum=<%file%\ProgramFiles\permnum.temp
set /p user=<%file%\ProgramFiles\user.temp
set /p now=<%file%\ProgramFiles\now.temp
set /p creator=<%file%\ProgramFiles\creator.temp
set "loggedin=y"
set "host=USER"
set "current=USER"

del %file%\ProgramFiles\perm.temp
del %file%\ProgramFiles\permnum.temp
del %file%\ProgramFiles\user.temp
del %file%\ProgramFiles\now.temp
del %file%\ProgramFiles\creator.temp
title %title%
IF "%permnum%" GTR "4" (
		goto :menu
)
exit
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:menu
::main menu for all functionality
cls
echo %header%
echo:
echo Options:
echo 0. Switch programs or exit.
echo 1. Create user.
echo 2. Delete user.
echo 3. View user logs.
echo 4. Change a user.
echo:
echo|set /p="[%textq%mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set choice=%choice:"=%
set choice=%choice:&=%

IF "%choice%"=="0" (
	goto :switch
)
IF "%choice%"=="1" (
	goto :create
)
IF "%choice%"=="2" (
	goto :delete
)
IF "%choice%"=="3" (
	goto :logs
)
IF "%choice%"=="4" (
	goto :changeuser
)

cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :menu
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:switch
::for exiting program or switching to another program
cls
echo %header%
echo:
echo [%textq%mWhat would you like to do?[%textb%;%textf%m
echo 0. Exit.
echo 1. Switch to OMEGAui.
echo 2. Switch to Program Manager.
echo:
echo|set /p="[%textq%mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set choice=%choice:"=%
set choice=%choice:&=%

IF "%choice%"=="0" (
	::set program to exit and exits User Manager
	IF NOT "%host%"=="USER" (
		set "current=EXIT"
		echo.EXIT > %file%\current.temp
	)
	exit
)
IF "%choice%"=="1" (
	::opens OMEGAui 
	IF "%host%"=="PROGRAM" (
		echo.OMEGA > %file%\current.temp
		exit
	)
	IF "%host%"=="USER" (
		set "current=OMEGA"
		echo.OMEGA > %file%\current.temp
		cmd /C %file%\OMEGAui.bat
		goto :startup
	)
	IF "%host%"=="OMEGA" (
		echo.OMEGA > %file%\current.temp
		exit
	)
	cls
	echo %header%
	echo:
	echo [%texte%mError: invalid host. [%textb%;%textf%m
	echo Host=%host%
	timeout 2 >nul
	goto :startup
)
IF "%choice%"=="2" (
	::opens Program manager 
	IF "%host%"=="PROGRAM" (
		echo.PROGRAM > %file%\current.temp
		exit
	)
	IF "%host%"=="USER" (
		set "current=PROGRAM"
		echo.PROGRAM > %file%\current.temp
		cmd /C %file%\ProgramFiles\ProgramAdd.bat
		goto :startup
	)
	IF "%host%"=="OMEGA" (
		echo.PROGRAM > %file%\current.temp
		exit
	)
	cls
	echo %header%
	echo:
	echo [%texte%mError: invalid host.[%textb%;%textf%m
	echo Host=%host%
	timeout 2 >nul
	goto :startup
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :switch
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:create
cls
echo %header%
echo:
echo Type exit to exit.
echo|set /p="[%textq%mPlease enter username of the new user:[%textb%;%textf%m"
set "usern="
set /p usern=

set usern=%usern:"=%
set usern=%usern:&=%

IF %usern%==exit (
	goto :menu
)

IF EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo User %usern% already exists.
	echo [%textq%mAre you sure you want to continue?[%textb%;%textf%m
	set "boolean="
	set /p boolean=
	
	set boolean=%boolean:"=%
	set boolean=%boolean:&=%
	
	IF "%boolean%"=="y" set "boolean=yes"
	IF "%boolean%"=="n" set "boolean=no"
	IF "%boolean%"=="yes" (
		for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
		cd %file%\Users\ALL\
		findstr /v %usern%: Userdat.dat > Userdat.temp
		del Userdat.dat
		ren Userdat.temp Userdat.dat
		findstr /v _%usern%_ Users.dat > Users.temp
		del Users.dat
		ren Users.temp Users.dat
		cd %file%
		goto :createcont
	)
	IF "%boolean%"=="no" (
		cls
		echo %header%
		echo:
		echo Canceled.
		set "usern="
		timeout 2 >nul
		goto :menu
	)
	cls
	echo %header%
	echo:
	echo [%texte%mError: Invalid option. [%textb%;%textf%m
	echo Aborting..
	timeout 2 >nul
	goto :menu
) 
goto :createcont
--------------------------------------------------------------------------------------
:createcont

cls
echo %header%
echo:
echo|set /p="[%textq%mPlease enter the password of user %usern%:[%textb%;%textf%m"
set "pass="
set /p pass=

set pass=%pass:"=%
set pass=%pass:&=%

cls
echo %header%
echo:
echo|set /p="[%textq%mPlease enter the permition level of user %usern%(1-5):[%textb%;%textf%m"
set "perm="
set /p perm=

set perm=%perm:"=%
set perm=%perm:&=%

IF "%perm%" GTR "5" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to high. [%textb%;%textf%m
	timeout 2 >nul
	goto :createcont
)
IF "%perm%" LSS "1" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to low. [%textb%;%textf%m
	timeout 2 >nul
	goto :createcont
)

set perm=%perm: =%
set pass=%pass: =%
for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
for /f "usebackq delims=" %%I in (`powershell "\"%pass%\".toUpper()"`) do set "pass=%%~I"
set "permnum=%perm%"
::anti forge
IF "%permnum%"=="1" (
	set "permnum="
)
IF "%permnum%"=="2" (
	set "permnum="
)
IF "%permnum%"=="3" (
	set "permnum="
)
IF "%permnum%"=="4" (
	set "permnum="
)
IF "%permnum%"=="5" (
	set "permnum="
)
cls
echo %header%
echo:
echo Creating..

md %file%\Users\%usern% >nul
md %file%\Users\%usern%\logs >nul
echo.password=%pass% > %file%\Users\%usern%\pass.dat
echo.perm=%perm% > %file%\Users\%usern%\permfull.dat
echo.%permnum% > %file%\Users\%usern%\permnum.dat
echo.creator=%ruser% > %file%\Users\%usern%\creator.dat
echo.%usern%:perm=%perm%,permnum=%permnum%,password=%pass%,creator=%ruser% >> %file%\Users\ALL\userdat.dat
echo._%usern%_ >> %file%\Users\ALL\users.dat
goto :menu
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:delete
::delete user from the database
cls
echo %header%
echo:
echo Users:
echo The username is between the underscores.
echo:
::prints all users
type %file%\Users\ALL\users.dat
echo:
echo Type exit to exit.
echo|set /p="[%textq%mPlease enter the username of the user that you want to delete:[%textb%;%textf%m"
set "usern="
set /p usern=

set usern=%usern: =%
set usern=%usern:&=%
set usern=%usern:"=%

for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I" 
IF "%usern%"=="EXIT" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :delete
)
IF "%usern%"==" =" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :delete
)
IF "%usern%"=="" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :delete
)
cls
echo %header%
echo:
echo [%textq%mAre you sure that you want to delete %usern% from the database?[%textb%;%textf%m

set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	del /F /Q %file%\Users\%usern%
	rd /s /q %file%\Users\%usern%
	cd %file%\Users\ALL\
	findstr /v %usern%: Userdat.dat > Userdat.temp
	del Userdat.dat
	ren Userdat.temp Userdat.dat
	findstr /v _%usern%_ Users.dat > Users.temp
	del Users.dat
	ren Users.temp Users.dat
	cd %file%
	goto :menu
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	set "usern="
	timeout 2 >nul
	goto :menu
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
echo Aborting...
timeout 2 >nul
goto :delete
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:logs
::log editor, deleter, and viewer
::get user name
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo Users:
echo The username is between the underscores.
echo:
type %file%\Users\ALL\users.dat
echo:
echo|set /p="[%textq%mPlease enter the username of the user that logs you want to view or delete:[%textb%;%textf%m"
set "usern="
set /p usern=

set usern=%usern:"=%
set usern=%usern:&=%

IF "%usern%"=="exit" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :logs
)
goto :logselect
--------------------------------------------------------------------------------------
:logselect
::show logs and ask what to do with them
cls
echo %header%
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.dat
echo:
echo [%textq%mWhat would you like to do with these logs?[%textb%;%textf%m
echo 0. Exit.
echo 1. Change user.
echo 2. View logs.
echo 3. Delete logs.
echo:
echo echo|set /p="[%textq%mPlease enter the your choice:[%textb%;%textf%m"
set "option="
set /p option=

set option=%option:"=%
set option=%option:&=%

IF "%option%"=="0" (
	goto :menu
)
IF "%option%"=="1" (
	goto :logs
)
IF "%option%"=="2" (
	goto :logview
)
IF "%option%"=="3" (
	goto :dellogs
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :logselect
--------------------------------------------------------------------------------------
:logview
::log viewer
cls
echo %header%
echo:
echo User %usern%'s Logs:
echo:
::Prints all of the users logs
type %file%\Users\%usern%\logs\ALL.dat
echo:
echo|set /p="[%textq%mPlease enter the log name of the log that you want to view(ex. 2000-01-01_00-00-00):[%textb%;%textf%m"
set "log="
set /p log=

set log=%log:"=%
set log=%log:&=%

::checks if it exists
IF NOT EXIST %file%\Users\%usern%\logs\%log%.dat (
	cls
	echo %header%
	echo:
	echo The log you entered does not exist.
	timeout 2 >nul
	goto :logselect
)
::displays log and prompts what to do next
cls
echo %header%
echo:
echo Log %log%:
echo:
type %file%\Users\%usern%\logs\%log%.dat
echo:
echo:
echo [%textq%mWhat would you like to do now?[%textb%;%textf%m
echo 0. Back.
echo 1. View another log.
echo 2. View another users logs.
echo|set /p="[%textq%mplease enter you choice:[%textb%;%textf%m"
set "option="
set /p option=

set option=%option:"=%
set option=%option:&=%

IF "%option%"=="0" (
	goto :menu
)
IF "%option%"=="1" (
	goto :logview
)
IF "%option%"=="2" (
	goto :logs
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :logop
--------------------------------------------------------------------------------------
:dellogs
::log deleter
cls
echo %header%
echo:
echo [%textq%mWhat would you like to do with %usern%'s logs?[%textb%;%textf%m
echo 0. Back.
echo 1. Delete all.
echo 2. Delete 1.
echo|set /p="[%textq%mPlease enter you choice:[%textb%;%textf%m"
set "option="
set /p option=

set option=%option:"=%
set option=%option:&=%

IF "%option%"=="0" (
	goto :logs
)
IF "%option%"=="1" (
	goto :delall
)
IF "%option%"=="2" (
	goto :dellog
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
echo Aborting..
timeout 2 >nul
goto :logs
--------------------------------------------------------------------------------------
:delall
::deletes all
cls
echo %header%
echo:
echo [%textq%mAre you sure that you want to delete all of %usern%'s logs from the database?[%textb%;%textf%m

set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
	del /F %file%\Users\%usern%\logs
	echo. > %file%\Users\%usern%\logs\ALL.dat
	cls
	echo %header%
	echo:
	echo Deleted.
	timeout 2 >nul
	goto :logs
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	timeout 2 >nul
	goto :logs
)
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
echo Aborting..
timeout 2 >nul
goto :logs
--------------------------------------------------------------------------------------
:dellog
::deletes one
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.dat
echo:
echo|set /p="[%textq%mPlease enter the log name of the log that you want to delete(ex. 2000-01-01_00-00-00):[%textb%;%textf%m"
set "log="
set /p log=

set log=%log:"=%
set log=%log:&=%

IF "%log%"=="exit" (
	goto :dellogs
)
IF NOT EXIST %file%\Users\%usern%\logs\%log%.dat (
	cls
	echo %header%
	echo:
	echo The log you entered does not exist.
	timeout 2 >nul
	goto :dellog
)

cls
echo %header%
echo:
echo [%textq%mAre you sure that you want to delete log %log%?[%textb%;%textf%m

set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	for /f "usebackq delims=" %%I in (`powershell "\"%log%\".toUpper()"`) do set "log=%%~I"
	del /F %file%\Users\%usern%\logs\%log%.dat
	cd %file%\Users\%usern%\logs
	findstr /v %log%.dat ALL.dat > ALL.temp
	del ALL.dat
	ren ALL.temp ALL.dat
	cd %file%
	cls
	echo %header%
	echo:
	echo Log deleted.
	timeout 2 >nul
	goto :dellogs
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	timeout 2 >nul
	goto :dellogs
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
echo Aborting..
timeout 2 >nul
goto :dellogs
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:changeuser
cls
echo %header%
echo:
echo Users:
echo The username is between the underscores.
echo:
::prints all users
type %file%\Users\ALL\users.dat
echo:
echo Type exit to exit.
echo|set /p="[%textq%mPlease enter the username of the user that you want to edit:[%textb%;%textf%m"
set "usern="
set /p usern=

set usern=%usern:"=%
set usern=%usern:&=%
set usern=%usern: =%

for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I" 
IF "%usern%"=="EXIT" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :changeuser
)
IF "%usern%"==" =" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :changeuser
)
IF "%usern%"=="" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: The user you entered does not exist.[%textb%;%textf%m
	timeout 2 >nul
	goto :changeuser
)
goto :displayatt
--------------------------------------------------------------------------------------
:displayatt
::displays the users attributes  

::setting all variables to dat files
set /p pass=<%file%\Users\%usern%\pass.dat
set /p permfull=<%file%\Users\%usern%\permfull.dat
set /p permnum=<%file%\Users\%usern%\permnum.dat
set /p creator=<%file%\Users\%usern%\creator.dat
set pass=%pass: =%
set permfull=%permfull: =%
set permnum=%permnum: =%
set creator=%creator: =%

::start of pass file
set "spass=password="
::start of permission file
set "perms=perm="

::gets only the password
for /f "tokens=1 delims=%spass% " %%a in ("%pass%") do set "jpass=%%a"
::gets only the permission level
for /f "tokens=1 delims=%perms% " %%a in ("%permfull%") do set "jperm=%%a"
set jperm=%jperm:=%

cls
echo %header%
echo:
echo User %usern%:
echo %usern%'s password is "%jpass%"
echo %usern%'s permisson level is "%jperm%"
echo:
echo [%textq%mWhat would you like to change?[%textb%;%textf%m
echo 0. Exit.
echo 1. Switch user.
echo 2. Change %usern%'s password.
echo 3. Change %usern%'s permisson level.
echo|set /p="[%textq%mPlease enter you choice:[%textb%;%textf%m"
set "option="
set /p option=

set option=%option:"=%
set option=%option:&=%

IF "%option%"=="0" goto :menu
IF "%option%"=="1" goto :changeuser
IF "%option%"=="2" goto :changepass
IF "%option%"=="3" goto :changeperm

cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :displayatt
--------------------------------------------------------------------------------------
:changepass
::change password
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo %usern%'s password is "%pass%"
echo|set /p="[%textq%mPlease enter %usern%'s new password:[%textb%;%textf%m"
set "npass0="
set /p npass0=

set npass0=%npass0:"=%
set npass0=%npass0:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%npass0%\".toUpper()"`) do set "npass0=%%~I"
IF "%npass0%"=="EXIT" goto :displayatt
::reenter password
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="[%textq%mPlease reenter %usern%'s new password:[%textb%;%textf%m"
set "npass1="
set /p npass1=

set npass1=%npass1:"=%
set npass1=%npass1:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%npass1%\".toUpper()"`) do set "npass1=%%~I"
IF "%npass0%"=="%npass1%" (
	set "npass=%npass0%"
	goto :confirmpass
)
cls
echo %header%
echo:
echo [%texte%mPasswords do not match. Please try again. [%textb%;%textf%m
timeout 2 >nul
goto :changepass
--------------------------------------------------------------------------------------
:confirmpass
cls
echo %header%
echo:
echo [%textq%mAre you sure you want to change %usern%'s password to %npass%? [%textb%;%textf%m

::using simple boolean system
set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="yes" (
	del %file%\Users\%usern%\pass.dat
	echo.password=%npass% > %file%\Users\%usern%\pass.dat
	cd %file%\Users\ALL\
	findstr /v "%usern%:" "Userdat.dat" > Userdat.temp
	del Userdat.dat
	ren Userdat.temp Userdat.dat
	cd %file%
	set permfull=%permfull:=%
	echo.%usern%:%permfull%,permnum=%permnum%,password=%npass%,%creator% >> %file%\Users\ALL\Userdat.dat
	cls
	echo %header%
	echo:
	echo [92mPassword changed. [%textb%;%textf%m
	timeout 2 >nul
	goto :displayatt
)
IF "%boolean%"=="no" goto :displayatt
IF "%boolean%"=="n" goto :displayatt
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :confirmpass
--------------------------------------------------------------------------------------
:changeperm
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="[%textq%mWhat would you like to change %usern%'s permisson level to (1-5):[%textb%;%textf%m"
set "nperm="
set /p nperm=

set nperm=%nperm:"=%
set nperm=%nperm:&=%

IF "%nperm%" GTR "5" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to high. [%textb%;%textf%m
	timeout 2 >nul
	goto :changeperm
)
IF "%nperm%" LSS "1" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to low. [%textb%;%textf%m
	timeout 2 >nul
	goto :changeperm
)
goto :confirmperm
--------------------------------------------------------------------------------------
:confirmperm
cls
echo %header%
echo:
echo [%textq%mAre you sure you want to change %usern%'s permission level to %nperm%? [%textb%;%textf%m

::using simple boolean system
set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

IF "%boolean%"=="no" goto :displayatt
IF "%boolean%"=="n" goto :displayatt

IF "%boolean%"=="y" set "boolean=yes"
IF NOT "%boolean%"=="yes" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Invalid option. [%textb%;%textf%m
	timeout 2 >nul
	goto :confirmperm
)

set nperm=%nperm: =%
set "npermnum=%nperm%"
::anti forge
IF "%npermnum%"=="1" (
	set "npermnum="
)
IF "%npermnum%"=="2" (
	set "npermnum="
)
IF "%npermnum%"=="3" (
	set "npermnum="
)
IF "%npermnum%"=="4" (
	set "npermnum="
)
IF "%npermnum%"=="5" (
	set "npermnum="
)

del %file%\Users\%usern%\permfull.dat
del %file%\Users\%usern%\permnum.dat
echo.perm=%nperm% > %file%\Users\%usern%\permfull.dat
echo.%npermnum% > %file%\Users\%usern%\permnum.dat
cd %file%\Users\ALL\
findstr /v "%usern%:" "Userdat.dat" > Userdat.temp
del Userdat.dat
ren Userdat.temp Userdat.dat
cd %file%
echo.%usern%:perm=%nperm%,permnum=%npermnum%,%pass%,%creator% >> %file%\Users\ALL\Userdat.dat
cls
echo %header%
echo:
echo [92mPermission level changed. [%textb%;%textf%m
timeout 2 >nul
goto :displayatt

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------