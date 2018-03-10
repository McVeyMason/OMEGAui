@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION
set file=%~dp0
SET string="::Chrome"
set current=0
SET numlines=9
set read=Y
set /a endline=%numlines%+%line%
set TempFile="%file%\temp.txt"
if exist %TempFile% del %TempFile%
pause
for /F "usebackdelims=" %%L in ("%file%\Choice1.cmd") do (
	echo %%L
	echo !read!
	IF NOT "!string!"=="%%L" (
		IF "!read!"=="Y" (
			echo %%L>>%TempFile%
		)
		IF "!read!"=="N" (
			IF !current!==!numlines! (
				set read=Y
			)
			IF !current! LSS !numlines! (
				set /a current+=1
			)
		)
	)
	IF !string!==%%L (
		set read=N
	)
)
pause