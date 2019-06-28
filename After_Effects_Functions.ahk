SetWorkingDir, C:\AHK\2nd-keyboard\support_files

#NoEnv
;Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input 
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

;-------------------------------------------------------------------------
; HELLO PEOPLES!
; IF YOU ARE NEW TO AUTOHOTKEY, YOU MUST AT LEAST TAKE THE FOLLOWING TUTORIAL:
; https://autohotkey.com/docs/Tutorial.htm
;
; You will need to know some basic scripting to custom tailor most
; of these scripts to your own machine, if you want to use them!
; VERY IMPORTANT NOTE:
; This file works in tandem with ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; All the functions from HERE are actually CALLED from keyboard shortcuts
; in THAT script. I had to do it this way because of the Stream Deck(s)...
; But you can put your key bindings and functions in the same script if
; you want.
;------------------------------------------------------------------------



twirlAE(open := 1)
{
;Each track is 26 pixels high on my screen. I think.

BlockInput, on
BlockInput, MouseMove

CoordMode Pixel ;, screen  ; IDK why but it works like this...
CoordMode Mouse, screen

MouseGetPos xPos, yPos
;I currently work on a 4k, 100% UI scaled screen. You might have to change these  values to fit your own screen, if you use a different UI.
rightedge = 200 ;250 for 150% UI
expanseUp = 13  ;32 for 150% UI
expanseDown = 13 ;10 for 150% UI

CoordMode Pixel ;, screen  ; IDK why but it works like this...
CoordMode Mouse, screen
; CoordMode, mouse, window
; CoordMode, pixel, window
; coordmode, Caret, window

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

