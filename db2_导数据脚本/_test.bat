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

set exelog=log/test.log
set DB2OPTIONS=-o -p -q -l %exelog%

db2 -p connect to %dbname% user %dbusername% using %dbpassword%

echo ''>%exelog%
echo ��ʼִ�в���
echo ����2:����ת���������
echo       NO1:�����˸��û�ת������,���ת��ǰ�����,˵��ȫ���ɹ�,����,�뵽dt_log���в鿴ת����־.
db2 %DB2OPTIONS%  "select count(*) ��Ҫת���ĸ����û��� from web_puser"
db2 %DB2OPTIONS%  "select count(*) ת����ĸ����û��� from s_u_user where 'G_' = substr(id,1,2) "
echo      NO2:���˽�ɫ����S_U_USER_TO_ROLE,������ǰ��NO1ת��������û������
db2 %DB2OPTIONS% "select count(*) ���˽�ɫ����S_U_USER_TO_ROLE from S_U_USER_TO_ROLE where 'G_' = substr(id,1,2)"

pause

echo       NO3:��֤��λ�û�ת������,���ת������ת��ǰ��2λ,˵��ȫ���ɹ�,����,�뵽dt_log���в鿴ת����־.
db2 %DB2OPTIONS%  "select count(*) ��Ҫת���ĵ�λ�û��� from web_user"
db2 %DB2OPTIONS%  "select count(*) ת����ĵ�λ�û�����ת��ǰ���� from s_u_user  where 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
echo      NO4:��λ��ɫ����S_U_USER_TO_ROLE,������ǰ��NO3ת����ĵ�λ�û������
db2 %DB2OPTIONS% "select count(*) ��λ��ɫ����S_U_USER_TO_ROLE from S_U_USER_TO_ROLE where 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"

pause

echo      ת��������־��¼
db2 %DB2OPTIONS% "select count(*) ������־��¼�� from DT_LOG"

pause

echo     ת��������־��¼�б�(select * from DT_LOG)
db2 %DB2OPTIONS% "select YWLB,BM,ERRMSG from DT_LOG" 

pause
echo �Ͽ� %dbname% ���ݿ������
db2 disconnect  %dbname% 
pause
exit