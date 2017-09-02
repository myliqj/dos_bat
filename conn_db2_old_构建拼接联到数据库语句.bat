@rem echo off

@rem 参数：%1 本地数据库名（特定名称） %2 用户(可选) %3 密码(可选)

@set db_cs1=%1
@set db_cs2=%2
@set db_cs3=%3
@set db_cs4=%4
@set db_cs5=%5
@set db_cs6=%6

@set local_db2_schema_set=
@set local_db2_schema_path=


@set show_help=0
@if "%1" == "help" set show_help=1
@if "%1" == "?" set show_help=1

@if "%show_help%" == "1" (


  @echo.
  @echo ====================E:\_Config\exec_db\conn.bat=============== cd /d %~dp0 =====
  @echo 1、联接数据库：%%1本地数据库名（特定名称） %%2 用户（可选） %%3 密码（可选） -- 提供用户时必须提供密码
  @echo    conn fssbcs  , conn fssbcs ccyh fssiccyh
  @echo 2、java获取DDL：%%1标识（ddl/getddl/db2ddl）,%%2-4 数据库/用户/密码（同1）,%%2/4 模式名.对象名
  @echo    conn ddl fssbcs fssb.s_jdmb , conn ddl fssbcs ccyh fssiccyh fssb.s_jdmb
  @echo 3、db2look获取DDL:%%1标识db2look %%2-4数据库用户/密码（同1）%%3/5 表名 -o %%4/6 输出文件名（可选时按表名）
  @echo    conn db2look -d %%1 -td@ -i %%2 -w %%3 -e -noview -nofed -t s_jdmb -o s_jdmb_fssbcs.ddl 
  @echo 4、编目节点 CATALOG TCPIP NODE n_r_wsbs REMOTE 189.50.111.16 SERVER 50000
  @echo    db2 "CATALOG TCPIP NODE %db_cs2% REMOTE %db_cs3% SERVER %db_cs4%"
  @echo 5、编目数据库 Catalog db wsbscs at NODE n_r_wsbs
  @echo    db2 "CATALOG DB %db_cs2% at NODE %db_cs3%"
  @echo.
  @echo 9、其它标识：%%1=d/del 联开数据联接,%%1=s/status 查看当前数据库联接 ,%%1=?/help 查看帮助
  @echo    conn d , conn s , conn ?
  @echo.
  @echo    runstats on table fssb.CW_SYHDWSJ for detailed indexes all / for indexes all
  @echo    runstats on table fssb.T_SFZJ_DWJFMX for detailed indexes fssb.I_SFZJ_DWJFMX_PZX
  @echo    load from /dev/null ^| nul of del replace into fssb.LOG_TIME nonrecoverable
  @echo    %%1 jh :db2expln -d fslwzb -u fslwzb Fsdb2012 -g -c fslwzb -p %%2 -s 0 -t ^>c:\%%2.txt
  @echo            type c:\%%2.txt ^| find "Estimated Cost"
  @echo.    
  @echo    获取对象ddl，如果%%1属于 ddl/getddl/db2ddl ，则参数要求为：%%1标识,%%2 数据库/用户/密码,%%3 模式名.对象名
  @echo.
  @echo    open cd/cur -- c:\windows\explorer.exe %%2
  @echo.
  @echo    %%1  jh 
  @echo    %%1  list-db/list-n 
  goto all_end2;
)


@rem 判断是否获取对象ddl，如果%1属于 ddl/getddl/db2ddl ，则参数要求为：%1标识,%2 数据库/用户/密码,%3 模式名.对象名
@set obj_out_dir=d:\u32bak\
@set getddl=0
@if "%db_cs1%" == "ddl" set getddl=1
@if "%db_cs1%" == "getddl" set getddl=1
@if "%db_cs1%" == "db2ddl" set getddl=1

@rem 如果是获取ddl,跳过一个参数
@if "%getddl%" == "1" shift

@if "%db_cs_1%" == "open" ( 
  set exec_path=%db_cs_2%
  if "%db_cs_2%" == "cd" set exec_path=%cd%
  if "%db_cs_2%" == "cur" set exec_path=%cd%
  c:\windows\explorer.exe %exec_path%
)

@set db_name=%1
@set db_user=%1
@set db_pwd=%1

@if "%getddl%"== "0" (
  set db_user=%2
  set db_pwd=%3
)

@if "%db_cs4%" == "" (  
  @if "%getddl%"== "0" (
    set db_user=%1
    set db_pwd=%1
  )
) else (
  goto p_connect_db
)

@title %db_name%
@echo pro n %db_name%
@call pro n %db_name%

@if /I "%1" == "list-db" (
  echo db2 list db directory
  db2 list db directory
  @goto all_end
)

@if /I "%1" == "list-n" (
  echo db2 list node directory
  db2 list node directory
  @goto all_end
)


@if /I "%1" == "jh" (  
  echo db2expln -d fslwzb -u fslwzb Fsdb2012 -g -c fslwzb -p %db_cs_2% -s 0 -t ^>c:\%db_cs_2%.txt
  echo type c:\%db_cs_2%.txt ^| find "Estimated Cost"
  @goto all_end
)


@if /I "%1" == "status" (
  echo db2 get connection state
  db2 get connection state
  @goto all_end
)
@if /I "%1" == "s" goto p_get_db_conn_status

@if /I "%1" == "d" goto p_connect_reset
@if /I "%1" == "del" goto p_connect_reset


@rem 核心一正式库 200.30.10.1
@set db_name=fssb_1
@set db_user=fssb
@set db_pwd=IBM@0rd
@if "%1" == "fssb_1" goto p_connect_db
@if "%1" == "fssb10" goto p_connect_db
@if "%1" == "fssb10zkb" (
  set db_user=zhongkb
  set db_pwd=zhonG829
  set local_db2_schema_set=SET CURRENT SCHEMA = "FSSB"
  set local_db2_schema_path=SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","FSSB"
  goto p_connect_db
)


@rem 核心一测试库 200.30.10.101
@set db_name=fssbcs
@set db_user=fssb
@set db_pwd=Fscs@0901
@if "%1" == "fssbcs" goto p_connect_db
@if "%1" == "fssb3" goto p_connect_db


@rem 人社中间库 19.128.101.194
@set db_name=rszb
@set db_user=rszb
@set db_pwd=rszb
@if /I "%1" == "rszb" goto p_connect_db
@if /I "%1" == "rszb194" goto p_connect_db


@rem ----------200.30.99.2----------
@set db_user=cqsi
@set db_pwd=cqsi
@if /I "%1" == "mz99.2" (
  set db_name=ccjmmz92
  goto p_connect_db
) 
@if /I "%1" == "mz299.2" (
  set db_name=ccjmmz22
  goto p_connect_db
)

@if /I "%1" == "ncyl" (
  echo ncyl == 200.30.99.2 ccnleims
  set db_name=ncyl
  goto p_connect_db
)
 
  @set db_user=fssi
  @set db_pwd=fssi
@if /I "%1" == "ncylqy" (
  echo ncylqy == 200.30.99.6 ccncylqy
  set db_name=ncylqy
  goto p_connect_db
)

@set db_user=wsbs
@set db_pwd=wsbs@123
@if /I "%1" == "wsbs99.2" (
  set db_name=wsbs
  goto p_connect_db
) 

@if /I "%1" == "wsbscs" (
  set db_name=wsbscs
  goto p_connect_db
) 

@if /I "%1" == "wsbs" (
  set db_name=wsbs
  goto p_connect_db
) 


@set db_user=fssb
@set db_pwd=unisure
@if /I "%1" == "fssb4" (
  set db_name=fssb4
  goto p_connect_db
) 





@rem ----------200.30.99.32/189.90.100.71 本机----------
@set db_user=cqsi
@set db_pwd=cqsiqz
@if /I "%1" == "mzliqj" (
  set db_name=ccjmmz
  goto p_connect_db
)
@if /I "%1" == "mzliqj_l" (
  set db_name=ccjmmz_l
  goto p_connect_db
)
@if /I "%1" == "mzl" (
  set db_name=ccjmmz_l
  goto p_connect_db
)


@rem 禅城9号机 170.111.7.109
@set db_user=cqsi
@set db_pwd=cqsi
@if /I "%1" == "mz109" (
  set db_name=mz109
  goto p_connect_db
)
@if /I "%1" == "mz109cs" (
  set db_name=mz109cs
  goto p_connect_db
)
@if /I "%1" == "mz109qz" (
  set db_name=mz109qz
  goto p_connect_db
)
@if /I "%1" == "mz109_2" (
  set db_name=mz109_2
  goto p_connect_db
)
@if /I "%1" == "mz109_3" (
  set db_name=mz109_3
  goto p_connect_db
)
@if /I "%1" == "mz109_u" (
  set db_name=mz109u
  goto p_connect_db
)

@rem 禅城4号机 170.111.7.104
@set db_user=cqsi
@set db_pwd=cqsi
@if /I "%1" == "mz104" (
  set db_name=cqsi
  goto p_connect_db
)

@rem DMZ测试机 200.30.10.25
@set db_user=fssb
@set db_pwd=fssiadmincs
@if /I "%1" == "fssbdmz" (
  set db_name=fssbdmz
  goto p_connect_db
)
@if /I "%1" == "dmzzs" (
  set db_name=swdbdmz
  goto p_connect_db
)
@if /I "%1" == "swdbdmz" (
  set db_name=swdbdmz
  goto p_connect_db
)

@rem 医疗个账-正式 200.30.20.24
@set db_user=fsylgz
@set db_pwd=fssi
@if /I "%1" == "fsylgz" (
  set db_name=fsylgz
  goto p_connect_db
)

@rem 地税中间库-正式 189.60.111.2
@set db_user=fssi
@set db_pwd=fssi
@if /I "%1" == "fsds" (
  set db_name=fsds
  goto p_connect_db
)


@rem 联网指标-正式 189.50.111.9
@set db_user=fslwzb
@set db_pwd=Fsdb2012
@if /I "%1" == "fslwzb" (
  set db_name=fslwzb
  goto p_connect_db
)


@rem yms:cs/dmz , 189.30.100.101_hx1sbcs,189.30.111.6_hx1swcs
@set db_user=fssb
@if /I "%1" == "yms-cs" (
  set db_name=hx1sbcs
  set db_pwd=sbfs321
  goto p_connect_db
)
@if /I "%1" == "yms-dmz" (
  set db_name=hx1swcs
  set db_pwd=sbfssi999
  goto p_connect_db
)
@if /I "%1" == "yms-dmz-user" (
  set db_name=hx1swcs
  set db_user=dmzuser
  set db_pwd=userfssi
  goto p_connect_db
)

@rem yms-zs:189.30.111.13
@set db_user=fssb
@set db_name=ymssbdb
@if /I "%1" == "yms-zs" (
  set db_pwd=fssb#2016
  goto p_connect_db
)
@if /I "%1" == "yms-zs-user" (
  set db_user=dmzuser
  set db_pwd=user#2016yms
  goto p_connect_db
)

@goto all_end

@rem 获取数据库联接状态
:p_get_db_conn_status
  @rem echo db2 get connection state
  db2 get connection state
@goto all_end

@rem 断开数据库联接
:p_connect_reset
  @rem echo db2 get connection state
  db2 get connection state
  @rem echo db2 connect reset
  db2 connect reset
@goto all_end

@rem 联接数据库1
:p_connect_db 
  @if "%getddl%"== "1" (
    goto p_get_obj_ddl
  ) else (
    goto p_connect_db_ok
  )
  
@goto all_end


@rem 联接数据库 ok
:p_connect_db_ok
  @echo db2 connect to %db_name% user %db_user% using %db_pwd%
  @db2 connect to %db_name% user %db_user% using %db_pwd%
  
  @if not "%local_db2_schema_set%" == "" db2 -v %local_db2_schema_set%
  @if not "%local_db2_schema_path%" == "" db2 -v %local_db2_schema_path%
  
  
@goto all_end


@rem 获取对象ddl
:p_get_obj_ddl
  set obj_fullname=%db_cs3%

  @rem echo java -classpath ".;E:\_Config\exec_db\;%classpath%" db2ddl -d %db_name% -u %db_user% -p %db_pwd% -o %obj_fullname% -t "%obj_out_dir%"
  java -classpath ".;E:\_Config\exec_db\;%classpath%" db2ddl -d %db_name% -u %db_user% -p %db_pwd% -o %obj_fullname% -t %obj_out_dir%

@goto all_end




@rem 总结束
:all_end
@echo errorlevel=%errorlevel%
:all_end2

@goto :eof


rem return unique temporary filename in TMPFILE variable
:GETTEMPNAME
set TMPFILE=%TEMP%\arytempfile-%RANDOM%-%TIME:~6,2%.tmp
if exist "%TMPFILE%" goto GETTEMPNAME 
@goto :EOF