#SingleInstance force

#IfWinActive ahk_exe Adobe Premiere Pro.exe ;this line of code means that everythign BELOW will only happen inside of Premiere. (unless changed later)

;-------------------------------------------------------------------------------------------------------------------------------

; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm


;RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU
; u  					select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
; backspace  			ripple delete --- but I don't use that in AutoHotKey because it's dangerous. This should be changed to something else; I use SHIFT C now.
; shift c				ripple delete --- very convenient for left handed use. Premiere's poor track targeting makes ripple delete less useful than it could be.
; ctrl alt shift d  	ripple delete --- I never type this in manually - long shortcuts like this are great for using AHK or a macro to press them. It gets them out of the way of more important, single keystorkes that I can do by hand.
; delete				delete
; c						delete --- I have this on C as well, because it puts it directly under my left hand. Very quick to press without having to move my hand.
; ctrl r 				speed/duration panel
; shift 1 				toggle track targeting for AUDIO LAYER 1
; shift 2 				toggle track targeting for AUDIO LAYER 2. And so on up to 8.
; alt 1 				toggle track targeting for VIDEO LAYER 1
; alt 2 				toggle track targeting for VIDEO LAYER 2. And so on up to 8. I wish there were DEDICATED shortcuts for ALL layers, both to enable and disable.
; ctrl p 				toggle "selection follows playhead"
; ctrl alt shift 7		effects --- (NOT the Effect controls panel)
; ctrl alt shift 4		program monitor

; Be aware that sometimes other programs like PUUSH can overlap with your customized shortcuts.

;-------------------------------------------------------------------------------------------------------------------------------

;Define all the timeline's possible colors on taran's computer. This accounts for trageted and untargeted tracks, both inside and outside the in and out points.
;Note that your colors will be different, but you can change UI brightness inside preferences > appearance > brightness.
;use Window Spy (it comes with AHK) to detect exact colors onscreen.
timeline1 = 0x2c2c2c
timeline2 = 0x252525
timeline3 = 0x4c4c4c
timeline4 = 0x212121
timeline5 = 0xd3d3d3
timeline6 = 0xdadada
timeline7 = "";0x2b2b2b 
timeline8 = 0xd4d4d4
timeline9 = 0x4b4b4b
timeline10 = 0x3d3d3d

Tippy(tipsHere, wait:=333) ;will create and then delete a tooltip
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



~Rbutton::
;<<<use right mouse button to move playhead in timeline>>>>>>
;tooltip, you are right clicking....
MouseGetPos X, Y
PixelGetColor colorr, %X%, %Y%, RGB
;Tooltip, not working, colors are different
if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6 || colorr = timeline7 || colorr = timeline8 || colorr = timeline9 || colorr = timeline10)
{
	;tooltip, COLORRRRRRRRRRRRRRRRR %colorr%
	; GetKeyState, OutputVar, Rbutton, P
	; Tooltip, WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW %outputvar%
	
	
	; while GetKeyState(Rbutton, P) = D
	while GetKeyState("Rbutton")
		{
		Send \
		Tooltip, Right click playhead mod
		sleep 16
		}
	tooltip,
	Send {escape} ;in case you end up inside the "delete" right click menu from the timeline
	;MouseClick, left
}
; \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Return ; from right click intercept


;Rbutton up::Rbutton up


; Rbutton up::
; ;tooltip, do nothing.

; /*
; msgbox rbutton up
; MouseGetPos X, Y
; PixelGetColor colorr, %X%, %Y%, RGB
; if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6 || colorr = timeline7 || colorr = timeline8 || colorr = timeline9)
; {
	; msgbox, color matches the timeline. so please block the key...
	; return
; }
; else
; {
	; msgbox, do not block the key please
	; ; sendinput, {Rbutton up}
	; MouseClick, Right up
	; return
; }
; */
; return

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
