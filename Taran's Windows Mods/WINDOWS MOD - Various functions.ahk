#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;%A_ScriptDir%\Lib\  ; Local library - requires v1.0.90+.
;%A_MyDocuments%\AutoHotkey\Lib\  ; User library.
;path-to-the-currently-running-AutoHotkey.exe\Lib\  ; Standard library.
;C:\Users\TaranVanHemert\AppData\Local\GitHub\TutorialRepository_a66c3719071da6d865a984bb8d6bfb5bcd775ec8\new-repo\Taran's Windows Mods\WINDOWS MOD - Various functions.ahk\Lib\


Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.

; makeboxes = 1
; msgboxer(message) {
; if makeboxes = 1
	; msgbox, %message%
; }

;--------THESE FUNCTIONS are for changing the address of an existing exporer window, into a new, given address --- unless you already have a window with that address open - in which case, it just brings that window to the front. This way, you dont have several exporer windows that are all at the exact same address.
;But I only call this function if you are NOT already in explorer, in which case, it also works this way but with much less code. Lol, hope that makes sense.
;sadly they are sometimes really slow - takes liek a second for it to kick in! I need a faster way to do this.
explorerLaunch(foo) {
Run, % foo
;I'm commenting this code out for now because it hasn't been working lately...
; if WinActive("ahk_exe explorer.exe")
	; {
	; tooltip, explorer is open already, now doing NAVRUN
	; NavRun(foo)
	; }
; Else
	; {
	; tooltip, else was triggered meaning we are not in explorer)
	; Run, % foo
	; }
; Return
}

;-------The below script origninally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/
; ; Hotkeys 1 & 2
; 1::NavRun("C:\")
; 2::NavRun(A_MyDocuments)
; http://msdn.microsoft.com/en-us/library/bb774094
GetActiveExplorer() {
	tooltip, getactiveexplorer code now
    static objShell := ComObjCreate("Shell.Application")
    WinHWND := WinActive("A")    ; Active window
    for Item in objShell.Windows
        if (Item.HWND = WinHWND)
            return Item        ; Return active window object
    return -1    ; No explorer windows match active window
}

NavRun(Path) {
    if (-1 != objIE := GetActiveExplorer())
        objIE.Navigate(Path)
    else
        Run, % Path
}
;--------The above script origninally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/


; ;instant save and reload for this script -- and i guess not the other ones...?
; !s::
; send ^s
; Reload
; Return



;macro key 16 on my logitech G15 keyboard. It will activate firefox,, and if firefox is already activated, it will go to the next window in firefox.
^!1::
if WinActive("ahk_class MozillaWindowClass")
	Send ^{tab}
else
	Send #1
Return

;macro key 13 on my logitech G15 keyboard. If firefox is activated, it will go to the PREVIOUS window. Otherwise it activates a left click.
^!6::
if WinActive("ahk_class MozillaWindowClass")
	Send ^+{tab}
else
	click left ;This DOES NOT WORK, it just rapidly clicks; you can't hold down. Must be done directly from the G15 keyboard, or not at all...
Return


;This is a script that will always go to the NEXT Explorer window if you hit the same button again.
;CTRL ALT 2 is pressed with a SINGLE button stoke from my logitech G15 keyboard -- Macro key 17.
^!2::
if WinActive("ahk_exe explorer.exe")
{
	multipress := multipress + 1
	loopnumber := multipress
	Send, {LWin down}
	while loopnumber > -1 ;loop ; need to loop a number of times
		{
		Send, 2
		loopnumber := loopnumber - 1
		sleep 5
		tooltip, %loopnumber%
		}
	sleep 30
	Send, {LWin up}
	Send, {LWin up}
	;Run, explorer, Max
	;tooltip, you were not in explorer
	sleep 20
	tooltip,
}
else
{
	;tooltip, explorerYAY
	multipress = 0
	Send, {LWin down}
	Send, 2
	sleep 100
	Send, {LWin up}
}
Return

;This is a script that will always go to the NEXT Word window if you hit the same button again.
;CTRL ALT 4 is pressed with a SINGLE button stoke from my logitech G15 keyboard -- Macro key 15.
^!4::
if WinActive("ahk_exe WINWORD.EXE")
{
	multipress4 := multipress4 + 1
	loopnumber4 := multipress4
	Send, {LWin down}
	while loopnumber4 > -1 ;loop ; need to loop a number of times
		{
		Send, 4
		loopnumber4 := loopnumber4 - 1
		sleep 5
		tooltip, %loopnumber4%
		}
	sleep 30
	Send, {LWin up}
	Send, {LWin up}
	;Run, explorer, Max
	;tooltip, you were not in explorer
	sleep 20
	tooltip,
}
else
{
	;tooltip, explorerYAY
	multipress4 = 0
	Send, {LWin down}
	Send, 4
	sleep 100
	Send, {LWin up}
}
Return


#IfWinActive

Break:: ; this refers to the actual pause/break key on a keyboard
;msgbox, hello
sleep 10
send ^!{insert} ;this was set in windows by right clicking on the icon and selecting proprties, of the SNIPPING tool, to open the snipping tool. Snips are nice because they go into the clipboard.
sleep 300
Send !n
sleep 100
Send r ; this script will create a new snip with a single button press.... that's the idea anyway. it doesn't always launch, IDK why.
return



; ^!+F1::
; msgbox, test
; Return

; ^!F2::
; ;msgbox, f2 test
; if WinActive("ahk_exe explorer")
	; {
	; msgbox, explorer
	; }
; Else
	; Send #2
; Return

; ^!+F3::
; msgbox, test
; Return


;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
`::
Send !{up}
Return

;this converts F4 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
#IfWinActive ahk_exe explorer.exe
F4::
Send !{F4}
Return



; http://www.autohotkey.net/~faqbot/faq.html#selectingfiles
;this will copy files over to the transcode folders if they are not already there.

; F1::
	; selection := FC("explorer","","selection")
	; Loop % selection.len()
		; run % "notepad.exe """ selection[A_Index] """"
	; ;FileCopy, C:\*.txt, Z:\Linus\1. Linus Tech Tips\Transcode\Vessel And China Transcode
; return



;;; these  things below will turn an explorer window into one with this address, unless it is already open - in which case, we switch over to it.
;;; each one is triggered by a pre-programmed techkeys keyboard, so that each is actually just one keystroke to engage.
#IfWinActive
^!+1::explorerLaunch("Z:\Linus\1. Linus Tech Tips\Pending") 
^!+2::explorerLaunch("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
^!+3::explorerLaunch("C:\Users\TaranVanHemert\Videos\SHADOWPLAY CAPTURE\Desktop")
;;; done ;;;;


;next techkeys keyboard here maybe?

; ^!+4::
; msgbox ctrl_alt_shift_4
; return

; !1::
; msgbox alt1
; return


#IfWinActive
;opens the CLOCK / CALENDAR. ;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#c::
Send #b{left}{enter}
Return


;code to locate an invisible cursor
; F7::
; Loop
; {
; tooltip, cursor, , ,3
; sleep 20
; }
;F7 Up::tooltip, , , ,3
;return