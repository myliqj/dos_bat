@echo off
echo _db2cfgexec.cmd :db2cmd /c _db2cfg.bat db_name user pwd schema1 cfgflag

title ��ȡdb2���ݿ�������Ϣ

set flag=%5

:start_first
set ti=%time:~0,2%%time:~3,2%%time:~6,2%
rem ��������0�����  0:00:00 ��ʽ,����� 00:00:00��ʽ
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
echo ��ѡ��Ҫ���еĲ�����Ȼ�󰴻س� db_name=%1
echo ==============================
echo %dir%%dt%
echo 1.����db2look��ȡ
echo 2.����ȡdb cfg
echo 3.����ȡdbm cfg
echo 4.Ĭ��db cfg,db2look
echo 5.��ȡ��ǰ���ݿ���(��ʱ�������ݿ���Ч)
echo 6.��������(����5)
echo 7.����
echo 0.�˳�ϵͳ
echo.

:cho
set choice=
set /p choice= ��ѡ��:
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

echo �����������������  ����������: %choice%��
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
set ch2=findstr /N /R "Ӧ�ó����� Ӧ�ó����ʶ Ӧ�ó����� �������� ���� ��ʽ"
echo %ch% | %ch2% > %fl%
%ch% | %ch2% > %fl%

:dbconnreset
echo -- db2 connect reset
db2 connect reset

if %dbmcfgflag%==onlygetdblocks goto end
if %dbmcfgflag%==onlydbcfg goto end

:db2look
echo db2look ��ȡ������Ϣ����, -o ����ļ��Զ����滻��,����ŵ����
echo ��ȡ:-l�������ݿⲼ�֣����ݿ�����顢����غͱ�ռ�
set ch=db2look -d %db% -l -i %user% -w %pwd% -o %dt%_%db%_db2look_storage.sql
set fl=%dt%_%db%_db2look_storage.sql
echo ����:%ch%
%ch%
echo -- %ch% >> %fl%

echo ��ȡ:-f��ȡ���ò����ͻ�������
set fl=%dt%_%db%_db2look_config.sql
set ch=db2look -d %db% -f -fd -i %user% -w %pwd% -o %fl%
echo ����:%ch%
%ch%
echo -- %ch% >> %fl%

echo ��ȡ:-e��ȡ�������ݿ�����Ҫ�� DDL �ļ�
echo      -dp��ɾ�����,����ϵ��/����/�洢����/��/��ͼ��
set fl=%dt%_%db%_db2look_dll.sql
set ch=db2look -d %db% -e -dp -i %user% -w %pwd% -o %fl%
echo ����:%ch%
%ch%
echo -- %ch% >> %fl%

echo ��ȡ����(����):db2look -d %db% -e -dp -tYS_GRJBXX -i %user% -w %pwd% -o ex_tab_dll.sql

rem �˳�����,ѭ��
:end
rem pause >nul
rem pause
echo.
echo �������������,0��������,1�رմ���,2���¿�ʼ (����󰴻س�)
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
