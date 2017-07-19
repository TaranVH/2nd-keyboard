StringToSend = InstantExplorer("Thumbnail",1)
Send_WM_COPYDATA(StringToSend)

InstantExplorer("Thumbnail",1)

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk