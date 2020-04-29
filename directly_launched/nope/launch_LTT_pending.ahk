StringToSend = InstantExplorer("Z:\Linus\1. Linus Tech Tips\Pending")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("Z:\Linus\1. Linus Tech Tips\Pending")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk