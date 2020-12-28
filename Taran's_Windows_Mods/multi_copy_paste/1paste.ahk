#WinActivateForce ;this may prevent taskbar flashing, and force a window to open instead, as it should.


;msgbox, A_ScriptName is %A_ScriptName%
; A_ScriptName is 7.ahk

;Result := Rtrim(A_ScriptName,1) ;Rtrim didn't work, idk how to use it i guess

numberResult := SubStr(A_ScriptName, 1, 1)  ; in 7.ahk, this will return "7"
; https://www.autohotkey.com/docs/commands/SubStr.htm

;msgbox, trimmed name is %numberResult%
;Trimmed name is 7

;;;THESE NEXT TWO LINES SEEM TO DO THE SAME THING, SO I'M PICKING THE FIRST ONE. I DON'T KNOW WHICH ONE IS BETTER/MORE ROBUST, SO IF YOU KNOW, TELL ME.
targetfile = %A_ScriptDir%\clipboards
;targetfile := A_ScriptDir . "\clipboards"

;msgbox, initial targetfile is `n`n%targetfile%

targetfile = %targetfile%\clippy%numberResult%.txt
;msgbox, final targetfile string is `n`n%targetfile%


;multiClipboardPaste(targetfile)
contentsClipboard := multiClipboardPaste(targetfile)

;the following line was done inside of multiclipboard so that i can modify it later without having to do so 8 times.
;SendInput {Raw}%contentsClipboard%



Exitapp


;SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%\multiClipboard.ahk







