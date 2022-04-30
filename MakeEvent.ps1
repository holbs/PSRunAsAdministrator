# Create a Windows event source which will trigger a scheduled task, which runs the main script as admin
$EventSource = 'PowerShell Automation'
$Source = [Diagnostics.EventLog]::SourceExists($EventSource)
If ($Source) {
    # Source exists
} Else {
    New-EventLog -LogName 'Windows PowerShell' -Source $EventSource
}
# Trigger the event
Write-EventLog -LogName 'Windows PowerShell' -Source $EventSource -EntryType Information "'TreeSize (via PSRunAsAdministrator)' launched by '$($env:USERDOMAIN.ToUpper())\$($env:USERNAME.ToLower())'" -EventId 7777