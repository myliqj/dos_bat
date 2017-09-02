
@rem 提示信息设置,
@echo 参数1: p 显示=日期时间路径 , n 比p 少了路径
@echo 参数2: 显示在时间与路径之间

@set cs1=%1
@set cs2=%2
@echo  cs1=%cs1%,cs2=%cs2%

:cs1_p
@if "%1" == "p" (
  echo  old_prompt=%prompt%
  echo  new_prompt=$d$s$t$s%2$p$g
  prompt=$d$s$t$s%2$p$g
  goto all_end
)

:cs1_n
@if "%1" == "n" (
  echo  old_prompt=%prompt%
  echo  new_prompt=$d$s$t$s%2$g
  prompt=$d$s$t$s%2$g
  echo %cd%
  goto all_end
)

@rem 没参数同参数1为p

@set cs1=p
goto cs1_p

:all_end
