
StringToSend = audioMonoMaker("left")
Send_WM_COPYDATA(StringToSend)
audioMonoMaker("left")
exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk