@echo off
setlocal enabledelayedexpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::
:: DOS�������������N��ǰ�����ڻ���N��ǰ������� ::
:: 2k��xp��2003��win7�²���ͨ��                  ::
:: @author zhzhl0                                ::
:: mklv2005#163.com                              ::
:::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo ���� days ��ǰ�� days ��������;
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ������days ��ǰ�����ڣ�������days �������ڣ�
:: set /p days=����������(days��ǰ����, days�����)
:: set days=17
set days=%1
if /i ""=="%days%" set days=1

rem program 'begin' ��ʼ
:begin
:: �жϲ���ϵͳ
ver | find /i "5.0" > nul && goto 2k || goto xp

rem program 'xp'��xp ϵͳ
:xp
for /f "tokens=1-3 delims=-/. " %%i in ("%date%") do ( 
  set /a yy=%%i, mm=%%j, dd=%%k 
) 
goto nornal

rem program '2k'��2k ϵͳ
:2k
for /f "tokens=2-4 delims=-/. " %%i in ("%date%") do ( 
  set /a yy=%%i, mm=%%j, dd=%%k 
)
goto nornal

rem program 'nornal'����������
:nornal
:: echo %yy%-%mm%-%dd%�����%yy%�Ƿ�������
set /a leap="^!(%yy% %% 4) & ^!(^!(%yy% %% 100)) | ^!(%yy% %% 400)"

:: ����������������
set /a nd=!dd!-!days!

:: echo [nd]=%nd%  ���㵱�µ�����
set /a num=0, mday=0, max=28+leap
set str=31 %max% 31 30 31 30 31 31 30 31 30 31
for %%i in (%str%) do ( 
  set /a num+=1 
  if !num! equ !mm! set /a mday=%%i 
)

::echo yy=%yy% mm=%mm% dd=%dd% nd=%nd% mday=%mday% leap=%leap%�� ���С�ڵ���0��ת��xiaoyu�鴦��
if !nd! leq 0 goto xiaoyu
:: ������ڵ���������ת��dayu�鴦��
if !nd! gtr !mday! goto dayu 

set nm=%mm%
goto println

rem program 'dayu' ������������������ڵ������������
:dayu
set /a nm=!mm!+1
set /a nd=!nd!-!mday!
if !nm! gtr 12 (
  set /a yy=!yy!+1
  set /a nm-=12
)
set /a leap="^!(%yy% %% 4) & ^!(^!(%yy% %% 100)) | ^!(%yy% %% 400)"
set /a num=0, mday=0, max=28+leap
set str=31 %max% 31 30 31 30 31 31 30 31 30 31
for %%i in (%str%) do ( 
  set /a num+=1 
  if !num! equ !nm! set /a mday=%%i 
)
set mm=%nm%

::echo yy=%yy% mm=%mm% nd=%nd% mday=%mday% leap=%leap%

if !nd! gtr !mday! goto dayu
goto println

rem program 'xiaoyu' ���������������С�ڵ���0�����
:xiaoyu
set /a nm=!mm!-1
if !nm! lss 1 (
  set /a yy=!yy!-1
  set /a nm+=12
)
set /a leap="^!(%yy% %% 4) & ^!(^!(%yy% %% 100)) | ^!(%yy% %% 400)"
set /a num=0, mday=0, max=28+leap
set str=31 %max% 31 30 31 30 31 31 30 31 30 31
for %%i in (%str%) do ( 
  set /a num+=1 
  if !num! equ !nm! set /a mday=%%i 
)
set /a nd=!mday!+!nd!
set mm=%nm%

::echo yy=%yy% mm=%mm% nd=%nd% mday=%mday% leap=%leap%

if !nd! leq 0 goto xiaoyu
goto println

rem program 'println' ���
:println
set mm=0%nm%
set dd=0%nd%
set mm=%mm:~-2%
set dd=%dd:~-2%
if !days! leq 0 echo ����������:%date%,%days:~1%���������ǣ�%yy%-%mm%-%dd% 
if !days! gtr 0 echo ����������:%date%,%days%��ǰ�������ǣ�%yy%-%mm%-%dd%

echo %days%��ǰ(mm-dd-yyyy): %mm%-%dd%-%yy%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
endlocal & set a_days_rq=%mm%-%dd%-%yy%