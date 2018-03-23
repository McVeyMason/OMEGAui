:startup
::setup
@echo off
set "file=%~dp0"
cd %file%
cd..
set "file=%cd%"
set "ruser=%username%"
title %title%
::getting time and date that it was started at
SETLOCAL ENABLEDELAYEDEXPANSION
set "log=Started session on %date% at %time%."
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC ^Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
    IF %%A GTR 0 (
		SET "Day=%%A"
		SET "Hour=%%B"
		SET "Min=%%C"
		SET "Month=%%D"
		SET "Sec=%%E"
		SET "Year=%%F"
    )
)
if %Month% LSS 10 set Month=0%Month%
if %Day% LSS 10 set Day=0%Day%
if %Min% LSS 10 set Minute=0%Minute%
if %Hour% LSS 10 set Hour=0%Hour%
set "now=%year%-%month%-%day%_%hour%-%min%-%sec%"
set "now=%now%"
cls
goto :logon
--------------------------------------------------------------------------------------
:error
::originally skipped
cls
echo %header%
echo:
echo [%texte%mError: Wrong username or password. [%textb%;%textf%m
timeout 2 >nul
goto :logon
--------------------------------------------------------------------------------------
:logon

for /f "usebackq delims=" %%I in (`powershell "\"%ruser%\".toUpper()"`) do set "ruser=%%~I" 
findstr "_%ruser%_" "%file%\Users\ALL\Users.dat
IF "%ERRORLEVEL%"=="1" (
	goto :creddefaut
)
cls 
echo %header%
echo:
echo [32mDo you want to use your default account? [%textb%;%textf%m

::using simple boolean system
set "boolean="
set /p boolean=

IF NOT [%boolean%]==[] (
	set boolean=%boolean:"=%
	set boolean=%boolean:&=%
	set boolean=%boolean: =%
)

IF "%boolean%"=="y" goto :creduser
IF "%boolean%"=="yes" goto :creduser
IF "%boolean%"=="n" goto :creddefaut
IF "%boolean%"=="no" goto :creddefaut
::error script
cls
echo %header%
echo:
echo [%texte%mError: Invalid option. [%textb%;%textf%m
timeout 2 >nul
goto :logon
--------------------------------------------------------------------------------------
:creduser
cls
echo %header%
::setting user to computers username
set "user=%ruser%"
echo:
set "psCommand=powershell -Command "$pword = read-host '[32mPlease enter your password[%textb%;%textf%m' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
		[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set "password=%%p" 
IF NOT [%password%]==[] (
	set password=%password:"=&%
	set password=%password:&= %
	set password=%password: =%
)
goto :logonscript
--------------------------------------------------------------------------------------
:creddefaut
::username

cls
echo %header%
echo:
set "user="
echo|set /p="[32mPlease enter your username:[%textb%;%textf%m"
set /p user=

IF NOT [%user%]==[] (
	set user=%user:"=%
	set user=%user:&=%
	set user=%user: =%
)

for /f "usebackq delims=" %%I in (`powershell "\"%user%\".toUpper()"`) do set "user=%%~I" 
findstr "_%user%_" "%file%\Users\ALL\Users.dat"
IF "%ERRORLEVEL%"=="1" (
	goto :error
)
::password
::masks with PowerShell script
cls
echo %header%
echo:
set "psCommand=powershell -Command "$pword = read-host '[32mPlease enter your password[%textb%;%textf%m' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set "password=%%p" 
IF NOT [%password%]==[] (
	set password=%password:"=&%
	set password=%password:&= %
	set password=%password: =%
)
goto :logonscript
--------------------------------------------------------------------------------------
:logonscript
::checks if user exists
IF NOT EXIST %file%\Users\%user% (
	goto :error
)
IF NOT EXIST %file%\Users\%user%\logs (
	md %file%\Users\%user%\logs
)
::logging real username
echo.Log started on %date% at %time% using %user% by computer account %ruser%.> %file%\Users\%user%\logs\%now%.log 
echo.Using program %title%.>> %file%\Users\%user%\logs\%now%.log
echo.%now%.log >> %file%\Users\%user%\logs\ALL.dat

::converting strings to uppercase 
for /f "usebackq delims=" %%I in (`powershell "\"%password%\".toUpper()"`) do set "password=%%~I"
for /f "usebackq delims=" %%I in (`powershell "\"%user%\".toUpper()"`) do set "user=%%~I" 
::converting password to correct format
::pass= the user entered password
set "pass=password=%password%"
set pass=%pass: =%
::setting variables to match user data
::fetches from the User file 
::RP= real password
set /P RP=<%file%\Users\%user%\pass.dat
set RP=%RP: =%
::perm= permission level
set /P perm=<%file%\Users\%user%\permfull.dat
set perm=%perm: =%
::permnum is just the raw user permission level
set /P permnum=<%file%\Users\%user%\permnum.dat
set permnum=%permnum: =%
::creator is the creator of the user
set /P creator=<%file%\Users\%user%\creator.dat
::converting permnum to correct format
IF "%permnum%"=="" (
	set "permfull=perm=1"
	set "permnum=1"
)
IF "%permnum%"=="" (
	set "permfull=perm=2"
	set "permnum=2"
)
IF "%permnum%"=="" (
	set "permfull=perm=3"
	set "permnum=3"
)
IF "%permnum%"=="" (
	set "permfull=perm=4"
	set "permnum=4"
)
IF "%permnum%"=="" (
	set "permfull=perm=5"
	set "permnum=5"
)
::debug
REM cls
REM echo pass="%pass%"
REM echo perm="%perm%"
REM echo permfull="%permfull%"
REM echo RP="%RP%"
REM echo permnum="%pernum%"
REM echo password="%password%"
REM pause
::deletes user and blacklists account if user forges data
set permfull=%permfull: =%
IF NOT "%perm%"=="%permfull%" (
	cls
	echo OMEGAui build version %build%
	echo:
	del /F /Q %file%Users\%user%
	rd /s /q %file%Users\%user%
	echo User %user% deleted
	echo.%ruser% >> %file%\Users\BLACKLIST\users.dat 
	echo.%ruser% > %file%\Users\BLACKLIST\%ruser%.dat
	cd %file%\Users\ALL\
	findstr /v "%usern%:" %file%\Users\ALL\Userdat.dat > %file%\Users\ALL\Userdat.temp
	del %file%\Users\ALL\Userdat.dat
	ren Userdat.temp Userdat.dat
	findstr /v "_%usern%_" %file%\Users\ALL\Users.dat > %file%\Users\ALL\Users.temp
	del %file%\Users\ALL\Users.dat
	ren Users.temp Users.dat
	cd %file%
	echo Didn't expect that %ruser%, did you?
	timeout 2 >nul
	exit
)

echo.[%time%]:Permission level is %perm% >> %file%\Users\%user%\logs\%now%.log
::comparing passwords to user files
IF /I "%pass%"=="%RP%" (
	goto :load
)
::going to error phase if any variables are incorrect
goto :error
--------------------------------------------------------------------------------------
:load
echo.%perm%> %file%\ProgramFiles\Temp\perm.temp
echo.%permnum%> %file%\ProgramFiles\Temp\permnum.temp
echo.%user%> %file%\ProgramFiles\Temp\user.temp
echo.%now%> %file%\ProgramFiles\Temp\now.temp
echo.%creator%> %file%\ProgramFiles\Temp\creator.temp
exit