@echo off
title OMEGA %build%
::setup for permissions
set op=0
cls
echo OMEGAui build version %build%
echo.
echo Welcome to the other programs selector.
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
