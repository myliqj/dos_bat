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

set exelog=log/transfer.log

set DB2OPTIONS=-o -p -q -l %exelog%
db2 -p connect to %dbname% user %dbusername% using %dbpassword%
if "%schema_name%" NEQ "" (
  db2 set current schema=%schema_name%
)

echo ''>%exelog%
echo ��ʼִ�нű�

echo ����IXF��ʽ�����ݵ�ģʽ%schema_name%��.....
echo ����IXF��ʽ�����ݱ�userstree(�û���)......
db2 %DB2OPTIONS% "import from data/userstree.ixf of ixf  modified by forcecreate create into sjzh_userstree"
echo �����������.



echo ������־��.......

echo ���뺯��functions.......

echo ����洢����procedures......

echo ��ʼ��ת���������.

echo ����1:��ʼת������.
echo ת���û���¼��Ϣ......

echo ת���û���¼��Ϣ���.

echo ����2:����ת���������
echo       �����˸��û�ת������,���ת��ǰ�����,˵��ȫ���ɹ�,����,�뵽dt_log���в鿴ת����־.


echo       ��֤��λ�û�ת������,���ת������ת��ǰ��2λ,˵��ȫ���ɹ�,����,�뵽dt_log���в鿴ת����־.

echo      ת��������־��¼

echo      ת��������־��¼�б�


echo ����3:��������
echo ��ִ��remove.bat�ļ�(ע��:���ת�������ж�����,��ڶ�ѯ���Ƿ�ɾ��ת���ɹ�����ʱ,��Ҫ����y)
echo �ر�%dbname%���ݿ������.....
db2 disconnect %dbname%
pause
exit