@Echo OFF

Call :TEXTMAN 5 30 "TextFile.txt"
Pause&Exit

:TEXTMAN
(SET /A "A=0", "LINE=0", "TOTAL_LINES=0")  &  (CALL :%~1 %* || (ECHO incorect parameters & Exit /B 1)) & (GOTO:EOF)
:GR
(For /F "tokens=1* delims=]" %%A in ('type "%~4" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "(IF "%%LINE%%" GEQ "%~2" IF "%%LINE%%" LEQ "%~3" (if "%%B" EQU "" (Echo+>> "%~4.NEW") ELSE ((Echo %%B)>> "%~4.NEW"))) && (IF "%%LINE%%" EQU "%~3" Exit /B 1)" || ((CALL :RENAMER "%~4") & (GOTO:EOF)))))
:RENAMER
(REN "%~1" "%~nx1.BAK") & (MOVE /Y "%~1.BAK" "%TEMP%\" >NUL) & (REN "%~1.NEW" "%~nx1") & (GOTO:EOF)