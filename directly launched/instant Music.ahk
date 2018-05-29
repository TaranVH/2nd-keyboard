; if FileExist("D:\")
    ; MsgBox, The drive exists.
send {SC0E8} ;scan code of an unassigned key
StringToSend = InstantExplorer("Music",1)
Send_WM_COPYDATA(StringToSend)
InstantExplorer("Music",1)
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk