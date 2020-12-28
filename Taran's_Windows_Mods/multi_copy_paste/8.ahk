#WinActivateForce ;this may prevent taskbar flashing, and force a window to open instead, as it should.


;msgbox, A_ScriptName is %A_ScriptName%
; A_ScriptName is, for example, 7.ahk

numberResult := SubStr(A_ScriptName, 1, 1)  ; in 7.ahk, this will return "7"
; https://www.autohotkey.com/docs/commands/SubStr.htm

;msgbox, trimmed name is %numberResult%
;Trimmed name is 7


;msgbox, A_ScriptDir is %A_ScriptDir%

;msgbox, A_WorkingDir is %A_WorkingDir%

;;;THESE NEXT TWO LINES SEEM TO DO THE SAME THING, SO I'M PICKING THE FIRST ONE. I DON'T KNOW WHICH ONE IS BETTER/MORE ROBUST, SO IF YOU KNOW, TELL ME.
targetfile = %A_ScriptDir%\clipboards
;targetfile := A_ScriptDir . "\clipboards"

;msgbox, initial targetfile is %targetfile%

targetfile = %targetfile%\clippy%numberResult%.txt

;msgbox, final targetfile string is `n`n%targetfile%


multiClipboardCopy(targetfile)
;textWasWritten := multiClipboard(targetfile)


Exitapp

;SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%\multiClipboard.ahk

; multiClipboardCopy(target)
; { 

; ClipSaved := ClipboardAll ;Save the clipboard
; Clipboard = ;Empty the clipboard
; SendInput, ^c
; ClipWait, 2
; if ErrorLevel
	; {
	; ;; MsgBox % "Failed attempt to copy text to clipboard."
	; MsgBox,,,"Failed attempt to copy text to clipboard.",0.7
	; return
	; }
; NewClipboard := Trim(Clipboard)
; ; StringReplace, NewClipboard, NewClipBoard, `r`n, `n, All ;comment this in to remove whitespace automaticaly
; Clipboard := ClipSaved ;Restore the clipboard
; ClipSaved = ;Free the memory in case the clipboard was very large.


; file := FileOpen(target, "w")
; file.write(NewClipboard)
; file.close()

; return NewClipboard
; }











