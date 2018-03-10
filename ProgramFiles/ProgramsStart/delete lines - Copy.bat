@ECHO off
SETLOCAL
set file=%~dp0
SET "string"="::Chrome"
set line='findstr /N /C:"string" /F:%file%\Option.cmd'
SET "numlines=9"
set TempFile="%file%\temp.txt"
pause
for /F "useback delims=" %%L in ("%file%\Option1.cmd") do (
	pause
	IF NOT "%%L"=="%string%" (
		echo %%L>>%file%\temp.txt
	) IF "%%L"=="%string%" (
		set /a !Line!+=%numlines%
	)
)
pause