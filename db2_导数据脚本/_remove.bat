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
set exelog=log/del.log
set DB2OPTIONS=-o -p -q -v -l %exelog%

echo ''>%exelog%
echo 开始执行脚本
echo 步骤3:清理数据.
set /P isDel=转换过程中所需表已无用,是否删除掉[y]:
set /P redo1=是否删除转换成功的数据,[y]则全部删除已转数据,否则跳过:
IF /I "Y" EQU "%isDel%" (

	echo 连接数据库...
	db2 %DB2OPTIONS% connect to %dbname% user %dbusername% using %dbpassword%
	echo 当前模式设为%schema_name%
	db2 %DB2OPTIONS% set current schema=%schema_name%
	echo 删除dmdy表.
    	db2 %DB2OPTIONS% drop table dmdy
    	echo 删除web_user表.
    	db2 %DB2OPTIONS% drop table web_user
	echo 删除web_puser表.
    	db2 %DB2OPTIONS% drop table web_puser
	echo 删除ys_dwjbxx表.
    	db2 %DB2OPTIONS% drop table ys_dwjbxx
	echo 删除ys_grjbxx表.
    	db2 %DB2OPTIONS% drop table ys_grjbxx
	echo 删除函数.
	db2 %DB2OPTIONS% drop FUNCTION F_GETCODE
	echo 删除过程.
	db2 %DB2OPTIONS% drop procedure SJZH_TO_USER
	
	
	IF /I "Y" EQU "%redo1%" (
	    echo 删除s_u_user转换成功的记录.
	    db2 %DB2OPTIONS% "delete from s_u_user where 'G_' = substr(id,1,2) or 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
	    echo 删除S_U_USER_TO_ROLE转换成功的记录.
	    db2 %DB2OPTIONS% "delete from S_U_USER_TO_ROLE where 'G_' = substr(id,1,2) or 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
	    echo 删除志换日志表drop table dt_log.
	    db2 %DB2OPTIONS% drop table dt_log
	)
	db2 %DB2OPTIONS% commit
	echo 清理完毕.
	echo 断开 %dbname% 数据库的连接.
	db2 disconnect  %dbname% 
)

echo 完毕.
pause
exit