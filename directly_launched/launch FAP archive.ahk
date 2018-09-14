StringToSend = runexplorer("N:\Fast As Possible") 
Send_WM_COPYDATA(StringToSend)
runexplorer("N:\Fast As Possible") 
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk