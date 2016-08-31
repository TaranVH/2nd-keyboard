
;These scripts only worked like 30% of the time, and were needlessly copmlex and finicky.
; I no longer use them.
; I am replacing both of them with insideclipboard scripts --- which will just load a saved clipboard state and PASTE directly into premiere.
;That seems to work fine. That way there's no need to COPY or SEARCH for anyhting. It can just be loaded directly.


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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This is a function that will mostly be launched from the 2nd keyboard.
;This function is frankly terrible and hardly works... I am replacing it with insideclipboard saved clips, which can be pasted in directly.
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

; This is also a terrible and broken script that I am going to replace with insideclipboard stuff.
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