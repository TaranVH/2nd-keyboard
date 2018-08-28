
StringToSend = saveLocation2()
Send_WM_COPYDATA(StringToSend)
saveLocation2()
Exitapp

;InstantExplorer("\",1)
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk