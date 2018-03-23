:startup
::setup
@echo off
cls
set "build=0.5"
set "title=OMEGA PROGRAM MANAGER v%build%"
set "header=Program Manager v%build%"
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
		echo [%texte%mError: Invalid current program. [%textb%;%textf%m
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
echo What would you like to do.
echo 0. Switch programs or exit.
echo 1. Add a program.
echo 2. Remove a program.
echo 3. Add a section. (WIP)
echo 4. Remove a section. (WIP)
echo 5. Add a website. (WIP)
echo 6. Remove a website. (WIP)
echo:
echo|set /p="[%textq%mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set choice=%choice:"=%
set choice=%choice:&=%

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
echo [%texte%mError: Wrong username or password. [%textb%;%textf%m
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
echo 2. Switch to User Manager.
echo:
echo|set /p="[%textq%mPlease enter your choice:[%textb%;%textf%m"
set "choice="
set /p choice=

set choice=%choice:"=%
set choice=%choice:&=%

set "current=EXIT"
IF "%choice%"=="0" (
	::set program to exit and exits User Manager
	IF NOT "%host%"=="PROGRAM" (
		set "current=EXIT"
		echo.EXIT > %file%\current.temp
	)
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
	echo [%texte%mError: Invalid host. [%textb%;%textf%m
	echo Host=%host%
	timeout 2 >nul
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
	echo [%texte%Error: Invalid host. [%textb%;%textf%m
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
echo|set /p="[%textq%mWhat is the name of this program:[%textb%;%textf%m"
set "nameA="
set /p nameA=

set nameA=%nameA:"=%
set nameA=%nameA:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%nameA%\".toUpper()"`) do set "nameA=%%~I" 
IF "%nameA%"=="EXIT" goto :menu
::verify name
cls
echo %header%
echo:
echo Type exit to exit.
echo:
echo|set /p="[%textq%mPlease renter the name:[%textb%;%textf%m"
set "nameB="
set /p nameB=

set nameB=%nameB:"=%
set nameB=%nameB:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%nameB%\".toUpper()"`) do set "nameB=%%~I" 
IF "%nameB%"=="EXIT" goto :menu
IF "%nameA%"=="%nameB%" (
	set "name=%nameA%"
	goto :type
)
cls
echo %header%
echo:
echo [%texte%mError: Names do not match. [%textb%;%textf%m
echo Please try again.
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
echo|set /p="[%textq%mWhat type is %name%:[%textb%;%textf%m"
set "type="
set /p type=

set type=%type:"=%
set type=%type:&=%

IF "%type%"=="0" goto :menu
IF "%type%"=="1" goto :path
IF "%type%"=="2" goto :path
IF "%type%"=="3" goto :path
IF "%type%"=="4" goto :path


cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
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
echo|set /p="[%textq%mPlease type the file path for %name%:[%textb%;%textf%m"
set "path="
set /p path=

set path=%path:"=%
set path=%path:&=%

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
echo|set /p="[%textq%mPlease type the requred permission level for %name%(1-5):[%textb%;%textf%m"
set "perm="
set /p perm=

set perm=%perm:"=%
set perm=%perm:&=%

IF "%perm%"=="exit" goto :type
IF "%perm%" GTR "5" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to high. [%textb%;%textf%m
	timeout 2 >nul
	goto :perm
)
IF "%perm%" LSS "1" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Perition level to low. [%textb%;%textf%m
	timeout 2 >nul
	goto :perm
)

set /a perm=%perm%-1
goto :confirm
--------------------------------------------------------------------------------------
:confirm
::verify the program
cls
echo %header%
echo:
echo Path=%path%.
echo Type=%type%.
echo Perition greater than %perm%.
echo [%textq%mAre you sure you want to add program %name%?[%textb%;%textf%m

set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

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
echo [%texte%mError: Invalid option. [%textb%;%textf%m
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
echo|set /p="[%textq%mWhat type of program do you want to delete:[%textb%;%textf%m"
set "type="
set /p type=

set type=%type:"=%
set type=%type:&=%

IF "%type%"=="0" goto :menu
IF "%type%"=="1" goto :pname
IF "%type%"=="2" goto :pname
IF "%type%"=="3" goto :pname
IF "%type%"=="4" goto :pname

cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
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
echo|set /p="[%textq%mWhat program would you like to delete:[%textb%;%textf%m"
set "name="
set /p name=

set name=%name:"=%
set name=%name:&=%

for /f "usebackq delims=" %%I in (`powershell "\"%name%\".toUpper()"`) do set "name=%%~I"
IF "%name%"=="EXIT" goto :menu
findstr "_%name%_" "%file%\ProgramFiles\ProgramsStart\Programs%type%.dat"
IF "%ERRORLEVEL%"=="1" (
	cls
	echo %header%
	echo:
	echo [%texte%mError: Program does not exist. [%textb%;%textf%m
	timeout 2 >nul
	goto :pname
)
goto :confirmdel
--------------------------------------------------------------------------------------
:confirmdel
::verify deletion of the program
cls
echo %header%
echo:
echo [%textq%mAre you sure you want to delete program %name%?[%textb%;%textf%m

set "boolean="
set /p boolean=

set boolean=%boolean:"=%
set boolean=%boolean:&=%

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
	timeout 2 >nul
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
echo [%texte%mError: Invalid option. [%textb%;%textf%m
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