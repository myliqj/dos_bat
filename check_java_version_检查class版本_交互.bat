
@echo off
@title %0 ���java��汾 %~dp0JavaClassVersionChecker.jar file
@echo cur-bat:%0
@setlocal
@cd /D %~dp0

@echo java_home=%java_home%

@set local_java_home=%java_home%
@set ext_list=jar,war,class
@set opt_view=-v 1 -gc

:show_help

if "%fileName%"=="y-help" (
  @echo   Usage: java -jar java-class-version-checker-^<version^>.jar [-e] [-v] Path1 Path2 ..
  @echo   -e Comma separated list of file extensions. e.g. jar^(default^),war,class,..   -- ��׺���б�
  @echo   -v Verbosity. Valid values are 1^(default^) and 2                              -- ��ʾ��ʽ 
  @echo      1: Prints stats: version, no. of classes, jar file and other versions of class files found in the archive
  @echo         -gc^(default^) Group by container e.g. folder, archive
  @echo         -gv Group by Java version
  @echo      2: Lists all the files with version in the output
  @echo   Path can be any folder or file which matches the provided extension^(s^)
  @echo   e.g. 1. java -jar java-class-version-checker-^<version^>.jar Folder1WithJars Folder2WithJars
  @echo        2. java -jar java-class-version-checker-^<version^>.jar -e jar,war,ear xyz.war abc.ear Folder2
  @echo        3. java -jar java-class-version-checker-^<version^>.jar abc.jar
  @echo        4. java -jar java-class-version-checker-^<version^>.jar -e class,jar abc.jar Xyz.class FolderWithClasses FolderWithJars
  @echo   Note: Except 'class' all other files ^(with matching extension e.g. war,zip,ear^) will be considered as compressed zip files
) else (
  @echo.
  @echo   ------------------help---------------
  @echo   1.¼��·����jar�ļ����������ļ����˴��ڣ�·����ȥ�����\�������Ҵ�·���µ�jar����ʾ�汾
  @echo   2.setList^(e^) ���ú�׺�б� , setView^(v^) ������ʾ��ʽ, setJava ����Jdk·��
  @echo   3.��׺�б� -e %ext_list% ,������ jar^(default^),war,class,..
  @echo   4.��ʾ��ʽ %opt_view% ,������ -v 1 -gc / -v 1 -gv �� -v 2 
  @echo                �ֱ��ʾĬ��^(���ļ�/·��^),�汾���� �� ������class�汾���� 
  @echo   5.��ǰִ�е�java_home·�� ^(��ǰ%java_home%^)
  @echo   6.¼�룡ǰ׺��ʾֱ��ִ������
  @echo   7.q/quit/exit �˳�, exit��رմ���
  @echo   8.h/help, ��ʾ���� ,y-help ��ʾԭ���� ���β�¼����ִ���ϴ���ͬ������
  @echo.
)

:start
@set /P fileName=(�ϴ����%fileName%) ���ȫ·������
@if /i "%fileName:~0,1%" == "!" (
  %fileName:~1%
  goto start
)

@if /I "%fileName%" == "q" goto end_all
@if /I "%fileName%" == "quit" goto end_all
@if /I "%fileName%" == "exit" goto end_all
@if /I "%fileName%" == "setJava" goto set_javahome
@if /I "%fileName%" == "setList" goto set_List
@if /I "%fileName%" == "e" goto set_List
@if /I "%fileName%" == "setView" goto set_View
@if /I "%fileName%" == "v" goto set_View
@if /I "%fileName%" == "h" goto show_help
@if /I "%fileName%" == "help" goto show_help
@if /I "%fileName%" == "y-help" goto show_help

@echo "%java_home%\bin\java.exe" -jar JavaClassVersionChecker.jar -e %ext_list% %opt_view% "%fileName%"
"%java_home%\bin\java.exe" -jar JavaClassVersionChecker.jar -e %ext_list% %opt_view% "%fileName%"

@goto start


:set_javahome

@set /P local_java_home=���� java_home(%local_java_home%):
@if /I "%local_java_home%"=="java_home" (
  echo ʹ��java_home:%java_home%
  set local_java_home=%java_home%
)
if not exist "%local_java_home%\bin\java.exe" (
  echo %local_java_home%\bin\java.exe �����ڣ�����������
  goto set_javahome
)
goto start


:set_List
@set local_list=%ext_list%
@set /P local_list=���ú�׺��[������ jar^(default^),war,class,..] (%local_list%):
@if /I "%local_list%"=="" (
  ::echo ����¼���ֵ�����û��ϴ�ֵ %ext_list%
  ::set local_list=%ext_list%
  goto :start
)
@if /I "q"=="%local_list%" goto :start
@if /I "b"=="%local_list%" goto :start
@set ext_list=%local_list%
goto :start


:set_View
@set local_opt=%opt_view%
@set /P local_opt=������ʾ��ʽ[������ 1:-v 1 -gc / 2:-v 1 -gv �� 3:-v 2] ��¼��1,2,3 (%local_opt%):
@if /I "%local_opt%"=="" (
  :echo ����¼���ֵ�����û��ϴ�ֵ %opt_view%
  :set local_opt=%opt_view%
  goto :start
)

@if /I "q"=="%local_opt%" goto :start
@if /I "b"=="%local_opt%" goto :start

@if /I "1"=="%local_opt%" set opt_view=-v 1 -gc && goto :start
@if /I "2"=="%local_opt%" set opt_view=-v 1 -gv && goto :start
@if /I "3"=="%local_opt%" set opt_view=-v 2 && goto :start

@set opt_view=%local_opt%
@echo ��¼��1,2,3,q,b������һ��
goto :set_View




:end_all
@if /I "%fileName%" == "exit" exit
pause
