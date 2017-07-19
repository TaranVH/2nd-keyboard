
StringToSend = insertSFX("pop")
Send_WM_COPYDATA(StringToSend)
insertSFX("pop")
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk