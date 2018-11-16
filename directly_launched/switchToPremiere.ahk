#SingleInstance force 

IfWinNotExist, ahk_class Premiere Pro
	{
	;Run, Adobe Premiere Pro.exe
	;Adobe Premiere Pro CC 2017
	; Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
	;Run, Adobe Premiere Pro.exe
	Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2019\Adobe Premiere Pro.exe
	}
if WinActive("ahk_class Premiere Pro")
	{
	IfWinNotExist, ahk_exe notepad++.exe
		{
		Run, notepad++.exe
		sleep 200
		}
	WinActivate ahk_exe notepad++.exe ;so I have this here as a workaround to a bug. Sometimes Premeire becomes unresponsive to keyboard input. (especially after timeline scrolling, especially with a playing video.) Switching to any other application and back will solve this problem. So I just hit the premiere button again, in those cases.g
	sleep 10
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro


; ; StringToSend = Premiere direct
; ; result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)

; ; switchToPremiere()

Exitapp


; ; SetWorkingDir %A_ScriptDir%
; ; #Include %A_ScriptDir%/REDIRECTOR Windows.ahk

