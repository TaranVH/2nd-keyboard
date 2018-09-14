
StringToSend = InstantExplorer() Taran Music
Send_WM_COPYDATA(StringToSend)
send {SC0E8} ;scan code of an unassigned key
InstantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Music\Warner Chappell 2018\Taran tentative")
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk