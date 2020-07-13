@echo off
setlocal enabledelayedexpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::
:: DOS下用批处理计算N天前的日期或者N天前后的日期 ::
:: 2k、xp、2003、win7下测试通过                  ::
:: @author zhzhl0                                ::
:: mklv2005#163.com                              ::
:::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo 计算 days 天前或 days 天后的日期;
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: 正数：days 天前的日期；负数：days 天后的日期；
:: set /p days=请输入天数(days天前正数, days天后负数)
:: set days=17
set days=%1
if /i ""=="%days%" set days=1

rem program 'begin' 开始
:begin
:: 判断操作系统
ver | find /i "5.0" > nul && goto 2k || goto xp

rem program 'xp'；xp 系统
:xp
for /f "tokens=1-3 delims=-/. " %%i in ("%date%") do ( 
  set /a yy=%%i, mm=%%j, dd=%%k 
) 
goto nornal

rem program '2k'；2k 系统
:2k
for /f "tokens=2-4 delims=-/. " %%i in ("%date%") do ( 
  set /a yy=%%i, mm=%%j, dd=%%k 
)
goto nornal

rem program 'nornal'；计算日期
:nornal
:: echo %yy%-%mm%-%dd%；算出%yy%是否是闰年
set /a leap="^!(%yy% %% 4) & ^!(^!(%yy% %% 100)) | ^!(%yy% %% 400)"

:: 计算日期相差的天数
set /a nd=!dd!-!days!

:: echo [nd]=%nd%  计算当月的天数
set /a num=0, mday=0, max=28+leap
set str=31 %max% 31 30 31 30 31 31 30 31 30 31
for %%i in (%str%) do ( 
  set /a num+=1 
  if !num! equ !mm! set /a mday=%%i 
)

::echo yy=%yy% mm=%mm% dd=%dd% nd=%nd% mday=%mday% leap=%leap%； 如果小于等于0则转到xiaoyu块处理
if !nd! leq 0 goto xiaoyu
:: 如果大于当月天数则转到dayu块处理
if !nd! gtr !mday! goto dayu 

set nm=%mm%
goto println

rem program 'dayu' 处理日期相差天数大于当月天数的情况
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

rem program 'xiaoyu' 处理日期相差天数小于等于0的情况
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

rem program 'println' 输出
:println
set mm=0%nm%
set dd=0%nd%
set mm=%mm:~-2%
set dd=%dd:~-2%
if !days! leq 0 echo 现在日期是:%date%,%days:~1%天后的日期是：%yy%-%mm%-%dd% 
if !days! gtr 0 echo 现在日期是:%date%,%days%天前的日期是：%yy%-%mm%-%dd%

echo %days%天前(mm-dd-yyyy): %mm%-%dd%-%yy%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
endlocal & set a_days_rq=%mm%-%dd%-%yy%