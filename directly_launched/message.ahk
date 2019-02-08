
; StringToSend = InstantExplorer("Scripts",1)
; Send_WM_COPYDATA(StringToSend)
message("TIMER IS UP")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk