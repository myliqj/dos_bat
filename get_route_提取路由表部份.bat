@echo off&setlocal enabledelayedexpansion

set v_r=IPv4 路由表
if "%1"=="2" set v_r=永久路由

goto start_all



@set route_start_line=0

:set_line
  :: echo %1
  set vi=%1

  @set x1=0 
  set v2=
  @for /l %%i in (2,1,10) do (
    set /a x1+=1
    :: echo %vi%  !x1!,!v1!
    set v1=!vi:~1,1%!
    set vi=!vi:~1!
    if "!v1!"=="]"  goto :eof 
      ::@echo line== !v2! &&
    set v2=!v2!!v1!
    set route_start_line=!v2!
  )
  @echo line== !v2!

  @goto start_route
  @exit /b 0

:start_all
for /f "usebackq" %%a in (`route print ^| find /N "%v_r%"`) do @call :set_line %%a && goto :start_route
goto :eof


:start_route
set /a route_start_line-=1
::echo route_start_line == %route_start_line%
for /F "skip=%route_start_line% usebackq delims=, tokens=1" %%i in (`route print`) do (
  ::@if not "%%i~:~0,4"=="IPv6" 
  set vn=%%i 
  set vn4=!vn:~0,4!
  ::echo !vn4!++++++++++++++
  if /i "!vn4!"=="IPv6" goto :eof
  echo !vn!
)


:all_end

