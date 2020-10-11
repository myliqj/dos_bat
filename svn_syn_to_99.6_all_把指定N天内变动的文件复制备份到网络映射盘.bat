
@set t_h=%time:~0,2%
@set t_m=%time:~3,2%
@set t_s=%time:~6,2%
@if /i %t_h% lss 10 set t_h=0%t_h:~1,1%

@set d_year=%date:~0,4%
@set d_month=%date:~5,2%
@set d_day=%date:~8,2%
@set /a d_day_cl=%d_day%-2
@if /i %d_day% lss 1 set d_day_cl=1
@set d_cl=%d_month%-%d_day_cl%-%d_year%

@set d=%date:~0,4%%date:~5,2%%date:~8,2%

@set dt=%d%_%t_h%%t_m%%t_s%

@set src_dir=D:\Repositories
@set desc_dir=O:\d_Repositories


@rem xcopy 参数说明 xcopy /?
@rem /Y 不提示覆盖文件,
@rem /D:m-d-y 复制在指定日期或指定日期以后更改的文件。如果没有提供日期，只复制那些源时间比目标时间新的文件。
@rem /E 复制目录和子目录，包括空的。
@rem /I 如果目标不存在，又在复制一个以上的文件，则假定目标一定是一个目录。
@rem /F 复制时显示完整的源和目标文件名。
@rem /R 覆盖只读文件。
@rem /H 也复制隐藏和系统文件。
@rem /K 复制属性。一般的 Xcopy 会重置只读属性。
@rem /C 即使有错误，也继续复制。
@rem /Z 在可重新启动模式下复制网络文件。


set desc_dir_temp=D:\svn_syn_to_99.6\temp_Repo_%dt%


set logfile=.\logs\svn_syn_file_log_%dt%.txt
echo.>>%logfile%
echo -----------------%date% %time%-----------------start----------------->>%logfile%
@rem 定时任务还必须设置 "只在用户登录时"，"使用最高权限运行" 才能运行,否则能运行但不报错，无任复制文件。
echo net use \\200.30.99.6\ipc$ unisure /user:zhongkebao >>%logfile%
net use \\200.30.99.6\ipc$ unisure /user:zhongkebao >>%logfile%

@rem %d_cl% 固定 05-23-2020
set d_cl=07-01-2020
call dyas_re.bat 5
set d_cl=%a_days_rq%
echo.>>%logfile%
echo xcopy "%src_dir%" "%desc_dir%" /Y /C /D:%d_cl% /E /I /F /R /H /K /Z >>%logfile%
xcopy "%src_dir%" "%desc_dir%" /Y /C /D:%d_cl% /E /I /F /R /H /K /Z >>%logfile%


@rem echo xcopy "%src_dir%" "%desc_dir_temp%" /Y /C /D:%d_cl% /E /I /F /R /H /K /Z >>%logfile%
@rem xcopy "%src_dir%" "%desc_dir_temp%" /Y /C /D:%d_cl% /E /I /F /R /H /K /Z >>%logfile%

@rem echo xcopy "%desc_dir_temp%" "%desc_dir%" /Y /C /E /I /F /R /H /K /Z >>%logfile%
@rem xcopy "%desc_dir_temp%" "%desc_dir%" /Y /C /E /I /F /R /H /K /Z >>%logfile%


echo -----------------%date% %time%-----------------end------------------->>%logfile%
echo.>>%logfile%

