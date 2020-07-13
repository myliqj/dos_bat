
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


@rem xcopy ����˵�� xcopy /?
@rem /Y ����ʾ�����ļ�,
@rem /D:m-d-y ������ָ�����ڻ�ָ�������Ժ���ĵ��ļ������û���ṩ���ڣ�ֻ������ЩԴʱ���Ŀ��ʱ���µ��ļ���
@rem /E ����Ŀ¼����Ŀ¼�������յġ�
@rem /I ���Ŀ�겻���ڣ����ڸ���һ�����ϵ��ļ�����ٶ�Ŀ��һ����һ��Ŀ¼��
@rem /F ����ʱ��ʾ������Դ��Ŀ���ļ�����
@rem /R ����ֻ���ļ���
@rem /H Ҳ�������غ�ϵͳ�ļ���
@rem /K �������ԡ�һ��� Xcopy ������ֻ�����ԡ�
@rem /C ��ʹ�д���Ҳ�������ơ�
@rem /Z �ڿ���������ģʽ�¸��������ļ���


set desc_dir_temp=D:\svn_syn_to_99.6\temp_Repo_%dt%


set logfile=.\logs\svn_syn_file_log_%dt%.txt
echo.>>%logfile%
echo -----------------%date% %time%-----------------start----------------->>%logfile%
@rem ��ʱ���񻹱������� "ֻ���û���¼ʱ"��"ʹ�����Ȩ������" ��������,���������е����������θ����ļ���
echo net use \\200.30.99.6\ipc$ unisure /user:zhongkebao >>%logfile%
net use \\200.30.99.6\ipc$ unisure /user:zhongkebao >>%logfile%

@rem %d_cl% �̶� 05-23-2020
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

