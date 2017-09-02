@echo off
echo ..........................................................
echo 该程序用于批量执行基于DB2LUW的SQL脚本,
@REM 在执行脚本前，请先通过以下命令连接数据库并设置正确的schema,
@REM 连接数据库:connect to <dbname> user <username> using <password>
@REM 设置当前schema:set current schema=<schema name>
echo 执行结果日志可以查看文件%exelog%
echo ..........................................................
set /P dbname=数据库名称:
set /P dbusername=数据库用户名:
set /P dbpassword=数据库口令:
:re_input_schema_name
set /P schema_name=SCHEMA名称:
if "%schema_name%" EQU "" (
  goto re_input_schema_name
)

set exelog=log/test.log
set DB2OPTIONS=-o -p -q -l %exelog%

db2 -p connect to %dbname% user %dbusername% using %dbpassword%

echo ''>%exelog%
echo 开始执行测试
echo 步骤2:验正转换后的数据
echo       NO1:验正人个用户转换数据,如果转换前后相等,说明全部成功,否则,请到dt_log表中查看转换日志.
db2 %DB2OPTIONS%  "select count(*) 需要转换的个人用户数 from web_puser"
db2 %DB2OPTIONS%  "select count(*) 转换后的个人用户数 from s_u_user where 'G_' = substr(id,1,2) "
echo      NO2:个人角色关联S_U_USER_TO_ROLE,必须与前边NO1转换后个人用户数相等
db2 %DB2OPTIONS% "select count(*) 个人角色关联S_U_USER_TO_ROLE from S_U_USER_TO_ROLE where 'G_' = substr(id,1,2)"

pause

echo       NO3:验证单位用户转换数据,如果转换后是转换前的2位,说明全部成功,否则,请到dt_log表中查看转换日志.
db2 %DB2OPTIONS%  "select count(*) 需要转换的单位用户数 from web_user"
db2 %DB2OPTIONS%  "select count(*) 转换后的单位用户数是转换前两倍 from s_u_user  where 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
echo      NO4:单位角色关联S_U_USER_TO_ROLE,必须与前边NO3转换后的单位用户数相等
db2 %DB2OPTIONS% "select count(*) 单位角色关联S_U_USER_TO_ROLE from S_U_USER_TO_ROLE where 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"

pause

echo      转换错误日志记录
db2 %DB2OPTIONS% "select count(*) 错误日志记录数 from DT_LOG"

pause

echo     转换错误日志记录列表(select * from DT_LOG)
db2 %DB2OPTIONS% "select YWLB,BM,ERRMSG from DT_LOG" 

pause
echo 断开 %dbname% 数据库的连接
db2 disconnect  %dbname% 
pause
exit