; if FileExist("D:\")
    ; MsgBox, The drive exists.
send {SC0E8} ;scan code of an unassigned key
StringToSend = Open Music
Send_WM_COPYDATA(StringToSend)
InstantExplorer("Music",1)
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk