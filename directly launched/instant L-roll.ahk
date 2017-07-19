

StringToSend = InstantExplorer("L-Roll",1)
Send_WM_COPYDATA(StringToSend)
InstantExplorer("L-Roll",1)
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk