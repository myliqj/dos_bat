@echo off
title 一键清除系统垃圾文件
color 0A
mode con: cols=75 lines=28
echo.
echo.　  　　　 　  　     ╭─────────────╮
echo.　      ╭──────┤   一键清除系统垃圾文件   ├──────╮
echo.　      │　　　　    ╰─────────────╯　          │
echo.      　│                                                      │
echo.　      │    这是网上流传的批处理。它会帮你删除回收站、临时目  │
echo.　      │录、最近打开过的文档痕迹等。对系统运行稍有帮助，但不能│
echo.　      │根治速度慢的问题。电脑速度慢通常是因为太多的无用的运行│
echo.　      │占据了CPU和内存资源所致，非删除一些文件就能解决。建议 │
echo.　      │装好系统后，及时做Ghost备份。以后如果觉得运行不畅了， │
echo.　      │就恢复系统，这是最彻底的办法。                        │
echo.　      │                                                      │
echo.　      │======================================================│
echo.　      │                                                      │
echo.　      │    请按任意键开始清除垃圾文件,完成后程序自动退出!    │
echo.　      │                                                      │
echo.　      ╰───────────────────────────╯
echo.                                  
cls
echo.
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\*.log
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
rd /q /s "C:\Program Files\pipi\pipicache"&&md "C:\Program Files\pipi\pipicache"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
exit