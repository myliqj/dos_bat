@echo off
mode con: cols=110 lines=15
:index
color 27
cls
echo.
echo     ��ӭʹ�ò鿴class�ļ��汾С����
echo     �ҵĲ���:http://blog.csdn.net/sunyujia/
echo     ��class�ļ���ק���˴��ں�,������ں��ûس�.������ʾ����Ŀ��class�ļ���jdk�汾
echo.
echo.
set route=%cd%
set ravel=
set /p ravel=    ������Ҫ�鿴��class�ļ�:
set "ravel=%ravel:"=%"
if /i "%ravel:~-6%"==".class" if exist "%ravel%" goto go
cls
echo �ļ�����,ָ���ļ������ڻ���class�ļ�!
echo ���������������... 
echo.
echo.
echo ���������������...
pause >nul
goto index

:go
java -jar  VersionViewer.jar %ravel%
echo.
echo �����������...
pause >nul
goto index
exit


