rem =========liudl경홈=======
rem @del c:\temp.vbs
@echo on error resume next >>c:\temp.vbs
@echo dim WshShell>>c:\temp.vbs
@echo Set WshShell = WScript.CreateObject("WScript.Shell")>>c:\temp.vbs
@echo WshShell.run"cmd">>c:\temp.vbs
@echo WshShell.AppActivate"c:\windows\system32\cmd.exe">>c:\temp.vbs
@echo WScript.Sleep 200>>c:\temp.vbs


@echo WshShell.SendKeys"telnet 200.30.10.1">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 100>>c:\temp.vbs
@echo WshShell.AppActivate"telnet.exe ">>c:\temp.vbs
@echo WScript.Sleep 2000>>c:\temp.vbs


@echo WshShell.SendKeys"fssb">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 2000>>c:\temp.vbs
@echo WshShell.SendKeys"fssb">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 2000>>c:\temp.vbs
@echo WshShell.SendKeys"db2 get snapshot for locks on fssbcs > fssbcs_locks.txt">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs

@echo WshShell.SendKeys"exit">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs

@echo WshShell.SendKeys" ftp 200.30.10.1 ">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
@echo WshShell.SendKeys"fssb">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
@echo WshShell.SendKeys"fssb">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
@echo WshShell.SendKeys"get fssbcs_locks.txt c:\fssbcs_locks.txt">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
@echo WshShell.SendKeys"quit">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
@echo WshShell.SendKeys"exit">>c:\temp.vbs
@echo WshShell.SendKeys"{ENTER}">>c:\temp.vbs
@echo WScript.Sleep 1000>>c:\temp.vbs
rem @call c:\temp.vbs
rem =========liudl경홈=======