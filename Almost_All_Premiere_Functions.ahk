SetWorkingDir %A_ScriptDir%
#NoEnv
Menu, Tray, Icon, shell32.dll, 283
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#MaxHotkeysPerInterval 2000

;#Warn

; temporary tooltip maker
Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere% TP,,,8
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,,,,8
	;removes the tooltip
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe

monitorKeys(whichMonitor,shortcut,useSpace := 1)
{
	if WinActive("ahk_exe Adobe Premiere Pro.exe") ;AHA, it is better to use the EXE, because if you are in a secondary monitor window, then the CLASS is not active even though the EXE still is, mildly interesssstting.
	{
		if (whichMonitor = "source"){
			x := "3100"
			y := "1000"
		} else {
			x := "1000"
			y := "400"
			whichMonitor = "program" ;just in case it was not defined properly, it becomes "program" by default.
		}
		
		;testing some sheeit
		x := "1000"
		y := "400"

		ActiveHwnd := WinExist("A")
		windowWidth := CoordGetControl(x,y, ActiveHwnd)

		if (windowWidth < 1500){ ;this means that the monitor is NOT maximized
			if (whichMonitor = "source"){
				prFocus("source") ;keep in mind, this FIRST brings focus to the Effects panel
			} else {
				prFocus("program") ;keep in mind, this FIRST brings focus to the Effects panel
			}
			sleep 20
		}

		sleep 30 ;sometimes these shortcuts don't "take" without a bit of delay.
		sendinput, %shortcut% ;so, this would be translated to   sendinput, ^+2   or something like that.

	}

	;THE CODE ABOVE IS SUPER OPTIONAL

	if (windowWidth < 1500){ ;again, if the monitor in question is NOT already maximized...
		if not (whichMonitor = "source"){ ;stay on the source (program?) monitor if it is active
			prFocus("timeline")
		}
	}
}
;end of monitorKeys() 



prFocus(panel){ ;this function allows you to have ONE spot where you define your personal shortcuts that "focus" panels in premiere.
	Send ^+!{F10}
	sleep 12
	
	Send ^+!{F10}
	Sleep 50 ;do it AGAIN, just in case a panel was full-screened... it would only have exited full screen, and not switched to the effects panel as it should have.
	
	if (panel = "effects"){
		Send ^+!{F7} ;Send ^!+7 ;do nothing. the shortcut has already been pressed.
	}else if (panel = "timeline"){
		Send ^+!{F3}
		Sleep 10 ;if focus had already been on the timeline, this would have switched to the next sequence in some arbitrary order.
	}else if (panel = "program"){ ;program monitor
		Send ^+!{F4}
	}else if(panel = "lumetri scopes"){
		Send ^+!{F10}
	}else if (panel = "source"){ ;source monitor
		Send ^+!{F2}
	}else if (panel = "project"){ ;AKA a "bin" or "folder"
		Send ^+!{F1}
	}else if (panel = "effect controls"){
		Send ^+!{F5}
	}else if(panel = "lumetri"){
		Send ^+!{F9}
	}else if(panel = "audio track mixer"){
		Send ^+!{F6}
	}
theEnd: ; Goto out-point
}

; Type in efects search
effectsPanelType(item := "neco se posralo"){
prFocus("effects")
sleep 20
Send ^b ;CTRL B --set in premiere to "select find box." Makes a windows noise if you do it again.
sleep 20
Send +{backspace} ;shift backspace deletes any text that may be present.
Sleep, 10
Send %item%
;-- now this next part re-selects the field in case you want to type anything different
sleep 10
send ^!b ;ctrl alt B is ALSO select find box, but doesn't have the annoying windows sound.
}


;;;;;;;;;;FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!;;;;;;;;;;;;
#IfWinActive ahk_exe Adobe Premiere Pro.exe
prPreset(item := "neco se posralo"){
Sendinput, k ;shuttle STOP

ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto theEnding ;and this line is here just in case the function is called while not inside premiere.

sleep 10
Send k ; another shortcut for Shuttle Stop.
;so if the video is playing, this will stop it. Othewise, it can mess up the script.
sleep 50
coordmode, mouse, screen
MouseGetPos, xposP, yposP
;Setting the coordinate mode is really important. This ensures that pixel distances are consistant for everything, everywhere.
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window


;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On

SetKeyDelay, 0 ;this ensures that any text AutoHotKey "types in," will input instantly, rather than one letter at a time.
 ;---stores the cursor's current coordinates at X%xposP% Y%yposP%
send, {mButton} ;this will MIDDLE CLICK to bring focus to the panel underneath the cursor (the timeline). I forget exactly why, but if you create a nest, and immediately try to apply a preset to it, it doesn't work, because the timeline wasn't in focus...?
prFocus("effects") ;CTRL SHIFT ALT 7 --set this in premiere's keyboard shortcuts menu to the "effects" panel

sleep 20
Send ^b ;CTRL B -- set in premiere to "select find box"
sleep 20
; sleep 20 
;Any text in the Effects panel's find box has now been highlighted. There is also a blinking "text insertion point" at the end of that text. This is the vertical blinking line, or "caret."  

MouseMove, %A_CaretX%, %A_CaretY%, 0
sleep 55 ;sometimes, premiere takes some time to notice that the text box has been highlighted. in that case, it will not return any value for the position of the Caret. Tehrefore, you have to wait.
MouseMove, %A_CaretX%, %A_CaretY%, 0
;and fortunately, AHK knows the exact X and Y position of this caret. So therefore, we can find the effects panel find box, no matter what monitor it is on, with 100% consistency.
sleep 15
MouseGetPos, , , Window, classNN
WinGetClass, class, ahk_id %Window%
;tooltip, 2 - ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
sleep 50
;;;I think ControlGetPos is not affected by coordmode??  Or at least, it gave me the wrong coordinates if premiere is not fullscreened... https://autohotkey.com/docs/commands/ControlGetPos.htm 
ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
;;my results:  59, 1229, 252, 21,      Edit1,    ahk_class Premiere Pro

;tooltip, classNN = %classNN%
;sleep 50
;now we have found a lot of useful informaiton about this find box. Turns out, we don't need most of it...
;we just need the X and Y coordinates of the "upper left" corner...

;comment in the following line to get a message box of your current variable values. The script will not advance until you dismiss the message box.
;MsgBox, xx=%XX% yy=%YY%

;MouseMove, XX-25, YY+10, 0 ;--------------------for 150% UI scaling, this moves the cursor onto the magnifying glass
MouseMove, XX-15, YY+10, 0 ;--------------------for 100% UI scaling, this moves the cursor onto the magnifying glass
;msgbox, should be in the center of the magnifying glass now.
;sleep 50
sleep 5
;This types in the text you wanted to search for. Like "pop in." We can do this because the entire find box text was already selected by Premiere. Otherwise, we could click the magnifying glass if we wanted to , in order to select that find box.
Send %item%

sleep 50
;MouseMove, 62, 95, 0, R ;----------------------(for 150% UI) relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the preset's icon. In my case, it is inside the "presets" folder, then inside of another folder, and the written name sohuld be compeltely unique so that it is the first and only item.
MouseMove, 41, 63, 0, R ;----------------------(for 100% UI) 
Sleep 10
CoordMode, mouse, screen
MouseGetPos, cojavim, cojanevim
MouseClickDrag, Left, %cojavim%, %cojanevim% , %xposP%, %yposP%, 2 ;---clicks the left button down, drags this effect to the cursor's pervious coordinates and releases the left mouse button, which should be above a clip, on the TIMELINE panel.
sleep 50
MouseClick, middle, , , 1 ;this returns focus to the panel the cursor is hovering above, WITHOUT selecting anything. great!
blockinput, MouseMoveOff ;returning mouse movement ability
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work if you get stuck!! Cool.
theEnding:
}
;END of preset()


savepreset(presetname){
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
msgbox, text in clipboard = %clipboard%
presetname = %clipboard%
msgbox, presetname = %presetname%
return presetname
}

;you can select something inside of premiere (like a group of clips, or a transition) and then, with this code, you can COPY it and SAVE that clipboard state. I use this in conjunction with my secondary keyboard.
;You need to have insideclipboard.exe installed, and all the file paths properly comfigured.
;Keep in mind that you must RESTART your computer before the clipboard states become usable. IDK why.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
saveClipboard(int) {
	StringReplace, int, int, +, , All ;replace + with nothing. This is just in case A_thishotkey contains + if shift was used!
	StringReplace, int, int, !, , All ;replace ! with nothing. This is just in case A_thishotkey contains ! if alt was used!
	StringReplace, int, int, ^, , All ;replace ^ with nothing. This is just in case A_thishotkey contains ^ if ctrl was used!
	;msgbox, , , saving as %int%, 0.6
	tooltip, saving as`n"clip" . %int% . ".clp"
	sleep 10
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
	sleep 20
	ClipWait, 0.25 ; this line might not be needed.
	SendInput, {c up}{Ctrl up}
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 1000
	saveToFile("clip" . int . ".clp")
	tooltip,
}

;This is the real magic. With this script, you can PASTE those previously saved clipboard states, at any time.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
recallClipboard(int, transition := 0) {
	WinActivate, Adobe Premiere Pro
	prFocus("timeline")
	;Send ^!d ;this is to deselect any clips that might be selected in the timeline.
	;tooltip, "now loading random text into the clipboard."
	loadFromFile("clipTEXT.clp") ;to create this file, just highlight some plain text, copy it, and use insideclipboard.exe to save it as clipTEXT.clp. The clipboard MUST have some text inside; it CANNOT be completely empty. This has the effect of DELETING all the aspects of the clipboard, EXCEPT for text.
	sleep 15
	; ; WinActivate, Adobe Premiere Pro ;IDK if this is needed here.
	; ; loadFromFile("clipTEXT.clp") ;The clipboard must be loaded twice, or it won't work about 70% of the time! I don't know why...
	; ; sleep 15
	;Autohotkey can now delete that string of text, so that no text is accidentlaly pasted into premiere. It doesn't seem to be able to delete EVERYTHING, so the above code is definitely necessary!
	clipboard = 
	;The clipboard is now completely empty.
	sleep 10
	
	;tooltip, now pasting NOTHING into premiere....
	WinActivate, Adobe Premiere Pro ;extremely important to ensure you are still active/focused on Premiere
	SendInput, {Shift Down}{Shift Up}
	sleep 10
	SendInput, {Ctrl Down}{v Down} ;this is a MUCH more robust way of using the keyboard shortcuts to PASTE, rather than just using "Send ^v"
	sleep 5
	SendInput, {v Up}{Ctrl Up}
	sleep 20
	
	;It is necessary to PASTE this COMPLETELY BLANK clipboard into premiere, or Premiere won't "know" that the clipboard has been completely emptied.
	;If you don't do this, Premiere will just use whatever thing you had previously copied inside of Premiere.
	clipboard = 
	;the above line is another method for clearing the clipboard that must also be done to ensure a totally empty clipboard
	sleep 30
	;tooltip, "clip" . %int% . ".clp" ;this code doesn't work
	;tooltip, now preparing to paste %int%
	;msgbox, %int%
	WinActivate, Adobe Premiere Pro 
	loadFromFile("clip" . int . ".clp") ;now we are loading the previously saved clipboard file!
	sleep 15
	; ; loadFromFile("clip" . int . ".clp") ;This must be done twice, or it doesn't work! I don't know why!! :D ;ADENDUM - i tried it with only 1 load and NOW it IS working??? IDK why
	; ; sleep 15
	WinActivate, Adobe Premiere Pro ;this is extremely important.... otherwise, it will try to paste into the command prompt or something. You must ensure the correct program is pasted into.
	
	; ; ; if (transition = 0)
	; ; ; {
		; ; ; target("v1", "off", "all", 5) ;this will disable all video layers, and enable only layer 5.
		; ; ; tooltip, only layer 5 was turned on should be
		; ; ; sleep 150
		
	; ; ; }
	tooltip, now PASTING into premiere...
	WinActivate, Adobe Premiere Pro
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	sleep 5
	SendInput, {v Up}{Ctrl Up}
	sleep 10
	
	;the below code doesn't work very well.
	; sleep 100
	;If (transition = 1){
	; ;now if we want an accurate label colorwe have to DELETE what we just did, since none of the label colors will be correct due to a premiere bug.
	; ;tooltip,,,gonna delete now,1
	; tooltip,gonna delete now
	; WinActivate, Adobe Premiere Pro
	; prFocus("timeline")
	; WinActivate, Adobe Premiere Pro
	; SendInput, +{delete} ;ripple delete
	; sleep 100
	
	; ;now to paste again, now that the label colors have been loaded.
	; ;REDO might also work. must test that.
	; WinActivate, Adobe Premiere Pro
	; prFocus("timeline")
	; sleep 30
	; SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	; ClipWait, 0.50
	; SendInput, {v Up}{Ctrl Up}
	; sleep 10
	;}
	
	
	if (transition = 0)
		target("v1", "on", "all")
	sleep 10
	; send ^{F9} ;toggle video tracks (hopefully off)
	; send ^+{F9} ;toggle audio tracks (hopefully off)
	tooltip,
	Send, ^!{F11} ;this is to deselect any clips that might be selected in the timeline. WAS ctrl alt D. might be unreliable.
	
} ;end of recall Clipboard()

;;target() is a script to TARGET or UNTARGET any arbitrary track.
;it doesn't work well, and I don't really use it.
Target(v1orA1, onOff, allNoneSolo := 0, numberr := 0)
{
;tooltip, now in TARGET function
; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos xPosCursor, yPosCursor
prFocus("timeline") ;brings focus to the timeline.
wrenchMarkerX := -1510
wrenchMarkerY := 500 ;the upper left corner for where to begin searching for the timeline WRENCH and MARKER icons -- the only unique and reliable visual i can use for coordinates.
targetdistance := 98 ;Distance from the edge of the marker Wrench to the left edge of the track targeting graphics
CoordMode Pixel ;, screen  ; IDK why, but it only works like this...
CoordMode Mouse, screen

;tooltip, starting
ImageSearch, xTime, yTime, wrenchMarkerX, wrenchMarkerY, wrenchMarkerX+600, wrenchMarkerY+1000, %A_WorkingDir%\timelineUniqueLocator2.png
if ErrorLevel = 0
	{
	;MouseMove, xTime, yTime, 0
	;tooltip, where u at son. y %ytime% and x %xtime%
	;do nothing. continue on.
	xTime -= targetdistance
	;MouseMove, xTime, yTime, 0
	}
else
	{
	tooltip, fail
	goto resetTrackTargeter
	}
;tooltip, continuing...

ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_targeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_targeted_alone.png
if ErrorLevel = 2
	{
	tippy("TARGETED v1 not found")
	goto trackIsUntargeted
	}
if ErrorLevel = 3
	{
	tippy("Could not conduct the TARGETED v1 search!")
	goto resetTrackTargeter
	}
if ErrorLevel = 0
	{
	;MouseMove, FoundX, FoundY, 0
	;tooltip, where is the cursor naow 1,,,2
	;tippy("a TARGETED track 1 was found.")
	if (v1orA1 = "v1")
		{
		send +{Numpad9} ;command in premiere to "toggle ALL video track targeting."
		sleep 10
		if (onOff = "on")
			{
			;tippy("turning ON")
			send +{Numpad9} ; do it again to TARGET everything.
			}
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	else if (v1orA1 = "a1")
		{
		send !{Numpad9} ;command in premiere to "toggle ALL audio track targeting."
		sleep 10
		if (onOff = "on")
			send !9 ; do it again to TARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
	goto resetTrackTargeter
	}

trackIsUntargeted:
;tooltip, track is untargeted,,,2
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_untargeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_untargeted_alone.png
if ErrorLevel = 0
	{
	;MouseMove, FoundX, FoundY, 0
	;tippy("an UNTARGETED track 1 was found.")
	;tooltip, where is the cursor naow,,,2
	
	if (v1orA1 = "v1")
		{
		send +{Numpad9};send +9 ;command in premiere to "toggle ALL video track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send +{Numpad9} ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	if (v1orA1 = "a1")
		{
		send !{Numpad9} ;command in premiere to "toggle ALL audio track targets." This should TARGET everything. ;also ALT f9 but it's dangerous.
		sleep 10
		if (onOff = "off")
			send !{Numpad9} ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
	goto resetTrackTargeter
	}

resetTrackTargeter:
; MouseMove, xPosCursor, yPosCursor, 0
; blockinput, off
; blockinput, MouseMoveOff
;sleep 1000
sleep 10
}
;END of Target()

#ifwinactive
saveToFile(name) {
	;code below does not use any fancy variables. It's a bare string. Unfortunately, I can't find a way to make it work better...
	;change this path ----|                  																 and this one --------|    to your own folder locations.
	;    	              |																										  |
	;                     v																									  	  v
	RunWait, %comspec% /c C:\Users\matya\Desktop\PremiereAHK\InsideClipboard.exe /saveclp %name%, C:\Users\matya\Desktop\PremiereAHK
	
	
	;just saving the below lines of code, which didn't work because %pathh% nor %Exec% variables could not be defined properly. Or something... IDK....
	;RunWait, %comspec% /c %Exec% /saveclp %name%, c:\Users\TaranWORK\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	;RunWait, %comspec% /c %Exec% /saveclp %name%, %pathh%
	
}

loadFromFile(name) {
	; You'll need to change these paths too!
	RunWait, %comspec% /c C:\Users\matya\Desktop\PremiereAHK\InsideClipboard.exe /loadclp %name%, C:\Users\matya\Desktop\PremiereAHK
}

;i think the line below is probably useless but i am afraid to delete it
#IfWinActive ahk_exe Adobe Premiere Pro.exe



;audioMonoMaker() will open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source.
audioMonoMaker(track){
	ifWinNotActive ahk_exe Adobe Premiere Pro.exe
		goto monoEnding
	sleep 3
	;msgbox,,, what the hell,0.6
	CoordMode,Mouse,Screen
	CoordMode,pixel,Screen
	;SetTitleMatchMode, 2
	;DetectHiddenWindows, On

	BlockInput, SendAndMouse
	BlockInput, On
	BlockInput, MouseMove ;prevents mouse from moving

	global tToggle = 1
	;msgbox, track is %track%
	if (track = "right")
	{
		;msgbox, this is for the RIGHT audio track. As usual, your number will be smaller, since I have 150% UI scaling enabled.
		addPixels = 30
	}
	else if (track = "left")
	{
		addPixels = 0
		;msgbox, this is for the LEFT audio track
	}
	Send ^!a ;control alt shift a --- ; audio channels shortcut, asigned in premiere - dont use this key combo anywhere else. UPDATE: seems unreliable to send shortcuts that use modifier keys, inside a funciton that was triggered using modifier keys. switched to F3.
	sleep 15

	MouseGetPos, xPosAudio, yPosAudio
	MouseMove, 970, 830, 0 ;moved the mouse onto the expected location of the "okay" box, which has a distinct white color when the cursor is over it, which will let us know the panel has appeared.

	; msgbox where am i, cursor says
	MouseGetPos, MouseX, MouseY

	waiting = 0
	;the following loop is waiting until it sees a specific color from the panel, which means that it has loaded and can then be affected.
	loop
		{
		waiting ++
		sleep 50
		tooltip, waiting = %waiting%`npixel color = %thecolor%
		MouseGetPos, MouseX, MouseY
		PixelGetColor, thecolor, MouseX, MouseY, RGB
		if (thecolor = "0x1D1D1D")
			{
			tooltip, COLOR WAS FOUND
			;msgbox, COLOR WAS FOUND 
			break
			}
			
		if (waiting > 50)
			{
			tooltip, no color found, go to ending
			goto, ending
			}
		}
		Sleep 150
	;*/
	CoordMode, Mouse, Client
	CoordMode, Pixel, Client
MouseMove, 105 + addPixels, 200, 0 ;this is relative to the audio channels window itself. Again, you should reduce these numbers by like 33%...?, since i use 150% UI scaling.
;msgbox, now we should be on the first check box
sleep 50
MouseGetPos, Xkolor, Ykolor
sleep 50
PixelGetColor, kolor, %Xkolor%, %Ykolor%
;msgbox, % kolor
; INFORMATION:
; 2b2b2b or 464646 = color of empty box
; cdcdcd = color when cursor is over the box
; 9a9a9a = color when cursor NOT over the box
; note that these colors will be different depending on your UI brightness set in premiere.
; For me, the default brightness of all panels is 313131 and/or 2B2B2B

;msgbox, kolor = %kolor%
If (kolor = "0x1d1d1d" || kolor = "0x333333") ; This is the color of an EMPTY checkbox. The coordinates hsould NOT lead to a position where the grey of the checkmark would be. Also, "kolor" is the variable name rather than "color" because "color" might be already used for something else in AHK.
{
	;msgbox, box is empty
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
}
else if (kolor = "0xb9b9b9") ;We are now looking for CHECK MARKS. This coordinate, should be directly on top of the box, but NOT directly on top of the GRAY checkmark itself. You need to detect telltale WHITE color that means the box has been checked.
{
	; Do nothing. There was a checkmark in this box already.
}
MouseMove, 105 + addPixels, 225, 0
sleep 10
MouseGetPos, Xkolor2, Ykolor2
sleep 30
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 10
;msgbox, k2 = %k2%
If (k2 = "0x1d1d1d" || k2 = "0x333333") ;both of these are potential dark grey background panel colors
{
	;msgbox, box is empty. i should click
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
	;msgbox, did clicking happen?
}
else if (k2 = "0xb9b9b9")
{
	; Do nothing. There was a checkmark in this box already
}
;msgbox, k2 color was %k2%
sleep 5
Send {enter}
ending:
CoordMode, Mouse, screen
CoordMode, Pixel, screen
MouseMove, xPosAudio, yPosAudio, 0
BlockInput, off
BlockInput, MouseMoveOff ;return mouse control to the user.
tooltip,
monoEnding:
} ; monomaker!!!!!!!!!!!!

reselect()
{
;alt k??
Send k ; another shortcut for Shuttle Stop
sleep 5
prFocus("effects") ; shortcut for select Effects panel
sleep 5
prFocus("timeline") ; shortcut for select timeline
sleep 5
send ^!d ;deselect
sleep 10
send ^p
sleep 1
send ^p ;toggles selection follows playhead

}
;end of reselect()

addGain(amount := 7)
{
send a
sleep 150
send %amount%
sleep 5
send {enter}
}
;end of addGain()

#ifwinactive

marker(){
send ^{SC027} ;this is the scan code for a semicolon.  ^;  CTRL SEMICOLON.
;msgbox,,,hie,0.5
;should be hitting CTRL ; to make a marker. That's a premiere shortcut u gotta set up.
;sleep 10
}

;EFFECT CONTROLS PANEL ---TRANSFORM ICON CLICKER
clickTransformIcon2()
{
Tippy("transform icon - F5") ;optional. Used to aid debugging. Delete this if it causes problems.
BlockInput, On ;blocks keyboard and mouse input... I think.
SetKeyDelay, 0
sendinput ^!+5 ;highlights the effect controls
sleep 20
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window ;This is the Effect controls panel. Info gotten from Window Spy. Your might be different. Be sure to check!!

;X := X+85 ;150% ui. change these variables to match the icon's position on your screen
;Y := Y+100 ;150% ui. change these variables to match the icon's position on your screen

X := X+56 ;100% ui
Y := Y+66 ;100% ui

MouseMove, X, Y, 0
MouseClick, left
MouseMove, %xpos%, %ypos%, 0
BlockInput, Off
}


masterClipSelect()
{
Tippy("masterClipSelect()")
BlockInput, On
BlockInput, MouseMove
SetKeyDelay, 0
prFocus("effect controls") ;highlights the effect controls
sleep 20

;NEEDED - code that can tell if a clip is already selected or not. instantVFX uses that.
;untwirl()

restart := 0
masterClipRestart:

Send {tab}
Sleep 50
if (A_CaretX = "")
{
	;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	;Therefore, we try to select the TOP clip at the playhead, using the code below.
	Send ^p ;"selection follows playhead,"
	sleep 10
	Send ^p
	restart++
	if(restart < 2) {
		goto masterClipRestart
	} else {
		Tippy("MaterClip Alredy Selected!", 1300)
		goto endung
	}
}
Send {Right}
Sleep 10
CoordMode, mouse, window
CoordMode, Caret, window
X := A_CaretX
Y := A_CaretY
X -= 140
Y -= 62
MouseMove, X, Y, 100
Sleep 10
;MSGBOX, trying to select masterclip
MouseClick, left

;MouseMove, %xpos%, %ypos%, 0 ;moves back to original coordinates
MouseMove, 250, 100, 0, R ;moves down and to the right to be inthe middle of the master clip controls.

endung:

CoordMode, mouse
CoordMode, Caret ; Reset coord mode to "Screen"

BlockInput, Off
BlockInput, MouseMoveOff
} ; End Master Clip

;i should delete or merge this but i think it is used SOMEWHERE....
clickTransformIcon()
{
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class13, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.

; Xcorner := Xcorner+83 ;150% ui
; Ycorner := Ycorner+98 ;150% ui
Xcorner += 56 ;100% ui
Ycorner += 66 ;100% ui

MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
sleep 10 ; just to make sure it gets there, this is done twice.
MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
;msgbox, the cursor should now be positioned directly over the transform icon. `n Xcorner = %Xcorner% `n Ycorner = %Ycorner%
MouseClick, left
}


;script to lock video and audio layers V1 and A1.
;I don't recommend that anyone use this. It's really finnicky to set up. Requires a ton of very carefully taken screenshots in order to work...
tracklocker()
{
BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor

xPos = -1600
yPos = 550 ;the coordinates of roughly where my timeline usually is located on the screen (a 4k screen.)
CoordMode Pixel ;, screen  ; IDK why, but it works like this...
CoordMode Mouse, screen
; CoordMode, mouse, window
; CoordMode, pixel, window
; coordmode, Caret, window
;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are done with default UI brightness, plus 150% UI scaling in Wondows.
;msgbox, workingDir is %A_WorkingDir%
ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_targeted_2019_ui100.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_targeted_2019_ui100.png
; if ErrorLevel = 1
	; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_untargeted_2018.png
; if ErrorLevel = 1
	; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_untargeted_2018.png
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2
    tippy("NO UNLOCK WAS FOUND")
	goto try2
	}
if ErrorLevel = 2
	{
    tippy("Could not conduct the search!")
	goto resetlocker
	}
if ErrorLevel = 0
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX+10, FoundY+10, 0
	sleep 5
	click left
	MouseMove, FoundX+10, FoundY+60, 0 ;moves downwards and onto where A1 should be...
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
	
try2:
tippy("we are now on try 2")
; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *2 %A_WorkingDir%\v1_ALT_locked_targeted_2018.1.png

	
if ErrorLevel = 1
	{
    tippy("try 2 part 1")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_locked_targeted_2019_ui100.png
	}
if ErrorLevel = 1
	{
    tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\IDK_2.png
	}
; if ErrorLevel = 1
	; {
    ; tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_locked_untargeted.png
	; }
if ErrorLevel = 2
	{
    tippy("Could not conduct search #2")
	goto resetlocker
	}
	
if ErrorLevel = 0
	{
	;tippy("found a locked lock")
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+10, 0
	sleep 5
	click left ;clicks on Video track 1
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+60, 0
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resetlocker:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10
}
;End of trackLocker()



untwirl()
{
tooltip, untwirl is starting now
dontrestart = 0

;the code below serves to save a lot of time in determining if a clip is selected or not.
prFocus("Effect Controls")
Send {tab}
if (A_CaretX = "")
{
	;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	;therefore, we will select the top clip at playhead using the code below:
	Send ^p ;"selection follows playhead,"
	sleep 10
	Send ^p
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint2
		}
	;otherwise,
	Return "reset"
}



restartPoint2:
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class13, ahk_class Premiere Pro ;This is the ClassNN of the effect controls panel. Use Window Spy to figure it out.
;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
; YY := Ycorner+99 ;ui 150%
; XX := Xcorner+19 ;ui 150%
YY := Ycorner+66 ;ui 100%
XX := Xcorner+13 ;ui 100%
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

; if (colorr = "0x353535") ;for 150% ui
if (colorr = "0x222222") ;for 100% ui
{
	tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
}
;else if (colorr = "0x757575") ;for 150% ui. again, this values could be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed. it also cannot be the same as a normal panel color (1d1d1d or 232323)
else if (colorr = "0x7A7A7A") ;for 100% ui
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	;untwirled = 1
	
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
	
}
else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{
	tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
		
	;resetFromAutoVFX()
	;play noise
	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint2 ;this is stupid but it works. Feel free to improve any of my code.
		}
	;otherwise,
	Return "reset"
	}
else
	{
	tooltip, %colorr% not expected
	;play noise
	
	Return "reset"
	;resetFromAutoVFX()
	}
} ;end of untwirl()






;how to use instantVFX: https://www.youtube.com/watch?v=Bi3zBqO74ms

;UPDATE:
;I overwrote the high DPI scaling behaviour of Premiere, by following THESE instructions: https://forums.adobe.com/message/10081059#10081059 , which changes the look of text and other elements of Premiere.
;Doing this totally BROKE the functionality of instantVFX() because now the pixel colors were different, and the images to be searched for would have had to have been updated.
;THEREFORE, I switched back to Premiere's built-in UI scaling, and will just have to wait for adobe to fix the issues that come with it.


instantVFX(foobar)
{
dontrestart = 0
restartPoint:
blockinput, sendandMouse
blockinput, MouseMove
blockinput, on

prFocus("effect controls")
sleep 10

MouseGetPos Xbeginlol, Ybeginlol
global Xbegin = Xbeginlol
global Ybegin = Ybeginlol

CoordMode, mouse, window
CoordMode, pixel, window

ImageSearch, cokdybyX, kdybyneY, 6, 136, 25, 1059, untwirled_2018.png
if(ErrorLevel = 2){
	MsgBox, Could not search
} else if(ErrorLevel = 1){
	Tooltip, Twirled
	ImageSearch, okdybyX, dybyneY, 4, 136, 35, 1070, twirled_2018.png
	if(ErrorLevel = 2){
		MsgBox, Could not search - 2nd search
	} else if(ErrorLevel = 1) {
		MsgBox, Found NOTHING - Restart
		if(dontrestart < 1){
			goto restartPoint
			dontrestart += 0.2
		}
	} else {
		MouseMove, %okdybyX%+3, %dybyneY%+2, 0
		MouseClick, L
	}
	if(dontrestart < 1){
		goto restartPoint
	}
} else {
	findVFX(foobar)
}

CoordMode, mouse
CoordMode, pixel

blockinput, off
blockinput, MouseMoveOff
}
Return ;from autoscaler part 1




findVFX(foobar) ; searches for text inside of the Motion effect. requires an actual image.
{
;tooltip, WTF
;msgbox, now we are in findVFX
sleep 5
MouseGetPos xPos, yPos
;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.

/*
if foobar = "scale"
	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\scale_D2017.png
else if foobar = "anchor_point"
	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
*/

;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2018.png

;something was wrong with using %A_WorkingDir% here. now fixed.

;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019.png
ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019_ui100.png
;within 0 shades of variation (this is much faster)
;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above.
;Again, your UI brightness might be different from mine! I now use the DEFAULT brightness.
; if ErrorLevel = 0
	; msgbox, error 0
if ErrorLevel = 1
	{
	;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
	msgbox, whwhwuhuat
	ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019_ui100.png
	}
if ErrorLevel = 2
	{
    msgbox,,, ERROR LEVEL 2`nCould not conduct the search,1
	resetFromAutoVFX()
	}
if ErrorLevel = 1
	{
	;msgbox, , , error level 1, .7
    msgbox,,, ERROR LEVEL 1`n%foobar% could not be found on the screeen,1
	resetFromAutoVFX()
	}
else
	{
	;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
	;msgbox, The %foobar% icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX, FoundY, 0
	;msgbox,,,moved to located text,1
	sleep 5
	findHotText(foobar)
	}
}


;2d8ceb
findHotText(foobar)
{
tooltip, ; removes any tooltips that might be in the way of the searcher.
; https://www.autohotkey.com/docs/commands/PixelSearch.htm
;CoordMode Pixel
MouseGetPos, xxx, yyy

;msgbox, foobar is %foobar%
if (foobar = "scale" ||  foobar = "anchor_point" || foobar = "rotation")
{
	;msgbox,,,scale or the other 3,1
	;PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x3398EE, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
	PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x2d8ceb, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
}
else if (foobar = "anchor_point_vertical")
{
	tooltip, looking for 0.00
	;msgbox,,, looking for 0.00,0.5
	;ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019.png ;because i never change the value of the anti-flicker filter, (0.00) and it is always the same distance from the actual hot text that i WANT, it is a reliable landmark. So this is a screenshot of THAT.
	ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_ui100.png ;for a user interface at 100%...
	;the *3 allows some minor variation in the searched image.
	if ErrorLevel = 1
		ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_2.png
}

; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anti-flicker-filter_000.png


if ErrorLevel
	{
    ;tooltip, blue not Found
	sleep 100
	resetFromAutoVFX()
	;return ;i am not sure if this is needed.
	}
else
	{
	tooltip, A color within 30 shades of variation was found at X%Px% Y%Py%
	;sleep 1000
    ;MsgBox, A color within 30 shades of variation was found at X%Px% Y%Py%.
	if (foobar <> "anchor_point_vertical")
	{
		
		MouseMove, Px+10, Py+5, 0 ;moves the cursor onto the scrubbable hot text
		;msgbox, anything but anchor point vertical
		;sleep 1000
	}
	else if (foobar = "anchor_point_vertical")
	{
		;msgbox,,,, about to move,0.5
		MouseMove, Px+80, Py-20, 0 ;relative to the unrelated 0.00 text (which I've never changed,) this moves the cursor onto the SECOND variable for the anchor point... the VERTICAL number, rather than horizontal.
		tooltip, where am I?
		;sleep 1000
	}
	Click down left
	
	GetKeyState, stateFirstCheck, %VFXkey%, P
		
	if stateFirstCheck = U
		{
			;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
			;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
			Click up left
			Sleep 10
			;I am removing the clode below, which acts to reset the whole thing. instead, now this allows me to type in my own custom value.
			
			; if (foobar = "scale")
			; {
				; Send, 100
				; sleep 50
				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
				; sleep 20
			; }
			; if (foobar = "rotation")
			; {
				; Send, 0
				; sleep 50
				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
				; sleep 20
			; }
			resetFromAutoVFX()
			;return
		}
	;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
	Loop
		{
		blockinput, off
		blockinput, MouseMoveOff
		;tooltip, %VFXkey% Instant %foobar% mod
		tooltip, ;removes any tooltips that might exist.
		sleep 15
		GetKeyState, state, %VFXkey%, P
		if state = U
			{
			Click up left
			;tooltip, "%VFXkey% is now physically UP so we are exiting now"
			sleep 15
			resetFromAutoVFX()
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

resetFromAutoVFX()
{
	;msgbox,,, is resetting working?,1
	global Xbegin
	global Ybegin
	MouseMove, Xbegin, Ybegin, 0
	;MouseMove, global Xbegin, global Ybegin, 0
	;MouseMove, Xbeginlol, Ybeginlol, 0
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}



;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;46664444444613
;end of scripts from INSTANT RESCALE BUTTON script


SendKey(theKEY, fun := "", sometext := ""){
tooltip,sendkey has recieved: `n%theKEY%`n%sometext%`n%fun%,,12
Sendinput {%theKEY%}
sleep 100
tooltip,,,12
}
;end of sendkey()


;;;;note to self: this highlights the find box of the bin it highlights, i have no idea why. must fix

;#IfWinNotActive ahk_class Premiere Pro
stopPlaying()
{
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	sendinput, {space}
;then it will ekip this next part and go to the end.
if !WinActive("ahk_exe Adobe Premiere Pro.exe")
{
;Below is some code to pause/play the timeline in Premiere, when the application is NOT the active window (on top.) This means that I can be reading through the script, WHILE the video is playing, and play/pause as needed without having to switch back to premeire every single time.
;Maybe this code really shoudl be in ALL PREMIERE FUNCTIONS.ahk.

;;macro key G3, when NOT in Premiere.
;play/pause premiere even when not in focus

;WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window

;Keyshower("[WC1] pause/play Premiere when not active",,1,-400)
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call("[WC1] pause/play Premiere when not active",,1,-400) 
}

;Trying to bring focus to the TIMELINE itself is really dangerous and unpredictable, since its Class# is always changing, based upon how many sequences, and other panels, that might be open.
ControlFocus, DroverLord - Window Class13,ahk_exe Adobe Premiere Pro.exe
; Window Class14 is the Program monitor, at least on my machine.
sleep 20
;ControlFocus, DroverLord - Window Class14,ahk_exe Adobe Premiere Pro.exe
;If we don't use ControlFocus first, ControlSend experiences bizzare and erratic behaviour, only able to work when the video is PLAYING, but not otherwise, but also SOMETIMES working perfectly, in unknown circumstances. Huge thanks to Frank Drebin for figuring this one out; it had been driving me absolutely mad. https://www.youtube.com/watch?v=sC2SeGCTX4U

;I tried windowclass3, (the effect controls) but that does not work, possibly due to stuff in the bins, which would play instead sometimes.

sleep 10
;ControlSend,DroverLord - Window Class3,^!+5,ahk_exe Adobe Premiere Pro.exe
;that is my shortcut for the Effect Controls.
sleep 10
;ControlSend,DroverLord - Window Class3,^!+3,ahk_exe Adobe Premiere Pro.exe

;that is my shortcut for the Timeline.
;this is to ensure that it doesn't start playing something in the source monitor, or a bin somewhere.

; ; ; sleep 10
; ; ; ControlSend,DroverLord - Window Class14,{ctrl up}{shift up}{space down},ahk_exe Adobe Premiere Pro.exe
; ; ; sleep 30
; ; ; ControlSend,DroverLord - Window Class14,{space up},ahk_exe Adobe Premiere Pro.exe

;now that we have a panel highlighted, we can send keystokes to premiere. But the panel itself is sometimes random. so it's best to use this to FORCE a specific panel that won't screw stuff up.


ControlSend,DroverLord - Window Class13, ^+!{F5},ahk_exe Adobe Premiere Pro.exe ;this shortcut will highlight the EFFECT CONTROLS, which will NOT also stop playback of the source monitor, if it is already playing.
sleep 40
;msgbox,,, srsly wtf,0.5
;msgbox,srsly wtf
ControlSend,DroverLord - Window Class13, ^+!{F5},ahk_exe Adobe Premiere Pro.exe
sleep 30


ControlSend,,{space}, ahk_exe Adobe Premiere Pro.exe
;;;use either the ABOVE line, or the line BELOW. Can't say right now which is better...
;ControlSend,DroverLord - Window Class1,{space},ahk_exe Adobe Premiere Pro.exe
;even though we are sending the "SPACE" to a windowclass that (often) doesn't exist, because we already highlighted the effect controls, the space will go to the effect controls panel. (it hasb't failed to do so yet, at least.)




;in case premiere was accidentally switched to, this will switch the user back to the original window.
if not WinActive(lolClass)
	WinActivate, %lolclass%
}

;end of Premiere play/pause when not in focus.
}



CoordGetControl(xCoord, yCoord, _hWin) ; _hWin should be the ID of the active window
{

	;this overly complicated funciton will get information about a window without having to move the cursor to those coordinates first. the AHK people really should have a command for this already....
	;Keep in mind, Premiere has LOTS of small windows within it. Open window Spy and move your cursor around Premiere, to see what i mean.

	;script originally from Coco
	; https://autohotkey.com/board/topic/84144-find-classnn-of-control-by-posxy-without-moving-mouse/
	
	
	CtrlArray := Object() 
	WinGet, ControlList, ControlList, ahk_id %_hWin%
	Loop, Parse, ControlList, `n
	{
		Control := A_LoopField
		ControlGetPos, left, top, right, bottom, %Control%, ahk_id %_hWin%
      right += left, bottom += top
		if (xCoord >= left && xCoord <= right && yCoord >= top && yCoord <= bottom)
			MatchList .= Control "|"
	}
	StringTrimRight, MatchList, MatchList, 1
	Loop, Parse, MatchList, |
	{
		ControlGetPos,,, w, h, %A_LoopField%, ahk_id %_hWin%
		Area := w * h
		CtrlArray[Area] := A_LoopField
	}
	for Area, Ctrl in CtrlArray
	{
		Control := Ctrl
		if A_Index = 1
			break
	}
	return w
}





easeInAndOut(){

;EASE IN AND EASE OUT
;This will click on the necessary menu items for you
;all you have to do is hover the cursor over a keyframe (or selected keyframes) in the Effect Controls panel, and hit the button.
tooltip, ease in and out
; blockinput, sendandMouse
blockinput, MouseMove
; blockinput, on
click right
send T
sleep 10
send E
send E
sleep 10
send {enter}
sleep 10
tooltip, 
; click right
click middle
sendinput {click right}
send T
sleep 10
send E
sleep 10
send {enter}
blockinput, off
blockinput, MouseMoveOff
;sleep 100
tooltip,

}

!+.::msgbox, A_workingDir should be %A_WorkingDir%



;;;;;;;;;;begin WINDOWS REPLATED SHIT;;;;;;;;;;;;;;;;;;;


; ;This ALSO WAS MOVED TO all windows functions
; ;function to start, then activate any given application
; openApp(theClass, theEXE, theTitle := ""){
; ;Keyshower(theEXE, "openApp") ;leads to a function that shows the keypresses onscreen
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(theEXE, "openApp") 
; }
; IfWinNotExist, %theClass%
	; Run, % theEXE
; if not WinActive(theClass)
	; {
	; WinActivate %theClass%
	; ;WinGetTitle, Title, A
	; WinRestore %theTitle%
	; }
; }








;moved to windows functions ahk
; runexplorer(foo){
; send {SC0E8} ;scan code of an unassigned key. ;;sending even a single keystroke from the secondary keyboard will prevents the taskbar icon from sometimes flashing pointlessly rather than opening.
; sleep 5
; Run, %foo%
; sleep 10
; Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;windows shortcut to resize name feild to fit.
; ;alt v o down enter will sort by date modified, but it is stupid...
; ;keyShower(foo, "runExplorer")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(foo, "runExplorer") 
	; }
; }
; ;; end of runexplorer()






; saveLocation2(){
; f_text = 0
; SetTitleMatchMode Slow
; WinGet, f_window_id, ID, A
; WinGetClass, f_class, ahk_id %f_window_id%
; ;;msgbox,,,%f_class%, 1
; if f_class in ExploreWClass,CabinetWClass ; if the window class is an Explorer window of either kind.
	; {
	; ; WinGetTitle, Title, ahk_class CabinetWClass
	; WinGetTitle, title, ahk_id %f_window_id% ;super lame way to do this, does not always work.
	; ;msgbox, address is `n%title%

	; FileDelete, C:\AHK\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	; FileAppend, %title% , C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; SavedExplorerAddress = %title%
	; msgbox, , , %title%`n`nwas saved as root, 1
	; }
; else
	; msgbox,,, this is not an explorer window you chump,1
; }
; ;for further reading:
; ;https://autohotkey.com/board/topic/60985-get-paths-of-selected-items-in-an-explorer-window/
; ;end of savelocation2()



; ;;;; SCRIPT TO ALWAYS OPEN THE MOST RECENTLY SAVED OR AUTOSAVED FILE OF A GIVEN FILETYPE, IN ANY GIVEN FOLDER (AND ALL SUBFOLDERS.);;;;
; ;;script partially obtained from https://autohotkey.com/board/topic/57475-open-most-recent-file-date-created-in-a-folder/
; openlatestfile(directory, filetype)
; {
; if directory = 1
	; {
	; FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; ;msgbox, current directory is`n%directory%
	; directory = %SavedExplorerAddress%
	; ;msgbox, new directory is`n%directory%
	; }
; ;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
; StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.

; ;Keyshower(directory,"openlatestfile")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(directory,"openlatestfile") 
; }

; ;I need some method of excluding ~$ files, since those clutter everything up (MS Word .docx ...)

; ;msgbox, directory is %directory%`n and filetype is %filetype%
; Loop, Files,%directory%\*%filetype%, FR
; {

; If (A_LoopFileTimeModified>Rec)
  ; {
  ; IfNotInString, A_LoopFileFullPath, ~$
	; FPath=%A_LoopFileFullPath%
  ; Rec=%A_LoopFileTimeModified%
  ; }
; }

; MsgBox 4,, Select YES to open the latest %filetype% at Fpath:`n`n%Fpath%
; IfMsgBox Yes
	; {
	; Run %Fpath%
	; }

; ; ; USING THE SCRIPT
; ; !n::
; ; examplePath = "Z:\Linus\6. Channel Super Fun\Flicking football"
; ; openlatestfile(examplePath, ".prproj") ;<--- notice how i INCLUDE the period in the parameters. IDK if it might be better to add the period later.
; ; return
; }
; ; end of openlatestfile()





; ;BEGIN savage-folder-navigation CODE!
; ;I got MOST of this code from https://autohotkey.com/docs/scripts/FavoriteFolders.htm
; ;and modified it to work with any given keypress, rather than middle mouse click as it had before.

; InstantExplorer(f_path,pleasePrepend := 0)
; {
; if pleasePrepend = 1
	; {
	; FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; ;msgbox, current f_path is %f_path%
	; f_path = %SavedExplorerAddress%\%f_path% ;no need to use . to concatenate
	; ;msgbox, new f_path is %f_path%
	; }
; ;for Keyshower, put code here to find the first / and remove the string before it. otherwise you can't see the final folder name
; ;Keyshower(f_path,"InstExplor")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(f_path,"InstExplor") 
; }
; f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable.
; ;msgbox, f_path is now finally %f_path%
; ;SoundBeep, 900, 400
; ; These first few variables are set here and used by f_OpenFavorite:
; WinGet, f_window_id, ID, A
; WinGetClass, f_class, ahk_id %f_window_id%
; if f_class in #32770,ExploreWClass,CabinetWClass  ; if the window class is a save/load dialog, or an Explorer window of either kind.
	; ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%

; /*
; if f_AlwaysShowMenu = n  ; The menu should be shown only selectively.
; {
	; if f_class in #32770,ExploreWClass,CabinetWClass  ; Dialog or Explorer.
	; {
		; if f_Edit1Pos =  ; The control doesn't exist, so don't display the menu
			; return
	; }
	; else if f_class <> ConsoleWindowClass
		; return ; Since it's some other window type, don't display menu.
; }
; ; Otherwise, the menu should be presented for this type of window:
; ;Menu, Favorites, show
; */

; ; msgbox, A_ThisMenuItemPos %A_ThisMenuItemPos%
; ; msgbox, A_ThisMenuItem %A_ThisMenuItem%
; ; msgbox, A_ThisMenu %A_ThisMenu%

; ;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; ; msgbox, f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; ; f_OpenFavorite:
; ;msgbox, BEFORE:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; ; Fetch the array element that corresponds to the selected menu item:
; ;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; if f_path =
	; return
; if f_class = #32770    ; It's a dialog.
; {
	; if f_Edit1Pos <>   ; And it has an Edit1 control.
	; {
		; ; IF window Title is NOT "export settings," with the exe "premiere pro.exe"
			; ;go to the end or do something else, since you are in Premiere's export media dialouge box... which has the same #23770 classNN for some reason...
		

		; ControlFocus, Edit1, ahk_id %f_window_id% ;this is really important.... it doesn't work if you don't do this...
		; tippy("DIALOUGE WITH EDIT1`n`nLE controlfocus of edit1 for f_window_id was just engaged.", 1000)
		; ; msgbox, is it in focus?
		; ; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
		; ; sleep 10
		; ; click
		; ; sleep 10
		; ; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
		; ;msgbox, edit1 has been clicked maybe
		
		; ; Activate the window so that if the user is middle-clicking
		; ; outside the dialog, subsequent clicks will also work:
		; WinActivate ahk_id %f_window_id%
		; ; Retrieve any filename that might already be in the field so
		; ; that it can be restored after the switch to the new folder:
		; ControlGetText, f_text, Edit1, ahk_id %f_window_id%
		; ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		; ControlSend, Edit1, {Enter}, ahk_id %f_window_id%
		; Sleep, 100  ; It needs extra time on some dialogs or in some cases.
		; ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
		; ;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
		; return
	; }
	; ; else fall through to the bottom of the subroutine to take standard action.
; }
; ;for some reason, the following code just doesn't work well at all.
; /*
; else if f_class in ExploreWClass,CabinetWClass  ; In Explorer, switch folders.
; {
	; tooltip, f_class is %f_class% and f_window_ID is %f_window_id%
	; if f_Edit1Pos <>   ; And it has an Edit1 control.
	; {
		; tippy("EXPLORER WITH EDIT1 only 2 lines of code here....", 1000)
		; ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		; msgbox, ControlSetText happened. `nf_class is %f_class% and f_window_ID is %f_window_id%`nAND f_Edit1Pos is %f_Edit1Pos%
		; ; Tekl reported the following: "If I want to change to Folder L:\folder
		; ; then the addressbar shows http://www.L:\folder.com. To solve this,
		; ; I added a {right} before {Enter}":
		; ControlSend, Edit1, {Right}{Enter}, ahk_id %f_window_id%
		; return
	; }
	; ; else fall through to the bottom of the subroutine to take standard action.
; }
; */

; else if f_class = ConsoleWindowClass ; In a console window, CD to that directory
; {
	; WinActivate, ahk_id %f_window_id% ; Because sometimes the mclick deactivates it.
	; SetKeyDelay, 0  ; This will be in effect only for the duration of this thread.
	; IfInString, f_path, :  ; It contains a drive letter
	; {
		; StringLeft, f_path_drive, f_path, 1
		; Send %f_path_drive%:{enter}
	; }
	; Send, cd %f_path%{Enter}
	; return
; }

; ; Since the above didn't return, one of the following is true:
; ; 1) It's an unsupported window type but f_AlwaysShowMenu is y (yes).
; ; 2) It's a supported type but it lacks an Edit1 control to facilitate the custom
; ;    action, so instead do the default action below.
; tippy("end was reached.",333)
; ;SoundBeep, 800, 300 ;this is nice but the whole damn script WAITS for the sound to finish before it continues...
; ; Run, Explorer %f_path%  ; Might work on more systems without double quotes.

; ;msgbox, f_path is %f_path%

; ; SplitPath, f_path, , OutDir, , ,
; ; var := InStr(FileExist(OutDir), "D")

; ; if (var = 0)
	; ; msgbox, directory does not exist
; ; else if var = 1
	; Run, %f_path%  ; I got rid of the "Explorer" part because it caused redundant windows to be opened, rather than just switching to the existing window
; ;else
; ;	msgbox,,,Directory does not exist,1
; }
; ;end of instantexplorer()

reverse(){
	Send ^{F10}
	Sleep 700
	Send {Tab 2}{Space}
	Sleep 10
	Send {Enter}
}

speed(spid){
	MouseClick, right
	Send {Up 16}{Enter}
	Send %spid%
	Send {Enter}
}

showAudioKeyframes(){
	prFocus("timeline")
	Send ^+!K
	MouseClick, middle
}

showVideoKeyframes(){
	prFocus("timeline")
	Send +!K
	MouseClick, middle
}
