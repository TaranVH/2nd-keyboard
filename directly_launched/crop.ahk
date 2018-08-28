

StringToSend = preset("crop full")
Send_WM_COPYDATA(StringToSend)
preset("crop full")
exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk

