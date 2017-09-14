@echo off
REM ====================================
REM ODAC 11.2.0.4.0 XCOPY INSTALL SCRIPT
REM ====================================
REM 
REM  This batch file installs components in an Oracle Instant Client Home
REM 
REM  ====================
REM  MODIFICATION HISTORY
REM  ====================
REM  
REM  06/04/12 - change version number to 11.2.0.4.0
REM  11/02/11 - change version number to 11.2.0.3.0
REM  11/15/10 - change version number to 11.2.0.2.1
REM  06/30/10 - change version number to 11.2.0.1.2
REM             Add ODP.NET 4 and ASP.NET 4 components
REM  08/21/09 - change version number to 11.1.0.7.20
REM  08/21/09 - remove component odp.net 1.x
REM  01/22/08 - Handle directory names with spaces
REM  01/22/08 - Fixed oracle.key file generation so that products that rely on
REM             it can reference the appropriate registry location 
REM  01/22/08 - Log all xcopy operations to the install.log in the destination
REM             directory

goto :ParseArgs


REM **********************
REM INSTALL ALL COMPONENTS
REM **********************
:InstallAll
REM installing everything so set DEP to false or else dependencies such as 
REM basic client will get installed needlessly by each component
set DEP=false
call :basic %1 %2 %3 %4
call :odp.net20 %1 %2 %3 %4
call :odp.net4 %1 %2 %3 %4
call :asp.net %1 %2 %3 %4
call :asp.net4 %1 %2 %3 %4
call :oledb %1 %2 %3 %4
call :oramts %1 %2 %3 %4
goto :EOF


REM ************************
REM INSTALL ASPNET Providers
REM ************************

:asp.net

REM echo Please wait... installing Oracle Providers for ASP.NET

if {%DEP%} == {true} (
call :odp.net20 %1 %2 %3 %4
)

echo *************************************** >> %2\install.log
echo Installing Oracle Providers for ASP.NET >> %2\install.log
echo *************************************** >> %2\install.log

REM copy the files
xcopy asp.net %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

REM pass in false for dependency because odp.net2x files are not copied over yet
REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat asp.net %3 false

call configure.bat asp.net %3 false

popd

echo.>> %2\install.log
echo ************************************** >> %2\install.log
echo Oracle Providers for ASP.NET installed >> %2\install.log
echo ************************************** >> %2\install.log
echo.>> %2\install.log

REM echo Oracle Providers for ASP.NET installed in an Oracle Instant Client Home.

goto :EOF



REM **************************
REM INSTALL ASPNET Providers 4
REM **************************

:asp.net4

REM echo Please wait... installing Oracle Providers for ASP.NET 4

if {%DEP%} == {true} (
call :odp.net4 %1 %2 %3 %4
)

echo ***************************************** >> %2\install.log
echo Installing Oracle Providers for ASP.NET 4 >> %2\install.log
echo ***************************************** >> %2\install.log

REM copy the files
xcopy asp.net4 %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

REM pass in false for dependency because odp.net4 files are not copied over yet
REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat asp.net4 %3 false

call configure.bat asp.net4 %3 false

popd

echo.>> %2\install.log
echo **************************************** >> %2\install.log
echo Oracle Providers for ASP.NET 4 installed >> %2\install.log
echo **************************************** >> %2\install.log
echo.>> %2\install.log

REM echo Oracle Providers for ASP.NET 4 installed in an Oracle Instant Client Home.

goto :EOF




REM *******************
REM INSTALL ODP.NET 2.0
REM *******************

:odp.net20

REM echo Please wait... installing Oracle Data Provider for .NET 2.0

if {%DEP%} == {true} (
call :basic %1 %2 %3 %4
)

echo ******************************************** >> %2\install.log
echo Installing Oracle Data Provider for .NET 2.0 >> %2\install.log
echo ******************************************** >> %2\install.log

REM copy the files
xcopy odp.net20 %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat odp.net20 %3

call configure.bat odp.net20 %3

popd

echo.>> %2\install.log
echo ******************************************* >> %2\install.log
echo Oracle Data Provider for .NET 2.0 installed >> %2\install.log
echo ******************************************* >> %2\install.log
echo.>> %2\install.log
REM echo Oracle Data Provider for .NET 2.0 installed in an Oracle Instant Client Home.

goto :EOF



REM *****************
REM INSTALL ODP.NET 4
REM *****************

:odp.net4

REM echo Please wait... installing Oracle Data Provider for .NET 4

if {%DEP%} == {true} (
call :basic %1 %2 %3 %4
)

echo ****************************************** >> %2\install.log
echo Installing Oracle Data Provider for .NET 4 >> %2\install.log
echo ****************************************** >> %2\install.log

REM copy the files
xcopy odp.net4 %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat odp.net4 %3

call configure.bat odp.net4 %3

popd

echo.>> %2\install.log
echo ***************************************** >> %2\install.log
echo Oracle Data Provider for .NET 4 installed >> %2\install.log
echo ***************************************** >> %2\install.log
echo.>> %2\install.log
REM echo Oracle Data Provider for .NET 4 installed in an Oracle Instant Client Home.

goto :EOF




REM *************
REM INSTALL OLEDB
REM *************

:oledb

REM echo Please wait... installing Oracle Provider for OLEDB

if {%DEP%} == {true} (
call :basic %1 %2 %3 %4
)

echo ************************************* >> %2\install.log
echo Installing Oracle Provider for OLE DB >> %2\install.log
echo ************************************* >> %2\install.log

REM copy the files
xcopy oledb %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat oledb %3

call configure.bat oledb %3

popd

echo.>> %2\install.log
echo ************************************ >> %2\install.log
echo Oracle Provider for OLE DB installed >> %2\install.log
echo ************************************ >> %2\install.log
echo.>> %2\install.log
REM echo Oracle Provider for OLEDB installed in an Oracle Instant Client Home.

goto :EOF





REM **************
REM INSTALL ORAMTS
REM **************

:oramts

REM echo Please wait... installing Oracle Services for MTS

if {%DEP%} == {true} (
call :basic %1 %2 %3 %4
)

echo ********************************** >> %2\install.log
echo Installing Oracle Services for MTS >> %2\install.log
echo ********************************** >> %2\install.log

REM copy the files
xcopy oramts %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2


REM not calling confifure.bat as follows since on Win2k when dir names contain 
REM a space it has issues when retreiving CURRENT DIR in configure.bat
REM call %2\configure.bat oramts %3

call configure.bat oramts %3

popd

echo.>> %2\install.log
echo ********************************* >> %2\install.log
echo Oracle Services for MTS installed >> %2\install.log
echo ********************************* >> %2\install.log
echo.>> %2\install.log
REM echo Oracle Services for MTS installed in an Oracle Instant Client Home.

goto :EOF




REM ***********************************
REM INSTALL Basic Oracle Instant Client
REM ***********************************

:basic

REM echo Please wait... installing Basic Oracle Instant Client

echo ************************************** >> %2\install.log
echo Installing Basic Oracle Instant Client >> %2\install.log
echo ************************************** >> %2\install.log

REM copy the files
xcopy instantclient_11_2 %2 /E /F /R /Y >> %2\install.log

echo.>> %2\install.log

pushd %2

call configure.bat basic %3

popd

echo.>> %2\install.log
echo ************************************* >> %2\install.log
echo Basic Oracle Instant Client installed >> %2\install.log
echo ************************************* >> %2\install.log
echo.>> %2\install.log
REM echo Basic Oracle Instant Client installed.
REM echo.
REM echo Please prepend %2 and %2\bin to system path environment variable

goto :EOF



REM =======================
REM Parse Script Arguments
REM =======================
:ParseArgs
if /i {%1} == {} goto :Usage
if /i {%2} == {} goto :Usage
if /i {%3} == {} goto :Usage
if /i {%1} == {-h} goto :Usage
if /i {%1} == {-help} goto :Usage

REM install dependencies or not - default is true
set DEP=true
if /i {%4} == {false} set DEP=false

if NOT EXIST %2\*.* (
  mkdir %2 > NUL 2>&1
)

echo ****************** >> %2\install.log
echo ODAC install files >> %2\install.log
echo ****************** >> %2\install.log
REM /R to overwrite readonly files at destination
REM /Y to overwrite an existing file without prompting
xcopy configure.bat %2 /R /Y /F >> %2\install.log
xcopy unconfigure.bat %2 /R /Y /F >> %2\install.log
xcopy uninstall.bat %2 /R /Y /F >> %2\install.log
xcopy network\admin\sample\tnsnames.ora %2\network\admin\sample\ /R /Y /F >> %2\install.log
xcopy network\admin\sample\sqlnet.ora %2\network\admin\sample\ /R /Y /F >> %2\install.log

echo.>> %2\install.log

if /i {%1} == {basic}     goto :basic
if /i {%1} == {odp.net20} goto :odp.net20
if /i {%1} == {odp.net2}  goto :odp.net20
if /i {%1} == {odp.net4}  goto :odp.net4
if /i {%1} == {asp.net}   goto :asp.net
if /i {%1} == {asp.net2}  goto :asp.net
if /i {%1} == {asp.net4}  goto :asp.net4
if /i {%1} == {oledb}     goto :oledb
if /i {%1} == {oramts}    goto :oramts
if /i {%1} == {all}       goto :InstallAll
goto :Usage


:Usage
echo.
echo Usage:
echo   install.bat component_name oracle_home_path oracle_home_name [install_dependents]
echo.
echo Example:
echo   install.bat all       c:\oracle myhome       (install all components)
echo   install.bat odp.net2  c:\oracle myhome true  (install ODP.NET 2 and its dependent components)
echo   install.bat odp.net4  c:\oracle myhome true  (install ODP.NET 4 and its dependent components)
echo   install.bat asp.net2  c:\oracle myhome true  (install ASP.NET Providers 2 and its dependent components)
echo   install.bat asp.net4  c:\oracle myhome true  (install ASP.NET Providers 4 and its dependent components)
echo   install.bat oledb     c:\oracle myhome true  (install OraOLEDB and its dependent components)
echo   install.bat oramts    c:\oracle myhome true  (install ORAMTS and its dependent components)
echo   install.bat basic     c:\oracle myhome false (install Oracle Instant Client)
goto :EOF
