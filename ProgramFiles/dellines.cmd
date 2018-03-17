@echo off

setlocal

rem Get start and end line numbers of the unwanted section
set start=
for /F "delims=:" %%a in ('findstr /N "K2START K2END" "smartforms Designer\Styles\Themes\Sun.css"') do (
   if not defined start (
      set start=%%a
   ) else (
      set end=%%a
   )
)

rem Copy all lines, excepting the ones in start-end section
(for /F "tokens=1* delims=:" %%a in ('findstr /N "^" "smartforms Designer\Styles\Themes\Sun.css"') do (
   if %%a lss %start% echo(%%b
   if %%a gtr %end% echo(%%b
)) > newFile.css