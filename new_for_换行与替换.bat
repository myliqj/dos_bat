@echo off&setlocal enabledelayedexpansion

:: ִ�з���"^" ��ע��^����Ҫ�ж������У�������ɰѻس���Ϊת��
set lf=^



set yljg_list=QZ_SE,A-02/QZ_SS,A-03/QZ_FY,A-06/QZ_ZX,A-07/QZ_GB,A-08/QZ_MB,A-09/QZ_KQ,A-10/QZ_TJ,A-11/QZ_CY,A-12/QZ_YA,A-13/QZ_XY,A-14/QZ_ZC,A-15/QZ_LS,A-16/QZ_HS,A-17/QZ_NZ,A-19/QZ_YD,A-30/QZ_ZS,A-35/QZ_SW,A-36/QZ_NS,A-37/QZ_LK,A-41/QZ_PF,E-01/QZ_SL,E-07

for /F "delims=, tokens=1,2" %%I in ("%yljg_list:/=!lf!%") do (
      echo %%I %%J
  )



:: һ���ַ�������д��ʹ��^���к��ַ�
set mline=a1^
a2^
a3

:: ��� a1a2a3
echo %mline%

