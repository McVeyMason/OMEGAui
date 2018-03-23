@echo off
echo Welcome to the file selector.
echo [%textq%mWhat would you like to do?[%textb%;%textf%m
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
::all permissions
echo %op%.  Add a file.
set /a op=%op%+1
