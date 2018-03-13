:startup
@echo off
set "build=0.5"
set "title=OMEGA USER CREATE %build%"
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
IF EXIST %file%\Users\BLACKLIST\%username%.txt exit
::Check if the user is logged in
IF "%loggedin%"=="y" (
	set "miss=0"
	IF "%perm%"=="" set "miss=1"
	IF "%permnum%"=="" set "miss=1"
	IF "%user%"=="" set "miss=1"
	IF "%now%"=="" set "miss=1"
	IF "%creator%"=="" set "miss=1"
	IF "%miss%"=="1" goto :start
	
	IF NOT EXIST %file%\Users\%user% (
		goto :start
	)
	goto :menu
)
goto :start
--------------------------------------------------------------------------------------------------
:start
cls
echo:
cmd /C %file%\ProgramFiles\Symbol.cmd
echo:
echo Welcome to the OMEGAui user cration system.
pause >nul
goto :logon
--------------------------------------------------------------------------------------------------
:logon
cmd /K %file%\ProgramFiles\Login.cmd

del %file%\Users\%user%\logs\%now%.txt

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
set "loggedin=y"

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
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:menu
cls
echo:
echo Options:
echo 0. Exit.
echo 1. Create user.
echo 2. Delete user.
echo 3. View user logs.
echo 4. Change a user.
echo:
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

IF "%choice%"=="0" (
	exit
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

cls
echo Invalid option!
pause >nul
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:create
cls
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
	echo:
	echo User %usern% already exists.
	echo Are you sure you want to continue?
	set "boolean="
	set /p boolean=

	IF "%boolean%"=="yes" (
		for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
		cd %file%\Users\ALL\
		findstr /v %usern%: Userdat.txt > Userdatgood.txt
		del Userdat.txt
		ren Userdatgood.txt Userdat.txt
		findstr /v _%usern%_ Users.txt > Usersgood.txt
		del Users.txt
		ren Usersgood.txt Users.txt
		cd %file%
		goto :createcont
	)
	IF "%boolean%"=="no" (
		cls
		echo:
		echo Canceled.
		set "usern="
		timeout 1 >nul
		goto :menu
	)
	cls
	echo Invalid option!
	echo Aborting..
	timeout 1 >nul
	goto :menu
) ELSE goto :createcont
--------------------------------------------------------------------------------------------------
:createcont

cls 
echo:
echo|set /p="Please enter the password of user %usern%:"
set "pass="
set /p pass=

cls 
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
echo:
echo Creating..

md %file%\Users\%usern% >nul
md %file%\Users\%usern%\logs >nul
echo.password=%pass% > %file%\Users\%usern%\pass.txt
echo.perm=%perm% > %file%\Users\%usern%\permfull.txt
echo.%permnum% > %file%\Users\%usern%\permnum.txt
echo.creator=%ruser% > %file%\Users\%usern%\creator.txt
echo.%usern%:perm=%perm%,permnum=%permnum%,password=%pass%,creator=%ruser% >> %file%\Users\ALL\userdat.txt
echo._%usern%_ >> %file%\Users\ALL\users.txt
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:delete
cls
echo:
echo Users:
echo The username is between the underscores.
echo:
type %file%\Users\ALL\users.txt
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
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
IF "%usern%"==" =" (
	cls
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
IF "%usern%"=="" (
	cls
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :delete
)
cls
echo:
echo Are you sure that you want to delete %usern% from the database?

set "boolean="
set /p boolean=
for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
IF "%boolean%"=="yes" (
	del /F /Q %file%\Users\%usern%
	rd /s /q %file%\Users\%usern%
	cd %file%\Users\ALL\
	findstr /v %usern%: Userdat.txt > Userdatgood.txt
	del Userdat.txt
	ren Userdatgood.txt Userdat.txt
	findstr /v _%usern%_ Users.txt > Usersgood.txt
	del Users.txt
	ren Usersgood.txt Users.txt
	cd %file%
	goto :menu
)
IF "%boolean%"=="no" (
	cls
	echo:
	echo Canceled.
	set "usern="
	timeout 2 >nul
	goto :menu
)
cls
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :delete
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:logs

cls
echo:
echo Type exit to exit.
echo:
echo Users:
echo The username is between the underscores.
echo:
type %file%\Users\ALL\users.txt
echo:
echo|set /p="Please enter the username of the user that logs you want to view or delete:"
set "usern="
set /p usern=

IF "%usern%"=="exit" (
	goto :menu
)
IF NOT EXIST %file%\Users\%usern% (
	cls
	echo:
	echo The user you entered does not exist.
	timeout 2 >nul
	goto :logs
) ELSE goto :logselect
--------------------------------------------------------------------------------------------------
:logselect
cls
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.txt
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
echo:
echo Invalid option!
pause >nul
goto :logselect
--------------------------------------------------------------------------------------------------
:logview
cls
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.txt
echo:
echo|set /p="Please enter the log name of the log that you want to view(ex. 2000-01-01_00-00-00):"
set "log="
set /p log=


IF NOT EXIST %file%\Users\%usern%\logs\%log%.txt (
	cls
	echo:
	echo The log you entered does not exist.
	timeout 2 >nul
	goto :logselect
)
cls
echo:
echo Log %log%:
echo:
type %file%\Users\%usern%\logs\%log%.txt
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
echo:
echo Invalid option!
pause >nul
goto :logop
--------------------------------------------------------------------------------------------------
:dellogs
cls
echo:
echo What would you like to do with %usern% logs?
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
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :logs
--------------------------------------------------------------------------------------------------
:delall
cls
echo:
echo Are you sure that you want to delete all of %usern% logs from the database?

set "boolean="
set /p boolean=
IF "%boolean%"=="yes" (
	for /f "usebackq delims=" %%I in (`powershell "\"%usern%\".toUpper()"`) do set "usern=%%~I"
	del /F %file%\Users\%usern%\logs
	echo. > %file%\Users\%usern%\logs\ALL.txt
	cls
	echo:
	echo Deleted.
	timeout 1 >nul
	goto :logs
)
IF "%boolean%"=="no" (
	cls
	echo:
	echo Canceled.
	timeout 1 >nul
	goto :logs
)
cls
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :logs
--------------------------------------------------------------------------------------------------
:dellog
cls
echo:
echo Type exit to exit.
echo:
echo User %usern% Logs:
echo:
type %file%\Users\%usern%\logs\ALL.txt
echo:
echo|set /p="Please enter the log name of the log that you want to delete(ex. 2000-01-01_00-00-00):"
set "log="
set /p log=

IF "%log%"=="exit" (
	goto :dellogs
)
IF NOT EXIST %file%\Users\%usern%\logs\%log%.txt (
	cls
	echo:
	echo The log you entered does not exist.
	timeout 2 >nul
	goto :dellog
)

cls
echo:
echo Are you sure that you want to delete log %log%?

set "boolean="
set /p boolean=
IF "%boolean%"=="yes" (
	for /f "usebackq delims=" %%I in (`powershell "\"%log%\".toUpper()"`) do set "log=%%~I"
	del /F %file%\Users\%usern%\logs\%log%.txt
	cd %file%\Users\%usern%\logs
	findstr /v %log%.txt ALL.txt > ALLgood.txt
	del ALL.txt
	ren ALLgood.txt ALL.txt
	cd %file%
	goto :dellogs
)
IF "%boolean%"=="no" (
	cls
	echo:
	echo Canceled.
	timeout 1 >nul
	goto :dellogs
)
cls
echo Invalid option!
echo Aborting..
timeout 1 >nul
goto :dellogs
--------------------------------------------------------------------------------------------------