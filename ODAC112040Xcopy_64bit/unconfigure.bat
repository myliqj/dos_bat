@echo off
REM ========================================================================
REM This batch file unconfigures components in an Oracle Instant Client Home
REM ========================================================================

goto :ParseArgs

REM **************************
REM UNCONFIGURE ALL COMPONENTS
REM **************************
:UnconfigureAll
call :odp.net20 %1 %ohname%
call :odp.net4 %1 %ohname%
call :asp.net %1 %ohname%
call :asp.net4 %1 %ohname%
call :oledb %1 %ohname%
call :oramts %1 %ohname%
goto :EOF



REM ****************************
REM UNCONFIGURE ASPNET Providers
REM ****************************

:asp.net

echo ****************************************** >> uninstall.log
echo Unconfiguring Oracle Providers for ASP.NET >> uninstall.log
echo ****************************************** >> uninstall.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v2.0.50727\*.* (

REM ***************************************************************
REM REMOVE ALL LANGUAGE SPECIFIC ASP.NET RESOURCE DLLS FROM THE GAC
REM ***************************************************************
"%BATCH_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Oracle.Web.resources, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove the aspnet provider policy dll from the GAC
"%BATCH_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Policy.2.111.Oracle.Web, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log
"%BATCH_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Policy.2.112.Oracle.Web, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove the aspnet provider assembly from the GAC
"%BATCH_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Oracle.Web, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove machine.config entries for Oracle Providers for ASP.NET
"%BATCH_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:unconfig /product:aspnet /frameworkversion:v2.0.50727 /component:all >> uninstall.log

)

echo Delete the registry entry to remove managed assembly in the Add Reference Dialog box in VS.NET >> uninstall.log
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\ASP.Net" /f >> uninstall.log

echo.>> uninstall.log
echo ***************************************** >> uninstall.log
echo Oracle Providers for ASP.NET unconfigured >> uninstall.log
echo ***************************************** >> uninstall.log
echo.>> uninstall.log

REM echo ASP.NET Providers are now unconfigured.


goto :EOF



REM ******************************
REM UNCONFIGURE ASPNET Providers 4
REM ******************************

:asp.net4

echo ******************************************** >> uninstall.log
echo Unconfiguring Oracle Providers for ASP.NET 4 >> uninstall.log
echo ******************************************** >> uninstall.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v4.0.30319\*.* (

REM *****************************************************************
REM REMOVE ALL LANGUAGE SPECIFIC ASP.NET 4 RESOURCE DLLS FROM THE GAC
REM *****************************************************************
"%BATCH_DIR%"asp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Oracle.Web.resources, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove the aspnet provider policy dll from the GAC
"%BATCH_DIR%"asp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Policy.4.112.Oracle.Web, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove the aspnet provider assembly from the GAC
"%BATCH_DIR%"asp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Oracle.Web, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Remove machine.config entries for Oracle Providers for ASP.NET 4
"%BATCH_DIR%"asp.net\bin\4\OraProvCfg.exe /action:unconfig /product:aspnet /frameworkversion:v4.0.30319 /component:all >> uninstall.log

)

echo Delete the registry entry to remove managed assembly in the Add Reference Dialog box in VS.NET >> uninstall.log
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\ASP.Net" /f >> uninstall.log

echo.>> uninstall.log
echo ******************************************* >> uninstall.log
echo Oracle Providers for ASP.NET 4 unconfigured >> uninstall.log
echo ******************************************* >> uninstall.log
echo.>> uninstall.log

REM echo ASP.NET Providers 4 are now unconfigured.


goto :EOF




REM ***********************
REM UNCONFIGURE ODP.NET 2.0
REM ***********************

:odp.net20

echo *********************************************** >> uninstall.log
echo Unconfiguring Oracle Data Provider for .NET 2.0 >> uninstall.log
echo *********************************************** >> uninstall.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v2.0.50727\*.* (

REM ***************************************************************
REM REMOVE ALL LANGUAGE SPECIFIC ODP.NET RESOURCE DLLS FROM THE GAC
REM ***************************************************************
"%BATCH_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Oracle.DataAccess.resources, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Unregister the counters
"%BATCH_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:unregister /product:odp /component:perfcounter /providerpath:"%BATCH_DIR%odp.net\bin\2.x\Oracle.DataAccess.dll" >> uninstall.log

REM remove odp section handler from machine.config for Framework 2.0
"%BATCH_DIR%"\odp.net\bin\2.x\OraProvCfg.exe /action:unconfig /product:odp /frameworkversion:v2.0.50727 >> uninstall.log

REM remove the odp 2.x publisher policy in the GAC
"%BATCH_DIR%"\odp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Policy.2.102.Oracle.DataAccess, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log
"%BATCH_DIR%"\odp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Policy.2.111.Oracle.DataAccess, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log
"%BATCH_DIR%"\odp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Policy.2.112.Oracle.DataAccess, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM remove the odp 2.x assembly in the GAC
"%BATCH_DIR%"\odp.net\bin\2.x\OraProvCfg.exe /action:ungac /providerpath:"Oracle.DataAccess, Version=2.112.4.0,processorArchitecture=AMD64" >> uninstall.log

)

REM remove registry entries for ODP.NET 2.x
echo Windows Registry Editor Version 5.00                     >  "%BATCH_DIR%"\odp.net.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET\2.112.4.0]  >> "%BATCH_DIR%"\odp.net.reg
	
regedit /s "%BATCH_DIR%\odp.net.reg"
del /q "%BATCH_DIR%\odp.net.reg"

echo Delete the registry entry to remove managed assembly in the Add Reference Dialog box in VS.NET >> uninstall.log
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\ODP.Net" /f >> uninstall.log

echo.>> uninstall.log
echo ********************************************** >> uninstall.log
echo Oracle Data Provider for .NET 2.0 unconfigured >> uninstall.log
echo ********************************************** >> uninstall.log
echo.>> uninstall.log

REM echo ODP.NET 2.x is now unconfigured.
goto :EOF



REM *********************
REM UNCONFIGURE ODP.NET 4
REM *********************

:odp.net4

echo ********************************************* >> uninstall.log
echo Unconfiguring Oracle Data Provider for .NET 4 >> uninstall.log
echo ********************************************* >> uninstall.log


REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v4.0.30319\*.* (

REM ***************************************************************
REM REMOVE ALL LANGUAGE SPECIFIC ODP.NET RESOURCE DLLS FROM THE GAC
REM ***************************************************************
"%BATCH_DIR%"odp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Oracle.DataAccess.resources, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM Unregister the counters
"%BATCH_DIR%"odp.net\bin\4\OraProvCfg.exe /action:unregister /product:odp /component:perfcounter /providerpath:"%BATCH_DIR%odp.net\bin\4\Oracle.DataAccess.dll" >> uninstall.log

REM remove odp section handler from machine.config for Framework 4
"%BATCH_DIR%"\odp.net\bin\4\OraProvCfg.exe /action:unconfig /product:odp /frameworkversion:v4.0.30319 >> uninstall.log

REM remove the odp 4 publisher policy in the GAC
"%BATCH_DIR%"\odp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Policy.4.112.Oracle.DataAccess, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

REM remove the odp 4 assembly in the GAC
"%BATCH_DIR%"\odp.net\bin\4\OraProvCfg.exe /action:ungac /providerpath:"Oracle.DataAccess, Version=4.112.4.0,processorArchitecture=AMD64" >> uninstall.log

)

REM remove registry entries for ODP.NET 4
echo Windows Registry Editor Version 5.00                     >  "%BATCH_DIR%"\odp.net.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET\4.112.4.0]  >> "%BATCH_DIR%"\odp.net.reg
	
regedit /s "%BATCH_DIR%\odp.net.reg"
del /q "%BATCH_DIR%\odp.net.reg"

echo Delete the registry entry to remove managed assembly in the Add Reference Dialog box in VS.NET >> uninstall.log
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\ODP.Net" /f >> uninstall.log

echo.>> uninstall.log
echo ******************************************** >> uninstall.log
echo Oracle Data Provider for .NET 4 unconfigured >> uninstall.log
echo ******************************************** >> uninstall.log
echo.>> uninstall.log

REM echo ODP.NET 4 is now unconfigured.
goto :EOF



REM ***************************
REM UNCONFIGURE OLEDB 
REM ***************************

:oledb

echo **************************************** >> uninstall.log
echo Unconfiguring Oracle Provider for OLE DB >> uninstall.log
echo **************************************** >> uninstall.log

REM Add <Oracle Home> to the PATH environment variable
set PATH=%BATCH_DIR%;%BATCH_DIR%bin;%PATH%

REM Unregister the OLEDB provider
regsvr32 /s /u "%BATCH_DIR%bin\OraOLEDB11.dll"

REM remove OLEDB registry entries
echo Windows Registry Editor Version 5.00                     >  "%BATCH_DIR%"\oledb.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_%ohname%]              >> "%BATCH_DIR%"\oledb.reg
echo "OLEDB"=-                                                >> "%BATCH_DIR%"\oledb.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_%ohname%\OLEDB]       >> "%BATCH_DIR%"\oledb.reg
	
regedit /s "%BATCH_DIR%\oledb.reg"
del     /q "%BATCH_DIR%\oledb.reg"

echo.>> uninstall.log
echo *************************************** >> uninstall.log
echo Oracle Provider for OLE DB unconfigured >> uninstall.log
echo *************************************** >> uninstall.log
echo.>> uninstall.log

REM echo OLEDB Provider are now unconfigured.


goto :EOF





REM ******************
REM UNCONFIGURE ORAMTS 
REM ******************

:oramts

echo ************************************* >> uninstall.log
echo Unconfiguring Oracle Services for MTS >> uninstall.log
echo ************************************* >> uninstall.log

rem set some local env vars used by genreg, etc.
set reg_file=%temp%\clean_registry.reg

echo Deleting OracleMTSRecoveryService .... >> uninstall.log
sc.exe stop   OracleMTSRecoveryService > NUL 2>&1
sc.exe delete OracleMTSRecoveryService >> uninstall.log

echo Cleaning up registry entries for OraMTS .... >> uninstall.log
call "%BATCH_DIR%"\oramts\install\genreg.bat deinstall %ohname% > %reg_file%
regedit -s %reg_file%
echo Registry entries for OraMTS cleaned up successfully >> uninstall.log

del %reg_file%

echo.>> uninstall.log
echo ************************************ >> uninstall.log
echo Oracle Services for MTS unconfigured >> uninstall.log
echo ************************************ >> uninstall.log
echo.>> uninstall.log

REM echo ORAMTS is now unconfigured.


goto :EOF



REM =======================
REM Parse Script Arguments
REM =======================
:ParseArgs
if /i {%1} == {} goto :Usage
if /i {%2} == {} goto :Usage
if /i {%1} == {-h} goto :Usage
if /i {%1} == {-help} goto :Usage

set FILE=%~pf0
if not exist "%FILE%" goto :eof
set BATCH_DIR=%~pd0

set ohname=%2

if EXIST %2\oracle.key goto :get_oraclehomename
goto :continue

:get_oraclehomename
for /f "delims=_ tokens=1,*" %%i in ('type %ohname%\oracle.key') do set ohname=%%j

:continue


if /i {%1} == {odp.net20} goto :odp.net20
if /i {%1} == {odp.net2}  goto :odp.net20
if /i {%1} == {odp.net4}  goto :odp.net4
if /i {%1} == {asp.net}   goto :asp.net
if /i {%1} == {asp.net2}  goto :asp.net
if /i {%1} == {asp.net4}  goto :asp.net4
if /i {%1} == {oledb}     goto :oledb
if /i {%1} == {oramts}    goto :oramts
if /i {%1} == {all}       goto :UnconfigureAll
goto :Usage



:Usage
echo.
echo Usage:
echo   unconfigure.bat component_name oracle_home_name
echo   or
echo   unconfigure.bat component_name oracle_home_path
echo.
echo Example:
echo   unconfigure.bat all       myhome     (unconfigure all components)
echo   unconfigure.bat odp.net2  myhome     (unconfigure ODP.NET 2)
echo   unconfigure.bat odp.net4  myhome     (unconfigure ODP.NET 4)
echo   unconfigure.bat asp.net2  myhome     (unconfigure ASP.NET Providers 2)
echo   unconfigure.bat asp.net4  myhome     (unconfigure ASP.NET Providers 4)
echo   unconfigure.bat oledb     c:\oracle  (unconfigure OLEDB Providers)
echo   unconfigure.bat oramts    c:\oracle  (unconfigure ORAMTS)
goto :EOF
