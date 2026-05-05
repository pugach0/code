[Setup]
AppName=StudyTracker
AppVersion=1.0
DefaultDirName={localappdata}\StudyTracker
DisableDirPage=yes

[Files]
Source: "timerLogic.exe"; DestDir: "{localappdata}\StudyTracker"
Source: "barControlAbsolute.ahk"; DestDir: "{localappdata}\StudyTracker"
Source: "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"; DestDir: "{localappdata}\StudyTracker"

[Run]
; create startup shortcut
Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; \
  Parameters: "-NoProfile -Command ""$s=(New-Object -ComObject WScript.Shell).CreateShortcut($env:APPDATA+'\Microsoft\Windows\Start Menu\Programs\Startup\StudyTracker.lnk');$s.TargetPath='{localappdata}\StudyTracker\AutoHotkey64.exe';$s.Arguments='{localappdata}\StudyTracker\barControlAbsolute.ahk';$s.Save()"""; \
  Flags: runhidden