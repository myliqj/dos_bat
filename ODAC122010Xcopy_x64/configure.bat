@echo off

REM ======================================================================
REM This batch file configures components in an Oracle Instant Client Home
REM ======================================================================

goto :ParseArgs

REM ************************
REM CONFIGURE ALL COMPONENTS
REM ************************
:ConfigureAll
call :odp.net20
call :odp.net4
call :asp.net
call :asp.net4
call :oledb
call :oramts
goto :EOF



REM **************************
REM CONFIGURE ASPNET Providers
REM **************************

:asp.net

REM echo Please wait... configuring Oracle Providers for ASP.NET

echo **************************************** >> install.log
echo Configuring Oracle Providers for ASP.NET >> install.log
echo **************************************** >> install.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v2.0.50727\*.* (

if {%MACHINE_WIDE_CFG%} == {true} (

REM Enter the aspnet provider assembly in the GAC
"%BAT_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%asp.net\bin\2.x\Oracle.Web.dll" >> install.log

REM Enter the aspnet provider publisher policy in the GAC
"%BAT_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%asp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.Web.dll" >> install.log
"%BAT_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%asp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.Web.dll" >> install.log
"%BAT_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%asp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.Web.dll" >> install.log

REM Configure machine.config for Oracle Providers for ASP.NET
"%BAT_DIR%"asp.net\bin\2.x\OraProvCfg.exe /action:config /product:aspnet /frameworkversion:v2.0.50727 /productversion:2.122.1.0 /component:all >> install.log

 ) 
)

echo Create a registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\Oracle.Web" /ve /t REG_SZ /d %BAT_DIR%asp.net\bin\2.x /f >> install.log

echo.>> install.log
echo *************************************** >> install.log
echo Oracle Providers for ASP.NET configured >> install.log
echo *************************************** >> install.log
echo.>> install.log

REM echo Oracle Providers for ASP.NET configured in an Oracle Instant Client Home.

if {%DEPENDENT%} == {true} (
goto :odp.net20
) else (
goto :EOF
)



REM ****************************
REM CONFIGURE ASPNET Providers 4
REM ****************************

:asp.net4

REM echo Please wait... configuring Oracle Providers for ASP.NET 4

echo ****************************************** >> install.log
echo Configuring Oracle Providers for ASP.NET 4 >> install.log
echo ****************************************** >> install.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v4.0.30319\*.* (

if {%MACHINE_WIDE_CFG%} == {true} (

REM Enter the aspnet4 provider assembly in the GAC
"%BAT_DIR%"asp.net\bin\4\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%asp.net\bin\4\Oracle.Web.dll" >> install.log

REM Configure machine.config for Oracle Providers for ASP.NET4
"%BAT_DIR%"asp.net\bin\4\OraProvCfg.exe /action:config /product:aspnet /frameworkversion:v4.0.30319 /productversion:4.122.1.0 /component:all >> install.log
 ) 
)

echo Create a registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\Oracle.Web" /ve /t REG_SZ /d %BAT_DIR%asp.net\bin\4 /f >> install.log

echo.>> install.log
echo ***************************************** >> install.log
echo Oracle Providers for ASP.NET 4 configured >> install.log
echo ***************************************** >> install.log
echo.>> install.log

REM echo Oracle Providers for ASP.NET 4 configured in an Oracle Instant Client Home.

if {%DEPENDENT%} == {true} (
goto :odp.net4
) else (
goto :EOF
)





REM *********************
REM CONFIGURE ODP.NET 2.0
REM *********************

:odp.net20

REM echo Please wait... configuring Oracle Data Provider for .NET 2.0

echo ********************************************* >> install.log
echo Configuring Oracle Data Provider for .NET 2.0 >> install.log
echo ********************************************* >> install.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v2.0.50727\*.* (

if {%MACHINE_WIDE_CFG%} == {true} (

REM Enter the odp 2.x assembly in the GAC
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\bin\2.x\Oracle.DataAccess.dll" >> install.log

REM Enter the odp 2.x publisher policy in the GAC
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\2.x\Policy.2.102.Oracle.DataAccess.dll" >> install.log
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.DataAccess.dll" >> install.log
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.DataAccess.dll" >> install.log
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.DataAccess.dll" >> install.log

REM configure machine.config for Framework 2.x with proper section handler
"%BAT_DIR%"odp.net\bin\2.x\OraProvCfg.exe /action:config /product:odp /frameworkversion:v2.0.50727 /providerpath:"%BAT_DIR%odp.net\bin\2.x\Oracle.DataAccess.dll" >> install.log

 ) 
)

REM setup registry entries for ODP.NET 2.x
echo Windows Registry Editor Version 5.00                                     >  "%BAT_DIR%"\odp.net.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET]                             >> "%BAT_DIR%"\odp.net.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET\2.122.1.0]                   >> "%BAT_DIR%"\odp.net.reg
echo "DllPath"="%REG_DIR%bin"                                                 >> "%BAT_DIR%"\odp.net.reg
echo "PromotableTransaction"="promotable"                                     >> "%BAT_DIR%"\odp.net.reg
echo "StatementCacheWithUdts"="1"                                             >> "%BAT_DIR%"\odp.net.reg
echo "TraceLevel"="0"                                                         >> "%BAT_DIR%"\odp.net.reg
echo "TraceOption"="0"                                                        >> "%BAT_DIR%"\odp.net.reg
echo "PerformanceCounters"="0"                                                >> "%BAT_DIR%"\odp.net.reg
echo "UdtCacheSize"="4096"                                                    >> "%BAT_DIR%"\odp.net.reg
echo "DemandOraclePermission"="0"                                             >> "%BAT_DIR%"\odp.net.reg
echo "SelfTuning"="1"                                                         >> "%BAT_DIR%"\odp.net.reg
echo "MaxStatementCacheSize"="100"                                            >> "%BAT_DIR%"\odp.net.reg

regedit /s "%BAT_DIR%\odp.net.reg"
del /q "%BAT_DIR%\odp.net.reg"

echo Delete the old registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\Oracle.DataAccess\ 1>NUL 2>NUL
if %ERRORLEVEL% EQU 0 (
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\Oracle.DataAccess" /f 1>NUL 2>NUL
)

echo Create a registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727\AssemblyFoldersEx\ODP.Net" /ve /t REG_SZ /d %BAT_DIR%odp.net\bin\2.x /f >> install.log

echo.>> install.log
echo ******************************************** >> install.log
echo Oracle Data Provider for .NET 2.0 configured >> install.log
echo ******************************************** >> install.log
echo.>> install.log
REM echo Oracle Data Provider for .NET 2.0 configured in an Oracle Instant Client Home.

goto :EOF




REM *******************
REM CONFIGURE ODP.NET 4
REM *******************

:odp.net4

REM echo Please wait... configuring Oracle Data Provider for .NET 4

echo ******************************************* >> install.log
echo Configuring Oracle Data Provider for .NET 4 >> install.log
echo ******************************************* >> install.log

REM Check if .NET Framework exists
if EXIST "%SystemRoot%"\Microsoft.NET\Framework\v4.0.30319\*.* (

if {%MACHINE_WIDE_CFG%} == {true} (

REM Enter the odp 4 assembly in the GAC
"%BAT_DIR%"odp.net\bin\4\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\bin\4\Oracle.DataAccess.dll" >> install.log

REM Enter the odp 4 publisher policy in the GAC
"%BAT_DIR%"odp.net\bin\4\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\4\Policy.4.112.Oracle.DataAccess.dll" >> install.log
"%BAT_DIR%"odp.net\bin\4\OraProvCfg.exe /action:gac /providerpath:"%BAT_DIR%odp.net\PublisherPolicy\4\Policy.4.121.Oracle.DataAccess.dll" >> install.log

REM configure machine.config for Framework 4 with proper section handler
"%BAT_DIR%"odp.net\bin\4\OraProvCfg.exe /action:config /product:odp /frameworkversion:v4.0.30319 /providerpath:"%BAT_DIR%odp.net\bin\4\Oracle.DataAccess.dll" >> install.log

 ) 
)

REM setup registry entries for ODP.NET 4
echo Windows Registry Editor Version 5.00                                     >  "%BAT_DIR%"\odp.net.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET]                             >> "%BAT_DIR%"\odp.net.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\ODP.NET\4.122.1.0]                   >> "%BAT_DIR%"\odp.net.reg
echo "DllPath"="%REG_DIR%bin"                                                 >> "%BAT_DIR%"\odp.net.reg
echo "PromotableTransaction"="promotable"                                     >> "%BAT_DIR%"\odp.net.reg
echo "StatementCacheWithUdts"="1"                                             >> "%BAT_DIR%"\odp.net.reg
echo "TraceLevel"="0"                                                         >> "%BAT_DIR%"\odp.net.reg
echo "TraceOption"="0"                                                        >> "%BAT_DIR%"\odp.net.reg
echo "PerformanceCounters"="0"                                                >> "%BAT_DIR%"\odp.net.reg
echo "UdtCacheSize"="4096"                                                    >> "%BAT_DIR%"\odp.net.reg
echo "DemandOraclePermission"="0"                                             >> "%BAT_DIR%"\odp.net.reg
echo "SelfTuning"="1"                                                         >> "%BAT_DIR%"\odp.net.reg
echo "MaxStatementCacheSize"="100"                                            >> "%BAT_DIR%"\odp.net.reg

regedit /s "%BAT_DIR%\odp.net.reg"
del /q "%BAT_DIR%\odp.net.reg"

echo Delete the old registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\Oracle.DataAccess\ 1>NUL 2>NUL
if %ERRORLEVEL% EQU 0 (
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\Oracle.DataAccess" /f 1>NUL 2>NUL
)

echo Create a registry entry to add managed assembly in the Add Reference Dialog box in VS.NET >> install.log
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\ODP.Net" /ve /t REG_SZ /d %BAT_DIR%odp.net\bin\4 /f >> install.log
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319\AssemblyFoldersEx\Oracle.DataAccess.EntityFramework6" /ve /t REG_SZ /d %BAT_DIR%odp.net\bin\4\EF6 /f >> install.log

REM Configure ODP.NET Managed Provider
pushd %BAT_DIR%\odp.net\managed\x64
call configure.bat %MACHINE_WIDE_CFG% >> %BAT_DIR%\install.log
popd

echo.>> install.log
echo ****************************************** >> install.log
echo Oracle Data Provider for .NET 4 configured >> install.log
echo ****************************************** >> install.log
echo.>> install.log
REM echo Oracle Data Provider for .NET configured in an Oracle Instant Client Home.


goto :EOF



REM *********************
REM CONFIGURE OLEDB
REM *********************

:oledb

REM echo Please wait... configuring Oracle Provider for OLEDB

echo ************************************** >> install.log
echo Configuring Oracle Provider for OLE DB >> install.log
echo ************************************** >> install.log

REM Add <Oracle Home> to the PATH environment variable
set PATH=%BAT_DIR%;%BAT_DIR%bin;%PATH%

REM Register OraOLEDB DLL in the registry
regsvr32 /s "%BAT_DIR%bin\OraOLEDB12.dll"

REM setup registry entries for OLEDB
echo Windows Registry Editor Version 5.00                               >  "%BAT_DIR%"\oledb.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_%2]                        >> "%BAT_DIR%"\oledb.reg
echo "OLEDB"="%REG_DIR%oledb\\mesg"                                     >> "%BAT_DIR%"\oledb.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_%2\OLEDB]                  >> "%BAT_DIR%"\oledb.reg
echo "CacheType"="Memory"                                               >> "%BAT_DIR%"\oledb.reg
echo "ChunkSize"="100"                                                  >> "%BAT_DIR%"\oledb.reg
echo "DistribTX"="1"                                                    >> "%BAT_DIR%"\oledb.reg
echo "FetchSize"="100"                                                  >> "%BAT_DIR%"\oledb.reg
echo "OSAuthent"="0"                                                    >> "%BAT_DIR%"\oledb.reg
echo "PLSQLRset"="0"                                                    >> "%BAT_DIR%"\oledb.reg
echo "PwdChgDlg"="1"                                                    >> "%BAT_DIR%"\oledb.reg
echo "SchRstLng"="10000"                                                >> "%BAT_DIR%"\oledb.reg
echo "UserDefFn"="0"                                                    >> "%BAT_DIR%"\oledb.reg
echo "DisableRetClause"="1"                                             >> "%BAT_DIR%"\oledb.reg
echo "VCharNull"="1"                                                    >> "%BAT_DIR%"\oledb.reg
echo "TraceCategory"="0"                                                >> "%BAT_DIR%"\oledb.reg
echo "TraceLevel"="0"                                                   >> "%BAT_DIR%"\oledb.reg
echo "TraceOption"="0"                                                  >> "%BAT_DIR%"\oledb.reg
echo "SPPrmDefVal"="0"                                                  >> "%BAT_DIR%"\oledb.reg
echo "StmtCacheSize"="0"                                                >> "%BAT_DIR%"\oledb.reg
echo "MetaDataCacheSize"="0"                                            >> "%BAT_DIR%"\oledb.reg
echo "DBNotifications"="0"                                              >> "%BAT_DIR%"\oledb.reg
echo "DeferUpdChk"="0"                                                  >> "%BAT_DIR%"\oledb.reg
echo "EnableCmdTimeout"="0"                                             >> "%BAT_DIR%"\oledb.reg


regedit /s "%BAT_DIR%\oledb.reg"
del /q "%BAT_DIR%\oledb.reg"

echo.>> install.log
echo ************************************* >> install.log
echo Oracle Provider for OLE DB configured >> install.log
echo ************************************* >> install.log
echo.>> install.log
REM echo Oracle Provider for OLEDB configured in an Oracle Instant Client Home.

goto :EOF




REM ****************
REM CONFIGURE ORAMTS
REM ****************

:oramts

REM echo Please wait... configuring Oracle Services for MTS

echo *********************************** >> install.log
echo Configuring Oracle Services for MTS >> install.log
echo *********************************** >> install.log

REM Add <Oracle Home> to the PATH environment variable
set PATH=%BAT_DIR%;%BAT_DIR%bin;%PATH%

REM configure.bat will be run from the destination orcl_home dir
REM after oramts files have been copied over in the destination orcl_home dir
set src_dir=%BAT_DIR%
set dst_dir=%BAT_DIR%

set reco_username=%userdomain%\%username%
REM set some local env vars used by genreg, etc.
set orcl_home=%dst_dir%
set reco_port=2030
set reco_host=%computername%
set reco_password=
set reco_username=LocalSystem
set oramts_ver=12.1.0.2.0
set mts_svcname=Oracle%2MTSRecoveryService
set svc_binary="%orcl_home%bin\omtsreco.exe %mts_svcname%"
set inst_dir=%src_dir%\oramts\install
set reg_file=%temp%\setup_reg.reg

REM echo creating OracleMTSRecoveryService ....
sc.exe stop   %mts_svcname% > NUL 2>&1
sc.exe delete %mts_svcname% > NUL 2>&1
sc.exe create %mts_svcname% binpath= %svc_binary%  start= auto obj= "NT AUTHORITY\LOCAL SERVICE" DisplayName= %mts_svcname% >> install.log
REM OracleMTSRecoveryService was successfully created with the LOCAL SERVICE
REM account as the logon account. Make sure to change the logon  credentials 
REM of this service using the "services" administration tool. Please read the
REM README.TXT under %orcl_home%\oramts\doc.

REM creating registry entries for OraMTS ....
call "%inst_dir%"\genreg.bat install %2 > %reg_file%
regedit -s %reg_file%
REM echo created registry entries for OraMTS successfully

REM echo starting OracleMTSRecoveryService ...
REM net start  OracleMTSRecoveryService
REM echo started OracleMTSRecoveryService successfully

del %reg_file%

echo.>> install.log
echo ********************************** >> install.log
echo Oracle Services for MTS configured >> install.log
echo ********************************** >> install.log
echo.>> install.log
echo.
REM echo Oracle Services for MTS configured in an Oracle Instant Client Home.

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
set BAT_DIR=%~pd0
set REG_DIR=%BAT_DIR:\=\\%


REM setup common registry entries
echo Windows Registry Editor Version 5.00                         >  "%BAT_DIR%"\common.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_%2]                  >> "%BAT_DIR%"\common.reg
echo "ORACLE_HOME"="%REG_DIR%"                                    >> "%BAT_DIR%"\common.reg
echo "ORACLE_HOME_NAME"="%2"                                      >> "%BAT_DIR%"\common.reg
echo "ORACLE_GROUP_NAME"="Oracle - %2"                            >> "%BAT_DIR%"\common.reg
echo "NLS_LANG"="AMERICAN_AMERICA.WE8MSWIN1252"                   >> "%BAT_DIR%"\common.reg

regedit /s "%BAT_DIR%\common.reg"
del /q "%BAT_DIR%\common.reg"

REM not all components create bin dir and copy files over
if EXIST "%BAT_DIR%"\bin\*.* (
 echo SOFTWARE\ORACLE\KEY_%2> "%BAT_DIR%bin\oracle.key"
)
echo SOFTWARE\ORACLE\KEY_%2> "%BAT_DIR%oracle.key"

REM configure dependencies or not - default is true
REM note that this option really only applies to asp.net component
set DEPENDENT=true
if /i {%3} == {false} set DEPENDENT=false

REM configure machine wide or not - default is false
set MACHINE_WIDE_CFG=false
if /i {%4} == {true} set MACHINE_WIDE_CFG=true

REM Basic Instant Client does not require any additional configuration
REM other than the common configuration done above
if /i {%1} == {basic}     goto :EOF
if /i {%1} == {odp.net20} goto :odp.net20
if /i {%1} == {odp.net2}  goto :odp.net20
if /i {%1} == {odp.net4}  goto :odp.net4
if /i {%1} == {asp.net}   goto :asp.net
if /i {%1} == {asp.net2}  goto :asp.net
if /i {%1} == {asp.net4}  goto :asp.net4
if /i {%1} == {oledb}     goto :oledb
if /i {%1} == {oramts}    goto :oramts
if /i {%1} == {all}       goto :ConfigureAll
goto :Usage



:Usage
echo.
echo Usage:
echo   configure.bat component_name oracle_home_name [configure_dependents] [machine_wide_configuration]
echo.
echo Example:
echo   configure.bat all       myhome true       (configure all components, do not configure at the machine level)
echo   configure.bat odp.net2  myhome true true  (configure ODP.NET 2 and dependent components at the machine level)
echo   configure.bat odp.net4  myhome            (configure ODP.NET 4 and dependent components, configure at the machine level)
echo   configure.bat asp.net2  myhome true       (configure ASP.NET Providers 2 and its dependent components)
echo   configure.bat asp.net4  myhome true       (configure ASP.NET Providers 4 and its dependent components)
echo   configure.bat oledb     myhome            (configure OLEDB)
echo   configure.bat oramts    myhome            (configure ORAMTS)
echo   configure.bat basic     myhome            (configure Oracle Instant Client)
echo.
echo NOTE: By default, configure_dependents=true and machine_wide_configuration=false.
echo.
echo NOTE: In order to specify machine_wide_configuration, configure_dependents have to be specified.
goto :EOF
