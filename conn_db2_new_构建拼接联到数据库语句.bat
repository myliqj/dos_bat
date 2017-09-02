@echo off&setlocal enabledelayedexpansion

:: �����滻���з�ʹ�ã��������������˿��У���ע���滻��������ֱ��echo������ʾ�����У���echo���滻�����ʾ
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


  :: ���ж��Ƿ��������֮�����ж����ݿ����
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

  :: �ƻ�ʱ�����ұ�������Ҫ�����ݿ�
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

  :: �������ݿ⣬�ҵ�ʱ���Ӳ��˳�
  goto :all_data_for_db
  if /i [!v_g_connect_db_find_ok!]==[1] goto :all_end
  
  :: ����ȫ������ʱ����ʾ����
  goto :help_show

:help_show 
  @echo.
  @echo ====================%~dp0conn.bat=============== cd /d %~dp0 =====
  @echo 1���������ݿ⣺%%1�������ݿ������ض����ƣ� %%2 �û�����ѡ�� %%3 ���루��ѡ�� -- �ṩ�û�ʱ�����ṩ����
  @echo    conn fssbcs  , conn fssbcs ccyh fssiccyh
  @echo 2��java��ȡDDL��%%1��ʶ��ddl/getddl/db2ddl��,%%2-4 ���ݿ�/�û�/���루ͬ1��,%%2/4 ģʽ��.������
  @echo    conn ddl fssbcs fssb.s_jdmb , conn ddl fssbcs ccyh fssiccyh fssb.s_jdmb
  @echo 3��db2look��ȡDDL:%%1��ʶdb2look %%2-4���ݿ��û�/���루ͬ1��%%3/5 ���� -o %%4/6 ����ļ�������ѡʱ��������
  @echo    conn db2look -d %%1 -td@ -i %%2 -w %%3 -e -noview -nofed -t s_jdmb -o s_jdmb_fssbcs.ddl 
  @echo 4����Ŀ�ڵ� CATALOG TCPIP NODE n_r_wsbs REMOTE 189.50.111.16 SERVER 50000
  @echo    db2 "CATALOG TCPIP NODE %db_cs2% REMOTE %db_cs3% SERVER %db_cs4%"
  @echo 5����Ŀ���ݿ� Catalog db wsbscs at NODE n_r_wsbs
  @echo    db2 "CATALOG DB %db_cs2% at NODE %db_cs3%"
  @echo.
  @echo 9��������ʶ��%%1=d/del ������������,%%1=s/status �鿴��ǰ���ݿ����� ,%%1=?/help �鿴����
  @echo    conn d , conn s , conn ?
  @echo.
  @echo    runstats on table fssb.CW_SYHDWSJ for detailed indexes all / for indexes all
  @echo    runstats on table fssb.T_SFZJ_DWJFMX for detailed indexes fssb.I_SFZJ_DWJFMX_PZX
  @echo    load from /dev/null ^| nul of del replace into fssb.LOG_TIME nonrecoverable
  @echo    %%1 jh :db2expln -d fslwzb -u fslwzb Fsdb2012 -g -c fslwzb -p %%2 -s 0 -t ^>c:\%%2.txt
  @echo            type c:\%%2.txt ^| find "Estimated Cost"
  @echo.    
  @echo    ��ȡ����ddl�����%%1���� ddl/getddl/db2ddl �������Ҫ��Ϊ��%%1��ʶ,%%2 ���ݿ�/�û�/����,%%3 ģʽ��.������
  @echo.
  @echo    open cd/cur -- c:\windows\explorer.exe %%2
  @echo.
  @echo    %%1  jh 
  @echo    %%1  list-db/list-n 
  @goto :eof

goto all_end


:: ���ݿ�����
:all_data_for_db

:: format db_alias#ip#db_name#user#pwd#desc;


  if "%v_db_name%" == "fssb10zkb" ( 
    set local_db2_schema_set=SET CURRENT SCHEMA = "FSSB"
    set local_db2_schema_path=SET CURRENT PATH = "SYSIBM","SYSFUN","SYSPROC","SYSIBMADM","FSSB"
  )


  @set db_list=^
fssb_1/fssb10   200.30.10.1    fssb_1  fssb     IBM@0rd      ����һ��ʽ��;^
fssb10zkb       200.30.10.1    fssb_1  zhongkb  zhonG829     ����һ��ʽ��-ֻ��;^
fssbcs/fssb101  200.30.10.101  fssbcs  fssb     Fscs@0901    ����һ���Կ�;^
fsylgz          200.30.20.24   fsylgz  fsylgz   fssi         ҽ�Ƹ���-��ʽ;^
fslwzb          189.50.111.9   fslwzb  fslwzb   Fsdb2012     ����ָ��-��ʽ;^
fsds            189.60.111.2   fsds    fssi     fssi         ��˰�м��-��ʽ;^
wsbs            189.50.111.15  wsbs    wsbs     wsbs@123     ���������м��;^
wsbscs          189.50.111.15  wsbscs  wsbs     wsbs@123     ���������м��;^
yms-cs          189.30.100.101 hx1sbcs fssb     sbfs321      һ��ʽ����fssb;^
yms-cs-dmz      189.30.100.101 hx1sbcs dmzuser  fssifssi     һ��ʽ����dmzuser;^
yms-dmz         189.30.111.6   hx1swcs fssb     sbfssi999    һ��ʽ����DMZ��fssb;^
yms-dmz-user    189.30.111.6   hx1swcs dmzuser  userfssi     һ��ʽ����DMZ��dmzuser;^
yms-zs          189.30.111.13  ymssbdb fssb     fssb#2016    һ��ʽ��ʽDMZ��fssb;^
yms-zs-user     189.30.111.13  ymssbdb dmzuser  user#2016yms һ��ʽ��ʽDMZ��dmzuser;^
rszb/rszb194    19.128.101.194 rszb    rszb     rszb         �����м��;

  :: echo %db_list:;=;!lf!%
  :: set db_list1=%db_list:;=;!lf!%

  :: echo aa1

  :: ����db�Ƿ��б�����ͬ�Ķ���, �ִ��е�";"�滻Ϊ";+����"���ܱ�forʶ��

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
     
    :: �ҵ����˳�������
    if [!v_g_connect_db_find_ok!]==[1] goto:eof 
  )

  :: ֻ��δ�ҵ�������ʾ���˳�  
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
    :: �������ݿ�����
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


:: C���е�strchr��������һ���ַ����в���һ���ַ����״γ���λ�ã��ҵ�ʱ��������λ�ã��Ҳ���ʱ����0ֵ��
:: �������е�˼·�����Ͻض��ַ�������ȡ�ض̺��ַ����е����ַ�����Ҫ����ַ��Ƚϣ������ͬ������goto�������ѭ���������������û����ͬ���ַ���ִ�е��������0ֵ��
:get_strchr
 :: %1 ��ʾ�ִ�, %2 ��ʾ�ָ���
 set str1=%1
 set ch1=%2
 ::ע�⣬���������ִ�Сд�ģ� -- ���� if /i �����������ִ�Сд
 set str=%str1%
 :: echo   str1=%str% , ch1=%ch1%
 ::�����ַ����������ض̣�����Ӱ��Դ�ַ���
 :next
 if not "%str%"=="" (
   set /a num+=1
   :: echo !num!,  str1=!str:~0,1! ,str=%str% , ch1=!ch1!
   if /i "!str:~0,1!"=="!ch1!" goto last
   ::�Ƚ����ַ��Ƿ�ΪҪ����ַ��������������ѭ��
   set str=!str:~1!
   goto next
 )
 set /a num=0
 ::û���ҵ��ַ�ʱ����num����
 :last
 :: echo �ַ�'%ch1%'���ַ���"%str1%"�е��״γ���λ��Ϊ%num%
 :: echo �����ϣ���������˳�&&pause>nul&&
 set v_g_cur_index=!num!
 :: echo num=!num!,index=!v_g_cur_index!
 exit /b %num%



@rem ��ȡ���ݿ�����״̬
:p_get_db_conn_status
  @rem echo db2 get connection state
  db2 get connection state
  @goto all_end

@rem �Ͽ����ݿ�����
:p_connect_reset
  @rem echo db2 get connection state
  db2 get connection state
  @rem echo db2 connect reset
  db2 connect reset
  call :prompt_set_of_name
  @goto all_end

@rem �������ݿ�1
:p_connect_db 
  @if "%getddl%"== "1" (
    goto p_get_obj_ddl
  ) else (
    goto p_connect_db_ok
  )
  
  @goto all_end


@rem �������ݿ�������
:db2_connect_set_status
  :: @echo db2 connect to %db_name% user %db_user% using %db_pwd%
  :: @db2 connect to %db_name% user %db_user% using %db_pwd%
  
  
  @if not "%local_db2_schema_set%" == "" db2 -v %local_db2_schema_set%
  @if not "%local_db2_schema_path%" == "" db2 -v %local_db2_schema_path%
  
  goto :eof


  
@goto all_end


@rem ��ȡ����ddl
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


