StringToSend = preset("this is supposed to just hit F19")
Send_WM_COPYDATA(StringToSend)
preset("this is supposed to just hit F19")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk