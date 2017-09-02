set dir = E:\_Config\IBM_Db2_v9.1

db2 connect to lfssb user db2admin using db2
db2 get snapshot for locks on lfssb >E:\_Config\IBM_Db2_v9.1\lfssb_locks_all.txt
db2 get snapshot for locks on lfssb | findstr /N /R "应用程序句柄 应用程序标识 应用程序名 对象类型 表名 方式" >E:\_Config\IBM_Db2_v9.1\lfssb_locks_only.txt

@echo db2 get snapshot for locks on lfssb | findstr /N /R "应用程序 表名 方式" d:\lfssb_locks2.txt

notepad.exe E:\_Config\IBM_Db2_v9.1\lfssb_locks_only.txt

@echo pause >nul
@echo off
@echo db2 get snapshot for locks on lfssb | find /N "方式" d:\lfssb_locks2.txt

@echo FINDSTR [/B] [/E] [/L] [/R] [/S] [/I] [/X] [/V] [/N] [/M] [/O] [/F:file]
@echo         [/C:string] [/G:file] [/D:dir list] [/A:color attributes] [/OFF[LINE]]
@echo         strings [[drive:][path]filename[ ...]]
@echo 
@echo   /B         在一行的开始配对模式。
@echo   /E         在一行的结尾配对模式。
@echo   /L         按字使用搜索字符串。
@echo   /R         将搜索字符串作为一般表达式使用。
@echo   /S         在当前目录和所有子目录中搜索匹配文件。
@echo   /I         指定搜索不分大小写。
@echo   /X         打印完全匹配的行。
@echo   /V         只打印不包含匹配的行。
@echo   /N         在匹配的每行前打印行数。
@echo   /M         如果文件含有匹配项，只打印其文件名。
@echo   /O         在每个匹配行前打印字符偏移量。
@echo   /P         忽略有不可打印字符的文件。
@echo   /OFF[LINE] 不跳过带有脱机属性集的文件。
@echo   /A:attr    指定有十六进位数字的颜色属性。请见 "color /?"
@echo   /F:file    从指定文件读文件列表 (/ 代表控制台)。
@echo   /C:string  使用指定字符串作为文字搜索字符串。
@echo   /G:file    从指定的文件获得搜索字符串。 (/ 代表控制台)。
@echo   /D:dir     查找以分号为分隔符的目录列表
@echo   strings    要查找的文字。
@echo   [drive:][path]filename
@echo              指定要查找的文件。
@echo 
@echo 除非参数有 /C 前缀，请使用空格隔开搜索字符串。
@echo 例如: 'FINDSTR "hello there" x.y' 在文件 x.y 中寻找 "hello" 或
@echo "there"。'FINDSTR /C:"hello there" x.y' 文件 x.y  寻找
@echo "hello there"。
@echo 
@echo 一般表达式的快速参考:
@echo   .        通配符: 任何字符
@echo   *        重复: 以前字符或类别出现零或零以上次数
@echo   ^        行位置: 行的开始
@echo   $        行位置: 行的终点
@echo   [class]  字符类别: 任何在字符集中的字符
@echo   [^class] 补字符类别: 任何不在字符集中的字符
@echo   [x-y]    范围: 在指定范围内的任何字符
@echo   \x       Escape: 元字符 x 的文字用法
@echo   \<xyz    字位置: 字的开始
@echo   xyz\    字位置: 字的结束
@echo 
@echo 有关 FINDSTR 常见表达法的详细情况，请见联机命令参考。