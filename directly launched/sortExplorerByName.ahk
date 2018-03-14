StringToSend = sortExplorerByName()
Send_WM_COPYDATA(StringToSend)
sortExplorerByName()
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
Exitapp
