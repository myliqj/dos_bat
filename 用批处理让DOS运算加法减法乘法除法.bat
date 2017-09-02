
rem 用批处理让DOS运算加法减法乘法除法
rem 2010年06月23日 13:33
 
rem 处理让DOS运算加法减法乘法除法
@echo off
:chushi
cls
set /a zque=0
set /a cwu=0
echo.
echo ---------------------加减法程序-------------------
echo 程序功能说明：
echo 1、产生两个随机数的加减法；
echo 2、能够统计分数。
echo 提示：做题目过程中，按"q"(小写)退出做题。
echo.
echo       沉沦天子  于2006-1-6日晚
echo ------------------------------------------------
echo 请选择程序:
echo 1、加法程序；
echo 2、减法程序
echo 3、按q退出
echo.
set goto=
set /p goto=请输入您的选择：
if "%goto%"=="1" set 算法=:add && set addorsub=+&& goto :add
if "%goto%"=="q" (goto :over) else set 算法=:sub && set addorsub=-&&goto :sub

----------------------程序说明------------------------
     %random:~-1%的意思就是取随机数的最后一个数字；
     "set jieguo="和"set /p xx:="命令的作用就是产生
     等待输入的提示："xx:"
------------------------------------------------------

:add
set /a shu_1=%random:~-1%
set /a shu_2=%random:~-1%
set /a jieguo_1=%shu_1%+%shu_2%
set jieguo=
set/p jieguo=%shu_1%+%shu_2%=
if "%jieguo%"=="q" goto :exit
if "%jieguo%"=="%jieguo_1%" (goto :right) else goto :wrong

----------------------说明---------------------
第一个if循环引进了一个变量shu_2,用它来储存较小的
数，用shu_1来储存较大的数。这样就解决了产生负数的
问题。
-----------------------------------------------
:sub
set /a shu_1=%random:~-1%
set /a shu_3=%random:~-1%
if %shu_1% leq %shu_3% (set /a shu_2=%shu_1% && set /a shu_1=%shu_3%) else set /a shu_2=%shu_3%
set /a jieguo_1=%shu_1%-%shu_2%
set jieguo=
set/p jieguo=%shu_1%-%shu_2%=
if "%jieguo%"=="%jieguo_1%" goto :right
if "%jieguo%"=="q" (goto :exit) else goto :wrong

-------------------说明-----------------
  这里"%算法%"这个变量储存的是原来你究竟
  选择的是加法还是减法，如果是加法的话则
  加法循环
----------------------------------------
:right
echo.
echo 恭喜您!你做对了!
set /a zque=%zque%+1
echo.
goto %算法%

:wrong
echo.
echo 很遗憾!这一道题你做错了。
echo 正确答案应该是：%shu_1%%addorsub%%shu_2%=%jieguo_1%
set /a cwu=%cwu%+1
echo.
goto %算法%

:exit
set /a tmshu=%zque%+%cwu%
set /a chengji=100*%zque%/%tmshu%
cls
echo -------------------您此次测试结果--------------------
echo 您总共做答了%tmshu%题。
echo 总共答对了%zque%题。
echo 总共答错了%cwu%题。
echo 您的成绩是%chengji%分。
echo.
set goto=
echo -------------------程序结束--------------------------
set /p goto=输入q退出程序，其它继续。
if "%goto%"=="q" (goto :over) else goto :chushi
