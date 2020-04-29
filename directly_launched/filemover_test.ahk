#WinActivateForce
;need code to first check if the locaiton is even available... in case the server crashes like is has before...
;sendinput, {blind}{SC0E8} ;scan code of an unassigned key
;StringToSend = Open L-roll
;Send_WM_COPYDATA(StringToSend)
;InstantExplorer("L-Roll",1)
#IfWinActive ahk_exe explorer.exe
Filemover("C:\Users\Taran\Desktop\move test")
sleep 1000
Exitapp

;SetWorkingDir %A_ScriptDir%
;#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
#Include C:\AHK\2nd-keyboard\Taran's_Windows_Mods\filemover.ahk