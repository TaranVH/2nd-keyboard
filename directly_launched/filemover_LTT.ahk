; #WinActivateForce
;need code to first check if the locaiton is even available... in case the server crashes like is has before...
;sendinput, {blind}{SC0E8} ;scan code of an unassigned key
;StringToSend = Open L-roll
;Send_WM_COPYDATA(StringToSend)
;InstantExplorer("L-Roll",1)

Filemover("Z:\Linus\1. Linus Tech Tips\Transcode\LTT Match Source")
sleep 10
Exitapp

;SetWorkingDir %A_ScriptDir%
;#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
#Include C:\AHK\2nd-keyboard\Taran's_Windows_Mods\filemover.ahk