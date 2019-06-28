StringToSend = InstantExplorer("N:\Linus Tech Tips")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("N:\Linus Tech Tips")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk