:startup
::setup
@echo off
set "build=0.5"
set "title=OMEGA PROGRAM MANAGER %build%"
set "header=Program Manager Version %build%"
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
	
	::checking if this is the correct program to be in
	IF NOT "%current%"=="PROGRAM" (
		::if its another go to that program
		IF "%current%"=="OMEGA" (
			cmd /C %file%\OMEGAui.bat
			goto :start
		)
		IF "%current%"=="USER" (
			cmd /C %file%\ProgramFiles\UserCreate.bat
			goto :start
		)
		cls
		echo %header%
		echo:
		echo Error in current program
		echo current program is set to %current%
		pause
		goto :start
	)
	goto :menu
)
goto :start
--------------------------------------------------------------------------------------------------
:start
cls
echo %header%
echo:
cmd /C %file%\ProgramFiles\Symbol.cmd
echo:
echo Welcome to the OMEGAui program editor.
pause >nul
goto :login
--------------------------------------------------------------------------------------------------
:login
::login script
cmd /K %file%\ProgramFiles\Login.cmd

del %file%\Users\%user%\logs\%now%.txt

::setting account variable
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
set "host=PROGRAM"
set "current=PROGRAM"

::deleting temp files
del %file%\ProgramFiles\perm.temp
del %file%\ProgramFiles\permnum.temp
del %file%\ProgramFiles\user.temp
del %file%\ProgramFiles\now.temp
del %file%\ProgramFiles\creator.temp
title %title%
IF "%permnum%" GTR "4" goto :menu
exit
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:menu

cls
echo %header%
echo:
echo Please select an option.
echo 0. Exit.
echo 1. Add a program.
echo 2. Remove a program. (WIP)
echo 3. Add a section.
echo 4. Remove a section. (WIP)
echo:
echo|set /p="Please enter your choice:"
set "choice="
set /p choice=

IF "%choice%"=="0" (
	::exits
	exit
)
IF "%choice%"=="1" (
	::goes to program creation menu
	goto :pcreate
)
IF "%choice%"=="2" (
	::goes to program deletion menu
	goto :pdelete
)
IF "%choice%"=="3" (
	::does to section creation menu
	goto :screate
)
IF "%choice%"=="4" (
	::does to section deletion menu
	goto :sdelete
)

cls
echo %header%
echo:
echo [91mWrong username or password. [%textb%;%textf%m
timeout 2 >nul
goto :menu
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:pcreate

:name
::name program
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="What is the name of this program:"
set "nameA="
set /p nameA=


::verify name
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="Please renter the name:"
set "nameB="
set /p nameB=

IF "%nameA%"=="exit" exit
IF "%nameB%"=="exit" exit
IF "%nameA%"=="%nameB%" (
	set "name=%nameA%"
	goto :type
)
cls
echo %header%
echo:
echo ERROR:Names do not match.
echo Pleas try again.
timeout 2>nul
goto :name
--------------------------------------------------------------------------------------------------
:type
::set the type of program
cls
echo %header%
echo:
echo Options:
echo 0. Exit.
echo 1.  Browser.
echo 2.  Game.
echo 3.  Utility.
echo 4.  Other.
echo|set /p="What type is %name%:"
set "type="
set /p type=

IF "%type%"=="0" goto :menu
IF "%type%"=="1" goto :path
IF "%type%"=="2" goto :path
IF "%type%"=="3" goto :path
IF "%type%"=="4" goto :path


cls
echo %header%
echo:
echo Invalid option.
timeout 2>nul
goto :type
--------------------------------------------------------------------------------------------------
:path
::set file path of program
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="Please type the file path for %name%:"
set "path="
set /p path=

IF "%path%"=="exit" goto :type
goto :perm
--------------------------------------------------------------------------------------------------
:perm
::set permission level 
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="Please type the requred permission level for %name%(1-4):"
set "perm="
set /p perm=

IF "%perm%"=="exit" goto :type
set /a perm=%perm%-1
goto :confirm
--------------------------------------------------------------------------------------------------
:confirm
::verify the program
cls
echo %header%
echo:
echo Are you sure you want to add program %name%?
echo Path=%path%.
echo Type=%type%.
echo Perition greater than %perm%.

set "boolean="
set /p boolean=

IF "%boolean%"=="yes" (
	cd %file%\ProgramFiles\ProgramsStart\
	ren Option%type%.cmd option%type%.txt
	echo.IF "%%permnum%%" GTR "%perm%" ^( >>Option%type%.txt
	echo.	echo %%op%%.  Start %name%.>>Option%type%.txt
	echo.	set /a op^=%%op%%+1>>Option%type%.txt
	echo.^)>>Option%type%.txt
	ren Option%type%.txt Option%type%.cmd
	ren Choice%type%.cmd Choice%type%.txt
	echo.IF "%%permnum%%" GTR "%perm%" (>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.	IF "%%choice%%"=="%%op%%" (>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.		::Starts %name%>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.		echo.[%%time%%]:----++++Started %name%.^>^>%%file%%\Users\%%user%%\logs\%%now%%.txt>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.		start "" "%path%">>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.		echo.true^> %%file%%\ProgramFiles\ProgramsStart\success.txt>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.	^)>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.	set /a o^p=%%op%%+1>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	echo.^)>>%file%\ProgramFiles\ProgramsStart\Choice%type%.txt
	ren Choice%type%.txt Choice%type%.cmd
	cd %file%
	goto :menu
)
IF "%boolean%"=="no" goto :menu
cls
echo %header%
echo:
echo Invalid option.
timeout 2 >nul
goto :confirm
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:pdelete 

goto :menu

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:screate

goto :menu

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
:sdelete

goto :menu

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------