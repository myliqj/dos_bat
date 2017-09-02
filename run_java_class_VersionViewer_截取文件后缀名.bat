@echo off
mode con: cols=110 lines=15
:index
color 27
cls
echo.
echo     欢迎使用查看class文件版本小工具
echo     我的博客:http://blog.csdn.net/sunyujia/
echo     将class文件拖拽到此窗口后,点击窗口后敲回车.即可显示编译目标class文件的jdk版本
echo.
echo.
set route=%cd%
set ravel=
set /p ravel=    请拖入要查看的class文件:
set "ravel=%ravel:"=%"
if /i "%ravel:~-6%"==".class" if exist "%ravel%" goto go
cls
echo 文件错误,指定文件不存在或不是class文件!
echo 按任意键重新输入... 
echo.
echo.
echo 按任意键重新输入...
pause >nul
goto index

:go
java -jar  VersionViewer.jar %ravel%
echo.
echo 按任意键继续...
pause >nul
goto index
exit


