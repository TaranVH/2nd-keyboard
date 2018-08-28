;Run, C:\Program Files\USR-VCOM\USR-VCOM.exe,Min
sleep, 1000
Run, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\permanent_numlock.exe,Min
Sleep, 10000
ExitApp


;Right click on permanent_numlock.exe,
;Go to properties > Compatibility > Change Settings for all Users
;and check "Run this program as administrator."

;-------------------

;;this is the stuff contained in permanent_numlock.ahk:

; #SingleInstance force 

; #installkeybdhook

; SetNumLockState,On
; SetNumLockState,AlwaysOn
; return


;https://autohotkey.com/boards/viewtopic.php?t=21434


; ; RunWait, %A_WinDir%\System32\schtasks.exe /create /TN [TaskName] /TR [Path\To\MyScript.exe] OR ["C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\permanent_numlock.ahk"] /RL HIGHEST /SC ONLOGON

;C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\permanent_numlock.ahk

; ;this code works, but it always launches a message box thingy asking if you're sure you want to run the program. No bueno.
; if not A_IsAdmin
 ; {
  ; Run *RunAs "%A_ScriptFullPath%"
  ; ExitApp
 ; }



;https://autohotkey.com/boards/viewtopic.php?t=21434

;RunWait, %A_WinDir%\System32\schtasks.exe /create /TN [TaskName] /TR [Path\To\MyScript.exe] OR ["c:\program files\AutoHotkey\autohotkey.exe" "PathTo\MyScript.ahk"] /RL HIGHEST /SC ONLOGON

/*
https://superuser.com/questions/1027228/is-it-possible-to-have-num-lock-always-on-without-the-ability-of-the-num-lock-k

https://superuser.com/questions/688889/permanently-disable-num-lock-in-windows

https://github.com/FaffyBucket/NUMlockCALC/blob/master/NUMlockCALC.ahk

https://autohotkey.com/board/topic/36222-trouble-remapping-capslock/

windows identifiers
https://autohotkey.com/docs/misc/CLSID-List.htm
*/