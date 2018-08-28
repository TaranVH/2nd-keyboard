
StringToSend = preset("crop left")
Send_WM_COPYDATA(StringToSend)
preset("crop left")
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk