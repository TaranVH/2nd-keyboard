#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;The ABOVE CODE ^^^ was automaticlaly generated when I made a new .ahk document. I don't know how essential it is.

#SingleInstance force ;only one instance of this script may run at a time!
#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO!

; HELLO, poeple who want info about making a second keyboard! scroll down past all this crap until you get to "F24::"
; here's how the keyboard works with the F24 key: https://youtu.be/lIFE7h3m40U?t=16m9s
; so you also need LUAmacros as well, of course.
; also, here you can see all of my code in action: https://www.youtube.com/user/TaranVH/videos

;[[[[[[[TRANSITIONS RECALLER]]]]]]]]]]]
;variable constants
transX1 = 393
transY1 = 86

transX2 = 319
transY2 = 129

transX3 = 477
transY3 = 126

transX4 = 384
transY4 = 165

transX5 = 386
transY5 = 202

transX6 = 332
transY6 = 243

transX7 = 506
transY7 = 237

transX8 = 399
transY8 = 277

transX9 = 0
transY9 = 0
;end of impact pushes
;begin cross dissolve
transX10 = 696
transY10 = 204

transX11 = 882
transY11 = 204

transX12 = 1145
transY12 = 202
;begin impact flash
transX13 = 687
transY13 = 238

transX14 = 884
transY14 = 240

transX15 = 1138
transY15 = 241
;dip to black
transX16 = 811
transY16 = 280
;dip to white
transX17 = 1170
transY17 = 275

transX18 = 2
transY18 = 2

transX19 = 3
transY19 = 2
;wipe left up
transX20 = 1431
transY20 = 201
;wipe up
transX21 = 1575
transY21 = 198
;wipe right up
transX22 = 1713
transY22 = 202

transX23 = 1436 ;wipe left??
transY23 = 239

transX24 = 1721
transY24 = 240

transX25 = 1428
transY25 = 274

transX26 = 1583 ;wipe down
transY26 = 278

transX27 = 1723
transY27 = 276

transX28 = 2063
transY28 = 237

transX29 = 2385
transY29 = 244
;variable constants for transitions recall


;;;tooltip maker;;;;;;;;;;;;;;
Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere%
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,
	;removes the tooltip
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;<fake mouse "click" on effects panel search bar >
;I don't use this one anymore:
;control alt f
^!f::
ControlFocus, Edit1, ahk_class Premiere Pro
Sleep, 10
return


;<<<<>>>>
;THIS IS THE FUNCTION FOR TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.
effectsPanelType(item)
{
SetKeyDelay, 0
ControlFocus, Edit1, ahk_class Premiere Pro ;this is the effects panel, according to windowspy
sleep 10
send {tab}
sleep 10
send +{tab}
sleep 10
Send +{backspace}
;Sleep, 10
Send %item%
;now this next part re-selects the field in case you want to type anything different
sleep 5
send {tab}
sleep 5
send +{tab}
}

;USING THE FUNCTION:
^!+f::effectsPanelType("") ;-------Types nothing in. So it just CLEARS the effects panel search bar
^!+p::effectsPanelType("presets")
^!+w::effectsPanelType("warp") ; I dont use this one anymnore.
~lButton & rButton::effectsPanelType("presets") ; this is super useful. click both mouse buttons to search
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



;;;;;;;;FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!;;;;;;;;;;;;
;This is the one I actually use!!
preset(item)
{
BlockInput, SendAndMouse
BlockInput, On
;Send ^!+`
;Sleep 10
;Send ^!+7
;Sleep 10
SetKeyDelay, 0
MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%
ControlGetPos, X, Y, Width, Height, Edit1, ahk_class Premiere Pro ;;;highlights Premier's effects panel search bar (info gotten from window spy)
MouseMove, X+Width+10, Y+Height/2, 0
sleep 5
MouseClick, left, , , 1 ;------------------------clicks on X
MouseMove, X-25, Y+10, 0
sleep 5
; MouseClick, left, , , 1 ;----------------------clicks on Q icon to prepare for deletion
; sleep 5
; Send +{backspace} ;----------------------------deletes shit
; sleep 5
MouseClick, left, , , 1
sleep 5
Send %item%
sleep 30
MouseMove, 52, 65, 0, R ;-----------------------moves cursor down and directly onto the effect's icon
MouseGetPos, iconX, iconY
ControlGetPos, , , www, hhh, DroverLord - Window Class10, ahk_class Premiere Pro
MouseMove, www/3, hhh/2, 0, R ;-----------------clicks in about the CENTER of the Effects panel. This clears the displayed presets from any duplication errors
MouseClick, left, , , 1
; msgbox hi bitch
sleep 10
MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the effect's icon

sleep 35
MouseClickDrag, Left, , , %xpos%, %ypos%, 0 ;---drags this effect to the cursor's pervious coordinates, which should be above a clip.
sleep 10
;Send ^+!0 ;-------------------------------------returns focus to the timeline. doesn't work for multiple timelines :(
MouseClick, left, , , 1 ;------------------------returns focus to the timeline.
BlockInput, off
}

;That's the end of the function. Now we make shortcuts to CALL that function, each with a different parameter!

;All of these refer to presets I have already created and named in Premiere
;note that using ALT for these is kind of stupid... they can interfere with menus.
;ALT C, for example, will always open the CLIP menu. So I can't use that anywhere.

!p::preset("crop")

!u::preset("blur 25")

^h::preset("Lumetri Color BLANK")
^g::preset("Lumetri shadows up")
^b::preset("Lumetri BRIGHT")

!r::preset("fill right")
!l::preset("2.4 limiter")
!]::preset("DeHummer Preset")

^+0::preset("card")

^!w::preset("Warp Stabilizer Preset")

;;---I have assigned all of the above keystroke combinations to my macro keys on my keyboard, so it's really just ONE KEYSTROKE to apply them!



;using transform effect presets, from 2nd keyboard with HIDMACROS. only for easy testing purposes.
^+down::preset("pan down")
^+up::preset("pan up")
^+left::preset("pan left")
^+right::preset("pan right")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;This is a function that will mostly be launched from the 2nd keyboard.
insertAudio(sound)
{
CoordMode, Mouse, Screen
BlockInput, SendAndMouse
BlockInput, On
BlockInput, MouseMove
;msgbox, "now in insertAudio()"
SetKeyDelay, 0
Send ^!+e ;this will highlight the EVENTS window, which is always ON MY LEFT-MOST MONITOR. This is important, or controlgetpos will only get the positions of the currently "active" windows on another monitor.
MouseGetPos, xpos, ypos ; stores the cursor's current coordinates at X%xpos% Y%ypos%
MouseMove, -4600, 21, 0 ; just moves onto monitor 1
sleep 30
;msgbox, moved to screen 1
CoordMode, Mouse, Window

;msgbox, monitor 1
ControlGetPos, X, Y, Width, Height, Edit2, ahk_class DroverLord - Window Class
;determined with Window Spy. Keep in mind that you MIGHT need a space after the "Window Class " or you might not!
;ControlGetPos, X, Y, Width, Height, DroverLord - Window Class7, ahk_class DroverLord - Window Class

MouseMove, X+Width+10, Y+Height/2, 0 ;moves to the "X" to delete whatever might be in the search bar.
sleep 10
MouseClick, left, , , 1 ;-------------clicks on X, to erase whatever text might be in the search bar.
MouseMove, X-25, Y+10, 0
sleep 10

MouseClick, left, , , 1
sleep 22
If (sound != "SEARCH")
{
	;msgbox this is not a search
	Send %sound%
	sleep 300
	MouseMove, X+25, Y+150, 0 ;moves down and onto the 1st result.
	sleep 10
	
	MouseClick, left, , , 2 ;loads the clip into the source monitor
	sleep 20
	send . ;period = overwrite.
	
	; MouseClick, right, , , 1
	; Send {down 17} ;highlights "overwrite" (you can't just press "o", which would be nice...)
	; Send {enter}
	
	sleep 10
	MouseMove, X+Width+10, Y+Height/2, 0 ;moves to X
	sleep 22
	MouseClick, left, , , 1 ;-------------clicks on X, to erase whatever text might be inserted.
	Send ^!+7 ;this will highlight the EFFECTS window, which is always ON MY 2ND, PRIMARY MONITOR.
	Sleep 20
	CoordMode, Mouse, Screen
	MouseMove, 2123, 21, 0 ;moves mouse back onto Primary monitor
	;CoordMode, Mouse, Window
	Sleep 20
	MouseMove, xPos, yPos, 0 ;moves mouse back to its original coordinates, instantly.
	Sleep 10
	BlockInput, off
	BlockInput, MouseMoveOff
}
else
{
	;msgbox this was a search
}
BlockInput, off
BlockInput, MouseMoveOff
Return
}

;;;;just for testing -- not permanent key assignments.
;F9::insertAudio("taran woosh")
;F8::insertAudio("SEARCH")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





recallTransition(n:=0)
{
CoordMode, Mouse, Screen

BlockInput, SendAndMouse
BlockInput, On
BlockInput, MouseMove
;msgbox, "now in recallTransition()"
SetKeyDelay, 0
MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%
MouseMove, 7500, 3400, 0 ; moves onto monitor 3
sleep 30
mouseClick
sleep 100
send ^+d ;deselect
sleep 30
;msgbox, moved to screen 3
CoordMode, Mouse, Window

MouseGetPos, , , Window, classNN ; I need to ASK the mouse cursor that the Class number is of the window it's on. It changes a lot.

;msgbox, should be about to move to corner
ControlGetPos, X, Y, Width, Height, %classNN%, ahk_class DroverLord - Window Class
MouseMove, X, Y, 0
sleep 10
;msgbox, should be in top corner now
sleep 10
tempX = transX%n%
tempY = transY%n%
;msgbox, %tempX% %tempY% "these are the tempX and Y variables"
temp2X := %tempX%
temp2Y := %tempY%
;msgbox, %n%
MouseMove, %temp2X%, %temp2Y%, 0, R
;msgbox, should have moved to transition
sleep 70
mouseClick
;msgbox, "I hope this is the right location"
Send ^c
sleep 40
CoordMode, Mouse, Screen
MouseMove, 2000, 0, 0 ;moves back to the primary monitor
sleep 10
MouseMove, xpos, ypos, 0
sleep 10
mouseClick
sleep 5
Send ^v
BlockInput, off
BlockInput, MouseMoveOff
}







;I know that using F24 is stupid. I know that writing and reading a .txt file on disk is stupid, as are all of these stupid ELSE IF statements. (keep in mind, AHK has no SWITCH function.)
;If you can write some code that will work better, please do! And send me a link!
F24::
FileRead, key, C:\Users\TaranVanHemert\Documents\keypressed.txt ;note that you don't need to backslash your backslashes in AHK, you DO need to do that in LUAmacros, though!
tippy(key) ; this will just launch a quick tooltip that shows you what key you pressed.
If (key = "o")
preset("flip horizontal") 
else if(key = "p")
preset("flip vertical")
else if(key = "i")
preset("multiply")

else if (key = "leftbracket")
preset("pop in motion") 
else if(key = "rightbracket")
preset("pop out motion")

else if (key = "y")
preset("pop in transform") 
else if(key = "u")
preset("pop out transform")

else if(key = "m")
preset("pan down")
else if(key = "j")
preset("pan up")
else if(key = "n")
preset("pan left")
else if(key = "comma")
preset("pan right")
else if(key = "h")
preset("zoom fast")
else if(key = "k")
preset("zoom slow")

else if(key = "period")
preset("crop small")
else if(key = "slash")
preset("crop full")
else if(key = "singlequote")
preset("warp")

else if(key = "semicolon")
preset("blur with edges")
else if(key = "l")
preset("LTT")

else if(key = "F6")
insertAudio("buzz")
else if(key = "F7")
insertAudio("ding")
else if(key = "F8")
insertAudio("bleep")
else if(key = "F9")
insertAudio("woosh")
else if(key = "F10")
insertAudio("woosh TSFX")
else if(key = "F11")
insertAudio("bwoop")
else if(key = "F12")
insertAudio("pop")
else if(key = "F5")
insertAudio("SEARCH")

;[[[[[[[[begin transitions]]]]]]]]]]]]

else if (key = "insert") ;FLASH TRANSITIONS
preset("impact flash long") ;recallTransition(15) ;it turns out you can SAVE transition presets from the effect controls triple line mnu button. But only cross dissolve and 3rd party transitions. I use filmimpact.net and red giant universe transitions. Lot of good free ones!
else if(key = "home") 
preset("impact flash med") ;recallTransition(14)
else if(key = "pageup")
preset("impact flash short") ;recallTransition(13)
else if(key = "delete") ;DISSOLVE TRANSITIONS
preset("cross dissolve long") ;recallTransition(12)
else if(key = "end")
preset("cross dissolve med") ;recallTransition(11)
else if(key = "pagedown")
preset("cross dissolve short") ;recallTransition(10)
else if(key = "q") ;WIPE transitions
recallTransition(20)
else if(key = "w")
recallTransition(21)
else if(key = "e")
recallTransition(22)
else if(key = "a")
recallTransition(23)
; else if(key = "s")
; recallTransition(??) ; iris
else if(key = "d")
recallTransition(24)
else if(key = "z")
recallTransition(25)
else if(key = "x")
recallTransition(26)
else if(key = "c")
recallTransition(27)

else if(key = "minus")
audioMonoMaker(0)
else if(key = "equals")
audioMonoMaker(1)

else if(key = "r")
Send ^!+{F1} ;copy 1 ; this uses insideclipboard.exe to work. more info here: https://www.youtube.com/watch?v=3ScBB7I1BEA
else if(key = "f")
Send ^!+{F2} ;copy 2
else if(key = "v")
Send ^!+{F3} ;copy 3

else if(key = "t")
Send ^!{F1} ;paste 1
else if(key = "g")
Send ^!{F2} ;paste 2
else if(key = "b")
Send ^!{F3} ;paste 3


else if(key = "up") ;impact push transitions - fun fact, you can SAVE TRANSITION PRESETS if they are cross dissolve or from a 3rd party. In the effect conrtols triple line menu.
preset("push up") ;			recallTransition(1) ;<--- previously was this.
else if(key = "left")
preset("push left") ;		recallTransition(2)
else if(key = "down")
preset("push down") ;		recallTransition(4)
else if(key = "right")
preset("push right") ;		recallTransition(3)

else if(key = "enter")
Send ^!e ;remove effects

else if(key = "num0") ;just mirroring the normal numpad - IDK how else to do this.
Send {Numpad0}
else if(key = "num1")
Send {Numpad1}
else if(key = "num2")
Send {Numpad2}
else if(key = "num3")
Send {Numpad3}
else if(key = "num4")
Send {Numpad4}
else if(key = "num5")
Send {Numpad5}
else if(key = "num6")
Send {Numpad6}
else if(key = "num7")
Send {Numpad7}
else if(key = "num8")
Send {Numpad8}
else if(key = "num9")
Send {Numpad9}
else if(key = "numDiv")
Send {NumpadDiv}
else if(key = "numMult")
Send {NumpadMult}

Return ;from F24


#IfWinNotActive ahk_exe Adobe Premiere Pro.exe ; this is so that you can use the additional copy/paste features OUTSIDE of premiere also.
F24::
FileRead, key, C:\Users\TaranVanHemert\Documents\keypressed.txt
tippy(key)
If(key = "r")
Send ^!+{F1} ;copy 1
else if(key = "f")
Send ^!+{F2} ;copy 2
else if(key = "v")
Send ^!+{F3} ;copy 3
else if(key = "t")
Send ^!{F1} ;paste 1
else if(key = "b")
Send ^!{F3} ;paste 3
else if(key = "g")
Send ^!{F2} ;paste 2
Return ; from f24 outside premiere



#IfWinActive ahk_exe Adobe Premiere Pro.exe

; these are so I can launch the scripts from my logitech G15 macros if I want to
#!l::
;msgbox, audio leftener
audioMonoMaker(0)
Return

#!r::
;msgbox, audio rightener
audioMonoMaker(1)
Return


audioMonoMaker(track)
{
BlockInput, SendAndMouse ;prevent mouse from moving
BlockInput, On
BlockInput, MouseMove
global tToggle = 1
;msgbox, track is %track%
if (track = 1)
{
	;msgbox, this is the RIGHT track
	addPixels = 38
}
else if (track = 0)
{
	addPixels = 0
	;msgbox, this is for the left audio track
}
Send ^!a ;control alt a --- ; audio channels shortcut - dont use this anywhere else please
sleep 350
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
MouseGetPos, xPosAudio, yPosAudio
MouseMove, 1786 + addPixels, 880, 0
sleep 10
MouseGetPos, Xkolor, Ykolor
sleep 50
PixelGetColor, kolor, %Xkolor%, %Ykolor%
; 080808 = color when cursor is over the box
; 1F1F1F = color when cursor NOT over the box
; DDDDDD = color when there is a checkmark already in the box
; note that these colors will be different depending on your UI brightness set in premiere.
If (kolor = "0x080808") ;"kolor" is the variable name rather than "color" because "color" might be already used for something else in AHK.
{
	click left
}
else if (kolor = "0xDDDDDD")
{
	; there was a checkmark in this box already
}
sleep 5
MouseMove, 1789 + addPixels, 914, 0
sleep 14
MouseGetPos, Xkolor2, Ykolor2
sleep 20
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 30
If (k2 = "0x080808")
{
	click left
}
else if (k2 = "0xDDDDDD")
{
	; there was a checkmark in this box already
}
;msgbox, k2 color was %k2%
sleep 5
Send {enter}
MouseMove, xPosAudio, yPosAudio, 0
BlockInput, off
BlockInput, MouseMoveOff ;return mouse control to the user.
} ; monomaker



