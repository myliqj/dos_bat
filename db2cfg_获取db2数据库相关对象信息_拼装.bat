@echo off
echo _db2cfgexec.cmd :db2cmd /c _db2cfg.bat db_name user pwd schema1 "tabschema in ('DB2ADMIN')" all

title ��ȡdb2���ݿ�������Ϣ

rem set flag=%5

:start_first
set ti=%time:~0,2%%time:~3,2%%time:~6,2%
rem ��������0�����  0:00:00 ��ʽ,����� 00:00:00��ʽ
set ti1=%ti:~0,1%
if "%ti1%"==" " set ti=0%time:~1,1%%time:~3,2%%time:~6,2%
set s_dt=%date:~0,4%%date:~5,2%%date:~8,2%%ti%
set s_path=%cd%\
rem if not "%flag%"=="" goto db2_start
:start
rem cls
rem color 0c
rem MODE con: COLS=50 LINES=27

set s_ins_name=db2
set s_db_name=%1
set s_user=%2
set s_pwd=%3
set s_tab_schema=%4
rem set s_tab_schema_where=tabschema in %5
if "%s_tab_schema_where%"=="" set s_tab_schema_where=tabschema in ('DB2ADMIN','FSSI','FSSB','FSSI','GMSI','SSSI','%4')

echo 0=%0 1=%1 2=%2 3=%3 4=%4 5=%5 6=%6 7=%7 8=%8 9=%9

:title_menu
echo db2 ����
echo ^<1^>ϵͳ����         !db2support
echo ^<1.1^>�汾��                !db2level
echo ^<1.2^>ע�������            !db2set -all ,
echo                              [db]select * from sysibmadm.reg_variables,
echo                              select * from table(sysproc.reg_list_variables()) as registryinfo
echo ^<1.3^>admin����             get admin cfg
echo ^<1.4^>dbm����               get dbm cfg [show detail (db2start, attach to db2_instance_name)]
echo                              [db] select * from sysibmadm.dbmcfg
echo ^<1.5^>ʵ��,�ڵ�,Ŀ¼,���ݿ� list database directory ,select * from table(sysproc.env_get_inst_info()) as a
echo ^<2^>���ݿ�                  !db2look ,[db] select * from sysibmadm.objectowners
echo ^<2.1^>db����                get db cfg for db_name [show detail (connect to db)]/attach to xx
echo                              [db] select * from sysibmadm.dbcfg
echo ^<2.2^>�����ֵ�              tableschema:syscat,sysibm
echo ^<2.2.1^>��ṹ,����,Լ��    tables,columns,indexes,checks,colchecks
echo ^<2.2.2^>����,�洢����,��ͼ  routines(functions,procedures,views)
echo ^<2.2.3^>��������:ϵ��,������,��������,�¼�,��,��Ȩ
echo                              sequences,triggers,datatypes,events,packages,(tabauth,colauth)
echo ^<2.3^>�洢���
echo ^<2.3.1^>��ռ�              list tablespaces show detail ,syscat.tablespaces

goto main_menu

:in_put_ins_name
set old_value=%s_ins_name%
set /p s_ins_name= ������db2ʵ������(%old_value%):
if "%s_ins_name%"=="" set s_ins_name=%old_value%
goto main_menu

:in_put_db_name
set old_value=%s_db_name%
set /p s_db_name= ���������ݿ�����(%old_value%):
if "%s_db_name%"=="" set s_db_name=%old_value%
goto main_menu

:in_put_user
set old_value=%s_user%
set /p s_user= �������û���(%old_value%):
if "%s_user%"=="" set s_user=%old_value%
goto main_menu

:in_put_pwd
set old_value=%s_pwd%
set /p s_pwd= ����������(%old_value%):
if "%s_pwd%"=="" set s_pwd=%old_value%
goto main_menu

:in_put_tab_schema
set old_value=%s_tab_schema%
set /p s_tab_schema= ������ģʽ��(%old_value%):
if "%s_tab_schema%"=="" set s_tab_schema=%old_value%
goto main_menu

:in_put_tab_schema_where
set old_value=%s_tab_schema_where%
set /p s_tab_schema_where= ������ģʽ��(%old_value%):
if "%s_tab_schema_where%"=="" set s_tab_schema_where=%old_value%
goto main_menu

:main_menu
echo.
echo datetime=%s_dt%,  current path=%s_path%
echo db_name=%s_db_name%,  user=%s_user%,  pwd=%s_pwd%,  ins_name=%s_ins_name%
echo tab_schema=%s_tab_schema%
echo tab_schema_where=%s_tab_schema_where%
echo.
echo d.����¼�����ݿ���   u.����¼���û���       p.����¼������   i.����¼��db2ʵ������
echo s.����¼���ģʽ     w.����¼���ģʽ����   q.�˳�
echo 1.��ȡdbm cfg        2.��ȡdb cfg           3.��ȡdbm cfg + db cfg
echo.
set flag=
set in_str=
set /p in_str= ��ѡ��:
IF not "%in_str%"=="" set in_str=%in_str:~0,1%
IF "%in_str%"=="" goto cho
if "%in_str%"=="" goto main_menu
if "%in_str%"=="d" goto in_put_db_name
if "%in_str%"=="u" goto in_put_user
if "%in_str%"=="p" goto in_put_pwd
if "%in_str%"=="i" goto in_put_ins_name
if "%in_str%"=="s" goto in_put_tab_schema
if "%in_str%"=="w" goto in_put_tab_schema_where
if "%in_str%"=="q" goto end
if "%in_str%"=="1" set flag=onlydbm
if "%in_str%"=="2" set flag=onlydb
if "%in_str%"=="3" set flag=all
if not "%flag%"=="" goto db2_start
echo �����������������  ����������: %in_str%��
goto 	main_menu

:db2_start
if "%flag%"=="onlydbm" goto dbmcfg
if "%flag%"=="onlydb" goto dbconn
if not "%flag%"=="all" goto main_menu

rem get db2 dbm cfg, �����������ݿ�
rem version,reg cfg,get ? cfg,list ?
:dbmcfg
set fl=%s_dt%_dbm_cfg.txt
echo --start dt: %date% %time% >>%fl%

set ch=db2level
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2set -all
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 get instance
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 attach to %s_ins_name% user %s_user% using %s_pwd%
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

rem ����-���ݿ����
set ch=db2 get admin cfg
echo. >> %fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

rem ����-���ݿ����Ա
set ch=db2 get dbm cfg show detail
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

rem ���ӿ���-���ݿ�
set ch=db2 get monitor switches
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

rem ���ӿ���-���ݿ����
set ch=db2 get dbm monitor switches
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

rem ����
set ch=db2 get alert cfg for dbm
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 get cli cfg
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 get contacts
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list database directory
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list command options
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list system odbc data sources
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list user odbc data sources
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list admin node directory show detail
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

set ch=db2 list node directory show detail
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >>%fl%

echo --end dt: %date% %time% >>%fl%
rem dbmcfg end.

if %flag%==onlydbm goto end

:dbconn
set ch_conn=db2 connect to %s_db_name% user %s_user% using %s_pwd%
echo -- %ch_conn%
%ch_conn%

rem -----��������
rem goto db2look

rem get db2 db cfg

:dbcfg

set fl=%s_dt%_%s_db_name%_dbcfg.txt
echo --start dt: %date% %time% >>%fl%

set ch=db2 get db cfg for %s_db_name% show detail
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

set ch=db2 list tablespaces show detail
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

echo . >>%fl%
echo ����ϵͳ��� >>%fl%
rem set sql=select cast(os_name as varchar(30)) os_name,cast(os_version as varchar(15)) os_version,cast(os_release as varchar(30)) os_release,cast(host_name as varchar(40)) host_name,total_cpus,configured_cpus,total_memory from table(sysproc.env_get_sys_info()) as systeminfo
set sql=select cast('os_name=' concat value(os_name,'') concat chr(9) concat 'os_version=' concat value(os_version,'') concat chr(9) concat 'os_release=' concat value(os_release,'') concat chr(9) concat 'host_name=' concat value(host_name,'') concat chr(9) concat 'total_cpusconcat=' concat value(char(total_cpus),'') concat chr(9) concat 'configured_cpus=' concat value(char(configured_cpus),'') concat chr(9) concat 'total_memory=' concat value(char(total_memory),'') as varchar(100)) from table(sysproc.env_get_sys_info()) as systeminfo
set ch=db2 -x %sql%
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

rem �����
rem set sql=SELECT snapshot_timestamp, cast(tabschema as varchar(32)) tabschema, cast(tabname as varchar(32)) tabname, tab_type, data_object_pages, rows_written, dbpartitionnum  FROM TABLE(sysproc.snap_get_tab('%s_dbname%',-1)) AS tabinfo WHERE SUBSTR(tabschema,1,3) != 'SYS'
rem set ch=db2 %sql%
rem echo. >>%fl%
rem echo %ch% ^>^>%fl%
rem echo -- %ch% ^>^>%fl% >>%fl%
rem %ch% >> %fl%

echo --end dt: %date% %time% >>%fl%
rem dbcfg end.  file_name=%s_dt%_%s_db_name%_dbcfg.txt


:syscat_tables
set fl=%s_dt%_%s_db_name%_tables.txt
echo --start dt: %date% %time% >>%fl%

set sql=select int(rownumber() over()) totseq,a.tableid,a.type,int(rownumber() over(partition by a.type)) subseq
set sql=%sql% ,cast(a.tabschema as varchar(16)) tabschema,cast(a.tabname as varchar(32)) tabname,cast(ltrim(rtrim(value(a.remarks,''))) as varchar(150)) remarks
set sql=%sql% ,a.colcount,a.avgrowsize,a.create_time,a.stats_time,a.last_regen_time,cast(a.tbspace as varchar(32)) tbspace,cast(value(a.index_tbspace,'') as varchar(32)) index_tbspace,	a.keycolumns,a.keyunique
rem ,f_test_get_obj_lists('indnameoftab','1',a.tabschema,a.tabname,'','') pkname
rem ,f_test_get_obj_lists('colnameofind','1',a.tabschema,a.tabname,'','') pkcolnames
rem ,f_test_get_obj_lists('indnameoftab','4',a.tabschema,a.tabname,'','') idxnames
rem ,f_test_get_obj_lists('colnameofind','4',a.tabschema,a.tabname,'','') idxcolnames
set sql=%sql% ,a.card,a.fpages,a.npages
rem ,f_test_get_obj_lists('colnameoftab','',a.tabschema,a.tabname,'','') colnames
set sql=%sql% from syscat.tables a
set sql=%sql% where a.tabschema not in ('SYSIBM') and a.tabname not like 'EXPLAIN_^%'
if not "%s_tab_schema_where%"=="" set sql=%sql% and a.%s_tab_schema_where%
set sql=%sql% order by a.tabschema,a.type,a.tabname

set ch=db2 %sql%
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

:syscat_columns

rem --����,=44 �ֺ�;=59 ��.=46 ������'=39 ˫����"=34 ������(=40 ������)=41 ð��:=59 �ٷֺ�%=37
rem --Сд��ĸa=97 z=122 ��д��ĸA=65 Z=90 �Ⱥ�==61
rem select cast(c.tabschema as varchar(20)) tabschema,cast(c.tabname as varchar(32)) tabname,cast(c.colname as varchar(32))
rem  ,c.colno,
rem  cast(
rem    case when t.typeid = 16 then
rem         case when value(c.scale,0) != 0 then 'DECIMAL(' concat rtrim(char(c.length)) concat ',' concat rtrim(char(c.scale)) concat ')'
rem         else 'DECIMAL(' concat rtrim(char(c.length)) concat ')' end
rem       when t.typeid in (8, 10, 20, 24, 28, 52, 84, 100, 104, 108) then c.typename
rem       when t.typeid = 128 then 'DATALINK'
rem       when t.typeid in (44, 60, 56, 76, 88, 92, 124) then rtrim(c.typename) concat chr(40) concat rtrim(char(c.length)) concat chr(41)
rem       when t.typeid = 1 then 'REF(' concat chr(34) concat rtrim(c.target_typeschema) concat chr(34) concat '.' concat chr(34)
rem         concat rtrim(c.target_typename) concat chr(34) concat chr(41)
rem         else chr(34) concat rtrim(c.typeschema) concat chr(34) concat '.' concat chr(34) concat rtrim(c.typename) concat chr(34) end
rem    as varchar(32)) as datatype,
rem  c.nulls, cast(value(c.default,'') as varchar(40)) default, c.identity, c.generated,
rem  case when t.typeid in (60, 56, 52) and c.codepage = 0 THEN 'Y' else 'N' end as for_bit_data,
rem  cast(value(case when (t.typeid = 1) then chr(34) concat rtrim(scope_tabschema) concat chr(34) concat '.' concat chr(34) concat rtrim(scope_tabname) concat CHR(34)
rem  	               else NULL end,'') as varchar(32)) as scope,
rem c.keyseq, cast(c.remarks as varchar(150)) remarks
rem from syscat.columns c inner join syscat.datatypes t on (t.typeschema, t.typename) = (c.typeschema, c.typename)
rem  inner join syscat.tables d on (d.tabschema, d.tabname) = (c.tabschema, c.tabname)
rem where c.tabschema not in ('SYSIBM') and c.tabname not like 'EXPLAIN_%%' and d.type='T'
rem if not "%s_tab_schema_where%"=="" set sql=%sql% and c.%s_tab_schema_where%
rem set sql=%sql% order by c.tabschema,c.tabname,c.colno for fetch only with ur


set fl=%s_dt%_%s_db_name%_columns.txt
echo --start dt: %date% %time% >>%fl%

set sql=select cast(c.tabschema as varchar(20)) tabschema,cast(c.tabname as varchar(32)) tabname,cast(c.colname as varchar(32))
set sql=%sql%  ,c.colno,
set sql=%sql%  cast(
set sql=%sql%    case when t.typeid = 16 then
set sql=%sql%         case when value(c.scale,0) != 0 then 'DECIMAL(' concat rtrim(char(c.length)) concat ',' concat rtrim(char(c.scale)) concat ')'
set sql=%sql%         else 'DECIMAL(' concat rtrim(char(c.length)) concat ')' end
set sql=%sql%       when t.typeid in (8, 10, 20, 24, 28, 52, 84, 100, 104, 108) then c.typename
set sql=%sql%       when t.typeid = 128 then 'DATALINK'
set sql=%sql%       when t.typeid in (44, 60, 56, 76, 88, 92, 124) then rtrim(c.typename) concat chr(40) concat rtrim(char(c.length)) concat chr(41)
set sql=%sql%       when t.typeid = 1 then 'REF(' concat chr(34) concat rtrim(c.target_typeschema) concat chr(34) concat '.' concat chr(34)
set sql=%sql%         concat rtrim(c.target_typename) concat chr(34) concat chr(41)
set sql=%sql%         else chr(34) concat rtrim(c.typeschema) concat chr(34) concat '.' concat chr(34) concat rtrim(c.typename) concat chr(34) end
set sql=%sql%    as varchar(32)) as datatype,
set sql=%sql%  c.nulls, cast(value(c.default,'') as varchar(40)) default, c.identity, c.generated,
set sql=%sql%  case when t.typeid in (60, 56, 52) and c.codepage = 0 THEN 'Y' else 'N' end as for_bit_data,
set sql=%sql%  cast(value(case when (t.typeid = 1) then chr(34) concat rtrim(scope_tabschema) concat chr(34) concat '.' concat chr(34) concat rtrim(scope_tabname) concat CHR(34)
set sql=%sql%  	               else NULL end,'') as varchar(32)) as scope,
set sql=%sql% c.keyseq, cast(c.remarks as varchar(150)) remarks
set sql=%sql% from syscat.columns c inner join syscat.datatypes t on (t.typeschema, t.typename) = (c.typeschema, c.typename)
set sql=%sql%  inner join syscat.tables d on (d.tabschema, d.tabname) = (c.tabschema, c.tabname)
set sql=%sql% where c.tabschema not in ('SYSIBM') and c.tabname not like 'EXPLAIN_%%' and d.type='T'
if not "%s_tab_schema_where%"=="" set sql=%sql% and c.%s_tab_schema_where%
set sql=%sql% order by c.tabschema,c.tabname,c.colno for fetch only with ur

rem echo %sql% >>%fl%

set ch=db2 "%sql%"
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

echo --end dt: %date% %time% >>%fl%
rem file_name=%s_dt%_%s_db_name%_columns.txt

:export_del
set fl=%s_dt%_%s_db_name%_export_del.txt
echo --start dt: %date% %time% >>%fl%
rem --�������,od 13�س���0a 10����
set sql=select '--' concat repeat(' ',4-length(rtrim(char(rownumber() over())))) concat rtrim(char(rownumber() over())) concat ' '
set sql=%sql% concat value(replace(replace(remarks,x'0d',''),x'0a',''),'') concat x'0d0a'
set sql=%sql% concat 'export to ' concat rtrim(tabname) concat '.ixf of ixf messages export_ixf.msg.txt select * from ' concat rtrim(tabname) concat ';'
set sql=%sql% from syscat.tables
set sql=%sql% where tabschema not in ('SYSIBM') and tabname not like 'EXPLAIN_%%' and type='T'
if not "%s_tab_schema_where%"=="" set sql=%sql% and %s_tab_schema_where%
set sql=%sql% order by tabschema,type,tabname

rem -z a1.txt

set ch=db2 -x "%sql%"
echo. >>%fl%
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

echo --end dt: %date% %time% >>%fl%
rem file_name=%s_dt%_%s_db_name%_export_del.txt

:syscat_procedures
echo �洢����
set fl=%s_dt%_%s_db_name%_export_proc_list.sql
set proc_path=%s_dt%proc\
set sql=select 'get routine into  %proc_path%' concat rtrim(procschema) concat '.' concat rtrim(procname) concat '.sar from procedure ' concat rtrim(procschema) concat '.' concat rtrim(procname) concat ';'
set sql=%sql% from syscat.procedures t where procschema in ('DB2ADMIN','FSSB','FSSI','GMSI','SSSI') order by procschema,procname,create_time
set ch=db2 -x "%sql%"
rem get routine into procs/proc1.sar from procedure myappl.proc1

rem ���ɵ����ű�
echo %ch% ^>^>%fl%
echo -- %ch% ^>^>%fl% >>%fl%
%ch% >> %fl%

rem ִ�е����ű�:1����Ŀ¼,2ִ��
rem md c_dir\
rem db2 -tvf file.txt >>log.txt
set ch=md %proc_path%
echo %ch% ^>^>%fl%.log
echo %ch% ^>^>%fl%.log >>%fl%.log
%ch%

echo --start dt: %date% %time% >>%fl%.log
set ch=db2 -tvf %fl%
echo %ch% ^>^>%fl%.log
echo %ch% ^>^>%fl%.log >>%fl%.log
%ch% >>%fl%.log
echo --end dt: %date% %time% >>%fl%.log



rem echo if %dbmcfgflag%==nogetdblocks goto dbconnreset
rem echo if Not %dbmcfgflag%==all goto dbconnreset
rem
rem :getdblocks
rem
rem set fl=%dir%\%dt%_%db%_locks_all.txt
rem set ch=db2 get snapshot for locks on %db%
rem echo %ch% ^> %fl%
rem echo 2%ch% > %fl%
rem echo 2set fl=%dir%%dt%_%db%_locks_only_X.txt
rem echo 2set ch2=findstr /N /R "Ӧ�ó����� Ӧ�ó����ʶ Ӧ�ó����� �������� ���� ��ʽ"
rem echo 2echo %ch% | %ch2% > %fl%
rem echo 2%ch% | %ch2% > %fl%

:dbconnreset
echo db2 connect reset
db2 connect reset

:db2look

echo.
echo ��ȡ:-e��ȡ�������ݿ�����Ҫ�� DDL �ļ�, -td @ ��@�����������
echo      -dp��ɾ�����,����ϵ��/����/�洢����/��/��ͼ��
echo      -l�������ݿⲼ�֣����ݿ�����顢����غͱ�ռ�
echo      -f��ȡ���ò����ͻ�������
rem ֻ����ģʽ��=sssi,db2look -d o_fs -td @ -e -dp -z sssi -i sssi -w sssi -o sssi_ddl.txt

set fl=%s_dt%_%s_db_name%_db2look_dll.sql
echo ִ�нű�:db2 -td@ -vf %fl%

set ch=db2look -d %s_db_name% -td @ -e -dp -l -f -i %s_user% -w %s_pwd% -o %fl%
echo.
echo %ch%
%ch%
echo -- %ch% >> %fl%
echo --end dt: %date% %time% >>%fl%

goto end



rem echo db2look ��ȡ������Ϣ����, -o ����ļ��Զ����滻��,����ŵ����
rem echo ��ȡ:-l�������ݿⲼ�֣����ݿ�����顢����غͱ�ռ�
rem set ch=db2look -d %db% -l -i %user% -w %pwd% -o %dt%_%db%_db2look_storage.sql
rem set fl=%dt%_%db%_db2look_storage.sql
rem echo ����:%ch%
rem %ch%
rem echo -- %ch% >> %fl%
rem
rem echo ��ȡ:-f��ȡ���ò����ͻ�������
rem set fl=%dt%_%db%_db2look_config.sql
rem set ch=db2look -d %db% -f -fd -i %user% -w %pwd% -o %fl%
rem echo ����:%ch%
rem %ch%
rem echo -- %ch% >> %fl%
rem
rem echo ��ȡ:-e��ȡ�������ݿ�����Ҫ�� DDL �ļ�, -td @ ��@�����������
rem echo      -dp��ɾ�����,����ϵ��/����/�洢����/��/��ͼ��
rem set fl=%dt%_%db%_db2look_dll.sql
rem set ch=db2look -d %db% -td @ -e -dp -i %user% -w %pwd% -o %fl%
rem echo ����:%ch%
rem %ch%
rem echo -- %ch% >> %fl%
rem
rem echo ��ȡ����(����):db2look -d %db% -td @ -e -dp -tYS_GRJBXX -i %user% -w %pwd% -o ex_tab_dll.sql

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
