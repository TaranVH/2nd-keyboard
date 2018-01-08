StringToSend = Clear Effects Panel
Send_WM_COPYDATA(StringToSend)

effectsPanelType("")

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk
Exitapp

; sleep 100
; exitapp
; ;SetWorkingDir %A_ScriptDir%
; #Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\ALL MULTIPLE KEYBOARD ASSIGNMENTS.ahk