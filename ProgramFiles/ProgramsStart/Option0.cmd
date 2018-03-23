@echo off
echo Welcome to the program selector.
echo [%textq%mWhat type of program would you like to start?[%textb%;%textf%m
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
::all permissions
echo %op%.  Browser.
set /a op=%op%+1
::all permissions
echo %op%.  Game.
set /a op=%op%+1
::all permissions
echo %op%.  Utility.
set /a op=%op%+1
::all permissions
echo %op%.  Other.
set /a op=%op%+1
