StringToSend = InstantExplorer("Z:\Linus\5. Fast As Possible\1. Pending")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("Z:\Linus\5. Fast As Possible\1. Pending")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk