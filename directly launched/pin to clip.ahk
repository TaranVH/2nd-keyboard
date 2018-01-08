StringToSend = Pin to clip (kb shortcut)
Send_WM_COPYDATA(StringToSend)

prFocus("Effect Controls") ;the following shortcut only works if the Effect Controls panel is in focus...
send ^!p ;shortcut for pin to clip
prFocus("timeline")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk


; sleep 100
; exitapp
; ;SetWorkingDir %A_ScriptDir%
; #Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\ALL MULTIPLE KEYBOARD ASSIGNMENTS.ahk