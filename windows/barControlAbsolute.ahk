#Requires AutoHotkey v2.0

timer := "C:\Users\" . A_UserName . "\AppData\Local\StudyTracker\timer.txt"
logFile := "C:\Users\" . A_UserName . "\AppData\Local\StudyTracker\log.txt"
timerLogic := EnvGet("LOCALAPPDATA") . "\StudyTracker\timerLogic.exe"
;timerLogic := "C:\Users\" . A_UserName . "\AppData\Local\StudyTracker\timerLogic.py"
myGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
myGui.BackColor := "CC0000"
myGui.SetFont("s12 cWhite Bold", "Courier New")
timerText := myGui.Add("Edit", "x0 y3 w100 h22 Center +ReadOnly -E0x200 +BackgroundCC0000", "00:00:00")
if FileExist(timer) {
    val := FileRead(timer)
}
barShown := false

topic := "NaN"
pid := "NaN"

screenW := SysGet(78)
#F9::{
    global val, topic, pid, logFile, barShown
    RunWait('powershell -NoProfile -Command "Stop-Process -Name pythonw* -Force -ErrorAction SilentlyContinue"',, "Hide")
    result := InputBox("Choose topic", "Study Tracker", "w300 h100")
    if result.Result = "Cancel"
        return
    val := "00:00:00"
    myGui.Show("x" . (screenW//2 - 50) . " y5 w100 h22 NoActivate")
    pid := Run('"' . timerLogic . '"')
    ;pid := Run('pythonw.exe "' . timerLogic . '"')
    topic := result.Value
    barShown := true
}
WinSetRegion("0-0 w100 h22 r10-10", myGui)
WinSetTransparent(180, myGui)

SetTimer(UpdateTimer, 1000)

UpdateTimer() {
    global val
    if FileExist(timer) {
        val := FileRead(timer)
        timerText.Value := Trim(val)
    }
}

Finish(){
    global val, topic, pid, logFile, barShown
    FileAppend(FormatTime(, "dd.MM.yy") . " " . FormatTime(, "HH:mm:ss") . " FINISH " . val . " " . topic . "`n", logFile)
    myGui.Hide()
    ProcessClose(pid)
    RunWait('powershell -NoProfile -Command "Stop-Process -Name pythonw* -Force -ErrorAction SilentlyContinue"',, "Hide")
    val := "00:00:00"
    file := FileOpen(timer, "w")
    file.Close()
    barShown := false
}

#F10::{
    if barShown {
        Finish()
    }
}

#F11::{
    global val, topic, pid, logFile, barShown
    result := InputBox("Add event", "Study Tracker", "w300 h100")
    if result.Result = "Cancel"
        return
    event := StrReplace(result.Value, " ", "_")
    FileAppend(FormatTime(, "dd.MM.yy") . " " . FormatTime(, "HH:mm:ss") . " EVENT " . event . "`n", logFile)
}

#F12::{
    global val, topic, pid, logFile, barShown
    FileAppend(FormatTime(, "dd.MM.yy") . " " . FormatTime(, "HH:mm:ss") . " DAYOFF " . "`n", logFile)
}