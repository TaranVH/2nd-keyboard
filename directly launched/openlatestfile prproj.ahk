StringToSend = openlatestfile(1, .prproj)
Send_WM_COPYDATA(StringToSend)
openlatestfile(1, .prproj)
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk