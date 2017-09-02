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

set exelog=log/transfer.log

set DB2OPTIONS=-o -p -q -l %exelog%
db2 -p connect to %dbname% user %dbusername% using %dbpassword%
if "%schema_name%" NEQ "" (
  db2 set current schema=%schema_name%
)

echo ''>%exelog%
echo 开始执行脚本

echo 导入IXF格式的数据到模式%schema_name%中.....
echo 导入IXF格式的数据表userstree(用户表)......
db2 %DB2OPTIONS% "import from data/userstree.ixf of ixf  modified by forcecreate create into sjzh_userstree"
echo 导入数据完毕.



echo 创建日志表.......

echo 导入函数functions.......

echo 导入存储过程procedures......

echo 初始化转换程序完毕.

echo 步骤1:开始转换数据.
echo 转换用户登录信息......

echo 转换用户登录信息完毕.

echo 步骤2:验正转换后的数据
echo       验正人个用户转换数据,如果转换前后相等,说明全部成功,否则,请到dt_log表中查看转换日志.


echo       验证单位用户转换数据,如果转换后是转换前的2位,说明全部成功,否则,请到dt_log表中查看转换日志.

echo      转换错误日志记录

echo      转换错误日志记录列表


echo 步骤3:清理数据
echo 请执行remove.bat文件(注意:如果转换过程中都正常,则第二询问是否删除转换成功数据时,不要输入y)
echo 关闭%dbname%数据库的连接.....
db2 disconnect %dbname%
pause
exit