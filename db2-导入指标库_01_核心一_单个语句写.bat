
@rem ----------�汾��Ϣ-------------
@rem 11:14 2011-3-25 liqj add YS_DWJBXXBG,WF_GZRW
@rem 2011-3-30 09:21:11 liqj add YS_RYZYXX
@rem   YS_GRBSTSMX �����˷�̫�󣬷ŵ�����ִ����ȥ
@rem   ��������ʹ��Сд����д��׺����; ����С��д�ļ����ͺ�׺���Ҵ�д.
@rem   ʹ�ñ�����ʽ�����ٽű���С

@rem db2cmd db2-����ָ���_01_����һ.bat

title=%* start
@rem ��ʾʱ��+·�� %
prompt=$d$s$t$s$p$g

@echo ����ָ���
db2 connect to fslwzb user fslwzb using fssi

@echo ��47��=3����+(18+2+1)��ϵ+13����+4ʧҵ+9����
@rem load ����˵����
@rem delprioritychar:��ֹ�ַ����лس���, fastparse:����Ч���ʽ, anyorder:��˳�����
@rem generatedignore:�����м����ֶ�ʱ����load�����ļ��еļ����ֶ�ֵ,���Ǹ��ݼ��㷽ʽ������
@rem identityoverride:�������Զ������ֶ�ʱ����load���ļ��м����ֶ�ֵ
@rem statistics yes with distribution and detailed indexes all:�������ݺ�ִ��ͳ����Ϣ�ռ�,ֻ��replace intoѡ��ſ�ָ��
@rem nonrecoverable:���ù鵵��־��ʽ�����ݿ⴦�����ݹ���

@rem ����С���ѡ��:mod=��S��,opt=ѡ��(�ռ���ϸͳ����Ϣ)
@set opt=statistics yes with distribution and detailed indexes all nonrecoverable
@set mod=modified by delprioritychar fastparse anyorder
@rem mod_gen=�м����ֶε���S��,opt_big=����ѡ��(ֻ�ռ��ռ�ͳ����Ϣ)
@set mod_gen=modified by generatedignore fastparse anyorder
@set opt_big=statistics yes and indexes all nonrecoverable

@rem ����:db2 load from S_MZDZB of del modified by delprioritychar fastparse anyorder messages load_hx1_bxgx.log replace into fslwzb.S_MZDZB statistics yes with distribution and detailed indexes all nonrecoverable

title=load ���� 3�ű�
db2 load from S_ZGPJGZ    of del %mod% messages load_hx1_cs.log replace into fslwzb.S_ZGPJGZ  %opt%
db2 load from S_LTXDYLB   of del %mod% messages load_hx1_cs.log replace into fslwzb.S_LTXDYLB %opt%
db2 load from S_ZJCSZ     of del %mod% messages load_hx1_cs.log replace into fslwzb.S_ZJCSZ   %opt%

title=load ���չ�ϵ 18�ű�+2+1+5*2
@rem start "load ys_grcbxx" db2 -v load from ys_grcbxx of del %mod% messages load_hx1_bxgx-grcb.log replace into fslwzb.ys_grcbxx %opt%
@rem start "load ys_grjbxx" db2 -v load from ys_grjbxx of del %mod% messages load_hx1_bxgx-grjb.log replace into fslwzb.ys_grjbxx %opt%
@rem start "load ylmx" db2 -v load from ys_ylbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-ylmx.log replace into fslwzb.ys_ylbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load yilmx" db2 -v load from ys_yilbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-yilmx.log replace into fslwzb.ys_yilbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load gsmx" db2 -v load from ys_gsbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-gsmx.log replace into fslwzb.ys_gsbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load shengymx" db2 -v load from ys_shengybxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-shymx.log replace into fslwzb.ys_shengybxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load jmzymx" db2 -v load from ys_jmzybxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-jmzymx.log replace into fslwzb.ys_jmzybxgryjsjmx statistics yes and indexes all nonrecoverable

start db2cmd /c db2_load_one.bat ys_grcbxx del replace 0 0 1
start db2cmd /c db2_load_one.bat ys_grjbxx del replace 0 0 1
@rem 2011-3-30 11:14:48 liqj 5��Ӧ��ʵ����ϸ��ʹ������ͬ���ķ�ʽ������������������
db2 load from ys_ylbxgryjsjmx_scrz_zl     of del %mod% messages load_hx1_bxgx-scrz_zl.log replace into fslwzb.ys_ylbxgryjsjmx_scrz_zl     %opt%
db2 load from ys_yilbxgryjsjmx_scrz_zl    of del %mod% messages load_hx1_bxgx-scrz_zl.log replace into fslwzb.ys_yilbxgryjsjmx_scrz_zl    %opt%
db2 load from ys_gsbxgryjsjmx_scrz_zl     of del %mod% messages load_hx1_bxgx-scrz_zl.log replace into fslwzb.ys_gsbxgryjsjmx_scrz_zl     %opt%
db2 load from ys_shengybxgryjsjmx_scrz_zl of del %mod% messages load_hx1_bxgx-scrz_zl.log replace into fslwzb.ys_shengybxgryjsjmx_scrz_zl %opt%
db2 load from ys_jmzybxgryjsjmx_scrz_zl   of del %mod% messages load_hx1_bxgx-scrz_zl.log replace into fslwzb.ys_jmzybxgryjsjmx_scrz_zl   %opt%
db2 load from ys_ylbxgryjsjmx_clsj_zl     of del %mod% messages load_hx1_bxgx-clsj_zl.log replace into fslwzb.ys_ylbxgryjsjmx_clsj_zl     %opt%
db2 load from ys_yilbxgryjsjmx_clsj_zl    of del %mod% messages load_hx1_bxgx-clsj_zl.log replace into fslwzb.ys_yilbxgryjsjmx_clsj_zl    %opt%
db2 load from ys_gsbxgryjsjmx_clsj_zl     of del %mod% messages load_hx1_bxgx-clsj_zl.log replace into fslwzb.ys_gsbxgryjsjmx_clsj_zl     %opt%
db2 load from ys_shengybxgryjsjmx_clsj_zl of del %mod% messages load_hx1_bxgx-clsj_zl.log replace into fslwzb.ys_shengybxgryjsjmx_clsj_zl %opt%
db2 load from ys_jmzybxgryjsjmx_clsj_zl   of del %mod% messages load_hx1_bxgx-clsj_zl.log replace into fslwzb.ys_jmzybxgryjsjmx_clsj_zl   %opt%
@rem ��ϸ�����ֱ�Ӵ����ɾ����־/�����ϸ���޸ļ�¼ͬ��������, Ҫ���±���洢����
db2 "call sysproc.REBIND_ROUTINE_PACKAGE('P','P_ZB_TB_MX_ZL_FSLWZB','ANY')"
start db2cmd /c db2_exec_tb_mx_zl.bat YS_YLBXGRYJSJMX
start db2cmd /c db2_exec_tb_mx_zl.bat YS_YILBXGRYJSJMX
start db2cmd /c db2_exec_tb_mx_zl.bat YS_GSBXGRYJSJMX
start db2cmd /c db2_exec_tb_mx_zl.bat YS_SHENGYBXGRYJSJMX
start db2cmd /c db2_exec_tb_mx_zl.bat YS_JMZYBXGRYJSJMX

db2 load from WF_GZRW     of del %mod% messages load_hx1_bxgx.log replace into fslwzb.WF_GZRW     %opt%
db2 load from YS_DWCBXX   of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_DWCBXX   %opt%
db2 load from YS_DWJBXX   of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_DWJBXX   %opt%
db2 load from YS_DWJBXXBG of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_DWJBXXBG %opt%
@rem �����˷�̫�󣬷ŵ�����ִ����ȥ
@rem db2 load from ys_grbstsmx of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_GRBSTSMX %opt%
start db2cmd /c db2_load_one.bat ys_grbstsmx del replace 0 0 1

db2 load from YS_GRQKHXXX of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_GRQKHXXX %opt%
db2 load from YS_GRQQXX   of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_GRQQXX   %opt%
db2 load from YS_GRSTJFYS of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_GRSTJFYS %opt%
db2 load from YS_GRYCXJF  of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_GRYCXJF  %opt%
db2 load from YS_RYZYMX   of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_RYZYMX   %opt%
db2 load from YS_RYZYXX   of del %mod% messages load_hx1_bxgx.log replace into fslwzb.YS_RYZYXX   %opt%

db2 load from YS_GWYYLBZGRYJSJMX of del %mod_gen% messages load_hx1_bxgx.log replace into fslwzb.ys_gwyylbzgryjsjmx %opt%
db2 load from YS_JMZYBXQCZYJSJMX of del %mod_gen% messages load_hx1_bxgx.log replace into fslwzb.YS_JMZYBXQCZYJSJMX %opt%
db2 load from YS_JMZYBXZCZYJSJMX of del %mod_gen% messages load_hx1_bxgx.log replace into fslwzb.YS_JMZYBXZCZYJSJMX %opt%

title=load ���� 13�ű�
db2 load from WF_GSGZRWB    of del %mod% messages load_hx1_gs.log replace into fslwzb.WF_GSGZRWB    %opt%
db2 load from YZ_GSBFTFMX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSBFTFMX   %opt%
db2 load from YZ_GSBXDYZFMX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSBXDYZFMX %opt%
db2 load from YZ_GSBXRDXX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSBXRDXX   %opt%
db2 load from YZ_GSBXSGDJXX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSBXSGDJXX %opt%
db2 load from YZ_GSDQDYXX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSDQDYXX   %opt%
db2 load from YZ_GSDYTZXX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSDYTZXX   %opt%
db2 load from YZ_GSGYQSJBXX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSGYQSJBXX %opt%
db2 load from YZ_GSKFQJFYMX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSKFQJFYMX %opt%
db2 load from YZ_GSLDNLJDXX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSLDNLJDXX %opt%
db2 load from YZ_GSRYJBXX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSRYJBXX   %opt%
db2 load from YZ_GSYLFYBXXX of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSYLFYBXXX %opt%
db2 load from YZ_GSYLFYMX   of del %mod% messages load_hx1_gs.log replace into fslwzb.YZ_GSYLFYMX   %opt%
title=load ʧҵ 4�ű�
db2 load from YZ_SYBXDYZFMX of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYBXDYZFMX %opt%
db2 load from YZ_SYDYXX     of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYDYXX     %opt%
db2 load from YZ_SYRYDYQK   of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYRYDYQK   %opt%
db2 load from YZ_SYRYJBXX   of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYRYJBXX   %opt%
title=load ���� 9�ű�
db2 load from YZ_YLDYGZZFMX of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLDYGZZFMX %opt%
db2 load from YZ_YLDYXX     of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLDYXX     %opt%
db2 load from YZ_YLGYQSXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLGYQSXX   %opt%
db2 load from YZ_YLJFZSXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLJFZSXX   %opt%
db2 load from YZ_YLRYJBXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLRYJBXX   %opt%
db2 load from YZ_YLRYJBXXBD of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLRYJBXXBD %opt%
db2 load from YZ_YLYCXDYXX  of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLYCXDYXX  %opt%
db2 load from YZ_YLYWJBXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLYWJBXX   %opt%

@rem ������ϸ-���Сд+��׺, ��Ҫ�������ִ��
title=load ������ϸ yz_yldyzfmx
db2 load from yz_yldyzfmx.del of del %mod_gen% messages load_hx1_yl.log replace into fslwzb.yz_yldyzfmx %opt_big%

title=%* end
pause
