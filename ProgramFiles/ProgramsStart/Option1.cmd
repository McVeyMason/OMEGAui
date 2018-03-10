@echo off
title OMEGA %build%
::setup for permissions
set op=0
cls
echo OMEGAui build version %build%
echo:
echo Welcome to the Browser selector.
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
::Chrome
IF "%permnum%" GTR "0" ( 
 	echo %op%.  Start Chrome.
	set /a op=%op%+1
)
