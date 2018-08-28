StringToSend = preset("autogate")
Send_WM_COPYDATA(StringToSend)
preset("autogate")

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk
Exitapp

; sleep 100
; exitapp
; ;SetWorkingDir %A_ScriptDir%
; #Include C:\AHK\2nd-keyboard\ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk