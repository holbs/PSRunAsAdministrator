@ECHO off
CLS
MD %SYSTEMROOT%\PSRunAsAdministrator
MD %SYSTEMROOT%\PSRunAsAdministrator\Logs
MD %SYSTEMROOT%\PSRunAsAdministrator\Tools
IF NOT EXIST %SYSTEMROOT%\PSRunAsAdministrator GOTO EXITERROR
robocopy %~dp0 %SYSTEMROOT%\PSRunAsAdministrator\Tools CreateShortcut.ps1 MakeEvent.ps1 TreeSize.exe ServiceUIx64.exe ServiceUIx86.exe /z /np /LOG:%SYSTEMROOT%\PSRunAsAdministrator\Logs\InstallPSRunAsAdministrator.log /tee
powershell Register-ScheduledTask -TaskName 'Create TreeSize shortcut' -TaskPath 'PSRunAsAdministrator\' -Action (New-ScheduledTaskAction -Execute 'powershell' -Argument '-NoProfile -ExecutionPolicy bypass -File %SYSTEMROOT%\PSRunAsAdministrator\Tools\CreateShortcut.ps1') -Trigger (New-ScheduledTaskTrigger -AtLogon) -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries)
powershell %~dp0CreateScheduledTasks.ps1
schtasks /run /tn "Create TreeSize shortcut"
SET DATETIME=%DATE%-%TIME%
REG ADD HKLM\SOFTWARE\PSRunAsAdministrator /v TreeSize /t REG_SZ /d %DATETIME% /f
:EXITSUCCESS
EXIT /b 0
:EXITERROR
EXIT /b 1