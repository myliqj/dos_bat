@echo off
title �޸�IP��ַ

:start_first

set ti=%time:~0,2%%time:~3,2%%time:~6,2%
rem ��������0�����  0:00:00 ��ʽ,����� 00:00:00��ʽ
set ti1=%ti:~0,1%
if "%ti1%"==" " set ti=0%time:~1,1%%time:~3,2%%time:~6,2%
set dt=%date:~0,4%%date:~5,2%%date:~8,2%%ti%
set dir=%cd%\

echo ʱ�䣺%date% %time% ����IP��
ipconfig

:start
rem cls
rem color 0c
rem MODE con: COLS=50 LINES=27
rem mode con: lines=300 cols=80
echo.
echo ===========================================================================
echo                   ��ѡ��Ҫ���еĲ�����Ȼ�󰴻س�
echo ===========================================================================
echo   ʱ�䣺%dt% ��ǰĿ¼��%dir%
echo                               ip            mask        gateway
echo  1.��˾���� 113        --192.168.1.113  255.255.0.0   192.168.1.1
echo  2.��˾���� ?88 133    --192.168.1.113  255.255.0.0   192.168.1.1 add/88.1
echo  3.�籣170�� 113+����  --170.111.73.113 255.255.0.0   170.111.6.252 add/192
echo  ---��������170.111.7.*/175.211.69.*, db2:7.104,69.4, ���� 170.111.100.1
echo  4.�籣19�� 113 web    --19.129.8.113   255.255.255.0 19.129.8.254 /61~64
echo  5.�籣200.30.0�� 141  --200.30.0.141   255.255.0.0   200.30.0.1
echo  6.�籣200.30.10�� 113 --200.30.10.113  255.255.0.0   200.30.10.1
echo  7.�Զ���
echo  8.�籣150.111.4�� 15  --150.111.4.15   255.255.0.0   150.111.100.1
echo    ·��: route add 200.10.10.0 mask 255.255.255.0 150.111.100.252 [-p �̶�]
echo  0.�˳�
echo.

:cho
set choice=
set /p choice= ��ѡ��:
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
IF "%Choice%"=="" goto cho
if /i %choice%==1 set flag=bgnw
if /i %choice%==2 set flag=bgnw88
if /i %choice%==3 set flag=sb170
if /i %choice%==4 set flag=sb19
if /i %choice%==5 set flag=sb_30_0
if /i %choice%==6 set flag=sb_30_10
if /i %choice%==7 set flag=custom
if /i %choice%==8 set flag=sb150
if /i %choice%==0 goto end
if Not "%flag%"=="" goto ok_start

echo �����������������  ����������: %choice%��
echo.
goto cho

:ok_start

if %flag%==bgnw goto bgnw
if %flag%==bgnw88 goto bgnw88
if %flag%==sb170 goto sb170
if %flag%==sb19 goto sb19
if %flag%==sb_30_0 goto sb_30_0
if %flag%==sb_30_10 goto sb_30_10
if %flag%==custom goto custom
if %flag%==oth goto start
if %flag%==sb150 goto sb150
if "%flag%"=="" goto start

rem �Զ���
:custom
:custom_set_ip
set c_ip=
set /p c_ip= ��¼��IP��ַ:
if "%c_ip%"=="" goto custom_set_ip
:custom_set_mask
set c_mask=
set /p c_mask= ��¼������(��-255.255.0.0):
if "%c_mask%"=="" set c_mask=255.255.0.0

:custom_set_gwmetric
set c_gwmetric=
set /p c_gwmetric= ��¼������(��-����ԭֵ):

set nip=netsh int ip set address name="��������" source=static addr=%c_ip% mask=%c_mask%
if not "%c_gwmetric%"=="" set nip=%nip% gateway=%c_gwmetric% gwmetric=1

echo %nip%

:sel_ok_start
set c_ok=
set /p c_ok=ȷ��(yִ��/n����¼��/c�˵�ѡ��/pPingIP/q�˳�ѡ��):
if "%c_ok%"=="" goto sel_ok_start
if not "%c_ok%"=="" set c_ok=%c_ok:~0,1%
if "%c_ok%"=="y" goto sel_ok_y
if "%c_ok%"=="n" goto custom
if "%c_ok%"=="c" goto start_first
if "%c_ok%"=="p" goto ping_ip
if "%c_ok%"=="q" goto set_end

goto sel_ok_start

:ping_ip
ping %c_ip%
goto sel_ok_start

:sel_ok_y

%nip%
if "%c_gwmetric%"=="" goto set_end

rem set nip=netsh int ip add address name="��������" gateway=%c_gwmetric% gwmetric=1
rem echo %nip%
rem %nip%
goto set_end

rem ��˾����
:bgnw

set nip=netsh int ip set address name="��������" source=static addr=192.168.1.113 mask=255.255.0.0 gateway=192.168.1.1 gwmetric=1
echo %nip%
%nip%
set nip=netsh interface ip set dns name="��������" source=static addr=202.96.128.86 register=PRIMARY
echo %nip%
%nip%
rem set nip=echo netsh interface ip add dns name="��������" addr=192.168.88.1 index=2
rem echo %nip%
rem %nip%

goto set_end

rem ��˾������˫IP
:bgnw88
set nip=netsh int ip set address name="��������" source=static addr=192.168.1.113 mask=255.255.0.0 gateway=192.168.1.1 gwmetric=1
echo %nip%
%nip%
set nip=netsh int ip add address name="��������" 192.168.88.113 255.255.0.0
echo %nip%
%nip%
set nip=netsh int ip add address name="��������" gateway=192.168.88.1 gwmetric=1
echo %nip%
%nip%


goto set_end

rem �籣170.111.73��,�ڰ��´������籣
:sb170
set nip=netsh int ip set address name="��������" source=static addr=170.111.73.113 mask=255.255.0.0 gateway=170.111.6.252 gwmetric=1
echo %nip%
%nip%

set nip=netsh int ip add address name="��������" source=static addr=192.168.1.113 mask=255.255.0.0 gateway=192.168.1.1 gwmetric=1
echo - %nip%
rem %nip%

goto set_end

:sb19
set c_ip=
set /p c_ip= ��¼��61~64:

set nip=netsh interface ip set address name="��������" source=static addr=19.129.8.%c_ip% mask=255.255.255.0 gateway=19.129.8.254 gwmetric=0
echo %nip%

:sel_ok_start_sb19
set c_ok=
set /p c_ok=ȷ��(yִ��/n����¼��/c�˵�ѡ��/pPingIP/q�˳�ѡ��):
if "%c_ok%"=="" goto sel_ok_start_sb19
if not "%c_ok%"=="" set c_ok=%c_ok:~0,1%
if "%c_ok%"=="y" goto set_ok_y_sb19
if "%c_ok%"=="n" goto sb19
if "%c_ok%"=="c" goto start_first
if "%c_ok%"=="p" goto ping_ip_sb19
if "%c_ok%"=="q" goto set_end
goto sel_ok_start_sb19

:ping_ip_sb19
ping 19.129.8.%c_ip%
goto sel_ok_start_sb19

:set_ok_y_sb19
%nip%


goto set_end

:sb_30_0
rem 200.30.0.1
set s_ip=200.30.0.141
set s_gateway=200.30.0.152
set nip=netsh interface ip set address name="��������" source=static addr=%s_ip% mask=255.255.0.0 gateway=%s_gateway% gwmetric=0
echo %nip%
%nip%

goto set_end

:sb_30_10
set nip=netsh interface ip set address name="��������" source=static addr=200.30.10.113 mask=255.255.0.0 gateway=200.30.10.1 gwmetric=0
echo %nip%
%nip%

goto set_end

:sb150
set c_ip=
set /p c_ip= ��¼��15~...:

set nip=netsh interface ip set address name="��������" source=static addr=150.111.4.%c_ip% mask=255.255.0.0 gateway=150.111.100.1 gwmetric=0
echo %nip%

:sel_ok_start_sb150
set c_ok=
set /p c_ok=ȷ��(yִ��/n����¼��/c�˵�ѡ��/q�˳�ѡ��):
if "%c_ok%"=="" goto sel_ok_start_sb150
if not "%c_ok%"=="" set c_ok=%c_ok:~0,1%
if "%c_ok%"=="y" goto set_ok_y_sb150
if "%c_ok%"=="n" goto sb150
if "%c_ok%"=="c" goto start_first
if "%c_ok%"=="q" goto set_end
goto sel_ok_start_sb150

:set_ok_y_sb150
%nip%

:sel_ok_start_sb150_ly
set c_ok=
set /p c_ok=�Ƿ�����·��(y/n):
if "%c_ok%"=="" goto sel_ok_start_sb150_ly
if not "%c_ok%"=="" set c_ok=%c_ok:~0,1%
if "%c_ok%"=="y" goto set_ok_y_sb150_yl

goto set_end

:set_ok_y_sb150_yl
set nip=route add 200.10.10.0 mask 255.255.255.0 150.111.100.252
echo %nip%
%nip%

:set_end

ipconfig/all


rem �˳�����,ѭ��
:end

rem pause >nul
rem pause
echo.
echo :netsh,help,cmd /c command,db2cmd /c ..,ipconfig /all, arp -a,ping ip -t
echo �������������,0�˳�,1�رմ���(exit),2���¿�ʼ (����󰴻س�,��ִ������)
:end_1
set choice=
set flag=
set /p choice=
IF NOT "%choice%"=="" SET Choice2=%choice:~0,1%
IF "%choice2%"=="" goto end_1
if /i %choice2%==0 goto end_2
if /i %choice2%==1 goto exit_1
if /i %choice2%==2 goto start_first
%choice%
set choice=
goto end_1

:exit_1
pause
exit

:end_2
pause

rem # netsh interface ip dump > c:\aaaa.txt
rem # netsh exec c:\aaaa.txt
rem # ----------------------------------
rem # �ӿ� IP ����
rem # ----------------------------------
rem pushd interface ip
rem
rem
rem # "��������" �Ľӿ� IP  ����
rem
rem set address name="��������" source=static addr=170.111.73.113 mask=255.255.0.0
rem add address name="��������" addr=192.168.1.113 mask=255.255.0.0
rem set address name="��������" gateway=192.168.1.1 gwmetric=0
rem add address name="��������" gateway=170.111.6.252 gwmetric=1
rem set dns name="��������" source=static addr=202.96.128.86 register=PRIMARY
rem set wins name="��������" source=static addr=none
rem
rem
rem popd
rem # �ӿ� IP ���ý���

rem ���ǲ���
rem set address name="��������" source=static addr=150.111.4.15 mask=255.255.0.0
rem set address name="��������" gateway=150.111.100.1 gwmetric=1
rem set dns name="��������" source=static addr=202.96.128.86 register=PRIMARY
rem set wins name="��������" source=static addr=none
rem + ·�� route add 200.10.10.0 mask 255.255.255.0 150.111.100.252
