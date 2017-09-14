@echo off 
REM ====================================================================== 
REM This batch file uninstalls components in an Oracle Instant Client Home 
REM ====================================================================== 
 
 
goto :ParseArgs 
 
 
 
REM ************************ 
REM UNINSTALL ALL COMPONENTS 
REM ************************ 
:UninstallAll 
 
call :odp.net20 %1 %2 
call :odp.net4 %1 %2 
call :asp.net %1 %2 
call :asp.net4 %1 %2 
call :oledb %1 %2 
call :oramts %1 %2 
call :basic %1 %2 
 
goto :EOF 
 
 
 
 
REM ************************** 
REM UNINSTALL ASPNET Providers 
REM ************************** 
 
:asp.net 
 
REM proceed only if component is installed 
if EXIST asp.net\bin\2.x\Oracle.Web.dll ( 
 
echo ***************************************** >> uninstall.log 
echo Uninstalling Oracle Providers for ASP.NET >> uninstall.log 
echo ***************************************** >> uninstall.log 
 
call unconfigure.bat asp.net %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f asp.net\bin\2.x\Oracle.Web.dll  2>nul
del /f asp.net\bin\2.x\OraProvCfg.exe  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.Web.dll  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.Web.dll  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.Web.dll  2>nul
REM SQL files are common to both asp.net and asp.net 4 
REM Remove only if asp.net 4 is not present 
if NOT EXIST asp.net\bin\4\Oracle.Web.dll ( 
del /f asp.net\doc\readme.htm  2>nul
del /f asp.net\SQL\InstallAllOracleASPNETProviders.sql  2>nul
del /f asp.net\SQL\InstallOracleASPNETCommon.sql  2>nul
del /f asp.net\SQL\InstallOracleASPNETCommonSP.plb  2>nul
del /f asp.net\SQL\InstallOracleMembership.sql  2>nul
del /f asp.net\SQL\InstallOracleMembershipSP.plb  2>nul
del /f asp.net\SQL\InstallOraclePersonalization.sql  2>nul
del /f asp.net\SQL\InstallOraclePersonalizationSP.plb  2>nul
del /f asp.net\SQL\InstallOracleProfile.sql  2>nul
del /f asp.net\SQL\InstallOracleProfileSP.plb  2>nul
del /f asp.net\SQL\InstallOracleRoles.sql  2>nul
del /f asp.net\SQL\InstallOracleRolesSP.plb  2>nul
del /f asp.net\SQL\InstallOracleSessionState.sql  2>nul
del /f asp.net\SQL\InstallOracleSessionStateSP.plb  2>nul
del /f asp.net\SQL\InstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\InstallOracleSiteMapSP.plb  2>nul
del /f asp.net\SQL\InstallOracleWebEvents.sql  2>nul
del /f asp.net\SQL\InstallOracleWebEventsSP.plb  2>nul
del /f asp.net\SQL\UninstallAllOracleASPNETProviders.sql  2>nul
del /f asp.net\SQL\UninstallOracleASPNETCommon.sql  2>nul
del /f asp.net\SQL\UninstallOracleMembership.sql  2>nul
del /f asp.net\SQL\UninstallOraclePersonalization.sql  2>nul
del /f asp.net\SQL\UninstallOracleProfile.sql  2>nul
del /f asp.net\SQL\UninstallOracleRoles.sql  2>nul
del /f asp.net\SQL\UninstallOracleSessionState.sql  2>nul
del /f asp.net\SQL\UninstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\UninstallOracleWebEvents.sql  2>nul
) 
rmdir asp.net\PublisherPolicy\2.x 2>nul 
rmdir asp.net\bin\2.x 2>nul 
rmdir asp.net\sql 2>nul 
rmdir asp.net\PublisherPolicy 2>nul 
rmdir asp.net\doc 2>nul 
rmdir asp.net\bin 2>nul 
rmdir asp.net 2>nul 
 
echo.>> uninstall.log 
echo **************************************** >> uninstall.log 
echo Oracle Providers for ASP.NET uninstalled >> uninstall.log 
echo **************************************** >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo ASP.NET Providers are now uninstalled in an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM **************************** 
REM UNINSTALL ASPNET Providers 4 
REM **************************** 
 
:asp.net4 
 
REM proceed only if component is installed 
if EXIST asp.net\bin\4\Oracle.Web.dll ( 
 
echo ******************************************* >> uninstall.log 
echo Uninstalling Oracle Providers for ASP.NET 4 >> uninstall.log 
echo ******************************************* >> uninstall.log 
 
call unconfigure.bat asp.net4 %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f asp.net\bin\4\Oracle.Web.dll  2>nul
del /f asp.net\bin\4\OraProvCfg.exe  2>nul
REM SQL files are common to both asp.net and asp.net 4 
REM Remove only if asp.net is not present 
if NOT EXIST asp.net\bin\2.x\Oracle.Web.dll ( 
del /f asp.net\doc\readme.htm  2>nul
del /f asp.net\SQL\InstallAllOracleASPNETProviders.sql  2>nul
del /f asp.net\SQL\InstallOracleASPNETCommon.sql  2>nul
del /f asp.net\SQL\InstallOracleASPNETCommonSP.plb  2>nul
del /f asp.net\SQL\InstallOracleMembership.sql  2>nul
del /f asp.net\SQL\InstallOracleMembershipSP.plb  2>nul
del /f asp.net\SQL\InstallOraclePersonalization.sql  2>nul
del /f asp.net\SQL\InstallOraclePersonalizationSP.plb  2>nul
del /f asp.net\SQL\InstallOracleProfile.sql  2>nul
del /f asp.net\SQL\InstallOracleProfileSP.plb  2>nul
del /f asp.net\SQL\InstallOracleRoles.sql  2>nul
del /f asp.net\SQL\InstallOracleRolesSP.plb  2>nul
del /f asp.net\SQL\InstallOracleSessionState.sql  2>nul
del /f asp.net\SQL\InstallOracleSessionStateSP.plb  2>nul
del /f asp.net\SQL\InstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\InstallOracleSiteMapSP.plb  2>nul
del /f asp.net\SQL\InstallOracleWebEvents.sql  2>nul
del /f asp.net\SQL\InstallOracleWebEventsSP.plb  2>nul
del /f asp.net\SQL\UninstallAllOracleASPNETProviders.sql  2>nul
del /f asp.net\SQL\UninstallOracleASPNETCommon.sql  2>nul
del /f asp.net\SQL\UninstallOracleMembership.sql  2>nul
del /f asp.net\SQL\UninstallOraclePersonalization.sql  2>nul
del /f asp.net\SQL\UninstallOracleProfile.sql  2>nul
del /f asp.net\SQL\UninstallOracleRoles.sql  2>nul
del /f asp.net\SQL\UninstallOracleSessionState.sql  2>nul
del /f asp.net\SQL\UninstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\UninstallOracleWebEvents.sql  2>nul
) 
rmdir asp.net\bin\4 2>nul 
rmdir asp.net\sql 2>nul 
rmdir asp.net\doc 2>nul 
rmdir asp.net\bin 2>nul 
rmdir asp.net 2>nul 
 
echo.>> uninstall.log 
echo ****************************************** >> uninstall.log 
echo Oracle Providers for ASP.NET 4 uninstalled >> uninstall.log 
echo ****************************************** >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo ASP.NET Providers 4 are now uninstalled in an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM ********************* 
REM UNINSTALL ODP.NET 2.0 
REM ********************* 
 
:odp.net20 
 
REM proceed only if component is installed 
if EXIST odp.net\bin\2.x\Oracle.DataAccess.dll ( 
 
echo ********************************************** >> uninstall.log 
echo Uninstalling Oracle Data Provider for .NET 2.0 >> uninstall.log 
echo ********************************************** >> uninstall.log 
 
call unconfigure.bat odp.net20 %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f odp.net\bin\2.x\Oracle.DataAccess.dll  2>nul
del /f odp.net\bin\2.x\OraProvCfg.exe  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.102.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.102.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.121.Oracle.DataAccess.dll  2>nul
REM oraops12.dll and readme.htm are common to both odp.net 2.x and odp.net 4 
REM Remove only if odp.net 4 is not present 
if NOT EXIST odp.net\bin\4\Oracle.DataAccess.dll ( 
del /f bin\OraOps12.dll  2>nul
del /f odp.net\doc\readme.htm  2>nul
) 
rmdir odp.net\PublisherPolicy\2.x 2>nul 
rmdir odp.net\bin\2.x 2>nul 
rmdir odp.net\PublisherPolicy 2>nul 
rmdir odp.net\doc 2>nul 
rmdir odp.net\bin 2>nul 
rmdir odp.net 2>nul 
rmdir bin 2>nul 
 
echo.>> uninstall.log 
echo ********************************************* >> uninstall.log 
echo Oracle Data Provider for .NET 2.0 uninstalled >> uninstall.log 
echo ********************************************* >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo ODP.NET 2.x now uninstalled in an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM ******************* 
REM UNINSTALL ODP.NET 4 
REM ******************* 
 
:odp.net4 
 
REM proceed only if component is installed 
if EXIST odp.net\bin\4\Oracle.DataAccess.dll ( 
 
echo ******************************************** >> uninstall.log 
echo Uninstalling Oracle Data Provider for .NET 4 >> uninstall.log 
echo ******************************************** >> uninstall.log 
 
call unconfigure.bat odp.net4 %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f odp.net\bin\4\Oracle.DataAccess.dll  2>nul
del /f odp.net\bin\4\OraProvCfg.exe  2>nul
del /f odp.net\bin\4\EF6\Oracle.DataAccess.EntityFramework.dll  2>nul
del /f odp.net\managed\common\Oracle.ManagedDataAccess.dll  2>nul
del /f odp.net\managed\common\EF6\Oracle.ManagedDataAccess.EntityFramework.dll  2>nul
del /f odp.net\managed\PublisherPolicy\4\Policy.4.121.Oracle.ManagedDataAccess.config  2>nul
del /f odp.net\managed\PublisherPolicy\4\Policy.4.121.Oracle.ManagedDataAccess.dll  2>nul
del /f odp.net\managed\x64\configure.bat  2>nul
del /f odp.net\managed\x64\Oracle.ManagedDataAccessDTC.dll  2>nul
del /f odp.net\managed\x64\Oracle.ManagedDataAccessIOP.dll  2>nul
del /f odp.net\managed\x64\OraProvCfg.exe  2>nul
del /f odp.net\managed\x64\unconfigure.bat  2>nul
del /f odp.net\managed\x86\configure.bat  2>nul
del /f odp.net\managed\x86\Oracle.ManagedDataAccessDTC.dll  2>nul
del /f odp.net\managed\x86\Oracle.ManagedDataAccessIOP.dll  2>nul
del /f odp.net\managed\x86\OraProvCfg.exe  2>nul
del /f odp.net\managed\x86\unconfigure.bat  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.112.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.112.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.121.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.121.Oracle.DataAccess.dll  2>nul
REM oraops12.dll and readme.htm are common to both odp.net 2.x and odp.net 4 
REM Remove only if odp.net is not present 
if NOT EXIST odp.net\bin\2.x\Oracle.DataAccess.dll ( 
del /f bin\OraOps12.dll  2>nul
del /f odp.net\doc\readme.htm  2>nul
) 
rmdir odp.net\PublisherPolicy\4 2>nul 
rmdir odp.net\managed\PublisherPolicy\4 2>nul 
rmdir odp.net\managed\common\EF6 2>nul 
rmdir odp.net\managed\x86 2>nul 
rmdir odp.net\managed\x64 2>nul 
rmdir odp.net\managed\PublisherPolicy 2>nul 
rmdir odp.net\managed\common 2>nul 
rmdir odp.net\bin\4\EF6 2>nul 
rmdir odp.net\bin\4 2>nul 
rmdir odp.net\PublisherPolicy 2>nul 
rmdir odp.net\managed 2>nul 
rmdir odp.net\doc 2>nul 
rmdir odp.net\bin 2>nul 
rmdir odp.net 2>nul 
rmdir bin 2>nul 
 
echo.>> uninstall.log 
echo ******************************************* >> uninstall.log 
echo Oracle Data Provider for .NET 4 uninstalled >> uninstall.log 
echo ******************************************* >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo ODP.NET 4 now uninstalled in an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM *************** 
REM UNINSTALL OLEDB 
REM *************** 
 
:oledb 
 
REM proceed only if component is installed 
if EXIST bin\OraOLEDB12.dll ( 
 
echo *************************************** >> uninstall.log 
echo Uninstalling Oracle Provider for OLE DB >> uninstall.log 
echo *************************************** >> uninstall.log 
 
call unconfigure.bat oledb %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f OraOledbIC12.dll  2>nul
del /f bin\OraOLEDB12.dll  2>nul
del /f bin\OraOLEDB12.tlb  2>nul
del /f bin\OraOLEDB12d.dll  2>nul
del /f bin\oraoledb12e.dll  2>nul
del /f bin\oraoledb12f.dll  2>nul
del /f bin\oraoledb12i.dll  2>nul
del /f bin\OraOLEDB12ja.dll  2>nul
del /f bin\OraOLEDB12ko.dll  2>nul
del /f bin\oraoledb12ptb.dll  2>nul
del /f bin\OraOLEDB12us.dll  2>nul
del /f bin\oraoledb12zhs.dll  2>nul
del /f bin\oraoledb12zht.dll  2>nul
del /f bin\OraOLEDBgmr12.dll  2>nul
del /f bin\OraOLEDBpus12.dll  2>nul
del /f bin\OraOLEDBrfc12.dll  2>nul
del /f bin\OraOLEDBrmc12.dll  2>nul
del /f bin\OraOLEDBrst12.dll  2>nul
del /f bin\OraOLEDButl12.dll  2>nul
del /f oledb\readme.htm  2>nul
rmdir oledb 2>nul 
rmdir bin 2>nul 
 
echo.>> uninstall.log 
echo ************************************** >> uninstall.log 
echo Oracle Provider for OLE DB uninstalled >> uninstall.log 
echo ************************************** >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo OLEDB now uninstalled from an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM **************** 
REM UNINSTALL ORAMTS 
REM **************** 
 
:oramts 
 
REM proceed only if component is installed 
if EXIST bin\oramts12.dll ( 
 
echo ************************************ >> uninstall.log 
echo Uninstalling Oracle Services for MTS >> uninstall.log 
echo ************************************ >> uninstall.log 
 
call unconfigure.bat oramts %2 %MACHINE_WIDE_UNCONFIG% 
 
del /f bin\omtsreco.exe  2>nul
del /f bin\omtsrecoevntd.dll  2>nul
del /f bin\omtsrecoevnte.dll  2>nul
del /f bin\omtsrecoevntf.dll  2>nul
del /f bin\omtsrecoevnti.dll  2>nul
del /f bin\omtsrecoevntja.dll  2>nul
del /f bin\omtsrecoevntko.dll  2>nul
del /f bin\omtsrecoevntptb.dll  2>nul
del /f bin\omtsrecoevntus.dll  2>nul
del /f bin\omtsrecoevntzhs.dll  2>nul
del /f bin\omtsrecoevntzht.dll  2>nul
del /f bin\omtsrecomsgus.dll  2>nul
del /f bin\oramts.dll  2>nul
del /f bin\oramts12.dll  2>nul
del /f bin\oramtsus.dll  2>nul
del /f oramts\admin\oramtsadmin.sql  2>nul
del /f oramts\admin\prvtoramts.plb  2>nul
del /f oramts\admin\utl_oramts.sql  2>nul
del /f oramts\doc\readme.txt  2>nul
del /f oramts\install\genreg.bat  2>nul
rmdir oramts\trace 2>nul 
rmdir oramts\install 2>nul 
rmdir oramts\doc 2>nul 
rmdir oramts\admin 2>nul 
rmdir oramts 2>nul 
rmdir bin 2>nul 
 
echo.>> uninstall.log 
echo *********************************** >> uninstall.log 
echo Oracle Services for MTS uninstalled >> uninstall.log 
echo *********************************** >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo ORAMTS now uninstalled from an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM ************************************* 
REM UNINSTALL Basic Oracle Instant Client 
REM ************************************* 
 
:basic 
 
REM proceed only if component is installed 
if EXIST oci.dll ( 
 
echo **************************************** >> uninstall.log 
echo Uninstalling Basic Oracle Instant Client >> uninstall.log 
echo **************************************** >> uninstall.log 
 
del /f adrci.exe  2>nul
del /f adrci.sym  2>nul
del /f BASIC_README  2>nul
del /f genezi.exe  2>nul
del /f genezi.sym  2>nul
del /f oci.dll  2>nul
del /f oci.sym  2>nul
del /f ocijdbc12.dll  2>nul
del /f ocijdbc12.sym  2>nul
del /f ociw32.dll  2>nul
del /f ociw32.sym  2>nul
del /f ojdbc8.jar  2>nul
del /f oramysql12.dll  2>nul
del /f oramysql12.sym  2>nul
del /f orannzsbb12.dll  2>nul
del /f orannzsbb12.sym  2>nul
del /f oraocci12.dll  2>nul
del /f oraocci12.sym  2>nul
del /f oraocci12d.dll  2>nul
del /f oraocci12d.sym  2>nul
del /f oraociei12.dll  2>nul
del /f oraociei12.sym  2>nul
del /f oraons.dll  2>nul
del /f orasql12.dll  2>nul
del /f orasql12.sym  2>nul
del /f uidrvci.exe  2>nul
del /f uidrvci.sym  2>nul
del /f xstreams.jar  2>nul
del /f vc14\oraocci12.dll  2>nul
del /f vc14\oraocci12.sym  2>nul
del /f vc14\oraocci12d.dll  2>nul
del /f vc14\oraocci12d.sym  2>nul
rmdir vc14 2>nul 
 
echo.>> uninstall.log 
echo *************************************** >> uninstall.log 
echo Basic Oracle Instant Client uninstalled >> uninstall.log 
echo *************************************** >> uninstall.log 
echo.>> uninstall.log 
) 
 
REM echo Basic Oracle Instant Client is now uninstalled in an Oracle Instant Client Home. 
 
goto :EOF 
 
 
 
 
 
 
REM ======================= 
REM Parse Script Arguments 
REM ======================= 
:ParseArgs 
if /i {%1} == {} goto :Usage 
if /i {%2} == {} goto :Usage 
if /i {%1} == {-h} goto :Usage 
if /i {%1} == {-help} goto :Usage 
 
REM unconfigure machine wide or not - default is false 
set MACHINE_WIDE_UNCONFIG=false 
if /i {%3} == {true} set MACHINE_WIDE_UNCONFIG=true 
 
if /i {%1} == {basic}     goto :basic 
if /i {%1} == {odp.net20} goto :odp.net20 
if /i {%1} == {odp.net2}  goto :odp.net20 
if /i {%1} == {odp.net4}  goto :odp.net4 
if /i {%1} == {asp.net}   goto :asp.net 
if /i {%1} == {asp.net2}  goto :asp.net 
if /i {%1} == {asp.net4}  goto :asp.net4 
if /i {%1} == {oledb}     goto :oledb 
if /i {%1} == {oramts}    goto :oramts 
if /i {%1} == {all}       goto :UninstallAll 
 
 
goto :Usage 
 
 
:Usage 
echo. 
echo Usage: 
echo   uninstall.bat component_name oracle_home_name [machine_wide_unconfiguration] 
echo   or 
echo   uninstall.bat component_name oracle_home_path [machine_wide_unconfiguration] 
echo. 
echo Example: 
echo   uninstall.bat all       myhome           (uninstall all components and do not unconfigure at machine wide level) 
echo   uninstall.bat odp.net2  myhome     true  (uninstall ODP.NET 2 and unconfigure at machine wide level) 
echo   uninstall.bat odp.net4  myhome           (uninstall ODP.NET 4) 
echo   uninstall.bat asp.net2  myhome           (uninstall ASP.NET Providers 2) 
echo   uninstall.bat asp.net4  myhome           (uninstall ASP.NET Providers 4) 
echo   uninstall.bat oledb     c:\oracle        (uninstall OraOLEDB) 
echo   uninstall.bat oramts    c:\oracle        (uninstall ORAMTS) 
echo   uninstall.bat basic     myhome           (uninstall Oracle Instant Client) 
echo. 
echo NOTE: By default, machine_wide_unconfiguration=false. 
goto :EOF 
