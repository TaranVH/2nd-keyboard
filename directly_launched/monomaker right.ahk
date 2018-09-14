
StringToSend = audioMonoMaker("right")
Send_WM_COPYDATA(StringToSend)
audioMonoMaker("right")
exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk