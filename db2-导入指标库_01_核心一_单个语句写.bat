
@rem ----------版本信息-------------
@rem 11:14 2011-3-25 liqj add YS_DWJBXXBG,WF_GZRW
@rem 2011-3-30 09:21:11 liqj add YS_RYZYXX
@rem   YS_GRBSTSMX 补发退发太大，放到单独执行中去
@rem   单独导出使用小写，且写后缀名称; 所有小表不写文件类型后缀名且大写.
@rem   使用变量方式，减少脚本大小

@rem db2cmd db2-导入指标库_01_核心一.bat

title=%* start
@rem 显示时间+路径 %
prompt=$d$s$t$s$p$g

@echo 联接指标库
db2 connect to fslwzb user fslwzb using fssi

@echo 共47表=3参数+(18+2+1)关系+13工伤+4失业+9养老
@rem load 参数说明：
@rem delprioritychar:防止字符中有回车行, fastparse:不在效验格式, anyorder:按顺序加载
@rem generatedignore:表中有计算字段时，让load忽略文件中的计算字段值,而是根据计算方式填数。
@rem identityoverride:表中有自动增长字段时，让load从文件中加载字段值
@rem statistics yes with distribution and detailed indexes all:导入数据后执行统计信息收集,只有replace into选项才可指定
@rem nonrecoverable:不让归档日志方式的数据库处理备份暂挂中

@rem 所有小表的选项:mod=修S符,opt=选项(收集详细统计信息)
@set opt=statistics yes with distribution and detailed indexes all nonrecoverable
@set mod=modified by delprioritychar fastparse anyorder
@rem mod_gen=有计算字段的修S符,opt_big=大表的选项(只收简单收集统计信息)
@set mod_gen=modified by generatedignore fastparse anyorder
@set opt_big=statistics yes and indexes all nonrecoverable

@rem 例子:db2 load from S_MZDZB of del modified by delprioritychar fastparse anyorder messages load_hx1_bxgx.log replace into fslwzb.S_MZDZB statistics yes with distribution and detailed indexes all nonrecoverable

title=load 参数 3张表
db2 load from S_ZGPJGZ    of del %mod% messages load_hx1_cs.log replace into fslwzb.S_ZGPJGZ  %opt%
db2 load from S_LTXDYLB   of del %mod% messages load_hx1_cs.log replace into fslwzb.S_LTXDYLB %opt%
db2 load from S_ZJCSZ     of del %mod% messages load_hx1_cs.log replace into fslwzb.S_ZJCSZ   %opt%

title=load 保险关系 18张表+2+1+5*2
@rem start "load ys_grcbxx" db2 -v load from ys_grcbxx of del %mod% messages load_hx1_bxgx-grcb.log replace into fslwzb.ys_grcbxx %opt%
@rem start "load ys_grjbxx" db2 -v load from ys_grjbxx of del %mod% messages load_hx1_bxgx-grjb.log replace into fslwzb.ys_grjbxx %opt%
@rem start "load ylmx" db2 -v load from ys_ylbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-ylmx.log replace into fslwzb.ys_ylbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load yilmx" db2 -v load from ys_yilbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-yilmx.log replace into fslwzb.ys_yilbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load gsmx" db2 -v load from ys_gsbxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-gsmx.log replace into fslwzb.ys_gsbxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load shengymx" db2 -v load from ys_shengybxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-shymx.log replace into fslwzb.ys_shengybxgryjsjmx statistics yes and indexes all nonrecoverable
@rem start "load jmzymx" db2 -v load from ys_jmzybxgryjsjmx of del modified by generatedignore fastparse anyorder messages load_hx1_bxgx-jmzymx.log replace into fslwzb.ys_jmzybxgryjsjmx statistics yes and indexes all nonrecoverable

start db2cmd /c db2_load_one.bat ys_grcbxx del replace 0 0 1
start db2cmd /c db2_load_one.bat ys_grjbxx del replace 0 0 1
@rem 2011-3-30 11:14:48 liqj 5个应缴实缴明细表使用增量同步的方式，不再整个表导过来了
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
@rem 明细表导入后直接处理从删除日志/最近明细表修改记录同步到本地, 要重新编译存储过程
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
@rem 补发退发太大，放到单独执行中去
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

title=load 工伤 13张表
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
title=load 失业 4张表
db2 load from YZ_SYBXDYZFMX of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYBXDYZFMX %opt%
db2 load from YZ_SYDYXX     of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYDYXX     %opt%
db2 load from YZ_SYRYDYQK   of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYRYDYQK   %opt%
db2 load from YZ_SYRYJBXX   of del %mod% messages load_hx1_sy.log replace into fslwzb.YZ_SYRYJBXX   %opt%
title=load 养老 9张表
db2 load from YZ_YLDYGZZFMX of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLDYGZZFMX %opt%
db2 load from YZ_YLDYXX     of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLDYXX     %opt%
db2 load from YZ_YLGYQSXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLGYQSXX   %opt%
db2 load from YZ_YLJFZSXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLJFZSXX   %opt%
db2 load from YZ_YLRYJBXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLRYJBXX   %opt%
db2 load from YZ_YLRYJBXXBD of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLRYJBXXBD %opt%
db2 load from YZ_YLYCXDYXX  of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLYCXDYXX  %opt%
db2 load from YZ_YLYWJBXX   of del %mod% messages load_hx1_yl.log replace into fslwzb.YZ_YLYWJBXX   %opt%

@rem 养老明细-大表，小写+后缀, 需要放在最后执行
title=load 养老明细 yz_yldyzfmx
db2 load from yz_yldyzfmx.del of del %mod_gen% messages load_hx1_yl.log replace into fslwzb.yz_yldyzfmx %opt_big%

title=%* end
pause
