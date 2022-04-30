@ECHO off
CLS
MD %SYSTEMROOT%\TreeSize
MD %SYSTEMROOT%\TreeSize\Logs
MD %SYSTEMROOT%\TreeSize\Tools
IF NOT EXIST %SYSTEMROOT%\TreeSize GOTO EXITERROR
robocopy %~dp0 %SYSTEMROOT%\TreeSize\Tools CreateShortcut.ps1 MakeEvent.ps1 TreeSize.exe ServiceUIx64.exe ServiceUIx86.exe TreeSize.ico /z /np /LOG:%SYSTEMROOT%\TreeSize\Logs\Robocopy_TreeSize_Install.log /tee
powershell Register-ScheduledTask -TaskName 'Create TreeSize shortcut' -TaskPath 'PSRunAsAdministrator\' -Action (New-ScheduledTaskAction -Execute 'powershell' -Argument '-NoProfile -ExecutionPolicy bypass -File %SYSTEMROOT%\TreeSize\Tools\CreateShortcut.ps1') -Trigger (New-ScheduledTaskTrigger -AtLogon) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries)
powershell %~dp0CreateScheduledTasks.ps1
schtasks /run /tn "Create TreeSize shortcut"
SET DATETIME=%DATE%-%TIME%
REG ADD HKLM\SOFTWARE\Elevator /v TreeSize /t REG_SZ /d %DATETIME% /f
:EXITSUCCESS
EXIT /b 0
:EXITERROR
EXIT /b 1