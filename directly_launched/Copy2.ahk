StringToSend = COPY 2
Send_WM_COPYDATA(StringToSend)
;you can delete the above two lines, it's only for my visualizer GUI.

;here's the real meat:
copy(2)
Exitapp
;and that's it.



;but also you need this so that it can access the actual function definition:
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk

