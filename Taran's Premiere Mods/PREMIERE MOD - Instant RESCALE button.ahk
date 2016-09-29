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


 ; SINGLE KEYSTROKE SCALING FUNCTION
;--------------------------------------------------------------------------------
; You have to HOLD DOWN scaleKey the entire time. no need to click and hold the mouse button, it is done for you
; Only works if your UI is a VERY PARTICULAR SHADE OF GRAY - so those values are different for everyone, unfortunately

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
MouseMove, Xcorner+85, Ycorner+100, 0
MouseClick, left
}


;;;INSTANT RESCALE MOD;;;
mButton::
global scaleKey = "mButton"
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
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro ;effect controls panel

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
YY := Ycorner+96
XX := Xcorner+15
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

if (colorr = "0xDDDDDD")
{
	;tooltip, color %colorr% means closed triangle-will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	clickTransformIcon()
	findScale()
	Return
}
else if (colorr = "0xADADAD" || colorr = "0xACACAC") ;again, this values will be different for everyone. check with window spy. This needs to lie on the edge of the trangle when it is open.
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	clickTransformIcon()
	findScale()
	Return
}
else if (colorr = "0x313131")
{
	;tooltip, this is a normal panel color of 313131 or %colorr%
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playehad." I don't know if there is a way to CHECK if it is on or not.
	resetFromAutoScale()
	;play noise
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
Return ;from autoscaler


findScale() ; searches for the "scale" text inside of the Motion effect. requires an actual image.
{
tooltip, ;deletes tooltips
;msgbox, now we are in findScale
sleep 5
MouseGetPos xPos, yPos
CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, C:\Users\TaranVanHemert\Desktop\AHK\scale.png
if ErrorLevel = 2
	{
    ;tippy(Could not conduct the search)
	resetFromAutoScale()
	}
else if ErrorLevel = 1
	{
	;msgbox, error level 1
    ;tippy(Icon could not be found on the screen)
	resetFromAutoScale()
	}
else
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX, FoundY, 0
	sleep 5
	findHotText()
	}
}

findHotText()
{
tooltip, ; removes any tooltips that might be in the way of the searcher.
; https://www.autohotkey.com/docs/commands/PixelSearch.htm
CoordMode Pixel
MouseGetPos, xxx, yyy
PixelSearch, Px, Py, xxx+50, yyy+10, xxx+500, yyy+11, 0x35A1A8, 25, Fast RGB
if ErrorLevel
	{
    ;tooltip,"colorNotFound")
	resetFromAutoScale()
	}
else
	{
	;tooltip, A color within 25 shades of variation was found at X%Px% Y%Py%
    ;MsgBox, A color within 25 shades of variation was found at X%Px% Y%Py%.
    MouseMove, Px+10, Py+5, 0
	Click down left
	Loop
		{
		blockinput, off
		blockinput, MouseMoveOff
		tooltip, "hot text" %scaleKey%
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



#IfWinActive ; PREMIERE END


