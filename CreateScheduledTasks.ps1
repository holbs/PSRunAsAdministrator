# Trigger for running the scheduled task when Event ID 7777 is generated in 'Windows PowerShell/PowerShell Automation' event log
$Class = Get-CimClass MSFT_TaskEventTrigger Root/Microsoft/Windows/TaskScheduler
$Trigger = $Class | New-CimInstance -ClientOnly
$Trigger.Enabled = $true
$Trigger.Subscription = '<QueryList><Query Id="0" Path="Windows PowerShell"><Select Path="Windows PowerShell">*[System[Provider[@Name=''PowerShell Automation''] and EventID=7777]]</Select></Query></QueryList>'
# Action and argument for starting TreeSize.exe
$ActionParameters = @{
    Execute  = "$env:WINDIR\PSRunAsAdministrator\Tools\ServiceUIx64.exe"
    Argument = "-Process:explorer.exe $env:WINDIR\PSRunAsAdministrator\Tools\TreeSize.exe"
}
$Action = New-ScheduledTaskAction @ActionParameters
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
$RegSchTaskParameters = @{
    TaskName    = 'Run TreeSize (via PSRunAsAdministrator)'
    Description = 'Runs TreeSize.exe as administrator'
    TaskPath    = 'PSRunAsAdministrator\'
    Action      = $Action
    Principal   = $Principal
    Settings    = $Settings
    Trigger     = $Trigger
}
# Create the scheduled task
Register-ScheduledTask @RegSchTaskParameters