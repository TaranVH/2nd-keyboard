; Easy Window Dragging and resizing -- KDE style (requires XP/2k/NT) -- by Jonny
; IT'S AWESOME. CAN'T LIVE WITHOUT IT NOW.
; Modified by Taran to work with Xbutton1 and Xbutton2 instead (the forward and back buttons on a 5-button mouse.)

; ORIGINAL SCRIPT IS HERE:
; https://autohotkey.com/docs/scripts/EasyWindowDrag_(KDE).htm


;KNOWN ISSUE:
;does NOT work properly on systems with varying UI scaling from one monitor to the next. it just keep enlargening the window indefinitely as soon as it touches the dofferently scaled monitor. i have no idea how to fix this...
;further reading...
;https://www.autohotkey.com/boards/viewtopic.php?f=14&t=13810
;

; okay, so ACTIVE WINDOW POSITION seems to be the only thing shared amongst all windows, yeah... need to uh, see if I can use THAT, thank you very much.
;also look into A_ScreenDPI 


#SingleInstance force
#InstallKeybdHook
#InstallMouseHook
#UseHook On
#KeyHistory 500

Menu, Tray, Icon, imageres.dll, 262 ;makes the icon into two window things


; Xbutton2::msgbox testing 1
; Xbutton1::msgbox testing 2

;this next line attempts to fix issues with different screens having different UI scaling. it doesn't work.
DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
;Gui -DPIScale

If (A_AhkVersion < "1.0.39.00")
{
    MsgBox,20,,This script may not work properly with your version of AutoHotkey. Continue?
    IfMsgBox,No
    ExitApp
}



killFullScreen()
{
; ;these two lines below activate the window under the cursor. But I do NOT like that, so i commented them out.
; MouseGetPos,,, WinUMID
; WinActivate, ahk_id %WinUMID%

MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class2, ahk_id %id%
WinGet, taranStyle, ExStyle, ahk_id %id%
WinGet, chromeStyle, Style, ahk_id %id%
;ToolTip, ahk_id %id%`nahk_class %class2%`n%title%`nControl: %control%
;Tooltip, %taranStyle%


;;Because you can CLICK on Premiere even while it's not the active applicaiton, we have to check to make sure it hasn't been clicked on. If it has, we skip to the end and do nothing. I never want to take premiere out of full screen.
; tooltip, class2 is %class2%
; sleep 300



If (class2 = "Premiere Pro")
	{
	tooltip, it's premiere`, don't kill full screen.
	sleep 100
	tooltip,
	goto skipitfull
	}

If (class2 = "SUMATRA_PDF_FRAME")
	{
	tooltip, it's SumatraPDF`, just hit F11.
	sleep 100
	tooltip,
	sendinput, {F11}
	
	if (taranStyle = 0x00000000) ;if it is full screen
		{
		tooltip, 0x00000000 SUMATRA PDF!
		sleep 100
		tooltip,
		sendinput, {F11} ;kill full screen

		sleep 10
		;This i gotta say is GOOD ENOUGH, though I'd prefer to not have to use F11. I'd prefer to send whatever command is being sent by F11 (in firefox and Chrome.)
		goto skipitfull
		return ;just in case
	}

;WinRestore, A ;which means the active window, which is no bueno for my needs.



;WinActivate, ahk_id %id% ;first, we need to activate that window. unfortunately, this also brings it to the foreground? again, those are NOT the same thing, but they are stuck together in this particular thing...
; ; ; MouseGetPos,,, WinUMID
; ; ; WinActivate, ahk_id %WinUMID%
; send MButton
; sleep 20
;I'm gonna have to just use controlsend to send the F11 I guess...
;ControlSend,, {F11}, ahk_id %fid%



WinRestore, %title%

if (taranStyle = 0x00000000) ;i think this is just for firefox...?
{
tooltip, 0x00000000
sleep 100
tooltip,
sendinput, {F11} ;this MURDERS firefox's "full screen" mode, but does not induce it, because otherwise it would have been 0x00000100 or 0x00000110

sleep 10
;This i gotta say is GOOD ENOUGH, though I'd prefer to not have to use F11. I'd prefer to send whatever command is being sent by F11 (in firefox and Chrome.)
return
}

;i DO need a check here to be sure it's actaully chrome that's active.
if (chromeStyle = 0x160F0000)
{
tooltip, chromeStyle 0x160F0000
sleep 100
tooltip,
; send MButton ;activate chrome i guess.
; sleep 20
sendinput, {F11}
sleep 10 ;without this, chrome will instantly become whatever full screen SIZE is, while still in "full screen" mode.

}


; https://www.autohotkey.com/docs/commands/WinGet.htm#ExStyle
; https://www.autohotkey.com/docs/commands/WinSet.htm


;WinSet, ExStyle, 0x00000100 ;this should disable "full screen" mode, but it doesn't do anything.

; WinSet, ExStyle, 0x00000000 ;this should INDUCE "full screen" mode, but it doesn't do anything either.

;msgbox, %taranstyle%

;0x00000000 is the style of "full screen" mode i think
;0x00000110 is the style of WINDOWed mode i think
; https://www.autohotkey.com/docs/misc/Styles.htm#Common
; https://support.mozilla.org/en-US/questions/1255696


;run, %title% -k
;winrestore will take your window OUT of "full screen" mode and into... "restore down" mode. So you can remove this if you don't like that. https://autohotkey.com/board/topic/53403-solved-pressing-the-restore-down-button-on-windows/

;WinSet, Style, +0x800000
;borderlessMode(title)


; this guy says to FAKE fullscreen mode, i dont liek that idea.
; https://autohotkey.com/board/topic/94136-command-for-fullscreen/
;another person finally has an answer -- super fullscreen is called "kiosk" mode, and i need to find a way to murder it with AHK. Update: twitter poeple pointed out that kiosk mode is something different, and cannot be gotten out of by pressing F11.
skipitfull:

}

; https://autohotkey.com/board/topic/121086-change-windowfull-screen-mode/


; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
;SetWinDelay,2
SetWinDelay,6
CoordMode, Mouse, Screen


; CoordMode, ToolTip, Screen
; CoordMode, Pixel, Screen
; CoordMode, Mouse, Screen
; CoordMode, Caret, Screen
; CoordMode, Menu, Screen

; CoordMode, ToolTip, relative
; CoordMode, Pixel, relative
; CoordMode, Mouse, relative
; CoordMode, Caret, relative
; CoordMode, Menu, relative

; CoordMode, ToolTip, window
; CoordMode, Pixel, window
; CoordMode, Mouse, window
; CoordMode, Caret, window
; CoordMode, Menu, window


; CoordMode, ToolTip, client
; CoordMode, Pixel, client
; CoordMode, Mouse, client
; CoordMode, Caret, client
; CoordMode, Menu, client

;try relative, window, and client.
return


;;;;note:  WinActive("ahk_class #32770") is a save/load Explorer window, mostly.

#if not WinActive("ahk_exe Adobe Premiere Pro.exe") ;because I use xbutton1 and xbutton2 for different things in Premiere. It's always full screen, so it doesn't matter. You can delete this entire line, or comment it out, or whatever. Follow your heart.

;Note that another #if thingy will only apply to all the code directly beneath it, until you hit another #if thingy. So the below line replaces the one above. I am keeping the above one because it's more likely what you're gonna want to use.

#if not (WinActive("ahk_class Premiere Pro") and WinActive("ahk_exe Adobe Premiere Pro.exe") or (WinActive("ahk_exe AfterFX.exe"))
or (WinActive("ahk_class DroverLord - Window Class") and WinActive("ahk_exe Adobe Premiere Pro.exe") ) ) ;YOU CAN DELETE THIS LINE ENTIRELY. i have this just for a SINGLE exception in Premiere when i want to use window dragging on Save/load dialouge boxes and sheeyt. Also i want it to work when the timeline is NOT on the main Premiere window. ;edit: wow, it works incredibly well. nice! ;edit2: now it also deliberately won't work in after effects. Nice! so i can keep adding ORs to the end to add more applications. I just remember that pairing OR and NOT together can sometimes result in everything being accepted by the IF statement...

;(WinActive("ahk_class DroverLord - Window Class") and WinActive("ahk_exe Adobe Premiere Pro.exe")




;^!F5::
; MouseGetPos, , , id, control
; WinGetTitle, title, ahk_id %id%
; WinGetClass, class, ahk_id %id%
; WinSet, Style, -0x40000 , ahk_id %ID% ; Remove Borders  : WS_SIZEBOX
;return




Xbutton2::
;tooltip, xbutton2
;;need to add code so that it will NOT make Explorer into full screen IF you click on a full screen firefox or chrome.

killFullScreen()

thekey = %A_thishotkey%
; If DoubleAlt
; {
    ; MouseGetPos,,,KDE_id
    ; ; This message is mostly equivalent to WinMinimize,
    ; ; but it avoids a bug with PSPad.
    ; PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    ; DoubleAlt := false
    ; return
; }
; Get the initial mouse position and window id, and
; abort if the window is maximized.


; https://www.autohotkey.com/docs/commands/MouseGetPos.htm
; MouseGetPos , OutputVarX, OutputVarY, OutputVarWin, OutputVarControl, Flag

; https://www.autohotkey.com/docs/commands/WinGet.htm
; WinGet, OutputVar [, SubCommand, WinTitle, WinText, ExcludeTitle, ExcludeText]

; https://www.autohotkey.com/docs/commands/WinGetPos.htm
; WinGetPos [, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText]

; https://www.autohotkey.com/docs/commands/WinMove.htm


MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
;tooltip, %KDE_Win%
; Get the initial window position.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinStartW,KDE_WinStartH,ahk_id %KDE_id%
WinGetClass,fancyclass,ahk_id %KDE_id%

;;Because you can CLICK on Premiere even while it's not the active application, we have to check to make sure that hasn't happened. If it has, we skip to the end and do nothing. I never want to change the window size of Premiere using this macro. I want it full screened all the time.
;msgbox, fancyclass is %fancyclass%`n`nahk_id is %ahk_id%
If (fancyclass = "Premiere Pro")
	{
	tooltip, premiere
	sleep 100
	tooltip,
	goto skipit
	}
	
; ;;interestingly, this code WILL run on a premiere sub-window. like, if you use premiere on multiple monitors. since the class becomes "driverlord" and stuff.
; ;;in that case, if it's important, which it isn't for me right now, I'd use some kinda code like this:
; ;;https://www.autohotkey.com/boards/viewtopic.php?t=66137
; ; WinGetClass, classvar, A
; ; WinGet, exevar, ProcessName, A
; ; MsgBox % "ahk_class " classvar "`nahk_exe " exevar	

Loop
{
    ;GetKeyState,KDE_Button,F20,P ; Break if button has been released.
    GetKeyState,KDE_Button,%thekey%,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2%,%KDE_WinStartW%,%KDE_WinStartH% ; Move the window to the new position.
	sleep 10
	; I have to re-specify KDE_WinStartH and KDE_WinStartW just in case different monitors have different UI scaling.
}
skipit:
return

;------------------------
;------------------------
;------------------------
;------------------------
;------------------------
;------------------------
;------------------------

Xbutton1::
;tooltip, xbutton1
killFullScreen()

; If DoubleAlt
; {
    ; MouseGetPos,,,KDE_id
    ; ; Toggle between maximized and restored state.
    ; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    ; If KDE_Win
        ; WinRestore,ahk_id %KDE_id%
    ; Else
        ; WinMaximize,ahk_id %KDE_id%
    ; DoubleAlt := false
    ; return
; }
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position and size.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Define the window region the mouse is currently in.
; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
    KDE_WinLeft := 1
Else
    KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
    KDE_WinUp := 1
Else
    KDE_WinUp := -1
Loop
{
	;tooltip, xbutton1 loopy before break
	
	;;the below line DOES work, but not over parsec
    GetKeyState,KDE_Button,Xbutton1,P ; Break if button has been released. Note that checking the physical state of a key will NOT work over applications like Parsec or (possibly) Teamviewer. (untested)
	
	
    ; GetKeyState,KDE_Button,XButton1
    ;GetKeyState,KDE_Button,VK05
	;tooltip, KDE_Button is %KDE_button%
	;sleep 300
	
	
	If KDE_Button = U
        break
	
	; https://www.autohotkey.com/docs/commands/GetKeyState.htm#function
	; KeyIsDown := GetKeyState(KeyName , P)
	; KeyIsDown := GetKeyState(XButton1,P)
	; tooltip, KeyIsDown is %KeyIsDown%
	; Sleep 400
	; If (KeyIsDown := 0)
		; {
		; msgbox, break
        ; break
		; }
	
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; Get the current window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    ; Then, act according to the defined region.
    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return








;;;;;;;;;i am bad at le code so I'm literally just gonna double the function just for a single exception. this is dumb, just delete everything under this line.



; #if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe")


; ; Xbutton2::
; ; WinRestore, A
; ; ;winrestore will take your window OUT of fullscreen mode and into... "restore down" mode. So you can remove this if you don't like that. https://autohotkey.com/board/topic/53403-solved-pressing-the-restore-down-button-on-windows/
; ; ;Must update this so that it only affects the window under the cursor, NOT the currently (A)ctive window.

; ; thekey = %A_thishotkey%
; ; ; If DoubleAlt
; ; ; {
    ; ; ; MouseGetPos,,,KDE_id
    ; ; ; ; This message is mostly equivalent to WinMinimize,
    ; ; ; ; but it avoids a bug with PSPad.
    ; ; ; PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    ; ; ; DoubleAlt := false
    ; ; ; return
; ; ; }
; ; ; Get the initial mouse position and window id, and
; ; ; abort if the window is maximized.
; ; MouseGetPos,KDE_X1,KDE_Y1,KDE_id
; ; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
; ; If KDE_Win
    ; ; return
; ; ;tooltip, %KDE_Win%
; ; ; Get the initial window position.
; ; WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
; ; Loop
; ; {
    ; ; ;GetKeyState,KDE_Button,F20,P ; Break if button has been released.
    ; ; GetKeyState,KDE_Button,%thekey%,P ; Break if button has been released.
    ; ; If KDE_Button = U
        ; ; break
    ; ; MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; ; KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    ; ; KDE_Y2 -= KDE_Y1
    ; ; KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    ; ; KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    ; ; WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
; ; }
; ; return

; ; ;------------------------

; ; Xbutton1::
; ; WinRestore, A
; ; ;winrestore will take your window OUT of fullscreen mode and into... "restore down" mode. So you can remove this if you don't like that. https://autohotkey.com/board/topic/53403-solved-pressing-the-restore-down-button-on-windows/

; ; ; If DoubleAlt
; ; ; {
    ; ; ; MouseGetPos,,,KDE_id
    ; ; ; ; Toggle between maximized and restored state.
    ; ; ; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    ; ; ; If KDE_Win
        ; ; ; WinRestore,ahk_id %KDE_id%
    ; ; ; Else
        ; ; ; WinMaximize,ahk_id %KDE_id%
    ; ; ; DoubleAlt := false
    ; ; ; return
; ; ; }
; ; ; Get the initial mouse position and window id, and
; ; ; abort if the window is maximized.
; ; MouseGetPos,KDE_X1,KDE_Y1,KDE_id
; ; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
; ; If KDE_Win
    ; ; return
; ; ; Get the initial window position and size.
; ; WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; ; ; Define the window region the mouse is currently in.
; ; ; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
; ; If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
    ; ; KDE_WinLeft := 1
; ; Else
    ; ; KDE_WinLeft := -1
; ; If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
    ; ; KDE_WinUp := 1
; ; Else
    ; ; KDE_WinUp := -1
; ; Loop
; ; {
    ; ; GetKeyState,KDE_Button,Xbutton1,P ; Break if button has been released.
    ; ; If KDE_Button = U
        ; ; break
    ; ; MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; ; ; Get the current window position and size.
    ; ; WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    ; ; KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    ; ; KDE_Y2 -= KDE_Y1
    ; ; ; Then, act according to the defined region.
    ; ; WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            ; ; , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            ; ; , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            ; ; , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    ; ; KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    ; ; KDE_Y1 := (KDE_Y2 + KDE_Y1)
; ; }
; ; return























;;;stuff from the old script that I never used:
; ; "Alt + MButton" may be simpler, but I
; ; like an extra measure of security for
; ; an operation like this.
; !MButton::
; If DoubleAlt
; {
    ; MouseGetPos,,,KDE_id
    ; WinClose,ahk_id %KDE_id%
    ; DoubleAlt := false
    ; return
; }
; return

; ; This detects "double-clicks" of the alt key.
; ~Alt::
; DoubleAlt := A_PriorHotkey = "~Alt" AND A_TimeSincePriorHotkey < 400
; Sleep 0
; KeyWait Alt  ; This prevents the keyboard's auto-repeat feature from interfering.
; return




