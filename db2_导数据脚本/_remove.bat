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
set exelog=log/del.log
set DB2OPTIONS=-o -p -q -v -l %exelog%

echo ''>%exelog%
echo ��ʼִ�нű�
echo ����3:��������.
set /P isDel=ת�������������������,�Ƿ�ɾ����[y]:
set /P redo1=�Ƿ�ɾ��ת���ɹ�������,[y]��ȫ��ɾ����ת����,��������:
IF /I "Y" EQU "%isDel%" (

	echo �������ݿ�...
	db2 %DB2OPTIONS% connect to %dbname% user %dbusername% using %dbpassword%
	echo ��ǰģʽ��Ϊ%schema_name%
	db2 %DB2OPTIONS% set current schema=%schema_name%
	echo ɾ��dmdy��.
    	db2 %DB2OPTIONS% drop table dmdy
    	echo ɾ��web_user��.
    	db2 %DB2OPTIONS% drop table web_user
	echo ɾ��web_puser��.
    	db2 %DB2OPTIONS% drop table web_puser
	echo ɾ��ys_dwjbxx��.
    	db2 %DB2OPTIONS% drop table ys_dwjbxx
	echo ɾ��ys_grjbxx��.
    	db2 %DB2OPTIONS% drop table ys_grjbxx
	echo ɾ������.
	db2 %DB2OPTIONS% drop FUNCTION F_GETCODE
	echo ɾ������.
	db2 %DB2OPTIONS% drop procedure SJZH_TO_USER
	
	
	IF /I "Y" EQU "%redo1%" (
	    echo ɾ��s_u_userת���ɹ��ļ�¼.
	    db2 %DB2OPTIONS% "delete from s_u_user where 'G_' = substr(id,1,2) or 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
	    echo ɾ��S_U_USER_TO_ROLEת���ɹ��ļ�¼.
	    db2 %DB2OPTIONS% "delete from S_U_USER_TO_ROLE where 'G_' = substr(id,1,2) or 'F_' = substr(id,1,2) or 'D_' = substr(id,1,2)"
	    echo ɾ��־����־��drop table dt_log.
	    db2 %DB2OPTIONS% drop table dt_log
	)
	db2 %DB2OPTIONS% commit
	echo �������.
	echo �Ͽ� %dbname% ���ݿ������.
	db2 disconnect  %dbname% 
)

echo ���.
pause
exit