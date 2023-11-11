#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

twirlAE(open := 1)
{
;Each track is 26 pixels high on my screen. I think.

BlockInput, on
BlockInput, MouseMove

CoordMode Pixel, window 
CoordMode Mouse, window
; https://www.autohotkey.com/docs/commands/CoordMode.htm

MouseGetPos xPos, yPos
;I currently work on a 4k, 100% UI scaled screen. You might have to change these  values to fit your own screen, if you use a different UI.
rightedge = 200 ;250 for 150% UI
expanseUp = 13  ;32 for 150% UI
expanseDown = 13 ;10 for 150% UI

CoordMode Pixel, window 
CoordMode Mouse, window

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png.

If open = 1
	{
	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, %A_WorkingDir%\AE_down.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\AE_down2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *5 %A_WorkingDir%\AE_down3.png

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

	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, %A_WorkingDir%\AE_right.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\AE_right2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *5 %A_WorkingDir%\AE_right3.png
		
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
tooltip, FAIL`, ErrorLevel is %ErrorLevel%
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resettwirl:
;;MouseMove, xPos-8, yPos-8, 0 ;IDK why, but if I don't subtract a few pixels, the cursor ends up in a slightly wrong spot...
MouseMove, xPos+0, yPos+0, 0 ;oh, it's what happens if after effects isn't full screen. hmm.
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
	Sleep 10
	
	MouseMove, 100, 60, 0, R
	MouseClickDrag, L, , , 0, -600, 0, R ; Drag it up (my effect controls panel is above the effects panel)
		
	Eduuuung:
	MouseMove, X, Y, 0
}
; -------- END of aePreset(); --------------

global selectedLayerX := 0 ; varieble in whitch to store the final value
global selectedLayerY := 0
global layerFound := 0

getSelectedLayer(){ ; function to store the position of selected layer title
	PixelSearch, cX, cY, -1420, 465, -1419, 11390, 0xA5A5A5, 0, fast ; cX - output X varieble, cY - output Y varieble, left upper corner from witch to search (are to be search is described in search_area.png), color to find (0xA5A5A5) 
	Sleep 100
	
	if ErrorLevel { ; if the search throw an exeption - 0(false) = all went smooth, 1(true) = nothing found, 2(true) = the search could not be conducted
		MsgBox, Aperrently no selected layer was found.
		selectedLayerX := ""
		selectedLayerY := ""
		layerFound := 0
	} else { ; if it went smooth
		selectedLayerX := cX
		selectedLayerY := cY
		layerFound := 1
	}
}
; end of getSelectedLayer();


aeGain(gain := "+7") { ; the gain "by how much" not to "what value"
	CoordMode, mouse
	CoordMode, pixel
	
	MouseGetPos, X, Y

	aeFocus("timeline") ; to be SURE colors are right and keyboard shortcuts work...
	
	getSelectedLayer() ; get position of the selected layer and if ti is actually selected
	
	if(layerFound) { ; a layer is selected
		ImageSearch, pX, pY, selectedLayerX - 200, selectedLayerY - 5, selectedLayerX - 150, selectedLayerY + 20, aeTwireledTriangleSelectedLayer.png
		Sleep 5
		if(ErrorLevel = 2) {
			MsgBox Could not conduct the search (mejbí the image wasn't found).
			goto Endiiging
		} else if(ErrorLevel = 1) {
			ImageSearch, pX, pY, selectedLayerX - 200, selectedLayerY - 5, selectedLayerX - 150, selectedLayerY + 20, aeUntwireledTriangleSelectedLayer.png ; If the layer was untwireled, the picture would be diferent - so another try
			Sleep 5
			if(ErrorLevel = 2) {
				MsgBox Could not conduct the search (mejbí the image wasn't found).
				goto Endiiging
			} else if(ErrorLevel = 1) {
				MsgBox Icon could not be found on the screen.
				goto Endiiging
			} else {
				MouseMove, pX, pY, 0
				MouseClick, L ; Twirel the layer to be able to surely untwirel it by presing L to go to audio level
			}
		}
	} else { ; no selected layer
		goto Endiiging
	}
	
	Send l ; untwirel right into audio levels
	Sleep 5
	
	MouseMove, pX + 210, pY + 20, 0
	Sleep 5
	MouseClick, L
	Send {Right} ; put coursor to end of text
	Sleep 5
	if(SubStr(gain,1,1) = "+"){ ; if the first chareacter of the value is +
		Send {NumpadAdd} ; Send + and the value
		gain := SubStr(gain,2)
		Send %gain%
	} else {
		Send {NumpadSub} ; otherwise
		gain := SubStr(gain,2) ; send - and the value
		Send %gain%
	}
	Sleep 500
	Send {Enter}
	
	Endiiging:
	
	MouseMove X, Y, 0
}
; ------- END of aeGain(); ----------------

aeBlendingMode(mode){ ; set blending mode of an layer
	
	downAmount := 0 ; number of keystokes needed to select the proper mode
	
	if(mode = "normal") { ; I tried to do this by arrays but I didn't manage to make it work
		downAmount := 0
	} else if(mode = "dissolve") {
		downAmount := 1
	} else if(mode = "dancing dissolve") {
		downAmount := 2
	} else if(mode = "darken") {
		downAmount := 3
	} else if(mode = "multiply") {
		downAmount := 4
	} else if(mode = "color burn") {
		downAmount := 5
	} else if(mode = "classic color burn") {
		downAmount := 6
	} else if(mode = "linear burn") {
		downAmount := 7
	} else if(mode = "darker color") {
		downAmount := 8
	} else if(mode = "add") {
		downAmount := 9
	} else if(mode = "lighten") {
		downAmount := 10
	} else if(mode = "screen") {
		downAmount := 11
	} else if(mode = "color dodge") {
		downAmount := 12
	} else if(mode = "classic color dodge") {
		downAmount := 13
	} else if(mode = "lighter color") {
		downAmount := 14
	} else if(mode = "overlay") {
		downAmount := 15
	} else if(mode = "soft light") {
		downAmount := 16
	} else if(mode = "hard light") {
		downAmount := 17
	} else if(mode = "linear light") {
		downAmount := 18
	} else if(mode = "vivid light") {
		downAmount := 19
	} else if(mode = "pin light") {
		downAmount := 20
	} else if(mode = "hard mix") {
		downAmount := 21
	} else if(mode = "difference") {
		downAmount := 22
	} else if(mode = "classic difference") {
		downAmount := 23
	} else if(mode = "exclusion") {
		downAmount := 24
	} else if(mode = "subtract") {
		downAmount := 25
	} else if(mode = "divide") {
		downAmount := 26
	} else if(mode = "hue") {
		downAmount := 27
	} else if(mode = "saturation") {
		downAmount := 28
	} else if(mode = "color") {
		downAmount := 29
	} else if(mode = "luminosity") {
		downAmount := 30
	} else if(mode = "stencil alpha") {
		downAmount := 31
	} else if(mode = "stencil luma") {
		downAmount := 32
	} else if(mode = "silhouette alpha") {
		downAmount := 33
	} else if(mode = "silhouette luma") {
		downAmount := 34
	} else if(mode = "alpha add") {
		downAmount := 35
	} else if(mode = "luminescent premul") {
		downAmount := 36
	}
	
	CoordMode, mouse
	CoordMode, pixel
	
	MouseGetPos, X, Y
	
	getSelectedLayer() ; get the position of the selected layer and if it was ACTUALLY selected
	if(layerFound){ ; if it was found
		MouseMove, selectedLayerX, selectedLayerY + 2, 0 ; the + 2 is there to be shure it is on the layer not on anti aliasing...
		Sleep 10
		MouseClick, R ; open menu
		Send {Down 11} ; goto blending mode
		Sleep 20
		Send {Right} ; go inside
		Sleep 3
		Send {Down %downAmount%} ; goto the mode you selected
		Sleep %downAmount% * 5
		Send {Enter}
	}
	
	MouseMove, X, Y, 0
}
; ------ END of aeBlendingMode(); --------
