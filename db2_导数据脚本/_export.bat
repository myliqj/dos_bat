@echo off
echo ..........................................................
echo �ó�����������ִ�л���DB2LUW��SQL�ű�,
@REM ��ִ�нű�ǰ������ͨ�����������������ݿⲢ������ȷ��schema,
@REM �������ݿ�:connect to <dbname> user <username> using <password>
@REM ���õ�ǰschema:set current schema=<schema name>
echo ִ�н����־���Բ鿴�ļ�%exelog%
echo ..........................................................
set /P dbname=���ݿ�����:
set /P dbusername=���ݿ��û���:
set /P dbpassword=���ݿ����:
:re_input_schema_name
set /P schema_name=SCHEMA����:
if "%schema_name%" EQU "" (
  goto re_input_schema_name
)
set exelog=log/export.log
set DB2OPTIONS=-o -p -q -l %exelog%
db2 -p connect to %dbname% user %dbusername% using %dbpassword%
echo ''>%exelog%
echo ��ʼִ�нű�>%exelog%

if "%schema_name%" NEQ "" (
  db2 set current schema=%schema_name%
)

echo ��IXF��ʽ�������ݱ� WEB_USER ......
db2 %DB2OPTIONS% EXPORT TO data/web_user.ixf OF IXF MESSAGES data/web_user.msg SELECT * FROM WEB_USER

echo ��IXF��ʽ�������ݱ� WEB_PUSER ......
db2 %DB2OPTIONS% EXPORT TO data/web_puser.ixf OF IXF MESSAGES data/web_puser.msg SELECT * FROM WEB_PUSER


echo �Ͽ� %dbname% ���ݿ������>%exelog%
db2 disconnect  %dbname% 
pause
exit