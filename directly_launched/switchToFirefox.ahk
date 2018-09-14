#NoEnv
SendMode Input
#SingleInstance force

sendinput, {SC0E8} ;scan code of an unassigned key
IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
; if WinActive("ahk_exe firefox.exe")
	; {
	; WinGetClass, class, A
	; if (class = "Mozillawindowclass1")
		; msgbox, this is a notification
	; }
if WinActive("ahk_exe firefox.exe")
	Send ^{tab}
else
	{
	;WinRestore ahk_exe firefox.exe
	WinActivatebottom ahk_exe firefox.exe
	;I use BOTTOM just in case there are annoying notifications that have popped up -- this will NOT activate those, and will instead activate the main window as intended.
	;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
	;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
	}
Exitapp
tooltip, you should never see this tooltip from switchToFirefox.ahk
sleep 200
Exitapp
