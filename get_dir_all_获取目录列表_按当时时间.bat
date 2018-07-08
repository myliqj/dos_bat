
@set t_h=%time:~0,2%
@set t_m=%time:~3,2%
@set t_s=%time:~6,2%
@if /i %t_h% lss 10 set t_h=0%t_h:~1,1%

@set d=%date:~0,4%%date:~5,2%%date:~8,2%

@set dt=%d%_%t_h%%t_m%%t_s%

@set out_file=%dt%_%2_dir_all_file_info.txt
@echo out_file=%out_file% >>"%out_file%"
@echo start ---- %date% %time% dir /-c /t:w /s "%1" >>"%out_file%"
@echo. >>"%out_file%"
dir /-c /t:w /s "%1" >>"%out_file%"
@echo. >>"%out_file%"
@echo end ---- %date% %time% dir /-c /t:w /s "%1" >>"%out_file%"
