StringToSend = preset("crop right")
Send_WM_COPYDATA(StringToSend)

preset("crop right")

Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk
