StringToSend = InstantExplorer("C:\AHK\2nd-keyboard")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("C:\AHK\2nd-keyboard")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk