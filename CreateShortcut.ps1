# Creates a shortcut in $env:APPDATA\Microsoft\Windows\Start Menu\Programs to run MakeEvent.ps1
If (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\TreeSize.lnk") {
    # Do nothing, the .lnk exists
} Else {
    $Shell = New-Object -ComObject WScript.Shell
    $Shortcut = $Shell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\TreeSize.lnk")
    $Shortcut.TargetPath = "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
    $Shortcut.Arguments = "-NoProfile -WindowStyle hidden -ExecutionPolicy bypass -File $env:WINDIR\PSRunAsAdministrator\Tools\MakeEvent.ps1"
    $Shortcut.Description = "Runs TreeSize as administrator using PSRunAsAdministrator"
    $Shortcut.WorkingDirectory = "$env:WINDIR\System32\WindowsPowerShell\v1.0\"
    $Shortcut.IconLocation = "$env:WINDIR\TreeSize\Tools\TreeSize.exe,0"
    $Shortcut.Save()
}