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
::CHROME
IF "%permnum%" GTR "0" ( 
	echo %op%.  Start CHROME.
	set /a op=%op%+1
)
::FIREFOX
IF "%permnum%" GTR "1" ( 
	echo %op%.  Start FIREFOX.
	set /a op=%op%+1
)
