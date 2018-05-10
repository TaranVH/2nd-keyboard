StringToSend = runexplorer("C:\Users\TaranWORK\Videos\Desktop")
Send_WM_COPYDATA(StringToSend)
runexplorer("C:\Users\TaranWORK\Videos\Desktop")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk