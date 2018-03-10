@echo off
title OMEGA %build%
::setup for permissions
set op=0
cls
echo OMEGAui build version %build%
echo.
echo Welcome to the program selector.
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
::all permissions
echo %op%.  Start Google chrome.
set /a op=%op%+1
::all permissions
echo %op%.  Start the best browser.
set /a op=%op%+1
::all permissions
echo %op%.  Start Spotify.
set /a op=%op%+1
::all permissions
echo %op%.  Start Powder toy.
set /a op=%op%+1
::all permissions
echo %op%.  Start Minecraft launcher.
set /a op=%op%+1
::all permissions
echo %op%.  Start Feed The Beast(FTB) launcher.
set /a op=%op%+1
::all permissions
echo %op%.  Start AT launcher.
set /a op=%op%+1
::all permissions
echo %op%.  Start Steam.
set /a op=%op%+1
::only shows powershell to users with permissions above 2
IF "%permnum%" GTR "2" (
	echo %op%.  Start powershell.
	set /a op=%op%+1
)
::only shows CMD to users with permissions above 2
IF "%permnum%" GTR "2" (
	echo %op%.  Start CMD.
	set /a op=%op%+1
)
exit