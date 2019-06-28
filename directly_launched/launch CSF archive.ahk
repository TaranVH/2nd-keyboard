StringToSend = InstantExplorer("N:\Channel Super Fun")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("N:\Channel Super Fun")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk