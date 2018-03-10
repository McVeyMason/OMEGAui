:startup
@echo off
set file=%~dp0
cd %file%
cd..
set file=%cd%
set ruser=%username%
title %title%
::getting time and date that it was started at
SETLOCAL ENABLEDELAYEDEXPANSION
set log=Started session on %date% at %time%.
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC ^Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
    IF %%A GTR 0 (
	SET Day=%%A
	SET Hour=%%B
	SET Min=%%C
	SET Month=%%D
	SET Sec=%%E
	SET Year=%%F
    )
)
if %Month% LSS 10 set Month=0%Month%
if %Day% LSS 10 set Day=0%Day%
if %Min% LSS 10 set Minute=0%Minute%
if %Hour% LSS 10 set Hour=0%Hour%
set now=%year%-%month%-%day%_%hour%-%min%-%sec%
set now=%now%
cls
goto :logon
--------------------------------------------------------------------------------------------------
:error
::originally skipped
cls
echo %title%
echo:
echo [91mWrong username or password. [%textb%;%textf%m
timeout 2 >nul
goto :logon
--------------------------------------------------------------------------------------------------
:logon
cls 
echo %title%
echo:
echo [32mDo you want to use your default account? [%textb%;%textf%m

::using simple boolean system
set boolean=
set /p boolean=
IF "%boolean%"=="yes" (
	goto :creduser
)
IF "%boolean%"=="no" (
	goto :creddefaut
)
::error script
cls
echo %title%
echo:
echo [91mInvalid option. [%textb%;%textf%m
timeout 2 >nul
goto :logon
--------------------------------------------------------------------------------------------------
:creduser
cls
echo %title%
::setting user to computers username
set user=%ruser%
echo:
set "psCommand=powershell -Command "$pword = read-host '[32mPlease enter your password[%textb%;%textf%m' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
		[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p 
goto :logonscript
--------------------------------------------------------------------------------------------------
:creddefaut
::username

cls
echo %title%
echo:
set user=
echo|set /p="[32mPlease enter your username:[%textb%;%textf%m"
set /p user=

::password
::masks with PowerShell script
cls
echo %title%
echo:
set "psCommand=powershell -Command "$pword = read-host '[32mPlease enter your password[%textb%;%textf%m' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p 
goto :logonscript
--------------------------------------------------------------------------------------------------
:logonscript
::checks if user exists
IF NOT EXIST %file%\Users\%user% (
	goto :error
)
IF NOT EXIST %file%\Users\%user%\logs (
	md %file%\Users\%user%\logs
)
::logging real username
echo.Log started on %date% at %time% using %user% by computer account %ruser%.> %file%\Users\%user%\logs\%now%.txt 
echo.Using program %title%.>> %file%\Users\%user%\logs\%now%.txt
echo.%now%.txt >> %file%\Users\%user%\logs\ALL.txt

::converting password to correct format
set pass=password=%password%
::converting strings to uppercase 
for /f "usebackq delims=" %%I in (`powershell "\"%password%\".toUpper()"`) do set "password=%%~I"
for /f "usebackq delims=" %%I in (`powershell "\"%user%\".toUpper()"`) do set "user=%%~I" 

::setting variables to match user data
::fetches from the User file 
set /p RP=<%file%\Users\%user%\pass.txt
set /p perm=<%file%\Users\%user%\permfull.txt
::permnum is just the raw user permission level
set /p permnum=<%file%\Users\%user%\permnum.txt
::RP= real password
set RP=%RP: =%
::perm= permission level
set perm=%perm: =%
::pass= the user entered password
set pass=%pass: =%

set permnum=%permnum: =%

cls
echo pass="%pass%"
echo perm="%perm%"
echo permfull="%permfull%"
echo RP="%RP%"
echo permnum="%pernum%"
echo password="%password%"
@echo %permnum%==%permfull%>%file%\plswork.txt
pause
::converting permnum to correct format
IF "%permnum%"=="" (
	set permfull=perm=1
	set permnum=1
)
IF "%permnum%"=="" (
	set permfull=perm=2
	set permnum=2
)
IF "%permnum%"=="" (
	set permfull=perm=3
	set permnum=3
)
IF "%permnum%"=="" (
	set permfull=perm=4
	set permnum=4
)
IF "%permnum%"=="" (
	set permfull=perm=5
	set permnum=5
)
::debug
cls
echo pass="%pass%"
echo perm="%perm%"
echo permfull="%permfull%"
echo RP="%RP%"
echo permnum="%pernum%"
echo password="%password%"
@echo %perm%==%permfull%>%file%\plswork.txt
pause
::deletes user and blacklists account if user forges data
set permfull=%permfull: =%
IF NOT "%perm%"=="%permfull%" (
	cls
	echo OMEGAui build version %build%
	echo:
	del /F /Q %file%Users\%user%
	rd /s /q %file%Users\%user%
	echo User %user% deleted
	echo.%ruser% >> %file%\Users\BLACKLIST\users.txt 
	echo.%ruser% > %file%\Users\BLACKLIST\%ruser%.txt
	cd %file%\Users\ALL\
	findstr /v "%usern%:" %file%\Users\ALL\Userdat.txt > %file%\Users\ALL\Userdatgood.txt
	del %file%\Users\ALL\Userdat.txt
	ren Userdatgood.txt Userdat.txt
	findstr /v "_%usern%_" %file%\Users\ALL\Users.txt > %file%\Users\ALL\Usersgood.txt
	del %file%\Users\ALL\Users.txt
	ren Usersgood.txt Users.txt
	cd %file%
	echo Didn't expect that %ruser%, did you?
	pause
	timeout 2 >nul
	exit
)

echo.[%time%]:Permission level is %perm% >> %file%\Users\%user%\logs\%now%.txt
::comparing passwords to user files
IF /I "%pass%"=="%RP%" (
	goto :load
)
::going to error phase if any variables are incorrect
goto :error
--------------------------------------------------------------------------------------------------
:load
echo.%perm%> %file%\ProgramFiles\perm.temp
echo.%permnum%> %file%\ProgramFiles\permnum.temp
echo.%user%> %file%\ProgramFiles\user.temp
echo.%now%> %file%\ProgramFiles\now.temp
exit