#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

twirlAE(open := 1)
{
;Each track is 26 pixels high on my screen. I think.

BlockInput, on
BlockInput, MouseMove

MouseGetPos xPos, yPos
;I work on a 4k, 150% UI scaled screen. You might have to change these  values to fit your own screen.
edge = 250
expanseUp = 32
expanseDown = 10

CoordMode Pixel ;, screen  ; IDK why but it works like this...
CoordMode Mouse, screen
; CoordMode, mouse, window
; CoordMode, pixel, window
; coordmode, Caret, window

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png.

If open = 1
	{
	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, %A_WorkingDir%\AE_down.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, *2 %A_WorkingDir%\AE_down2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, *2 %A_WorkingDir%\AE_down3.png

	if ErrorLevel = 0
		{
		;tooltip, The icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX+8, FoundY+8, 0
		sleep 5
		click left
		sleep 5
		goto resettwirl
		}
	}
else if open = 0
	{

	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, %A_WorkingDir%\AE_right.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, *2 %A_WorkingDir%\AE_right2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, edge, yPos+expanseDown, *2 %A_WorkingDir%\AE_right3.png
		
	if ErrorLevel = 0
		{
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX+8, FoundY+8, 0
		sleep 5
		click left
		sleep 5
		goto resettwirl
		}
	}
tooltip, FAIL
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resettwirl:
MouseMove, xPos-11, yPos-11, 0
blockinput, off
blockinput, MouseMoveOff
sleep 20
tooltip,
}
;End of AEtwirl()


aeFocus(panel){
	x := 0 ; blank array to stor the windows position
	y := 0
	if(panel == "effects"){
		x := 200 ; very likely coordinates of my effects etc.
		y := 1200
	} else if(panel == "effect controls"){
		x := 200
		y := 500
	} else if(panel == "timeline"){
		x := -800
		y := 900
	} else if(panel == "essential graphics"){
		x := 900
		y := 1200
	} else if(panel == "viewer"){
		x := 900
		y := 500
	} else if(panel == "preview"){
		x := 2500
		y := 300
	} else if(panel == "tracker"){
		x := 2500
		y := 900
	} else if(panel == "render queue"){
		x := 200
		y := 500
	} else if(panel == "project"){
		x := 2700
		y := 1000
	}
	
	CoordMode, mouse
	
	BlockInput, MouseMove
	
	MouseGetPos, xStart, yStart
	MouseClick, Middle, x, y, 1, 0
	MouseMove, xStart, yStart, 0
	Sleep 10
	
	BlockInput, MouseMoveOff
}

; AE PRESET aplyier - counterpart to Premiere-functions preset(); (I have it rename to prPreset for consistancy but it isn't necesarry)
aePreset(item := "neco se posralo"){
	aeFocus("effects") ; bring focus to effects panel - just to be shure it won't need a double click for aplying the effect later...
	
	CoordMode, mouse
	CoordMode, pixel
	CoordMode, Caret
	
	MouseGetPos, X, Y ; save current mouse pos to be able to return to it at end
	
	ImageSearch, pX, pY, 0, 1000, 50, 1070, aeSearch.png ; pX and pY - coordinats of the lefu upper corner of the image found, from where, to where, picture of the magnification glass
	Sleep 5
	if(ErrorLevel = 2) {
		MsgBox Could not conduct the search (mejbí the image wasn't found).
		goto Eduuuung
	} else if(ErrorLevel = 1) {
		ImageSearch, pX, pY, 0, 1000, 50, 1070, aeSearchSelected.png ; If the bax had anything in it, the picture would be blue - so another try
		Sleep 5
		if(ErrorLevel = 2) {
			MsgBox Could not conduct the search (mejbí the image wasn't found).
			goto Eduuuung
		} else if(ErrorLevel = 1) {
			MsgBox Icon could not be found on the screen.
			goto Eduuuung
		}
	}

	MouseMove, pX + 30, pY + 3, 0
	Sleep 3
	MouseClick, L ; click into the field to start typing
	
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{a Down} ; Select all that's inside the box
	sleep 20
	SendInput, {a up}{Ctrl up}
	sleep 20
	
	Send +{Backspace} ; Delete everything that might have been writen inside the search box alredy.
	Sleep 5
	
	Send %item% ; Enter the preset name
	Sleep 3
	
	MouseMove, 100, 60, 0, R
	MouseClickDrag, L, , , 0, -600, 0, R ; Drag it up (my effect controls panel is above the effects panel)
		
	Eduuuung:
	MouseMove, X, Y, 0
}
; -------- END of aePreset(); --------------
