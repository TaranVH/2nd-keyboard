StringToSend = InstantExplorer() shadowplay
Send_WM_COPYDATA(StringToSend)

InstantExplorer("C:\Users\Taran\Videos\Desktop")
sleep 10
sortByDateDescending()
sleep 50
sortByDateDescending()
sleep 100
sortByDateDescending()
sleep 500
sortByDateDescending()
sleep 500
sortByDateDescending()

Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk