@if "%date:~5,1%"==" " (
  set /a ys=%date:~6,1%-1
) else (
  set /a ys=%date:~5,2%-1
)
@set /a ns=%date:~0,4%
@if "%ys%"=="0" set /a ns=%ns%-1
@if "%ys%"=="0" set ys=12

  @rem set fkssq=%date:~0,4%%date:~5,2%
  @rem set /a fkssq=fkssq-1

@rem %1=auto
@echo current date=%date% %time% , иотб=%ns%-%ys%-01
@if "%1" == "auto" (
  set fkssq=%ns%%ys%
  set lb=[%1]
)else (
  set fkssq=%1
  set lb=[%%1]
)
@echo fkssq=%fkssq% %lb%
