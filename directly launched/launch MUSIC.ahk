
StringToSend = runexplorer() sWC 2018
Send_WM_COPYDATA(StringToSend)
send {SC0E8} ;scan code of an unassigned key
runexplorer("Z:\Linus\1. Linus Tech Tips\Assets\Music\Warner Chappell 2018\Taran tentative")
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk