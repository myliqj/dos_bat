rem %*
rem ����˳��1����,2����,3into��ʽ:insert/replace/...,4�Ƿ��м����ֶ�:1������ֵ��,5�Ƿ����Զ������ֶ�:1������ֵ��,6ͳ�Ʒ�ʽ:1��ϸ2������ֵ��ͳ��
@rem start db2cmd /c db2_load_one.bat s_jdmb del replace 0 0 1
@rem ����:db2 load from S_MZDZB of del modified by delprioritychar fastparse anyorder messages load_hx1_bxgx.log replace into fslwzb.S_MZDZB statistics yes with distribution and detailed indexes all nonrecoverable
@rem ��ʾʱ��+·��
prompt=$d$s$t$s$p$g
@rem ���ñ���
@set t=%3
@if "%4"=="1" @set t=%t% generatedignore
@if "%5"=="1" @set t=%t% identityoverride
@if "%6"=="1" @set t=%t% tj=statistics detailed
@if "%6"=="2" @set t=%t% tj=statistics
title=%1.%2 load.... %t%

@set mod=modified by delprioritychar fastparse anyorder
@if "%4"=="1" set mod=%mod% generatedignore
@if "%5"=="1" set mod=%mod% identityoverride
@set opt=
@if "%6"=="1" @set opt=statistics yes with distribution and detailed indexes all
@if "%6"=="2" @set opt=statistics yes and indexes all

db2 connect to fslwzb user fslwzb using fssi
db2 load from %1.%2 of %2 %mod% messages load_%1.log %3 into %1 %opt% nonrecoverable
@echo errorlevel=%errorlevel%
db2 connect reset
title=%1.%2 load end %t%

pause
