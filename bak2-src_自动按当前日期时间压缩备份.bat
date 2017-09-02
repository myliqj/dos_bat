

title= 压缩备份Delphi工程 write by 高文杰 ver 2.0 (2010-08-02 23:59:59)

@ECHO   OFF  


::color 后面的数字,第一位代表背景色,第二位的数字代表前景色
color 37

::删除D7中临时文件
::删除一文件夹（包含子文件夹）中所有后缀名为 指定类型 的文件
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





::删除D2007中临时文件
::********************** 注释 ************************
::用批处理文件查找并删除文件夹及其下文件
::列出当前目录和子目录中包含“__history”的文件夹，然后删除。
::dir /s /b /a:d 用于列举当前目录和子目录。（/s 也列举子目录，/b 隐藏标题信息或摘要，/a 只列出指定属性的文件，d表示文件夹。）
::findstr /i "\\__history$" 在列出的目录中找出匹配“\__history”的文件夹，（/i 不区分大小写）
::for /f "usebackq tokens=1* delims=/" %%a in ...do remdir /s /q %%a 删除所找到的文件夹。(/s 删除子目录,/q 不需要确认）
::******************************************************
::cd
for /f "usebackq tokens=1* delims=/" %%a in (`dir /s /b /a:d ^| findstr /i "\\__history$"`) do rmdir /s /q "%%a"



::备份文件
echo 当前盘符：%~d0
echo 当前盘符和路径：%~dp0

set "lj=%~p0"
set "lj=%lj:\= %"
for %%a in (%lj%) do set wjj=%%a
echo 当前文件夹:%wjj%

::如果小时数只有一位数字，造成中间有空格而出错的问题，请使用如下方法补0
set hh=%time:~0,2%
if /i %hh% LSS 10 (set hh=0%time:~1,1%)

::设置备份文件名称
set bakFileName=%wjj%_%date:~0,4%%date:~5,2%%date:~8,2%_%hh%%time:~3,2%%time:~6,2%.rar

if   exist   ..\backup   goto   creat_dst  
md   ..\backup

:creat_dst
set rar="%ProgramFiles%\WinRAR\Rar.exe"
set inpath=.\
set outpath=..\backup


%RAR% a  -k -r -s -ibck "%outpath%\%bakFileName%" "%inpath%"


echo 当前时间是：%date:~0,4%年%date:~5,2%月%date:~8,2%日%time:~0,2%时%time:~3,2%分%time:~6,2%秒

echo 已经保存到：%outpath%\%bakFileName%

pause



