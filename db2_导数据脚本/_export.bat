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
set exelog=log/export.log
set DB2OPTIONS=-o -p -q -l %exelog%
db2 -p connect to %dbname% user %dbusername% using %dbpassword%
echo ''>%exelog%
echo 开始执行脚本>%exelog%

if "%schema_name%" NEQ "" (
  db2 set current schema=%schema_name%
)

echo 以IXF格式导出数据表 WEB_USER ......
db2 %DB2OPTIONS% EXPORT TO data/web_user.ixf OF IXF MESSAGES data/web_user.msg SELECT * FROM WEB_USER

echo 以IXF格式导出数据表 WEB_PUSER ......
db2 %DB2OPTIONS% EXPORT TO data/web_puser.ixf OF IXF MESSAGES data/web_puser.msg SELECT * FROM WEB_PUSER


echo 断开 %dbname% 数据库的连接>%exelog%
db2 disconnect  %dbname% 
pause
exit