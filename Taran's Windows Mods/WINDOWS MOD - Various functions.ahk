#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
`::
Send !{up}
Return
#IfWinActive



;opens a specific folder destination in explorer
;these are launched from a techkeys keyboard
#IfWinActive
^!+1::
Run, "Z:\Linus\1. Linus Tech Tips\Pending"
Return

^!+2::
Run, "Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project"
Return

^!+3::
Run, "C:\Users\TaranVanHemert\Videos\SHADOWPLAY CAPTURE\Desktop"
Return
;;; done ;;;;



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