StringToSend = sortExplorerByDate()
Send_WM_COPYDATA(StringToSend)
sortExplorerByDate()
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
Exitapp
