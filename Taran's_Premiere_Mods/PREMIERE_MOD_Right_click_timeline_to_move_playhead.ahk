#SingleInstance force ; only 1 instance of this script may run at a time.
#InstallMouseHook
#InstallKeybdHook

CoordMode, Mouse, screen
CoordMode, Pixel, screen

Menu, Tray, Icon, imageres.dll, 90

;THIS IS A GREAT FIRST SCRIPT FOR AHK NOOBS! IT WORKS WITH VERY LITTLE SETUP. JUST READ THE STUFF BELOW! YAY! 
;VIDEO EXPLANATION:  https://youtu.be/O6ERELse_QY?t=23m40s

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; NOTE THAT YOU MUST ASSIGN \ (backslash) to "Move playhead to cursor" in Premiere's keyboard shortcuts panel!
; YOU SHOULD ALSO ASSIGN CTRL ALT D to "DESELECT ALL" 
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;NOTE: I use the right mouse button for this because my current mouse does not have macro keys on it. I could use the middle mouse button, but it requires too much pressure to push down so often, and you have to be careful not to accidentally scroll it.
;But if you want to use a button other than the right mouse button, the script becomes a lot simpler. Scroll down to the bottom for that script.

;NOTE: This does not, and cannot work on the timeline where there are no tracks visible.
;Explanation: https://twitter.com/boxrNathan/status/927371468371103745
;That is color 0x212121, and last I checked, it shows up in many other places in premiere, not just that part of the timeline.
;The easy solution is to just fill up your timeline with tracks; have no blank space.

;---------------------------------------------------------------------------------------

;First, we define all the timeline's DEFAULT possible colors.
;(Note that your colors will be different if you changed the UI brightness inside preferences > appearance > brightness.)
;I used Window Spy (it comes with AHK) to detect the exact colors onscreen.
timeline1 = 0x414141 ;timeline color inside the in/out points ON a targeted track
timeline2 = 0x313131 ;timeline color of the separating LINES between targeted AND non targeted tracks inside the in/out points
timeline3 = 0x1b1b1b ;the timeline color inside in/out points on a NON targeted track
timeline4 = 0x202020 ;the color of the bare timeline NOT inside the in out points
timeline5 = 0xDFDFDF ;the color of a SELECTED blank space on the timeline, NOT in the in/out points
timeline6 = 0xE4E4E4 ;the color of a SELECTED blank space on the timeline, IN the in/out points, on a TARGETED track
timeline7 = 0xBEBEBE ;the color of a SELECTED blank space on the timeline, IN the in/out points, on an UNTARGETED track


#IfWinActive ahk_exe Adobe Premiere Pro.exe ;exact name was gotten from windowspy
;--------EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO!----------

Rbutton::
MouseGetPos X, Y
PixelGetColor colorr, %X%, %Y%, RGB
if (colorr = timeline5 || colorr = timeline6 || colorr = timeline7) ;these are the timeline colors of a selected clip or blank space, in or outside of in/out points.
	send {ESC} ;in Premiere 13.0, ESCAPE will now deselect clips on the timeline, in addition to its other uses. i think it is good ot use here, now. But you can swap this out with CTRL SHIFT D if you like.
;send ^!d ;in Premiere, set CTRL ALT D to "DESELECT ALL"
if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6 || colorr = timeline7) ;alternatively, i think I can use "if in" for this kind of thing..
{
	;BREAKTHROUGH -- it looks like a middle mouse click will BRING FOCUS TO a panel without doing ANYTHING ELSE like selecting or going through tabs or anything. Unfortunately, i still can't know with AHK which panel is already in focus.
	click middle ;sends the middle mouse button to BRING FOCUS TO the timeline, WITHOUT selecting any clips or empty spaces between clips. very nice!
	; tooltip, % GetKeyState("Rbutton", "P") ;<----this was essential for me to figure out EXACTLY how AHK wanted this query to be phrased. Why should i need the quotation marks?? Why does it return a 1 and 0, but for the other method, it returns U and D? Who the hell knows...
	; if GetKeyState("$Rbutton") = D ;<--- see, this line did not work AT ALL.
	if GetKeyState("Rbutton", "P") = 1 ;<----THIS is the only way to phrase this query.
		{
		;tooltip, we are inside the IF now
		;sleep 1000
		;tooltip,
		loop
			{
			Send \ ;in premiere, this must be set to "move playhead to cursor."
			Tooltip, Right click playhead mod! ;you can remove this line if you don't like the tooltip. You don't need it!
			sleep 16 ;this loop will repeat every 16 milliseconds.
			if GetKeyState("Rbutton", "P") = 0
				{
				;msgbox,,,time to break,1 ;I use message boxes when debugging, and then just comment the out rather than deleting them. It's just like disabling a clip in Premiere.
				tooltip,
				goto theEnd
				break
				}
			}
		}
	;tooltip,
	Send {escape} ;in case you end up inside the "delete" right click menu from the timeline
	;MouseClick, left ;notice how this is commented out. I deemed it inferior to using ESCAPE.
}
else
	sendinput {Rbutton} ;this is to make up for the lack of a ~ in front of Rbutton. ... ~Rbutton. It allows the command to pass through, but only if the above conditions were NOT met.
theEnd:
Return


;If you don't want to use Rbutton (the right mouse button), then you don't need to check for colors and things. This simplifies the script siginificantly.
;In the following script, You can change "Mbutton" to anything else. like "Xbutton1", or  even "F12" if you wanted.
;So, assuming you've mapped "move playhead to cursor" to the \ key, the problem is that it fires once, waits 1 second, and only then does it continue to fire.
;that's why I use a loop - to send constant keypresses, for a smooth experience.
;SCRIPT HAS NOT YET BEEN TESTED BY ME.

;;;;;Mbutton::\ ;<----this would be the STUPID way of doing this. BAD BAD BAD! do not want!
; #ifwinactive ahk_exe adobe premiere pro.exe
; Xbutton2::
; if GetKeyState("Xbutton2", "P") = 1
		; {
		; loop
			; {
			; Send \ ;in premiere, this must be set to "move playhead to cursor."
			; ;Tooltip, button 5 playhead mod!
			; sleep 16 ;this loop will repeat every 16 milliseconds.
			; if GetKeyState("Xbutton2", "P") = 0
				; {
				; ;msgbox,,,time to break,1
				; tooltip,
				; goto theEnd2
				; break
				; }
			; }
; }
; theEnd2:
; Return

