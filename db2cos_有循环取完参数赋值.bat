setlocal

:iterargs

if %0. == . goto iterdone
   if /i %0. == INSTANCE. set INSTANCE=%1
   if /i %0. == DATABASE. set DATABASE=%1
   if /i %0. == TIMESTAMP. set TIMESTAMP=%1
   if /i %0. == APPID. set APPID=%1
   if /i %0. == PID. set PID=%1
   if /i %0. == TID. set TID=%1
   if /i %0. == DBPART. set DBPART=%1
   if /i %0. == PROBE. set PROBE=%1
   if /i %0. == FUNCTION. set FUNCTION=%1
   if /i %0. == REASON. set REASON=%1
   if /i %0. == DESCRIPTION. set DESCRIPTION=%1
   if /i %0. == DiAGPATH. set DIAGPATH=%1
   shift
goto iterargs

:iterdone

if %DATABASE%. == . goto no_database
   db2pd -db %DATABASE% -inst >> %DIAGPATH%\db2cos%PID%%TID%.%DBPART%
   goto exit

:no_database
   db2pd -inst >> %DIAGPATH%\db2cos%PID%%TID%.%DBPART%

:exit
