StringToSend = InstantExplorer("Thumbnail",1)
Send_WM_COPYDATA(StringToSend)

InstantExplorer("Thumbnail",1)
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk