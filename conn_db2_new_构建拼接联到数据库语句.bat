@echo off&setlocal enabledelayedexpansion

:: 用来替换换行符使用，后面至少留二人空行，且注意替换到变量中直接echo不能显示后面行，在echo中替换则可显示
@set lf=^


:init_var

  @set db_cs1=%1
  @set db_cs2=%2
  @set db_cs3=%3
  @set db_cs4=%4
  @set db_cs5=%5
  @set db_cs6=%6

  @set v_db_name=
  if not [%db_cs1%] == [] (
    set v_db_name=%db_cs1%
  )


  set v_alias=&set v_ip=&set v_db=&set v_user=&set v_pwd=&set v_desc=
  set v_g_cur_index=0
  set local_db2_schema_set=
  set local_db2_schema_path=

  set v_g_connect_db=1
  set v_g_connect_db_find_ok=0


  :: 先判断是否特殊类别，之后再判断数据库别名
  if /i [%db_cs1%]==[d] goto :p_connect_reset
  if /i [%db_cs1%]==[del] goto :p_connect_reset
  if /i [%db_cs1%]==[s] goto :p_get_db_conn_status
  if /i [%db_cs1%]==[status] goto :p_get_db_conn_status

  if /i [%db_cs1%]==[h] goto :help_show
  if /i [%db_cs1%]==[help] goto :help_show
  if /i [%db_cs1%]==[?] goto :help_show


  if /i [%db_cs1%]==[pro] (
    call :prompt_set_of_name %db_cs2%
    goto :all_end
  )

  if "%db_cs1%" == "open" ( 
    set exec_path=%db_cs2%
    if "%db_cs2%" == "cd" set exec_path=%cd%
    if "%db_cs2%" == "cur" set exec_path=%cd%
    call :db2_log c:\windows\explorer.exe !exec_path!
    goto :all_end
  )


  if /i [%db_cs1%]==[cm] goto :db2_log db2 -td@ -f "%1"

  :: for /l %%i in (0 1 7) do if "%ye2%" == "%%i" call :Han%%i   
  :: call :help_show

  :: 计划时，查找别名，不要联数据库
  if /i [%db_cs1%]==[jh] (
    set v_g_connect_db=0
    goto :all_data_for_db
    if defined v_db (
      goto :db2expln_jh
    )
    goto :all_end
  )


  if /I "%db_cs1%" == "list-db" (
    call :db2_log db2 list db directory
    @goto all_end
  )

  if /I "%db_cs1%" == "list-n" (
    call :db2_log db2 list node directory
    @goto all_end
  )

  :: 查找数据库，找到时联接并退出
  goto :all_data_for_db
  if /i [!v_g_connect_db_find_ok!]==[1] goto :all_end
  
  :: 参数全部不对时，显示帮助
  goto :help_show

:help_show 
  @echo.
  @echo ====================%~dp0conn.bat=============== cd /d %~dp0 =====
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
  @goto :eof

goto all_end


:: 数据库内容
:all_data_for_db

:: format db_alias#ip#db_name#user#pwd#desc;


  if "%v_db_name%" == "fssb10zkb" ( 
    set local_db2_schema_set=SET CURRENT SCHEMA = "FSSB"
    set local_db2_schema_path=SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","FSSB"
  )


  @set db_list=^
fssb_1/fssb10   200.30.10.1    fssb_1  fssb     IBM@0rd      核心一正式库;^
fssb10zkb       200.30.10.1    fssb_1  zhongkb  zhonG829     核心一正式库-只读;^
fssbcs/fssb101  200.30.10.101  fssbcs  fssb     Fscs@0901    核心一测试库;^
fsylgz          200.30.20.24   fsylgz  fsylgz   fssi         医疗个账-正式;^
fslwzb          189.50.111.9   fslwzb  fslwzb   Fsdb2012     联网指标-正式;^
fsds            189.60.111.2   fsds    fssi     fssi         地税中间库-正式;^
wsbs            189.50.111.15  wsbs    wsbs     wsbs@123     行政服务中间库;^
wsbscs          189.50.111.15  wsbscs  wsbs     wsbs@123     行政服务中间库;^
yms-cs          189.30.100.101 hx1sbcs fssb     sbfs321      一门式测试fssb;^
yms-cs-dmz      189.30.100.101 hx1sbcs dmzuser  fssifssi     一门式测试dmzuser;^
yms-dmz         189.30.111.6   hx1swcs fssb     sbfssi999    一门式测试DMZ区fssb;^
yms-dmz-user    189.30.111.6   hx1swcs dmzuser  userfssi     一门式测试DMZ区dmzuser;^
yms-zs          189.30.111.13  ymssbdb fssb     fssb#2016    一门式正式DMZ区fssb;^
yms-zs-user     189.30.111.13  ymssbdb dmzuser  user#2016yms 一门式正式DMZ区dmzuser;^
rszb/rszb194    19.128.101.194 rszb    rszb     rszb         人社中间库;

  :: echo %db_list:;=;!lf!%
  :: set db_list1=%db_list:;=;!lf!%

  :: echo aa1

  :: 查找db是否有别名相同的定义, 字串中的";"替换为";+换行"才能被for识别

  for /F "delims=;" %%i in ("%db_list:;=;!lf!%") do (
    @echo %%i
    call :get_db_info %%i
  
    :: echo !v_alias!
    if /i [!v_alias!]==[%v_db_name%] goto :find_db_ok
    
    set v_g_cur_index=0 && call :get_strchr !v_alias! /
    if /i not "!v_g_cur_index!" == "0" (
      :: echo v_g_cur_index="!v_g_cur_index!" , alias="!v_alias!"
      call :get_sub_db !v_alias!
    )
     
    :: 找到后退出本过程
    if [!v_g_connect_db_find_ok!]==[1] goto:eof 
  )

  :: 只有未找到，才显示后退出  
  if [!v_g_connect_db_find_ok!]==[0] goto :no_find_db
  goto :eof


:get_sub_db
  set v_a1=%1
  for /F "delims=/" %%T in ("%v_a1:/=/!lf!%") do (
      :: echo %%T
      if /i [%%T]==[%v_db_name%] set v_alias=%%T && goto :find_db_ok
  )
  goto :eof

:no_find_db
  echo no_find_db :%v_db_name%
  goto :eof


:find_db_ok
  set v_g_connect_db_find_ok=1
  echo find_db_ok: alias=%v_alias%, ip=%v_ip%, db=%v_db%, user=%v_user%, pwd=%v_pwd%, desc=%v_desc%


  if /i [%v_g_connect_db%]==[1] (
    call :prompt_set_of_name %v_db%
    call :db2_log db2 -v connect to %v_db% user %v_user% using %v_pwd%
    call :db2_connect_set_status
    :: 联接数据库后结束
    goto :all_end
  )
  goto :eof


goto :all_end

:prompt_set_of_name
  echo old_prompt=%prompt%  new_prompt=$d$s$t$s%2$g
  prompt=$d$s$t$s%1$g
  echo %cd%
  goto :eof

:get_db_info
  set v_alias=&set v_ip=&set v_db=&set v_user=&set v_pwd=&set v_desc=
  
  set v_db_con=%*
  :: echo   %v_db_con%
  for /f "tokens=1,2,3,4,5,6" %%a in ("%*") do (
    set v_alias=%%a&set v_ip=%%b&set v_db=%%c&set v_user=%%d&set v_pwd=%%e&set v_desc=%%f
  )
  :: echo   alias=%v_alias%, ip=%v_ip%, db=%v_db%, user=%v_user%, pwd=%v_pwd%, desc=%v_desc%

  goto :eof


:db2expln_jh
  call :db2_log db2expln -d %v_db% -u %v_user% %v_pwd% -g -c fslwzb -p %db_cs_2% -s 0 -t ^>c:\%db_cs_2%.txt
  call :db2_log type c:\%db_cs_2%.txt ^| find "Estimated Cost"
  @goto all_end

:log
        ECHO. %* >> !log!
        %* >> !log! 2>&1
        GOTO :eof

:log1
        %* >> !log! 2>&1
        GOTO :eof


:db2_log
  if /i [v_mode]==[file] (
    echo %*>>!log!
    %*>> !log! 2>&1
  ) else (
    echo %*
    %*
  )
  goto :eof


:: C语中的strchr函数，在一个字符串中查找一个字符的首次出现位置，找到时返回所在位置，找不到时返回0值。
:: 批处理中的思路：不断截短字符串，并取截短后字符串中的首字符，和要求的字符比较，如果相同就利用goto语句跳出循环，输出结果，如果没有相同的字符，执行到最后就输出0值。
:get_strchr
 :: %1 表示字串, %2 表示分隔符
 set str1=%1
 set ch1=%2
 ::注意，这里是区分大小写的！ -- 增加 if /i 参数，不区分大小写
 set str=%str1%
 :: echo   str1=%str% , ch1=%ch1%
 ::复制字符串，用来截短，而不影响源字符串
 :next
 if not "%str%"=="" (
   set /a num+=1
   :: echo !num!,  str1=!str:~0,1! ,str=%str% , ch1=!ch1!
   if /i "!str:~0,1!"=="!ch1!" goto last
   ::比较首字符是否为要求的字符，如果是则跳出循环
   set str=!str:~1!
   goto next
 )
 set /a num=0
 ::没有找到字符时，将num置零
 :last
 :: echo 字符'%ch1%'在字符串"%str1%"中的首次出现位置为%num%
 :: echo 输出完毕，按任意键退出&&pause>nul&&
 set v_g_cur_index=!num!
 :: echo num=!num!,index=!v_g_cur_index!
 exit /b %num%



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
  call :prompt_set_of_name
  @goto all_end

@rem 联接数据库1
:p_connect_db 
  @if "%getddl%"== "1" (
    goto p_get_obj_ddl
  ) else (
    goto p_connect_db_ok
  )
  
  @goto all_end


@rem 联接数据库后的设置
:db2_connect_set_status
  :: @echo db2 connect to %db_name% user %db_user% using %db_pwd%
  :: @db2 connect to %db_name% user %db_user% using %db_pwd%
  
  
  @if not "%local_db2_schema_set%" == "" db2 -v %local_db2_schema_set%
  @if not "%local_db2_schema_path%" == "" db2 -v %local_db2_schema_path%
  
  goto :eof


  
@goto all_end


@rem 获取对象ddl
:p_get_obj_ddl
  set obj_fullname=%db_cs3%

  @rem echo java -classpath ".;E:\_Config\exec_db\;%classpath%" db2ddl -d %db_name% -u %db_user% -p %db_pwd% -o %obj_fullname% -t "%obj_out_dir%"
  java -classpath ".;E:\_Config\exec_db\;%classpath%" db2ddl -d %db_name% -u %db_user% -p %db_pwd% -o %obj_fullname% -t %obj_out_dir%

@goto all_end


rem return unique temporary filename in TMPFILE variable
:GETTEMPNAME
  set TMPFILE=%TEMP%\arytempfile-%RANDOM%-%TIME:~6,2%.tmp
  if exist "%TMPFILE%" goto GETTEMPNAME 
  @goto :EOF



:all_end
  @echo errorlevel=%errorlevel%

  goto :eof

:: exit /b %*


