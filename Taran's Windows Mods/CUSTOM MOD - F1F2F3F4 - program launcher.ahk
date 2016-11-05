#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.


;#######THIS IS THE BEST SCRIPT I'VE EVER WRITTEN.#########

;And also one of the simplest. Basically, If you press the "explorer" key (F1) it will instantly:
; 1. Create an explorer window if one is not already running.
; 2. Open the LAST ACTIVE explorer window if Explorer is not already active
; 3. If you keep pressing the key, it will cycle through Explorer windows in the order they were last activated

;Programs like chrome are a little different. It will open Chrome if it's not already open,
;but when you keep pressing the button, it hits "CTRL TAB" to advance you forwards through your tabs.

;This is all significantly superior to switching between applications by CLICKING on them in the taskbar,
;and also very superior to using WIN 1, WIN 2, WIN 3 etc to switch between applications.

;You will want to tailor this script to launch your own most commonly used applications.
;You can use Window Spy (it comes with autohotkey) to figure out the ahk_exe and ahk_class of your applications.
;There is a video explaining all of this, coming soon.


;Applications used in this example:
;explorer
;chrome
;premiere
;word

#IfWinActive 

F1::
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
Return


F2::
IfWinNotExist, ahk_class Chrome_WidgetWin_1
	Run, chrome.exe
	
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^{tab}
else
	WinActivate ahk_class Chrome_WidgetWin_1
Return


F3::
IfWinNotExist, ahk_class Premiere Pro
	Run, Adobe Premiere Pro.exe
WinActivate ahk_class Premiere Pro
Return


F4::
Process, Exist, WINWORD.EXE
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	GroupAdd, taranwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, taranwords, r
	else
		WinActivate ahk_class OpusApp
	}
Return



;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
`::
Send !{up}
Return


#IfWinActive
;opens the CLOCK / CALENDAR. ;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#c::
Send #b{left}{enter}
Return
