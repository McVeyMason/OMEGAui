@echo off
echo Welcome to the website selector.
echo [%textq%mWhat website would you like to start?[%textb%;%textf%m
echo Options:
::all permissions
echo %op%.  Back.
set /a op=%op%+1
::all permissions
echo %op%.  Add a website.
set /a op=%op%+1
