StringToSend = openlatestfile(1, .docx)
Send_WM_COPYDATA(StringToSend)
openlatestfile(1, .docx)
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk