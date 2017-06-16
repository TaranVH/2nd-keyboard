#SingleInstance force ; only 1 instance of this script may run at a time.
#InstallMouseHook
#InstallKeybdHook
#IfWinActive ahk_exe Adobe Premiere Pro.exe ;this line of code means that everything BELOW will only happen inside of Premiere. (unless changed later)

CoordMode, Mouse, screen
CoordMode, Pixel, screen

;-------------------------------------------------------------------------------------------------------------------------------

;Define all the timeline's DEFAULT possible colors.
;Note that your colors will be different IF you changed the UI brightness inside preferences > appearance > brightness.
;use Window Spy (it comes with AHK) to detect exact colors onscreen.
timeline1 = 0x414141 ;timeline color inside the in/out points ON a targeted track
timeline2 = 0x313131 ;timeline color of the separating LINES between targeted AND non targeted tracks inside the in/out points
timeline3 = 0x1b1b1b ;the timeline color inside in/out points on a NON targeted track
timeline4 = 0x202020 ;the color of the bare timeline NOT inside the in out points
timeline5 = 0xDFDFDF ;the color of a SELECTED blank space on the timeline, NOT in the in/out points
timeline6 = 0xE4E4E4 ;the color of a SELECTED blank space on the timeline, IN the in/out points

Tippy(tipsHere, wait:=3000) ;will create and then delete a tooltip
{
ToolTip, %tipsHere%
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,
	;removes the tooltip
return


#IfWinActive ahk_exe Adobe Premiere Pro.exe ;exact name was gotten from windowspy
;---------------------EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO!------------------------------------




;these are commented out because i don't use them anymore:
; control g = make 200% speed
;^g::
;Send ^r200{Enter}
;return

; control h = make 50% speed
;^h::
;Send ^r50{Enter}
;return



; Rbutton::
; MouseGetPos X, Y
; PixelGetColor colorr, %X%, %Y%, RGB
; ;Tooltip, not working, colors are different
; if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6 || colorr = timeline7 || colorr = timeline8 || colorr = timeline9)
; {
	
		; Tooltip, Right click playhead mod2 
		
; }
; else
; {
	; tooltip, click R
	; click right
; }	
; Return


/*
Rbutton::

;tooltip, `nwhat
MouseGetPos X, Y
PixelGetColor colorr, %X%, %Y%, RGB
if (colorr = timeline1)
	{
		tooltip, timeline color yeah
	}
else
	sendinput {Rbutton}
return
*/




Rbutton:: 
;<<<use right mouse button to move playhead in timeline>>>>>>
MouseGetPos X, Y
PixelGetColor colorr, %X%, %Y%, RGB
if (colorr = timeline5 || colorr = timeline6) ;these are the timeline colors of a selected clip or blank space, in or outside of in/out points.
	send ^!d ;set in premiere to DESELECT
if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6)
{
	;BREAKTHROUGH -- it looks like a middle mouse click will SELECT / BRING FOCUS TO a timeline panel without doing ANYTHING ELSE like selecting or going through tabs or anything. So although i can't know with AHK which panel is in focus, I can at least BRING focus to a panel... but only if I already know its position... hmmmmmm...
	;however, i probably CAN just do an image search on the entire screen, for icons that are unique to each panel! then use the coordinates of that to figure out the unique ClassNN! GREAT IDEA, TARAN!
	click middle ;sends the middle mouse button to BRING FOCUS TO the timeline, WITHOUT selecting any clips or empty spaces between clips. very noice.
	
	; tooltip, % GetKeyState("Rbutton", "P") ;<----this was essential for me to figure out EXACTLY how AHK wanted this query to be phrased. Why should i need the quotation marks?? Why does it return a 1 and 0, but for the other method, it returns U and D? Who the hell knows....
	; if GetKeyState("$Rbutton") = D ;<--- see, this line did not work AT ALL.
	if GetKeyState("Rbutton", "P") = 1 ;<----THIS is the only way to phrase this query. Took me 2 hours to figure this shit out.
		{
		;tooltip, we are inside the IF now
		;sleep 1000
		;tooltip,
		loop
			{
			Send \ ;in premiere, this is set to "move playhead to cursor."
			Tooltip, Right click playhead mod!
			sleep 16
			; if GetKeyState("$Rbutton") = U ; again, this does not work at all.
			if GetKeyState("Rbutton", "P") = 0
				{
				;msgbox,,,time to break,1
				tooltip,
				goto theEnd
				break
				}
			}
		}
	;tooltip,
	Send {escape} ;in case you end up inside the "delete" right click menu from the timeline
	;MouseClick, left
}
else
	sendinput {Rbutton} ;this is to make up for the lack of a ~ in front of Rbutton. ... ~Rbutton. It allows the command to pass through, but only if the above conditions were NOT met.
theEnd:
; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Return ; from right click intercept



;<<<<<<<<< Apply any transition to a clip -- sadly you cannot use this to SAVE a CUSTOM transition >>>>>>>>>>>
;(A clip or clips must be selected first.)
; THIS FUNCTION IS NOW OBSOLETE, BECAUSE I HAVE FIGURED OUT HOW TO SAVE AND LOAD CLIPBOARDS INSIDE PREMIERE -- MEANING I CAN NOW PASTE ANY TRANSITION I WANT.

transition(name, xx:=70, yy:=245)
{
Tippy(name " transition", 600)
SetKeyDelay, 0
MouseGetPos, xpos, ypos 
BlockInput, on
BlockInput, MouseMove ;----------------Prevents the user from interfering with the operation.
ControlGetPos, X, Y, Width, Height, Edit1, ahk_class Premiere Pro
MouseMove, X-25, Y+10, 0 ;-------------moves the cursor directly on top of the magnifying glass icon -- your coordinates will vary!
sleep 10 ;-----------------------------does nothing for 10 milliseconds. I like to ensure that the previous command has had a bit of time
MouseClick, left, , , 1 ;--------------clicks the left mouse button once. This should select the search bar AND the text inside!
sleep 10
Send +{backspace} ;--------------------shift backspace is less destructive than regular backspace, and still deletes text!
sleep 10
Send %name%
;msgbox, should have typed stuff in
sleep 10
MouseMove, %xx%, %yy%, 0, R ;----------moves down to the transition's icon. Your pixel count will be different!
sleep 10
;msgbox, should be on top of the transition
MouseClick, right
Send {down} ;--------------------------selects "set selected as default transition"
Send {enter}
Send ^t ;------------------------------CTRL T is my Premiere shortcut for "apply default transition to selection"
sleep 10
MouseMove, %xpos%, %ypos%, 0
BlockInput, off
BlockInput, MouseMoveOff ;-------------returns mouse control
}

;Using the code:

;F7::transition("impact flash", 70, 245) ;-----the search result will not always be in the same location. This can modify coordinates.
;F8::transition("dip to black") 
;F9::transition("push", 0, 0)
;F10::transition("cross zoom", 0, 0)


#IfWinActive





;--------------------------------------------------------------------------------------------------------------------------


;THESE ARE JUST NOTES FOR MYSELF--- IGNORE THEM PLZ


;ControlGetPos [, X, Y, Width, Height, Control,   WinTitle,               WinText,                      ExcludeTitle, ExcludeText]
;ControlGetPos, x, y, w, h,            %classNN%, ahk_class %ahk_class%,  DroverLord - TabPanel Window, 0,            0

;effectControls:
;ControlGetPos, X, Y, Width, Height, DroverLord - Window Class2, ahk_class Premiere Pro, DroverLord - TabPanel Window
;Control ==== classNN   ======= DroverLord - Window Class2
;WinTitle === ahk_class ======= ahk_class Premiere Pro
;WinText ==== Text:	======= DroverLord - TabPanel Window

;Effects:
;ControlGetPos, X, Y, Width, Height, Edit1, ahk_class Premiere Pro
;Control ==== classNN   ======= edit 1                            ///// or alternatively, the whole panel is: DroverLord - Window Class10... sometimes
;WinTitle === ahk_class ======= ahk_class Premiere Pro
;WinText ==== Text:	======= DroverLord - TabPanel Window

;BIN:
;Control ==== classNN   ======= DroverLord - Window Class2
;WinTitle === ahk_class ======= DroverLord - Window Class
;WinText ==== Text:	======= DroverLord - TabPanel Window

;Bin search bar:
;ControlGetPos, X, Y, Width, Height, Edit4, ahk_class DroverLord - Window Class 
;Control ==== classNN   ======= Edit1
;WinTitle === ahk_class ======= DroverLord - Window Class
;WinText ==== Text:	======= [blank]
