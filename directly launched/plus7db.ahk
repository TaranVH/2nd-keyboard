StringToSend = +7db
Send_WM_COPYDATA(StringToSend)

Send {F2}7{enter}
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk


; sleep 100
; exitapp
; ;SetWorkingDir %A_ScriptDir%
; #Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\ALL MULTIPLE KEYBOARD ASSIGNMENTS.ahk