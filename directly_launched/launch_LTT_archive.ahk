StringToSend = InstantExplorer("N:\Linus Tech Tips")
Send_WM_COPYDATA(StringToSend)
InstantExplorer("N:\Linus Tech Tips")
sleep 1
InstantExplorer("V:\01. LTT vault 2")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk