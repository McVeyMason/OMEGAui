:startup
::setup
@echo off 
cls
set "build=0.5"
set "title=OMEGA USER MANAGER %build%"
set "header=User Manager Version %build%"
set "file=%~dp0"
cd %file%
cd..
set "file=%cd%"
set "ruser=%username%"
title %title%
color 0c
set "textf=91"
set "textb=0"
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
		echo Error in current program
		echo current program is set to %current%
		pause >nul
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
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

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
	goto :change
)

cls
echo %header%
echo:
echo Invalid option!
pause >nul
goto :menu
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:switch
::for exiting program or switching to another program
cls
echo %header%
echo:
echo What would you like to do?
echo 0. Exit.
echo 1. Switch to OMEGAui.
echo 2. Switch to Program Manager.
echo:
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

IF "%choice%"=="0" (
	::set program to exit and exits User Manager
	set "current=EXIT"
	echo.EXIT > %file%\current.temp
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
	echo Error invalid host
	echo Host=%host%
	pause >nul
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
	echo Error invalid host
	echo Host=%host%
	pause >nul
	goto :startup
)
cls
echo %header%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :switch
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:create
cls
echo %header%
echo:
echo Type exit to exit.
echo|set /p="Please enter username of the new user:"
set "usern="
set /p usern=
IF %usern%==exit (
	goto :menu
)

IF EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo User %usern% already exists.
	echo Are you sure you want to continue?
	set "boolean="
	set /p boolean=
	
	IF "%boolean%"=="y" set "boolean=yes"
	IF "%boolean%"=="n" set "boolean=no"
	IF "%boolean%"=="yes" (
		for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
		cd %file%\Users\ALL\
		findstr /v %usern%: Userdat.dat > Userdatgood.temp
		del Userdat.dat
		ren Userdatgood.temp Userdat.dat
		findstr /v _%usern%_ Users.dat > Usersgood.temp
		del Users.dat
		ren Usersgood.temp Users.dat
		cd %file%
		goto :createcont
	)
	IF "%boolean%"=="no" (
		cls
		echo %header%
		echo:
		echo Canceled.
		set "usern="
		timeout 1 >nul
		goto :menu
	)
	cls
	echo %header%
	echo:
	echo Invalid option!
	echo Aborting..
	timeout 1 >nul
	goto :menu
) ELSE goto :createcont
--------------------------------------------------------------------------------------
:createcont

cls
echo %header%
echo:
echo|set /p="Please enter the password of user %usern%:"
set "pass="
set /p pass=

cls
echo %header%
echo:
echo|set /p="Please enter the permition level of user %usern%(1-5):"
set "perm="
set /p perm=

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
echo.%usern%:perm=%perm%,permnum=%permnum%,password=%pass%,creator=%ruser% >> %file%\Users\ALL\userdat.dat
echo._%usern%_ >> %file%\Users\ALL\users.dat
goto :menu
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:delete
cls
echo %header%
echo:
echo Users:
echo The username is between the underscores.
echo:
type %file%\Users\ALL\users.dat
echo:
echo Type exit to exit.
echo|set /p="Please enter the username of the user that you want to delete:"
set "usern="
set /p usern=
set usern=%usern: =%
IF "%usern%"=="exit" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
IF "%usern%"==" =" (
	cls
	echo %header%
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
IF "%usern%"=="" (
	cls
	echo %header%
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
cls
echo %header%
echo:
echo Are you sure that you want to delete %usern% from the database?

set "boolean="
set /p boolean=
for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	del /F /Q %file%\Users\%usern%
	rd /s /q %file%\Users\%usern%
	cd %file%\Users\ALL\
	findstr /v %usern%: Userdat.dat > Userdatgood.temp
	del Userdat.dat
	ren Userdatgood.temp Userdat.dat
	findstr /v _%usern%_ Users.dat > Usersgood.temp
	del Users.dat
	ren Usersgood.temp Users.dat
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
echo Invalid option!
echo Aborting..
timeout 1 >nul
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
echo|set /p="Please enter the username of the user that logs you want to view or delete:"
set "usern="
set /p usern=

IF "%usern%"=="exit" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo %header%
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :logs
) ELSE goto :logselect
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
echo What would you like to do with these logs?
echo 0. Exit.
echo 1. Change user.
echo 2. View logs.
echo 3. Delete logs.
echo:
echo echo|set /p="Please enter the your choice:"
set "option="
set /p option=

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
echo Invalid option!
pause >nul
goto :logselect
--------------------------------------------------------------------------------------
:logview
::log viewer
cls
echo %header%
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.dat
echo:
echo|set /p="Please enter the log name of the log that you want to view(ex. 2000-01-01_00-00-00):"
set "log="
set /p log=

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
echo What would you like to do now?
echo 0. Back.
echo 1. View another log.
echo 2. View another users logs.
echo|set /p="please enter you choice:"
set "option="
set /p option=

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
echo Invalid option!
pause >nul
goto :logop
--------------------------------------------------------------------------------------
:dellogs
::log deleter
cls
echo %header%
echo:
echo What would you like to do with %usern%'s logs?
echo 0. Back.
echo 1. Delete all.
echo 2. Delete 1.
echo|set /p="please enter you choice:"
set "option="
set /p option=

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
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :logs
--------------------------------------------------------------------------------------
:delall
::deletes all
cls
echo %header%
echo:
echo Are you sure that you want to delete all of %usern%'s logs from the database?

set "boolean="
set /p boolean=

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
	timeout 1 >nul
	goto :logs
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	timeout 1 >nul
	goto :logs
)
cls
echo %header%
echo:
echo Invalid option!
echo Aborting..
timeout 1 >nul
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
echo|set /p="Please enter the log name of the log that you want to delete(ex. 2000-01-01_00-00-00):"
set "log="
set /p log=

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
echo Are you sure that you want to delete log %log%?

set "boolean="
set /p boolean=

IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	for /f "usebackq delims=" %%I in (`powershell "\"%log%\".toUpper()"`) do set "log=%%~I"
	del /F %file%\Users\%usern%\logs\%log%.dat
	cd %file%\Users\%usern%\logs
	findstr /v %log%.dat ALL.dat > ALLgood.temp
	del ALL.dat
	ren ALLgood.temp ALL.dat
	cd %file%
	goto :dellogs
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	timeout 1 >nul
	goto :dellogs
cls
echo %header%
echo:
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :dellogs
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:change

