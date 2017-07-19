StringToSend = runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")
Send_WM_COPYDATA(StringToSend)
runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk