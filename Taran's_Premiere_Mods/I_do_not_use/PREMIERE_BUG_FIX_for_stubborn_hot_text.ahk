;;NOTE
;I no longer use this script, since I figured out that all it's doing is changing a windows mouse setting that you can already access manually.

;see  how_I_fix_stubborn_hot_text_permanently.png  for the fix that i use now (as of ~ April 2019 and onward)

;You have to set it to the 7th (or higher) setting.
;HOWEVER, this may be too fast for some people. Fortunately, my mouse has a DPI setting that I can change to whatever I like, so I just use that instead.
;IF SETTING "7" IS TOO HIGH FOR YOU, AND YOUR MOUSE DOES NOT HAVE ITS OWN DPI SETTING, then this is the script for you to run!

;Note that the DLL call setting "11" seems to correspond with the 7th line (or tick) that you can see on that screenshot. So the 6th line/tick is actaully DLL call setting "10." Yes, I know it's stupid.




;ORIGINAL BUG REPORT THREAD ON ADOBE FORUMS, WITH DanielOvrutskiy's SOLUTION: https://forums.adobe.com/message/6258808#6258808

;But adobe's forum redisign killed older threads, so here is the archive:
;https://web.archive.org/web/20141205034700/https://forums.adobe.com/message/6258808

;New thread with same issue, and me posting my current solution:
; https://community.adobe.com/t5/premiere-pro/to-change-parameter-values-i-have-to-move-my-mouse-at-a-certain-speed/m-p/10415720?page=1





;DanielOvrutskiy's code is below, was taken from here: https://pastebin.com/aUPjqnkL


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PREMIERE START
; Numeric control drag hack/fix for Premiere using AutoHotKey. Works by manipulating windows pointer speed (SPI_SETMOUSESPEED) to 7 ticks during dragging with Left Mouse Button. Resets to default 6 ticks when not.

Menu, Tray, Icon, shell32.dll, 100 ;changes the icon to a little clicking hand

#singleinstance force
#MaxHotkeysPerInterval 2000


~^LButton::
~LButton::
If WinActive("ahk_exe Adobe Premiere Pro.exe")
    DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ; Slightly Faster then Windows default
Return

~LButton Up::
DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UInt, MOUSE_NOW, UInt, 0)
If MOUSE_NOW != 10 ; Check if the speed is not default, adjust this as needed.
    DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0) ; Default Windows 6 Ticks [10], adjust this as needed.
Return
 
; #IfWinExist



;;;;;========================================================================
;;FUTURE TARAN NOTE: I switched from the above script, to the script below, which was frankly even MORE compicated... IDK whatr i was thinking. Keeping it here since it might be of use to you...


/*
 
;;;F12::DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ;just for testing, not for actual use.


;this might be better and simpler. just use a different mouse default when Premiere is the active window.
; https://autohotkey.com/board/topic/118644-run-the-script-if-window-become-active/
Loop
{
WinWaitActive, ahk_exe Adobe Premiere Pro.exe
;tooltip, activated
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ;0x71 will SET the value
settimer, meowzers, -250

WinWaitNotActive, ahk_exe Adobe Premiere Pro.exe
; DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UInt, MOUSE_NOW, UInt, 0)
; If MOUSE_NOW != 10 ; Check if the speed is not default, adjust this as needed.
    ; DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0) ; Default Windows 6 Ticks [10], adjust this as needed.
; tooltip, deactivated
;so like, you can set it back to 10 for the rest of the computer... but then the mouse will be faster in Premiere all the time, and slower for all other programs. It's just dumb. So just use speed 11 at all times!!
;VERY IMPORTANT NOTE:
;Mouse properties > Pointer Options > select a pointer speed
;IS the same thing. "11" refers to position #6 on there. yeah.

; DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UInt, MOUSE_NOW, UInt, 0) ; 0x70 will CHECK the value. i guess?

; tooltip, mouse_now is %MOUSE_NOW%

DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0)
settimer, meowzers, -50
sleep 10
}


return



meowzers:
;we have to use a timer, beacuse at lease Premiere and after effects seem to RESET that number to "10" every time you activate the program. So the timer gets around this.
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ; Slightly Faster then Windows default
sleep 200
DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0) ; Slightly Faster then Windows default
return

*/

;fin