#SingleInstance force ; only 1 instance of this script may run at a time.
#InstallMouseHook
#InstallKeybdHook


CoordMode, Mouse, screen
CoordMode, Pixel, screen

Menu, Tray, Icon, shell32.dll, 17


;-------------------------------------------------------------------------------------------------------------------------------

;Define all the timeline's DEFAULT possible colors.
;Note that your colors will be different IF you changed the UI brightness inside preferences > appearance > brightness.
;use Window Spy (it comes with AHK) to detect exact colors onscreen.
timeline1 = 0x414141 ;timeline color inside the in/out points ON a targeted track
timeline2 = 0x313131 ;timeline color of the separating LINES between targeted AND non targeted tracks inside the in/out points
timeline3 = 0x1b1b1b ;the timeline color inside in/out points on a NON targeted track
timeline4 = 0x202020 ;the color of the bare timeline NOT inside the in out points
timeline5 = 0xDFDFDF ;the color of a SELECTED blank space on the timeline, NOT in the in/out points
timeline6 = 0xE4E4E4 ;the color of a SELECTED blank space on the timeline, IN the in/out points, on a TARGETED track
timeline7 = 0xBEBEBE ;the color of a SELECTED blank space on the timeline, IN the in/out points, on an UNTARGETED track

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



Rbutton::
;<<<use right mouse button to move playhead in timeline>>>>>>
MouseGetPos X, Y
PixelGetColor colorr, %X%, %Y%, RGB
if (colorr = timeline5 || colorr = timeline6 || colorr = timeline7) ;these are the timeline colors of a selected clip or blank space, in or outside of in/out points.
	send ^!d ;set in premiere to DESELECT
if (colorr = timeline1 || colorr = timeline2 || colorr = timeline3 || colorr = timeline4 || colorr = timeline5 || colorr = timeline6 || colorr = timeline7) ;i think I can use "if in" for this kind of thing..
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
Return
