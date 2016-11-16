#SingleInstance force

Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere%
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,
	;removes the tooltip
return




#IfWinActive ahk_exe Adobe Premiere Pro.exe

~+k::
;keyboard shortcut assigned to "keyboard shrtcuts panel."
;the trouble with CC2017 is that the find box is not automatically selected.
;and it is not even possible to us a shortcut to select it, either.
;so this script will do that.
;If i launch it with CTRL K, it will NOT select the find box.
;(I use shift K primarily, simply for the fact that the shift key is physically larger, and closer to K.)

;SetKeyDelay, 0

coordmode, mouse, screen
coordmode, pixel, screen

MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%

winwait, Keyboard Shortcuts, ,0.5

IfWinExist, Keyboard Shortcuts ;if you are just typing a capital K, NOT in the keyboard shortcuts panel, the script won't do anyhting.
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


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;script that increases or decreases the size of the program monitor, no matter what panel you have selected.
; SHORTCUT				MAPPED TO THIS COMMAND IN PREMIERE
; ctrl numpad -			"zoom (program) monitor in"
; ctrl numpad +			"zoom (program) monitor out"
; ctrl numpad enter		"zoon (program) monitor to fit"

numpadAdd::
numpadSub::
numpadEnter::
sendinput ^+!7 ;premiere shortcut to activate the effects panel. this is necessary.
sleep 50
sendinput ^+!4 ;shortcut to activate the program monitor. If the program monitor is ALREADY selected, it will cycle to the next sequence. This is stupid. Therefore, another panel (that never cycles through anywhere, and is already always open) must be slected first.
sleep 10
send ^{%A_thishotkey%} ;adds the CTRL key and re-presses the key you just pressed. now that you are in the program monitor, this shortcut will work.
;If there was a way to return focus to the panel you were on before this script was run, I would include that step here. But there's not.... i don't have 2 way communication all the time....
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
Tippy("triangle unfurl - F4")
BlockInput, on
BlockInput, MouseMove
SetKeyDelay, 0
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro, DroverLord - TabPanel Window
MouseMove, X+20, Y+94, 0
MouseClick
;MouseMove, %xpos%, %ypos%, 0
BlockInput, off
BlockInput, MouseMoveOff
Return



; THE FOLLOWING CODE IS NO LONGER NEEDED! PREMIERE HAS A SHORTCUT FOR THIS. iT CAN BE FOUND AS: PANELS > PROJECT PANEL > "GO BACK"
/*
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~F12::
Tippy("Bin BACK button press (F12)")
; CoordMode Pixel, screen
; CoordMode mouse, screen
BlockInput, On
BlockInput, MouseMove
MouseGetPos, xpos, ypos, Window, classNN
WinGetClass, class, ahk_id %Window% ;----"ahk_id %Window%" is important for SOME REASON. if you delete it, this doesnt work.

;ToolTip, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%

ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
;---the ahk_class will be: ahk_class DroverLord - Window Class

XX := XX+28
YY := YY+7 ;------------------------moves the cursor directly onto the light gray part of the "back" icon. Your pixel count may vary.

MouseMove, XX, YY, 0 ;--------------for somereason you DO have to actually move the mouse for PixelGetColor to work.


;this color detection does NOT WORK on my monitors 1 and 3, making it useles....
/*
PixelGetColor, colorr, XX, YY ;-----I like to double the last letter of some variable names so i know it's one of MINE! :P
MsgBox color is %colorr%, but 0x505050 is what we want
;sleep 10
if (colorr = "0x505050") ;----------YOUR COLOR WILL VARY! In Premiere CS6, it's 0xC1C1C1. You'll have to run the script just up to this point to get the right color.
{
	MsgBox color %colorr% is CORRECT
	Click XX, YY
}
Click XX, YY
sleep 10

MouseMove, xpos, ypos, 0 ;--------------instantly returns cursor to original coordinates
;MsgBox now we return mouse control ;---used for debugging
BlockInput, Off ;-----------------------if you forget to turn blockinput off, CTRL ALT DELETE will still work to return control.
BlockInput, MouseMoveOff

Return ; from F12 BACK BUTTON PRESS

*/


marker(){
send /
sleep 10
}




 ; SINGLE KEYSTROKE SCALING FUNCTION
;--------------------------------------------------------------------------------
; You have to HOLD DOWN scaleKey the entire time. no need to click and hold the mouse button, it is done for you
; Only works if your UI is a VERY PARTICULAR SHADE OF GRAY - so those values are different for everyone, so you have to find your particualr colors using Window Spy!

resetFromAutoScale()
{
	MouseMove, Xbegin, Ybegin, 0
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}

clickTransformIcon()
{
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro 
MouseMove, Xcorner+83, Ycorner+98, 0
MouseClick, left
}





;experimental script to lock video and audio layers V1 and A1.
F19::
BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor
xPos = 400
yPos = 1050
CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
CoordMode Mouse, screen

ImageSearch, FoundX, FoundY, xPos, yPos, xPos+400, yPos+1000, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\v1_unlocked_cc2017.png
;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above. Again, your UI brightness will probably be different from mine!

if ErrorLevel = 2
	{
    tippy("Could not conduct the search")
	goto resetlocker
	}
if ErrorLevel = 1
	{
	;msgbox, , , error level 1, .7
    ;tippy("no unlocked lock was found...")
	goto try2
	}
else
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX+10, FoundY+10, 0
	sleep 5
	click left
	MouseMove, FoundX+10, FoundY+50, 0
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
	
try2:
ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+400, yPos+1000, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\v1_locked_cc2017.png
if ErrorLevel = 2
	{
    tippy("Could not conduct the search")
	goto resetlocker
	}
if ErrorLevel = 1
	{
	msgbox, , , locked image cannot be found., .7
    tippy("image could not be found on the screen")
	}
else
{
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


; ;experimental script to lock video and audio layers V1 and A1.
; F19::
; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos xPosCursor, yPosCursor
; xPos = 400
; yPos = 1050
; CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
; CoordMode Mouse, screen

; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+400, yPos+1000, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\v1unlocked.png
; ;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above. Again, your UI brightness will probably be different from mine!

; if ErrorLevel = 0
	; {
	; ;tooltip, The icon was found at %FoundX%x%FoundY%.
	; ;msgbox, The icon was found at %FoundX%x%FoundY%.
	; MouseMove, FoundX+10, FoundY+10, 0
	; sleep 5
	; click left
	; MouseMove, FoundX+10, FoundY+50, 0
	; click left ;clicks on Audio track 1 as well.
	; sleep 10
	; goto resetlocker
	; }
	
; try2:
; ImageSearch, FoundX_a1, FoundY_a1, xPos, yPos, xPos+400, yPos+1000, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\a1unlocked.png
; if ErrorLevel = 0
; {
	; MouseMove, FoundX_a1+10, FoundY_a1+10, 0
	; sleep 5
	; click left
	; MouseMove, FoundX_a1+10, FoundY_a1+50, 0
	; click left ;clicks on Audio track 1 as well.
	; sleep 10
	; goto resetlocker
; }
; ;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
; resetlocker:
; MouseMove, xPosCursor, yPosCursor, 0
; blockinput, off
; blockinput, MouseMoveOff
; sleep 10
; return









;;;INSTANT RESCALE MOD;;;
; I had this on mbutton (middle mouse button) but that was aggravating my RSI :..( so I moved it onto my G12 macro key, which is mapped to F14 because I am magical.
; If you can't get F14 to work, just use any of the other function keys, F1-F12. Best NOT to use a modifier key though, since that changes how the hot text operates.
~F14::
global scaleKey = "F14"
dontrestart = 0
restartPoint:
blockinput, sendandMouse
blockinput, MouseMove
blockinput, on

; send ^+d ;deselect anything that might be selected. We want to affect ONLY the clip the playhead is currently on top of - what we can see in the program monitor.
; sleep 10
; Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
; sleep 10
; Send ^p ;this now disables "selection follows playehad." I don't know if there is a way to CHECK if it is on or not.
; sleep 10

ToolTip, A, , , 2
MouseGetPos Xbegin, Ybegin
global Xbegin = Xbegin
global Ybegin = Ybegin 
; MsgBox, "please verify that the mouse cannot move"
; sleep 2000
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro ;effect controls panel. It's actually Window Class3 but it still works??? I am not going to tempt fate and try to change it.

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
YY := Ycorner+99 ;143??
XX := Xcorner+19
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

if (colorr = "0x444444") ;868686
{
	tooltip, color %colorr% means closed triangle-will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	clickTransformIcon()
	findScale()
	Return
}
else if (colorr = "0x868686") ;again, this values will be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	clickTransformIcon()
	findScale()
	Return
}
else if (colorr = "0x2C2C2C" || colorr = "0x2B2B2B")
{
	tooltip, this is a normal panel color of 2b2b2b or %colorr%, which means NO CLIP has been selected! So we need to select something - If you didnt change your UI brightness
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playehad." I don't know if there is a way to CHECK if it is on or not.
	resetFromAutoScale()
	;play noise
	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more!
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint ;this is stupid but it works. Feel free to improve any of my code; I know it's garbage.
		}
	Return
}
else
{
	tooltip, %colorr% not expected
	;play noise
	resetFromAutoScale()
	Return
}
Return ;from autoscaler part 1




findScale() ; searches for the "scale" text inside of the Motion effect. requires an actual image.
{
tooltip, ;deletes tooltips
;msgbox, now we are in findScale
sleep 5
MouseGetPos xPos, yPos
;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.


ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\scale_CC2017.png
;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above. Again, your UI brightness will probably be different from mine!

if ErrorLevel = 2
	{
    tippy("Could not conduct the search")
	resetFromAutoScale()
	}

	
	
if ErrorLevel = 1
	{
	msgbox, , , error level 1, .7
    tippy("scale could not be found on the screen")
	resetFromAutoScale()
	}
else
	{
	tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX, FoundY, 0
	;msgbox,,,moved to located "scale",1
	sleep 5
	findHotText()
	}
}

findHotText()
{
tooltip, ; removes any tooltips that might be in the way of the searcher.
; https://www.autohotkey.com/docs/commands/PixelSearch.htm
;CoordMode Pixel
MouseGetPos, xxx, yyy
PixelSearch, Px, Py, xxx+50, yyy+10, xxx+500, yyy+11, 0x3398EE, 30, Fast RGB ;note that i did not change UI brightness for controls and focus stuff.
if ErrorLevel
	{
    tooltip,"colorNotFound")
	resetFromAutoScale()
	}
else
	{
	;tooltip, A color within 30 shades of variation was found at X%Px% Y%Py%
    MsgBox, A color within 30 shades of variation was found at X%Px% Y%Py%.
    MouseMove, Px+10, Py+5, 0
	Click down left
	
	GetKeyState, stateFirstCheck, %scaleKey%, P
	if stateFirstCheck = U
		{
			;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
			;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
			Click up left
			Sleep 10
			Send, 100
			sleep 50
			Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
			sleep 20
			resetFromAutoScale()
		}
	;Now we start the oficcial loop, which will continue as long as the user holds down the scalekey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
	Loop
		{
		blockinput, off
		blockinput, MouseMoveOff
		tooltip, %scaleKey% Instant Rescale mod
		sleep 15
		GetKeyState, state, %scaleKey%, P
		if state = U
			{
			Click up left
			;tooltip, "%scaleKey% is now physically UP so we are exiting now"
			sleep 15
			resetFromAutoScale()
			; MouseMove, Xbegin, Ybegin, 0
			; tooltip,
			; ToolTip, , , , 2
			; blockinput, off
			; blockinput, MouseMoveOff
			Return
			}
		}
	}
}

;;;--------------------------------------------------------------------------------------------
; Used F14






















resetFromAutoAnchor()
{
	MouseMove, XbeginAP, YbeginAP, 0
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}




;-------------------------------------------------------------------------------------------

;;;INSTANT anchor point change MOD;;;
; If you can't get F15 to work, just use any of the other function keys, F1-F12. Best NOT to use a modifier key though, since that changes how the hot text operates.
~F15::
global anchorKey = "F15"
dontrestart = 0
restartPointAP:
blockinput, sendandMouse
blockinput, MouseMove
blockinput, on

; send ^+d ;deselect anything that might be selected. We want to affect ONLY the clip the playhead is currently on top of - what we can see in the program monitor.
; sleep 10
; Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
; sleep 10
; Send ^p ;this now disables "selection follows playehad." I don't know if there is a way to CHECK if it is on or not.
; sleep 10

ToolTip, ^AP, , , 2
MouseGetPos XbeginAP, YbeginAP
global XbeginAP = XbeginAP
global YbeginAP = YbeginAP
; MsgBox, "please verify that the mouse cannot move"
; sleep 2000
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro ;effect controls panel

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
YY := Ycorner+99
XX := Xcorner+19
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

if (colorr = "0x444444")
{
	;tooltip, color %colorr% means closed triangle-will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	clickTransformIcon()
	findAnchor()
	Return
}
else if (colorr = "0x868686") ;again, this values will be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	clickTransformIcon()
	findAnchor()
	Return
}
else if (colorr = "0x2C2C2C" || colorr = "0x2B2B2B")
{
	;tooltip, this is a normal panel color of 313131 or %colorr%
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playehad." I don't know if there is a way to CHECK if it is on or not.
	resetFromAutoAnchor()
	;play noise
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPointAP ;this is stupid but it works. Feel free to improve any of my code; I know it's garbage.
		}
	Return
}
else
{
	tooltip, %colorr% not expected
	;play noise
	resetFromAutoAnchor()
	Return
}
Return ;from autoscaler


findAnchor() ; searches for the "anchor point" using a real image
{
tooltip, ;deletes tooltips
;msgbox, now we are in findAnchor
sleep 5
MouseGetPos xPos, yPos
;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\anchorPoint_CC2017.png
if ErrorLevel = 2
	{
    ;tippy(Could not conduct the search)
	resetFromAutoAnchor()
	}
else if ErrorLevel = 1
	{
	;msgbox, error level 1
    ;tippy(Icon could not be found on the screen)
	resetFromAutoAnchor()
	}
else
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX, FoundY, 0
	sleep 5
	findHotTextAP()
	}
}

findHotTextAP()
{
tooltip, ; removes any tooltips that might be in the way of the searcher.
; https://www.autohotkey.com/docs/commands/PixelSearch.htm
;CoordMode Pixel
MouseGetPos, xxx, yyy
PixelSearch, Px, Py, xxx+20, yyy+10, xxx+500, yyy+13, 0x3398EE, 25, Fast RGB ;this searches in a given rectangle for the exact blueish color of the hot text. Make sure you use RGB or the values are swapped for some stupid reason.
if ErrorLevel
	{
    ;tooltip,"colorNotFound")
	resetFromAutoAnchor()
	}
else
	{
	;tooltip, A color within 25 shades of variation was found at X%Px% Y%Py%
    ;MsgBox, A color within 25 shades of variation was found at X%Px% Y%Py%.
    MouseMove, Px+10+73, Py+5, 0 ; The +73 is the amount of pixels I need to go to the RIGHT in order to select the SECOND row of hot text. This corresponds to the VERTICAL, or Y coordinate, for the anchor point hot text.
	Click down left
	Loop
		{
		blockinput, off
		blockinput, MouseMoveOff
		tooltip, %anchorKey% Instant Anchor Point mod
		sleep 15
		GetKeyState, state, %anchorKey%, P
		if state = U
			{
			Click up left
			;tooltip, "%anchorKey% is now physically UP so we are exiting now"
			sleep 15
			resetFromAutoAnchor()
			; MouseMove, XbeginAP, Ybegin, 0
			; tooltip,
			; ToolTip, , , , 2
			; blockinput, off
			; blockinput, MouseMoveOff
			Return
			}
		}
	}
}

;;;--------------------------------------------------------------------------------------------


#IfWinActive ; PREMIERE END

#IfWinActive ahk_exe notepad++.exe
F19::
send ^s
sleep 20
reload
return
