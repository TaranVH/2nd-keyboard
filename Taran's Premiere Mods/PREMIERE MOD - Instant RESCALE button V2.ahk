#SingleInstance force

; SetWorkingDir %A_ScriptDir%
SetWorkingDir C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files
;Set the above string to your own personal support file folder full of images.
;The resulting string is: %A_WorkingDir%


Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere%
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,
	;removes the tooltip
return


^!F12::
lolvariable := ReturnString()
;msgbox %lolvariable%
return

ReturnString()
{
	msgbox, doing an actual thingg
    retStr := "Yipee"  ;Or: retStr = Yipee
    Return, retStr
}



prFocus(panel) ;this function allows you to have ONE spot where you define your personal shortcuts that "focus" panels in premiere.
{
;panel := """" . panel . """" ;this adds quotation marks around the parameter so that it works as a string, not a variable.
;Send ^!+1 ;bring focus to a random bin, in order to "clear" the current focus on any and all bins
Send ^!+7 ;bring focus to the effects panel, in order to "clear" the current focus on the MAIN monitor
if (panel = "effects")
	goto theEnd ;Send ^!+7 ;do nothing. the shortcut has already been pressed.
else if (panel = "timeline")
	Send ^!+0 ;if focus had already been on the timeline, this would have switched to the next sequence in some arbitrary order.
else if (panel = "program")
	Send ^!+4
else if (panel = "project") ;AKA a "bin" or "folder"
	Send ^!+1
else if (panel = "effect controls")
	Send ^!+5
theEnd:

}
;end of focusing panel




#IfWinActive ahk_exe Adobe Premiere Pro.exe

~+k::
;keyboard shortcut assigned to "keyboard shrtcuts panel."
;the trouble with CC2017 is that the find box is not automatically selected.
;and it is not even possible to use a shortcut to select it, either.
;so this script will do that.
;If i launch it with CTRL K, it will NOT select the find box.
;(I use shift K primarily, simply for the fact that the shift key is physically larger, and closer to K.)

;SetKeyDelay, 0

coordmode, mouse, screen
coordmode, pixel, screen

MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%

winwait, Keyboard Shortcuts, ,0.5

IfWinExist, Keyboard Shortcuts ;if you are just typing a capital K, while NOT in the keyboard shortcuts panel, the script won't do anyhting.
{
coordmode, mouse, window
coordmode, pixel, window
BlockInput, On
ControlGetPos, X, Y, Width, Height, Edit1, Keyboard Shortcuts ;find box of the keyboard shortcuts panel.
; ControlClick, x10 y10, edit1, Keyboard Shortcuts ;dunno why... but i can never get controlclick to work.
MouseMove, X-20, Y+10, 0
sleep 1
MouseClick, left, , , 1 ;------------------------clicks on magnifying glass. It is clickable even when the panel has not fully become visible!
sleep 20
coordmode, mouse, screen
coordmode, pixel, screen
MouseMove, xpos, ypos, 0 ;------------------------returns cursor to previous coordinates
BlockInput, Off
}
return






;;;;;;;;;;;;;shortcuts for creating markers of specific colors.;;;;;;;;;;;;;;;;;;
#IfWinActive ahk_exe Adobe Premiere Pro.exe
numpadend::
marker()
send !{numpad1}
return

;suuposedly shift numpad 5, but remapped from numlock, if interceptor is working....
numpadclear::
marker()
send !{numpad2}
return

+numpadmult::
marker()
send !{numpad3}
return

numpadpgdn::
marker()
send !{numpad4}
return


numpadhome::
marker()
send !{numpad5}
return

+numpaddiv::
marker()
send !{numpad6}
;tooltip, DIV num8
return

numpadins::
marker()
send !{numpad7}
return

numpadpgup::
marker()
send !{numpad8}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;shortcut to close the titler with ctrl w, which only closes panels otherwise...
^w::
Tippy("Close titler (ctrl w )", 1200)
coordmode, mouse, screen
coordmode, pixel, screen
MouseGetPos, xpos, ypos ;--------stores the cursor's current coordinates at X%xpos% Y%ypos%
coordmode, mouse, client
coordmode, pixel, client
WinGetActiveStats, Title, Width, Height, X, Y

MouseMove, Width-40, -20, 0 ;-----moves the mouse onto the "x" at the top right of the titler window

tooltip, closing titler now!
Click left
sleep 50 ;-----------------------wait 1/20th of a second to ensure everything is done

coordmode, mouse, screen
coordmode, pixel, screen
MouseMove, %xpos%, %ypos%, 0 ;---moves the cursor back

return






;EFFECT CONTROLS PANEL ---TRANSFORM ICON CLICKER
~F5::
Tippy("transform icon - F5")
BlockInput, On
SetKeyDelay, 0
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro, DroverLord - TabPanel Window
X := X+85
Y := Y+100
MouseMove, X, Y, 0
MouseClick, left
MouseMove, %xpos%, %ypos%, 0
BlockInput, Off
Return


;EFFECT CONTROLS PANEL --- MOTION EFFECT TRIANGLE UNFURL CLICKER;
;it's not intelligent though. it will only toggle.
;need to somehow combine this with the intelligent functionality below.
;watch the associated video for more information!
;   

~F4::
Tippy("blind triangle unfurl - F4")
BlockInput, on
BlockInput, MouseMove
SetKeyDelay, 0
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window
MouseMove, X+20, Y+94, 0
MouseClick
;MouseMove, %xpos%, %ypos%, 0
BlockInput, off
BlockInput, MouseMoveOff
Return


marker(){
send /
sleep 10
}




 ; SINGLE KEYSTROKE SCALING FUNCTION
;--------------------------------------------------------------------------------
; You have to HOLD DOWN VFXkey the entire time. no need to click and hold the mouse button, it is done for you
; Only works if your UI is a VERY PARTICULAR SHADE OF GRAY - so those values are different for everyone, so you have to find your particualr colors using Window Spy!


clickTransformIcon()
{
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.
;this info might CHANGE every time you add a panel, so you may need a more robust method than this...
MouseMove, Xcorner+83, Ycorner+98, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
;msgbox, the cursor should now be positioned directly over the transform icon.
MouseClick, left
}



Target(v1orA1, onOff, allNoneSolo := 0, numberr := 0)
{
; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos xPosCursor, yPosCursor
wrenchMarkerX := 400
wrenchMarkerY := 800 ;the upper left corner for where to begin searching for the timeline WRENCH and MARKER icons -- the only unique and reliable visual i can use for coordinates.
TargetDistance := 98 ;Distance from the edge of the marker Wrench to the left edge of the track targeting graphics
CoordMode Pixel ;, screen  ; IDK why, but it only works like this...
CoordMode Mouse, screen
tooltip, starting
ImageSearch, xTime, yTime, wrenchMarkerX, wrenchMarkerY, wrenchMarkerX+600, wrenchMarkerY+1000, %A_WorkingDir%\timelineUniqueLocator2.png
if ErrorLevel = 0
{
	;MouseMove, xTime, yTime, 0
	;tooltip, where u at son. y %ytime% and x %xtime%
	;do nothing. continue on.
}
else
{
	tooltip, fail
	goto resetTrackTargeter
}

ImageSearch, FoundX, FoundY, xTime-%TargetDistance%, yTime, xTime, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_targeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime-%TargetDistance%, yTime, xTime, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_targeted_alone.png
if ErrorLevel = 2
	{
	tippy("TARGETED v1 not found")
	goto trackIsUntargeted
	}
if ErrorLevel = 3
	{
	tippy("Could not conduct the TARGETED v1 search!")
	goto resetTrackTargeter
	}
if ErrorLevel = 0
	{
	;tippy("a TARGETED track 1 was found.")
	if (v1orA1 = "v1")
		{
		send +9 ;command in premiere to "toggle ALL video track targeting."
		sleep 10
		if (onOff = "on")
			{
			tippy("turning ON")
			send +9 ; do it again to TARGET everything.
			}
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	else if (v1orA1 = "a1")
		{
		send !9 ;command in premiere to "toggle ALL audio track targeting."
		sleep 10
		if (onOff = "on")
			send !9 ; do it again to TARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
				
		
	goto resetTrackTargeter
	}





trackIsUntargeted:
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime-%TargetDistance%, yTime, xTime, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_untargeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime-%TargetDistance%, yTime, xTime, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_untargeted_alone.png
if ErrorLevel = 0
	{
	tippy("an UNTARGETED track 1 was found.")
	if (v1orA1 = "v1")
		{
		send +9 ;command in premiere to "toggle ALL video track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send +9 ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	if (v1orA1 = "a1")
		{
		send !9 ;command in premiere to "toggle ALL audio track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send !9 ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
	goto resetTrackTargeter
	}

resetTrackTargeter:
; MouseMove, xPosCursor, yPosCursor, 0
; blockinput, off
; blockinput, MouseMoveOff
tooltip,
sleep 10
}
;END of TRACK TARGETER







;script to lock video and audio layers V1 and A1.
~F19::


BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor

xPos = 400
yPos = 1050 ;the coordinates of roughly where my timeline usually is located on the screen
CoordMode Pixel ;, screen  ; IDK why but it works like this...
CoordMode Mouse, screen


;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are done with default UI brightness, plus 150% UI scaling in Wondows.

ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_unlocked_targeted.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_unlocked_targeted.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_unlocked_untargeted.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_unlocked_untargeted.png
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2
    tippy("NO UNLOCK WAS FOUND")
	goto try2
	}
if ErrorLevel = 2
	{
    tippy("Could not conduct the search!")
	goto resetlocker
	}
if ErrorLevel = 0
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX+10, FoundY+10, 0
	sleep 5
	click left
	MouseMove, FoundX+10, FoundY+50, 0 ;moves downwards and onto where A1 should be...
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
	
try2:
ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_locked_targeted.png

	
if ErrorLevel = 1
	{
    tippy("LOCKED TARGETED V1 could not be found")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_locked_targeted.png
	}
if ErrorLevel = 1
	{
    tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_locked_untargeted.png
	}
; if ErrorLevel = 1
	; {
    ; tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_locked_untargeted.png
	; }
if ErrorLevel = 2
	{
    tippy("Could not conduct search #2")
	goto resetlocker
	}
	
if ErrorLevel = 0
	{
	tippy("found a locked lock")
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+10, 0
	sleep 5
	click left
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+50, 0
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resetlocker:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10
return






;;;INSTANT VFX HOT TEXT SELECTOR MOD;;;
;;;;;;;;;;;;;super useful!;;;;;;;;;;;;;

; I had this on mbutton (middle mouse button) but that was aggravating my RSI :..( 
; so I moved it onto my G12 macro key, which is mapped to F14 because I am magical.
; If you can't get F14 to work, just use any of the other function keys, F1-F12.
; Probably best NOT to use a modifier key though, since that changes how the hot text operates.

;Macro key G12 on my Logitech G15 keyboard
~F14::
global VFXkey = "F14"
instantVFX(3) ;Three tab presses are required to get to "Scale"
return

;Macro key G11
~F15::
global VFXkey = "F15"
instantVFX(7) ;7 tab presses are required to get to "Anchour Point" (vertical)
return

;Macro key G10
~F18::
global VFXkey = "F18"
instantVFX(6) ;6 tab presses are required to get to "Anchor Point" (horizontal)
return

;Macro key G7
~F17::
global VFXkey = "F17"
instantVFX(5) ;Five tab presses are required to get to "Rotation"
return

instantVFX(foobar)
{

;blockinput, sendandMouse
blockinput, MouseMove
blockinput, on


;ToolTip, A, , , 2
MouseGetPos Xbeginlol, Ybeginlol
global Xbegin = Xbeginlol
global Ybegin = Ybeginlol

; MsgBox, "please verify that the mouse cannot move"
; sleep 2000

nowWhat := untwirl()
;msgbox,,, nowWhat is %nowWhat%,1

if nowWhat = untwirled
{
	clickTransformIcon()
	findHotText(foobar)
}
else if nowWhat = reset
	tippy(FAILED TO FIND MOTION EFFECT TRIANGLE)
;msgbox,,, what just happened?,1


resetFromAutoVFX()
}




untwirl()
{
tooltip, untwirl is starting now
dontrestart = 0

;the code below serves to save a lot of time in determining if a clip is selected or not.
prFocus("Effect Controls")
Send {tab}
if (A_CaretX = "")
{
	;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	Send ^p ;"selection follows playhead,"
	sleep 10
	Send ^p
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint
		}
	;otherwise,
	Return "reset"
}



restartPoint:
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;This is the ClassNN of the effect controls panel. Use Window Spy to figure it out.
;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
YY := Ycorner+99 ;143??
XX := Xcorner+19
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

if (colorr = "0x353535")
{
	tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
}
else if (colorr = "0x757575") ;again, this values will be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	;untwirled = 1
	
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
	
}
else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{
	tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
		
	;resetFromAutoVFX()
	;play noise
	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint ;this is stupid but it works. Feel free to improve any of my code.
		}
	;otherwise,
	Return "reset"
	}
else
	{
	tooltip, %colorr% not expected
	;play noise
	
	Return "reset"
	;resetFromAutoVFX()
	}
} ;end of untwirl()





findHotText(foobar)
{
coordmode, pixel, screen
coordmode, mouse, screen
coordmode, Caret, screen

SetKeyDelay, 0

;clear tooltips
tooltip,

;highlight the Effect Controls panel.
prFocus("Effect Controls")
;Send ^!+5 ;this is set to "Effect Controls" panel focusing in Premiere's shortcuts.

;Send a specified number of [TAB] keypresses to get to the desired hot text.
Sendinput {tab %foobar%}
;msgbox,,, did that work? the correct thing should be highlighted now,1
;msgbox, foobar is %foobar%
sleep foobar * 30 ;i have to wait for premiere to execute all those TABs...
; sleep 500
GetKeyState, stateFirstCheck, %VFXkey%, P
;Code to RESET this variable if the user has already released the VFXkey.
if stateFirstCheck = U
	{
		;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
		;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
		Click up left
		Sleep 10
		if (foobar = 3) ;scale
		{
			;msgbox,,, foobar is equal to 3 which is `nSCALE or `n100,1
			Sendinput, 100
			sleep 50
			Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
			sleep 20
		}
		if (foobar = 5) ;rotation
		{
			Sendinput, 0
			sleep 50
			Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
			sleep 20
		}
		resetFromAutoVFX()
		return ;if you don't RETURN, the below code will be executed, whoops.
	} ;end of instant reset

Sendinput {escape} ;this exits the text box's editing mode
MouseMove, %A_CaretX%, %A_CaretY%, 0

;msgbox, the cursor should be on the Caret now.

Click down left
sleep 10

;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
Loop
	{
	blockinput, off
	blockinput, MouseMoveOff
	tooltip, %VFXkey% Instant %foobar% mod
	sleep 15
	GetKeyState, state, %VFXkey%, P
	if state = U
		{
		Click up left
		;tooltip, "%VFXkey% is now physically UP so we are exiting now"
		sleep 15
		resetFromAutoVFX()
		; MouseMove, Xbegin, Ybegin, 0
		; tooltip,
		; ToolTip, , , , 2
		; blockinput, off
		; blockinput, MouseMoveOff
		Return
			}
		}
	}


;;;--------------------------------------------------------------------------------------------
; Used F14



resetFromAutoVFX()
{
	;msgbox,,, is resetting working?,1
	global Xbegin
	global Ybegin
	MouseMove, Xbegin, Ybegin, 0
	;MouseMove, global Xbegin, global Ybegin, 0
	;MouseMove, Xbeginlol, Ybeginlol, 0
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}

;^!+c::msgbox, Caret x = %A_CaretX% `nCaret y = %A_CaretY%

#IfWinActive ; PREMIERE END

#IfWinActive ahk_exe notepad++.exe
~F21::
send ^s
sleep 20
reload
return

#IfWinActive ahk_class Notepad++
;instant save and reload for this script -- and i guess not the other ones...?
F5::
send ^s
sleep 100
Reload
Return
#IfWinActive
