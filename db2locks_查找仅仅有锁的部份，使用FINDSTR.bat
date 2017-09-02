set dir = E:\_Config\IBM_Db2_v9.1

db2 connect to lfssb user db2admin using db2
db2 get snapshot for locks on lfssb >E:\_Config\IBM_Db2_v9.1\lfssb_locks_all.txt
db2 get snapshot for locks on lfssb | findstr /N /R "Ӧ�ó����� Ӧ�ó����ʶ Ӧ�ó����� �������� ���� ��ʽ" >E:\_Config\IBM_Db2_v9.1\lfssb_locks_only.txt

@echo db2 get snapshot for locks on lfssb | findstr /N /R "Ӧ�ó��� ���� ��ʽ" d:\lfssb_locks2.txt

notepad.exe E:\_Config\IBM_Db2_v9.1\lfssb_locks_only.txt

@echo pause >nul
@echo off
@echo db2 get snapshot for locks on lfssb | find /N "��ʽ" d:\lfssb_locks2.txt

@echo FINDSTR [/B] [/E] [/L] [/R] [/S] [/I] [/X] [/V] [/N] [/M] [/O] [/F:file]
@echo         [/C:string] [/G:file] [/D:dir list] [/A:color attributes] [/OFF[LINE]]
@echo         strings [[drive:][path]filename[ ...]]
@echo 
@echo   /B         ��һ�еĿ�ʼ���ģʽ��
@echo   /E         ��һ�еĽ�β���ģʽ��
@echo   /L         ����ʹ�������ַ�����
@echo   /R         �������ַ�����Ϊһ����ʽʹ�á�
@echo   /S         �ڵ�ǰĿ¼��������Ŀ¼������ƥ���ļ���
@echo   /I         ָ���������ִ�Сд��
@echo   /X         ��ӡ��ȫƥ����С�
@echo   /V         ֻ��ӡ������ƥ����С�
@echo   /N         ��ƥ���ÿ��ǰ��ӡ������
@echo   /M         ����ļ�����ƥ���ֻ��ӡ���ļ�����
@echo   /O         ��ÿ��ƥ����ǰ��ӡ�ַ�ƫ������
@echo   /P         �����в��ɴ�ӡ�ַ����ļ���
@echo   /OFF[LINE] �����������ѻ����Լ����ļ���
@echo   /A:attr    ָ����ʮ����λ���ֵ���ɫ���ԡ���� "color /?"
@echo   /F:file    ��ָ���ļ����ļ��б� (/ �������̨)��
@echo   /C:string  ʹ��ָ���ַ�����Ϊ���������ַ�����
@echo   /G:file    ��ָ�����ļ���������ַ����� (/ �������̨)��
@echo   /D:dir     �����Էֺ�Ϊ�ָ�����Ŀ¼�б�
@echo   strings    Ҫ���ҵ����֡�
@echo   [drive:][path]filename
@echo              ָ��Ҫ���ҵ��ļ���
@echo 
@echo ���ǲ����� /C ǰ׺����ʹ�ÿո���������ַ�����
@echo ����: 'FINDSTR "hello there" x.y' ���ļ� x.y ��Ѱ�� "hello" ��
@echo "there"��'FINDSTR /C:"hello there" x.y' �ļ� x.y  Ѱ��
@echo "hello there"��
@echo 
@echo һ����ʽ�Ŀ��ٲο�:
@echo   .        ͨ���: �κ��ַ�
@echo   *        �ظ�: ��ǰ�ַ�����������������ϴ���
@echo   ^        ��λ��: �еĿ�ʼ
@echo   $        ��λ��: �е��յ�
@echo   [class]  �ַ����: �κ����ַ����е��ַ�
@echo   [^class] ���ַ����: �κβ����ַ����е��ַ�
@echo   [x-y]    ��Χ: ��ָ����Χ�ڵ��κ��ַ�
@echo   \x       Escape: Ԫ�ַ� x �������÷�
@echo   \<xyz    ��λ��: �ֵĿ�ʼ
@echo   xyz\    ��λ��: �ֵĽ���
@echo 
@echo �й� FINDSTR ������﷨����ϸ����������������ο���