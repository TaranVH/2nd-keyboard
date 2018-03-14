;ORIGINAL BUG REPORT THREAD ON ADOBE FORUMS, WITH DanielOvrutskiy's SOLUTION: https://forums.adobe.com/message/6258808#6258808

;DanielOvrutskiy's code is below, was taken from here: https://pastebin.com/aUPjqnkL

;I do not yet know if this code might interfere with other left-click functions in Premiere. I'll keep running the script on my own machine to test for any possible problems.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PREMIERE START
; Numeric control drag hack/fix for Premiere using AutoHotKey. Works by manipulating windows pointer speed (SPI_SETMOUSESPEED) during dragging with Left Mouse Button. Resets to default 6 ticks when not.
Menu, Tray, Icon, shell32.dll, 100 ;changes the icon to a little clicking hand

#singleinstance force
#MaxHotkeysPerInterval 2000
#IfWinExist ahk_exe Adobe Premiere Pro.exe

;VERY IMPORTANT NOTE:
;YOU will want to remove all references to F14, F15, F18, and F17. I only do this because it works in tandem with the instantVFX() function.

~F14::
~F15::
~F18::
~F17::
~^LButton::
~LButton::
If WinActive("ahk_exe Adobe Premiere Pro.exe")
    DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ; Slightly Faster then Windows default
Return

~F14 Up::
~F15 Up::
~F18 Up::
~F17 Up::
~LButton Up::
DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UInt, MOUSE_NOW, UInt, 0)
If MOUSE_NOW != 10 ; Check if the speed is not default, adjust this as needed.
    DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0) ; Default Windows 6 Ticks [10], adjust this as needed.
Return
 
; ; #IfWinExist
 
; PREMIERE END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;this might be better and simpler. just use a different mouse default when Premiere is the active window.
;https://autohotkey.com/board/topic/118644-run-the-script-if-window-become-active/
; ; ; Loop
; ; ; {
; ; ; WinWaitActive, ahk_exe Adobe Premiere Pro.exe
; ; ; ;tooltip, activated
; ; ; DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ; Slightly Faster then Windows default
; ; ; WinWaitNotActive, ahk_exe Adobe Premiere Pro.exe
; ; ; DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UInt, MOUSE_NOW, UInt, 0)
; ; ; If MOUSE_NOW != 10 ; Check if the speed is not default, adjust this as needed.
    ; ; ; DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0) ; Default Windows 6 Ticks [10], adjust this as needed.
; ; ; ;tooltip, deactivated
; ; ; sleep 10
; ; ; }
; ; ; return