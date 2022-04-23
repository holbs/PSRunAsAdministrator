@ECHO off
CLS
RD %SYSTEMROOT%\TreeSize /q /s
schtasks /delete /tn "Create TreeSize shortcut" /f
schtasks /delete /tn "Run TreeSize (via Elevator)" /f
REG DELETE HKLM\SOFTWARE\Elevator /v "TreeSize" /f