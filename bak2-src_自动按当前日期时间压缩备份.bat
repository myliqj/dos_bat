

title= ѹ������Delphi���� write by ���Ľ� ver 2.0 (2010-08-02 23:59:59)

@ECHO   OFF  


::color ���������,��һλ������ɫ,�ڶ�λ�����ִ���ǰ��ɫ
color 37

::ɾ��D7����ʱ�ļ�
::ɾ��һ�ļ��У��������ļ��У������к�׺��Ϊ ָ������ ���ļ�
cd   %pathName% 
del *.cfg /s 
del *.dof /s 
del *.ddp /s 
del *.~dpk /s 
del *.~ddp /s 
del *.~dpr /s 
del *.~pas /s 
del *.~dfm /s 
del *.dcu /s 
del *.dsk /s 





::ɾ��D2007����ʱ�ļ�
::********************** ע�� ************************
::���������ļ����Ҳ�ɾ���ļ��м������ļ�
::�г���ǰĿ¼����Ŀ¼�а�����__history�����ļ��У�Ȼ��ɾ����
::dir /s /b /a:d �����оٵ�ǰĿ¼����Ŀ¼����/s Ҳ�о���Ŀ¼��/b ���ر�����Ϣ��ժҪ��/a ֻ�г�ָ�����Ե��ļ���d��ʾ�ļ��С���
::findstr /i "\\__history$" ���г���Ŀ¼���ҳ�ƥ�䡰\__history�����ļ��У���/i �����ִ�Сд��
::for /f "usebackq tokens=1* delims=/" %%a in ...do remdir /s /q %%a ɾ�����ҵ����ļ��С�(/s ɾ����Ŀ¼,/q ����Ҫȷ�ϣ�
::******************************************************
::cd
for /f "usebackq tokens=1* delims=/" %%a in (`dir /s /b /a:d ^| findstr /i "\\__history$"`) do rmdir /s /q "%%a"



::�����ļ�
echo ��ǰ�̷���%~d0
echo ��ǰ�̷���·����%~dp0

set "lj=%~p0"
set "lj=%lj:\= %"
for %%a in (%lj%) do set wjj=%%a
echo ��ǰ�ļ���:%wjj%

::���Сʱ��ֻ��һλ���֣�����м��пո����������⣬��ʹ�����·�����0
set hh=%time:~0,2%
if /i %hh% LSS 10 (set hh=0%time:~1,1%)

::���ñ����ļ�����
set bakFileName=%wjj%_%date:~0,4%%date:~5,2%%date:~8,2%_%hh%%time:~3,2%%time:~6,2%.rar

if   exist   ..\backup   goto   creat_dst  
md   ..\backup

:creat_dst
set rar="%ProgramFiles%\WinRAR\Rar.exe"
set inpath=.\
set outpath=..\backup


%RAR% a  -k -r -s -ibck "%outpath%\%bakFileName%" "%inpath%"


echo ��ǰʱ���ǣ�%date:~0,4%��%date:~5,2%��%date:~8,2%��%time:~0,2%ʱ%time:~3,2%��%time:~6,2%��

echo �Ѿ����浽��%outpath%\%bakFileName%

pause



