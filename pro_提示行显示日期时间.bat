
@rem ��ʾ��Ϣ����,
@echo ����1: p ��ʾ=����ʱ��·�� , n ��p ����·��
@echo ����2: ��ʾ��ʱ����·��֮��

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

@rem û����ͬ����1Ϊp

@set cs1=p
goto cs1_p

:all_end
