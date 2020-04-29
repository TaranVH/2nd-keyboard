StringToSend =  KEYCAPS FOLDER!
Send_WM_COPYDATA(StringToSend)
InstantExplorer("C:\AHK\2nd-keyboard\KEYCAP_IMAGES")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk