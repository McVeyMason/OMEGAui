:startup
::setup
@echo off
cls
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
IF EXIST %file%\Users\BLACKLIST\%username%.dat exit
::sets the current variable
set /p current=<%file%\current.temp
set current=%current: =%
del %file%\current.temp
::Check if the user is logged in
IF "%loggedin%"=="y" (
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
	IF NOT "%current%"=="PROGRAM" (
		::if its another go to that program
		IF "%current%"=="OMEGA" (
			cmd /C %file%\OMEGAui.bat
			goto :startup
		)
		IF "%current%"=="USER" (
			cmd /C %file%\ProgramFiles\UserCreate.bat
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
		pause
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
echo Welcome to the OMEGAui program editor.
pause >nul
goto :login
--------------------------------------------------------------------------------------
:login
::login script
cmd /K %file%\ProgramFiles\Login.cmd

del %file%\Users\%user%\logs\%now%.log

::setting account variable
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
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:menu

cls
echo %header%
echo:
echo Please select an option.
echo 0. Switch programs or exit.
echo 1. Add a program.
echo 2. Remove a program. (WIP)
echo 3. Add a section.
echo 4. Remove a section. (WIP)
echo:
echo|set /p="Please enter your choice:"
set "choice="
set /p choice=

IF "%choice%"=="0" (
	::goes to switch menu
	goto :switch
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
echo 2. Switch to User Manager.
echo:
echo|set /p="[32mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set "current=EXIT"
IF "%choice%"=="0" (
	::set program to exit and exits User Manager
	set "current=EXIT"
	echo.EXIT > %file%\current.temp
	exit
)
IF "%choice%"=="1" (
	::opens OMEGAui 
	IF "%host%"=="PROGRAM" (
		set "current=OMEGA"
		echo.OMEGA > %file%\current.temp
		cmd /C %file%\OMEGAui.bat
		goto :startup
	)
	IF "%host%"=="USER" (
		echo.OMEGA > %file%\current.temp
		exit
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
		set "current=USER"
		echo.USER > %file%\current.temp
		cmd /C %file%\ProgramFiles\UserCreate.bat
		goto :startup
	)
	IF "%host%"=="USER" (
		echo.USER > %file%\current.temp
		exit
	)
	IF "%host%"=="OMEGA" (
		echo.USER > %file%\current.temp
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

for /f "usebackq delims=" %%I in (`powershell "\"%nameA%\".toUpper()"`) do set "nameA=%%~I" 

::verify name
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="Please renter the name:"
set "nameB="
set /p nameB=

for /f "usebackq delims=" %%I in (`powershell "\"%nameB%\".toUpper()"`) do set "nameB=%%~I" 

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
--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------
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

for /f "usebackq delims=" %%I in (`powershell "\"%name%\".toUpper()"`) do set "name=%%~I" 

IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="yes" (
	::Edits option file
	cd %file%\ProgramFiles\ProgramsStart\
	ren Option%type%.cmd Option%type%.temp
	echo.::%name%-START>> Option%type%.temp
	echo.IF "%%permnum%%" GTR "%perm%" ^( >> Option%type%.temp
	echo.	echo %%op%%.  Start %name%.>> Option%type%.temp
	echo.	set /a op^=%%op%%+1>> Option%type%.temp
	echo.^)>> Option%type%.temp
	echo.::%name%-END>> Option%type%.temp
	ren Option%type%.temp Option%type%.cmd
	
	::Edits Choice file
	ren Choice%type%.cmd Choice%type%.temp
	echo.::%name%-START>> Choice%type%.temp
	echo.IF "%%permnum%%" GTR "%perm%" (>> Choice%type%.temp
	echo.	IF "%%choice%%"=="%%op%%" (>> Choice%type%.temp
	echo.		::Starts %name%>> Choice%type%.temp
	echo.		echo.[%%time%%]:----++++Started %name%.^>^>%%file%%\Users\%%user%%\logs\%%now%%.log>> Choice%type%.temp
	echo.		start "" "%path%">> Choice%type%.temp
	echo.		echo.true^> %%file%%\ProgramFiles\ProgramsStart\success.temp>> Choice%type%.temp
	echo.	^)>> Choice%type%.temp
	echo.	set /a o^p=%%op%%+1>> Choice%type%.temp
	echo.^)>> Choice%type%.temp
	echo.::%name%-END>> Choice%type%.temp
	ren Choice%type%.temp Choice%type%.cmd
	cd %file%
	
	::Adds program to list
	echo._%name%_ >> %file%\ProgramFiles\ProgramsStart\Programs%type%.dat
	
	goto :menu
)
IF "%boolean%"=="n" goto :menu
IF "%boolean%"=="no" goto :menu
cls
echo %header%
echo:
echo Invalid option.
timeout 2 >nul
goto :confirm
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:pdelete
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
echo|set /p="What type of program do you want to delete:"
set "type="
set /p type=

IF "%type%"=="0" goto :menu
IF "%type%"=="1" goto :pname
IF "%type%"=="2" goto :pname
IF "%type%"=="3" goto :pname
IF "%type%"=="4" goto :pname

cls
echo %header%
echo:
echo Invalid option.
timeout 2>nul
goto :pdelete
--------------------------------------------------------------------------------------
:pname
::name of program
cls
echo %header%
echo:
echo Programs:
type %file%\ProgramFiles\ProgramsStart\Programs%type%.dat
echo:
echo Type name without underscores.
echo Type exit to exit.
echo|set /p="What program would you like to delete:"
set "name="
set /p name=

for /f "usebackq delims=" %%I in (`powershell "\"%name%\".toUpper()"`) do set "name=%%~I"
IF "%name%"=="EXIT" goto :menu
findstr "_%name%_" "%file%\ProgramFiles\ProgramsStart\Programs%type%.dat"
IF "%ERRORLEVEL%"=="1" (
	cls
	echo %header%
	echo:
	echo Invalid name.
	timeout 2 >nul
	goto :pname
)
pause
goto :confirmdel
--------------------------------------------------------------------------------------
:confirmdel
::verify deletion of the program
cls
echo %header%
echo:
echo Are you sure you want to delete program %name%?

set "boolean="
set /p boolean=


IF "%boolean%"=="y" set "boolean=yes"
IF "%boolean%"=="n" set "boolean=no"
IF "%boolean%"=="yes" (
	
	set "startstring=%name%-START"
	set "endstring=%name%-END"
	set "infile=%file%\ProgramFiles\ProgramsStart\Option%type%.cmd"
	set "outfile=%file%\ProgramFiles\ProgramsStart\Option%type%.temp"
	cmd /C %file%\ProgramFiles\dellines.cmd
	
	set "infile=%file%\ProgramFiles\ProgramsStart\Choice%type%.cmd"
	set "outfile=%file%\ProgramFiles\ProgramsStart\Choice%type%.temp"
	cmd /C %file%\ProgramFiles\dellines.cmd
	
	cd %file%\ProgramFiles\ProgramsStart\
	del Option%type%.cmd
	ren Option%type%.temp Option%type%.cmd
	del Choice%type%.cmd
	ren Choice%type%.temp Choice%type%.cmd
	findstr /v _%name%_ Programs%type%.dat > Programs%type%.temp
	del Programs%type%.dat
	ren Programs%type%.temp Programs%type%.dat
	cd %file%
	
	cls
	echo %header%
	echo:
	echo Done!
	pause 
	goto :menu
)
IF "%boolean%"=="no" (
	cls
	echo %header%
	echo:
	echo Canceled.
	timeout 2 >nul
	goto :menu
)
cls
echo %header%
echo:
echo Invalid option.
timeout 2>nul
goto :confirmdel

goto :menu

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:screate

goto :menu

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
:sdelete

goto :menu

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------