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
 
call unconfigure.bat asp.net %2 
 
del /f asp.net\bin\2.x\Oracle.Web.dll  2>nul
del /f asp.net\bin\2.x\OraProvCfg.exe  2>nul
del /f asp.net\bin\2.x\Resources\de\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\es\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\fr\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\it\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\ja\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\ko\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\pt-BR\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\zh-CHS\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\2.x\Resources\zh-CHT\Oracle.Web.resources.dll  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.Web.dll  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.Web.dll  2>nul
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
del /f asp.net\SQL\InstallOracleSessionState92.sql  2>nul
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
del /f asp.net\SQL\UninstallOracleSessionState92.sql  2>nul
del /f asp.net\SQL\UninstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\UninstallOracleWebEvents.sql  2>nul
) 
rmdir asp.net\PublisherPolicy\2.x 2>nul 
rmdir asp.net\bin\2.x\Resources\zh-CHT 2>nul 
rmdir asp.net\bin\2.x\Resources\zh-CHS 2>nul 
rmdir asp.net\bin\2.x\Resources\pt-BR 2>nul 
rmdir asp.net\bin\2.x\Resources\ko 2>nul 
rmdir asp.net\bin\2.x\Resources\ja 2>nul 
rmdir asp.net\bin\2.x\Resources\it 2>nul 
rmdir asp.net\bin\2.x\Resources\fr 2>nul 
rmdir asp.net\bin\2.x\Resources\es 2>nul 
rmdir asp.net\bin\2.x\Resources\de 2>nul 
rmdir asp.net\bin\2.x\Resources 2>nul 
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
 
call unconfigure.bat asp.net4 %2 
 
del /f asp.net\bin\4\Oracle.Web.dll  2>nul
del /f asp.net\bin\4\OraProvCfg.exe  2>nul
del /f asp.net\bin\4\Resources\de\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\es\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\fr\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\it\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\ja\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\ko\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\pt-BR\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\zh-CHS\Oracle.Web.resources.dll  2>nul
del /f asp.net\bin\4\Resources\zh-CHT\Oracle.Web.resources.dll  2>nul
del /f asp.net\PublisherPolicy\4\Policy.4.112.Oracle.Web.config  2>nul
del /f asp.net\PublisherPolicy\4\Policy.4.112.Oracle.Web.dll  2>nul
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
del /f asp.net\SQL\InstallOracleSessionState92.sql  2>nul
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
del /f asp.net\SQL\UninstallOracleSessionState92.sql  2>nul
del /f asp.net\SQL\UninstallOracleSiteMap.sql  2>nul
del /f asp.net\SQL\UninstallOracleWebEvents.sql  2>nul
) 
rmdir asp.net\PublisherPolicy\4 2>nul 
rmdir asp.net\bin\4\Resources\zh-CHT 2>nul 
rmdir asp.net\bin\4\Resources\zh-CHS 2>nul 
rmdir asp.net\bin\4\Resources\pt-BR 2>nul 
rmdir asp.net\bin\4\Resources\ko 2>nul 
rmdir asp.net\bin\4\Resources\ja 2>nul 
rmdir asp.net\bin\4\Resources\it 2>nul 
rmdir asp.net\bin\4\Resources\fr 2>nul 
rmdir asp.net\bin\4\Resources\es 2>nul 
rmdir asp.net\bin\4\Resources\de 2>nul 
rmdir asp.net\bin\4\Resources 2>nul 
rmdir asp.net\bin\4 2>nul 
rmdir asp.net\sql 2>nul 
rmdir asp.net\PublisherPolicy 2>nul 
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
 
call unconfigure.bat odp.net20 %2 
 
del /f odp.net\bin\2.x\Oracle.DataAccess.dll  2>nul
del /f odp.net\bin\2.x\OraProvCfg.exe  2>nul
del /f odp.net\bin\2.x\Resources\de\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\es\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\fr\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\it\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\ja\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\ko\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\pt-BR\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\zh-CHS\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\2.x\Resources\zh-CHT\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.102.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.102.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.111.Oracle.DataAccess.dll  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\2.x\Policy.2.112.Oracle.DataAccess.dll  2>nul
REM oraops11w.dll and readme.htm are common to both odp.net 2.x and odp.net 4 
REM Remove only if odp.net 4 is not present 
if NOT EXIST odp.net\bin\4\Oracle.DataAccess.dll ( 
del /f bin\OraOps11w.dll  2>nul
del /f odp.net\doc\readme.htm  2>nul
) 
rmdir odp.net\PublisherPolicy\2.x 2>nul 
rmdir odp.net\bin\2.x\Resources\zh-CHT 2>nul 
rmdir odp.net\bin\2.x\Resources\zh-CHS 2>nul 
rmdir odp.net\bin\2.x\Resources\pt-BR 2>nul 
rmdir odp.net\bin\2.x\Resources\ko 2>nul 
rmdir odp.net\bin\2.x\Resources\ja 2>nul 
rmdir odp.net\bin\2.x\Resources\it 2>nul 
rmdir odp.net\bin\2.x\Resources\fr 2>nul 
rmdir odp.net\bin\2.x\Resources\es 2>nul 
rmdir odp.net\bin\2.x\Resources\de 2>nul 
rmdir odp.net\bin\2.x\Resources 2>nul 
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
 
call unconfigure.bat odp.net4 %2 
 
del /f odp.net\bin\4\Oracle.DataAccess.dll  2>nul
del /f odp.net\bin\4\OraProvCfg.exe  2>nul
del /f odp.net\bin\4\Resources\de\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\es\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\fr\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\it\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\ja\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\ko\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\pt-BR\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\zh-CHS\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\bin\4\Resources\zh-CHT\Oracle.DataAccess.resources.dll  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.112.Oracle.DataAccess.config  2>nul
del /f odp.net\PublisherPolicy\4\Policy.4.112.Oracle.DataAccess.dll  2>nul
REM oraops11w.dll and readme.htm are common to both odp.net 2.x and odp.net 4 
REM Remove only if odp.net is not present 
if NOT EXIST odp.net\bin\2.x\Oracle.DataAccess.dll ( 
del /f bin\OraOps11w.dll  2>nul
del /f odp.net\doc\readme.htm  2>nul
) 
rmdir odp.net\PublisherPolicy\4 2>nul 
rmdir odp.net\bin\4\Resources\zh-CHT 2>nul 
rmdir odp.net\bin\4\Resources\zh-CHS 2>nul 
rmdir odp.net\bin\4\Resources\pt-BR 2>nul 
rmdir odp.net\bin\4\Resources\ko 2>nul 
rmdir odp.net\bin\4\Resources\ja 2>nul 
rmdir odp.net\bin\4\Resources\it 2>nul 
rmdir odp.net\bin\4\Resources\fr 2>nul 
rmdir odp.net\bin\4\Resources\es 2>nul 
rmdir odp.net\bin\4\Resources\de 2>nul 
rmdir odp.net\bin\4\Resources 2>nul 
rmdir odp.net\bin\4 2>nul 
rmdir odp.net\PublisherPolicy 2>nul 
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
if EXIST bin\OraOLEDB11.dll ( 
 
echo *************************************** >> uninstall.log 
echo Uninstalling Oracle Provider for OLE DB >> uninstall.log 
echo *************************************** >> uninstall.log 
 
call unconfigure.bat oledb %2 
 
del /f OraOledbIC11.dll  2>nul
del /f bin\OraOLEDB11.dll  2>nul
del /f bin\OraOLEDB11.tlb  2>nul
del /f bin\OraOLEDB11d.dll  2>nul
del /f bin\OraOLEDB11e.dll  2>nul
del /f bin\OraOLEDB11f.dll  2>nul
del /f bin\OraOLEDB11i.dll  2>nul
del /f bin\OraOLEDB11ja.dll  2>nul
del /f bin\OraOLEDB11ko.dll  2>nul
del /f bin\OraOLEDB11ptb.dll  2>nul
del /f bin\OraOLEDB11us.dll  2>nul
del /f bin\OraOLEDB11zhs.dll  2>nul
del /f bin\OraOLEDB11zht.dll  2>nul
del /f bin\OraOLEDBgmr11.dll  2>nul
del /f bin\OraOLEDBpus11.dll  2>nul
del /f bin\OraOLEDBrfc11.dll  2>nul
del /f bin\OraOLEDBrmc11.dll  2>nul
del /f bin\OraOLEDBrst11.dll  2>nul
del /f bin\OraOLEDButl11.dll  2>nul
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
if EXIST bin\oramts11.dll ( 
 
echo ************************************ >> uninstall.log 
echo Uninstalling Oracle Services for MTS >> uninstall.log 
echo ************************************ >> uninstall.log 
 
call unconfigure.bat oramts %2 
 
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
del /f bin\oramts11.dll  2>nul
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
del /f ocijdbc11.dll  2>nul
del /f ocijdbc11.sym  2>nul
del /f ociw32.dll  2>nul
del /f ociw32.sym  2>nul
del /f ojdbc5.jar  2>nul
del /f ojdbc6.jar  2>nul
del /f orannzsbb11.dll  2>nul
del /f orannzsbb11.sym  2>nul
del /f oraocci11.dll  2>nul
del /f oraocci11.sym  2>nul
del /f oraociei11.dll  2>nul
del /f oraociei11.sym  2>nul
del /f orasql11.dll  2>nul
del /f orasql11.sym  2>nul
del /f uidrvci.exe  2>nul
del /f uidrvci.sym  2>nul
del /f xstreams.jar  2>nul
del /f vc8\oraocci11.dll  2>nul
del /f vc8\oraocci11.sym  2>nul
del /f vc9\oraocci11.dll  2>nul
del /f vc9\oraocci11.sym  2>nul
rmdir vc9 2>nul 
rmdir vc8 2>nul 
 
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
echo   uninstall.bat component_name oracle_home_name 
echo   or 
echo   uninstall.bat component_name oracle_home_path 
echo. 
echo Example: 
echo   uninstall.bat all       myhome     (uninstall all components) 
echo   uninstall.bat odp.net2  myhome     (uninstall ODP.NET 2) 
echo   uninstall.bat odp.net4  myhome     (uninstall ODP.NET 4) 
echo   uninstall.bat asp.net2  myhome     (uninstall ASP.NET Providers 2) 
echo   uninstall.bat asp.net4  myhome     (uninstall ASP.NET Providers 4) 
echo   uninstall.bat oledb     c:\oracle  (uninstall OraOLEDB) 
echo   uninstall.bat oramts    c:\oracle  (uninstall ORAMTS) 
echo   uninstall.bat basic     myhome     (uninstall Oracle Instant Client) 
goto :EOF 
