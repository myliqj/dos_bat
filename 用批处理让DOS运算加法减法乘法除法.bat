
rem ����������DOS����ӷ������˷�����
rem 2010��06��23�� 13:33
 
rem ������DOS����ӷ������˷�����
@echo off
:chushi
cls
set /a zque=0
set /a cwu=0
echo.
echo ---------------------�Ӽ�������-------------------
echo ������˵����
echo 1����������������ļӼ�����
echo 2���ܹ�ͳ�Ʒ�����
echo ��ʾ������Ŀ�����У���"q"(Сд)�˳����⡣
echo.
echo       ��������  ��2006-1-6����
echo ------------------------------------------------
echo ��ѡ�����:
echo 1���ӷ�����
echo 2����������
echo 3����q�˳�
echo.
set goto=
set /p goto=����������ѡ��
if "%goto%"=="1" set �㷨=:add && set addorsub=+&& goto :add
if "%goto%"=="q" (goto :over) else set �㷨=:sub && set addorsub=-&&goto :sub

----------------------����˵��------------------------
     %random:~-1%����˼����ȡ����������һ�����֣�
     "set jieguo="��"set /p xx:="��������þ��ǲ���
     �ȴ��������ʾ��"xx:"
------------------------------------------------------

:add
set /a shu_1=%random:~-1%
set /a shu_2=%random:~-1%
set /a jieguo_1=%shu_1%+%shu_2%
set jieguo=
set/p jieguo=%shu_1%+%shu_2%=
if "%jieguo%"=="q" goto :exit
if "%jieguo%"=="%jieguo_1%" (goto :right) else goto :wrong

----------------------˵��---------------------
��һ��ifѭ��������һ������shu_2,�����������С��
������shu_1������ϴ�����������ͽ���˲���������
���⡣
-----------------------------------------------
:sub
set /a shu_1=%random:~-1%
set /a shu_3=%random:~-1%
if %shu_1% leq %shu_3% (set /a shu_2=%shu_1% && set /a shu_1=%shu_3%) else set /a shu_2=%shu_3%
set /a jieguo_1=%shu_1%-%shu_2%
set jieguo=
set/p jieguo=%shu_1%-%shu_2%=
if "%jieguo%"=="%jieguo_1%" goto :right
if "%jieguo%"=="q" (goto :exit) else goto :wrong

-------------------˵��-----------------
  ����"%�㷨%"��������������ԭ���㾿��
  ѡ����Ǽӷ����Ǽ���������Ǽӷ��Ļ���
  �ӷ�ѭ��
----------------------------------------
:right
echo.
echo ��ϲ��!��������!
set /a zque=%zque%+1
echo.
goto %�㷨%

:wrong
echo.
echo ���ź�!��һ�����������ˡ�
echo ��ȷ��Ӧ���ǣ�%shu_1%%addorsub%%shu_2%=%jieguo_1%
set /a cwu=%cwu%+1
echo.
goto %�㷨%

:exit
set /a tmshu=%zque%+%cwu%
set /a chengji=100*%zque%/%tmshu%
cls
echo -------------------���˴β��Խ��--------------------
echo ���ܹ�������%tmshu%�⡣
echo �ܹ������%zque%�⡣
echo �ܹ������%cwu%�⡣
echo ���ĳɼ���%chengji%�֡�
echo.
set goto=
echo -------------------�������--------------------------
set /p goto=����q�˳���������������
if "%goto%"=="q" (goto :over) else goto :chushi
