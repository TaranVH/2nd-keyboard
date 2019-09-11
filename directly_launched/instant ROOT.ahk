
StringToSend = InstantExplorer - ROOT
Send_WM_COPYDATA(StringToSend)
InstantExplorer("",1)
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk