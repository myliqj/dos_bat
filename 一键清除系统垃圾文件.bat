@echo off
title һ�����ϵͳ�����ļ�
color 0A
mode con: cols=75 lines=28
echo.
echo.��  ������ ��  ��     �q���������������������������r
echo.��      �q��������������   һ�����ϵͳ�����ļ�   ���������������r
echo.��      ����������    �t���������������������������s��          ��
echo.      ����                                                      ��
echo.��      ��    ���������������������������ɾ������վ����ʱĿ  ��
echo.��      ��¼������򿪹����ĵ��ۼ��ȡ���ϵͳ�������а����������ܩ�
echo.��      �������ٶ��������⡣�����ٶ���ͨ������Ϊ̫������õ����Щ�
echo.��      ��ռ����CPU���ڴ���Դ���£���ɾ��һЩ�ļ����ܽ�������� ��
echo.��      ��װ��ϵͳ�󣬼�ʱ��Ghost���ݡ��Ժ�����������в����ˣ� ��
echo.��      ���ͻָ�ϵͳ��������׵İ취��                        ��
echo.��      ��                                                      ��
echo.��      ��======================================================��
echo.��      ��                                                      ��
echo.��      ��    �밴�������ʼ��������ļ�,��ɺ�����Զ��˳�!    ��
echo.��      ��                                                      ��
echo.��      �t�������������������������������������������������������s
echo.                                  
cls
echo.
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\*.log
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
rd /q /s "C:\Program Files\pipi\pipicache"&&md "C:\Program Files\pipi\pipicache"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
exit