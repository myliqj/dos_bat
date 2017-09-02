@echo off
echo _db2cfgexec.cmd :db2cmd /c _db2cfg.bat db_name user pwd schema1 cfgflag

title 获取db2数据库配置信息

set flag=%5

:start_first
set ti=%time:~0,2%%time:~3,2%%time:~6,2%
rem 处理晚上0点情况  0:00:00 格式,处理成 00:00:00格式
set ti1=%ti:~0,1%
if "%ti1%"==" " set ti=0%time:~1,1%%time:~3,2%%time:~6,2%
set dt=%date:~0,4%%date:~5,2%%date:~8,2%%ti%
set dir=%cd%\
if Not "%flag%"=="" goto db2_start
:start
rem cls
rem color 0c
rem MODE con: COLS=50 LINES=27
echo.
echo ==============================
echo 请选择要进行的操作，然后按回车 db_name=%1
echo ==============================
echo %dir%%dt%
echo 1.仅用db2look提取
echo 2.仅获取db cfg
echo 3.仅获取dbm cfg
echo 4.默认db cfg,db2look
echo 5.获取当前数据库锁(暂时本地数据库有效)
echo 6.所有配置(不含5)
echo 7.所有
echo 0.退出系统
echo.

:cho
set choice=
set /p choice= 请选择:
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
IF "%Choice%"=="" goto cho
if /i %choice%==1 set flag=onlydb2look
if /i %choice%==2 set flag=onlydbcfg
if /i %choice%==3 set flag=onlydbmcfg
if /i %choice%==4 set flag=dbcfgdb2look
if /i %choice%==5 set flag=onlygetdblocks
if /i %choice%==6 set flag=nogetdblocks
if /i %choice%==7 set flag=all
if /i %choice%==0 goto end
if Not "%flag%"=="" goto db2_start

echo 输入错误，请重新输入  （您输入了: %choice%）
echo.
goto cho

:db2_start
rem _db2cfgexec.cmd :db2cmd /c _db2cfg.bat db_name user pwd schema1 cfgflag

set db=%1
set user=%2
set pwd=%3
set dbmcfgflag=%flag%
set tabschema_where=tabschema in ('DB2ADMIN','FSSI','FSSB','%4')

if %dbmcfgflag%==onlydb2look goto db2look
if %dbmcfgflag%==onlydbcfg goto dbconn
if %dbmcfgflag%==onlydbmcfg goto dbmcfg
if %dbmcfgflag%==all goto dbmcfg
if %dbmcfgflag%==onlygetdblocks goto dbconn

goto dbconn

rem get db2 dbm cfg
:dbmcfg
echo -- db2set -all^>^>%dt%_db2set.txt
db2set -all>>%dt%_db2set.txt
echo -- db2 attach to db2
echo -- db2 get dbm cfg show detail ^>^>%dt%_db2dbm_cfg.txt
db2 attach to db2
db2 get dbm cfg show detail >>%dt%_db2dbm_cfg.txt

if %dbmcfgflag%==onlydbmcfg goto end

:dbconn
echo -- db2 connect to %db% user %user% using %pwd%
db2 connect to %db% user %user% using %pwd%

if %dbmcfgflag%==onlygetdblocks goto getdblocks

rem get db2 db cfg
:dbcfg
set ch=db2 get db cfg for %db% show detail
set fl=%dt%_%db%_dbcfg.txt
echo -- %ch%
echo -- %ch% ^>^> %fl% >>%fl%
%ch% >> %fl%
set ch=db2 list tablespaces show detail
set fl=%dt%_%db%_tablespaces.txt
echo -- %ch%
echo -- %ch% ^>^> %fl% >>%fl%
%ch% >> %fl%

set ch="select cast('-- tabschema:'||rtrim(ltrim(a.tabschema))||' remarks:'||replace(replace(value(rtrim(ltrim(a.remarks)),''),x'0D',''),x'0A','')||x'0D0A'||'export to '||rtrim(ltrim(tabname))||'.del of del messages export_del.msg.txt select * from '||rtrim(ltrim(tabname))||';' as varchar(500)) from syscat.tables a where %tabschema_where%  and type = 'T' order by substr(rtrim(ltrim(tabname)),1,5)"
set fl=%dt%_%db%_export_del.sql
echo -- %ch%
echo -- db2 -x %ch% ^>^> %fl% >> %fl%
db2 -x %ch% >>%fl%

set ch="select 'load client from '||rtrim(ltrim(tabname))||'.del of del messages load_del.msg.txt insert into '||rtrim(ltrim(tabname))||' NONRECOVERABLE;' from syscat.tables a where %tabschema_where%  and type = 'T' order by substr(rtrim(ltrim(tabname)),1,5)"
set fl=%dt%_%db%_load_del.sql
echo -- %ch%
echo -- db2 -x %ch% ^>^> %fl% >> %fl%
db2 -x %ch% >>%fl%

set fl=%dt%_%db%_export_table_info.sql
set ch=db2 export to %fl% of del select  t.tabname,t.remarks,t.npages,t.fpages,t.card,t.owner,t.create_time,t.tableid,t.colcount,t.tbspace,t.index_tbspace,t.keycolumns,t.avgrowsize from syscat.tables t where %tabschema_where%  and type = 'T' order by npages desc,tabschema,tabname
echo %ch%
%ch%

if %dbmcfgflag%==nogetdblocks goto dbconnreset
if Not %dbmcfgflag%==all goto dbconnreset

:getdblocks

set fl=%dir%\%dt%_%db%_locks_all.txt
set ch=db2 get snapshot for locks on %db%
echo %ch% ^> %fl%
%ch% > %fl%
set fl=%dir%%dt%_%db%_locks_only_X.txt
set ch2=findstr /N /R "应用程序句柄 应用程序标识 应用程序名 对象类型 表名 方式"
echo %ch% | %ch2% > %fl%
%ch% | %ch2% > %fl%

:dbconnreset
echo -- db2 connect reset
db2 connect reset

if %dbmcfgflag%==onlygetdblocks goto end
if %dbmcfgflag%==onlydbcfg goto end

:db2look
echo db2look 获取数据信息工具, -o 输出文件自动被替换了,命令放到最后
echo 获取:-l生成数据库布局：数据库分区组、缓冲池和表空间
set ch=db2look -d %db% -l -i %user% -w %pwd% -o %dt%_%db%_db2look_storage.sql
set fl=%dt%_%db%_db2look_storage.sql
echo 命令:%ch%
%ch%
echo -- %ch% >> %fl%

echo 获取:-f抽取配置参数和环境变量
set fl=%dt%_%db%_db2look_config.sql
set ch=db2look -d %db% -f -fd -i %user% -w %pwd% -o %fl%
echo 命令:%ch%
%ch%
echo -- %ch% >> %fl%

echo 获取:-e抽取复制数据库所需要的 DDL 文件
echo      -dp加删除语句,包含系列/函数/存储过程/表/视图等
set fl=%dt%_%db%_db2look_dll.sql
set ch=db2look -d %db% -e -dp -i %user% -w %pwd% -o %fl%
echo 命令:%ch%
%ch%
echo -- %ch% >> %fl%

echo 获取单表(例子):db2look -d %db% -e -dp -tYS_GRJBXX -i %user% -w %pwd% -o ex_tab_dll.sql

rem 退出控制,循环
:end
rem pause >nul
rem pause
echo.
echo 任意键保留窗口,0到命令行,1关闭窗口,2重新开始 (输入后按回车)
:end_1
set choice=
set flag=
set /p choice=
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
IF "%Choice%"=="" goto end_1
if /i %choice%==0 goto end_2
if /i %choice%==1 goto exit_1
if /i %choice%==2 goto start_first
goto end_1
:exit_1
exit
:end_2
