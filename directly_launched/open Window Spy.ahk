StringToSend = openApp() Window Spy
Send_WM_COPYDATA(StringToSend)
openApp("ahk_class AU3Reveal", "AU3_Spy.exe", "Active Window Info")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
