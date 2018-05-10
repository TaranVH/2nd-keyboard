StringToSend = runexplorer("C:\Users\TaranWORK\Videos\") 
Send_WM_COPYDATA(StringToSend)
runexplorer("C:\Users\TaranWORK\Videos\") 
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk