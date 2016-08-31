#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;The ABOVE CODE ^^^ was automatically generated when I made a new .ahk document. I don't know how essential it is.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#SingleInstance force ;only one instance of this script may run at a time!
#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO!



; HELLO, poeple who want info about making a second keyboard! scroll down past all this crap until you get to "F24::"
; here's how the keyboard works with the F24 key: https://youtu.be/lIFE7h3m40U?t=16m9s
; so you also need LUAmacros as well, of course. (Let me know if you find something better!!)



;_______________________________________________________________________________________________________________________
;                                                                                                                       
; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm

;RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU
; KEYS					PREMIERE FUNCTIONS
;---------------------------------------------------------------------------------
; u  					select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
; backspace  			ripple delete --- but I don't use that in AutoHotKey because it's dangerous. This should be changed to something else; I use SHIFT C now.
; shift c				ripple delete --- very convenient for left handed use. Premiere's poor track targeting makes ripple delete less useful than it could be.
; ctrl alt shift d  	ripple delete --- I never type this in manually - long shortcuts like this are great for using AHK or a macro to press them.
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
; ctrl alt shift a 		audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; F2					gain
; F3					audio channels --- (but this might change in the future.)
; ctrl shift m			From source monitor, match frame. -- awkward to press by hand. This is done with a macro instead.
;                                                                                                                        
; Be aware that sometimes other programs like PUUSH can overlap with your customized shortcuts.
;_______________________________________________________________________________________________________________________


;;;;;;temporary tooltip maker;;;;;;
Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere%
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,
	;removes the tooltip
return
;;;;;;temporary tooltip maker;;;;;;



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

effectsPanelType(item)
{
Send ^+!7 ;set in premiere to "effects" panel
Send ^\ ;set in premiere to "select find box."
sleep 20
Send +{backspace} ;shift backspace deletes any text that may be present.
Sleep, 10
Send %item%
;now this next part re-selects the field in case you want to type anything different
sleep 5
send {tab}
sleep 5
send +{tab}
}
/*
effectsPanelType_OLD_SCRIPT(item) ;This script is now obsolete!
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
*/
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




;;;;;;;;;;FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!;;;;;;;;;;;;
;Probably my most used, and most useful AHK function! There is no good reason why Premiere doesn't have this functionality.
;keep in mind, I use 150% UI scaling, so your pixel distances for functions like mousemove() WILL be different!
;to use this script yourself, carefully go through  testing the script and changing the values, ensuring that the script works, one line at a time
preset(item)
{
BlockInput, SendAndMouse
BlockInput, On

; the block of code below  moves the cursor to the effects panel FIND BOX, deletes what's in it, and inserts the given text.
SetKeyDelay, 0
MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%
ControlGetPos, X, Y, Width, Height, Edit1, ahk_class Premiere Pro ;highlights Premier's effects panel SEARCH BAR specifically. (info gotten from window spy.) For you, it may have a different name.
MouseMove, X+Width+10, Y+Height/2, 0
sleep 5
MouseClick, left, , , 1 ;------------------------clicks on X
MouseMove, X-25, Y+10, 0
sleep 5
MouseClick, left, , , 1
sleep 5
Send %item%
; The above block of code CAN NOT be replaced with effectsPanelType(item) because it moves the cursor into position, in preparation for the upcoming code, which still requires use of the cursor.

sleep 30
MouseMove, 52, 65, 0, R ;-----------------------moves cursor down and directly onto the effect's icon
MouseGetPos, iconX, iconY
ControlGetPos, , , www, hhh, DroverLord - Window Class14, ahk_class Premiere Pro ; --- important -- this must match the EFFECTS panel window class.
MouseMove, www/4, hhh/2, 0, R ;-----------------clicks in about the CENTER of the Effects panel. This clears the displayed presets from any duplication errors. quite important.
;msgbox, test
MouseClick, left, , , 1
sleep 10
MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the effect's icon

sleep 35
MouseClickDrag, Left, , , %xpos%, %ypos%, 0 ;---drags this effect to the cursor's pervious coordinates, which should be above a clip.
sleep 10
;Send ^+!0 ;-------------------------------------returns focus to the timeline. doesn't work for multiple timelines :(
MouseClick, left, , , 1 ;------------------------returns focus to the timeline. Can be annoying if it selects something...
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work!! Cool.
}

;That's the end of the function. Now we make shortcuts to CALL that function, each with a different parameter!

;All of these refer to presets I have already created and named in Premiere
;note that using ALT for these is kind of stupid... they can interfere with menus.
;ALT C, for example, will always open Premiere's CLIP menu. So I can't use that anywhere.


^!+f::effectsPanelType("") ;set to macro key G1 on my logitech G15 keyboard. ;This just CLEARS the effects panel search bar s o that you can type something in.
^!w::preset("Warp Stabilizer Preset") ;macro key G2. I wish it would also press "analyse..."
^!+p::effectsPanelType("presets") ;set to macro key G3. ;Types in "presets," which reveals your own entire list of presets.

^h::preset("Lumetri Color BLANK") ;macro key G4. This is a completely BLANK lumetri preset, untwirled and ready for me to change specific values.
^g::preset("Lumetri shadows up") ;macro key G5. This preset increases brightness, contrast, and saturation slightly, and adds a slight vingette. I use this often
^b::preset("Lumetri BRIGHT") ;macro key G6. This lumetri preset adds a LOT of brightness, and saturation to balance. I use it for very dark shots.

#!l::audioMonoMaker(0) ;macro key G7
!l::preset("2.4 limiter") ;macro key G8. A compressor and limiter for the audio, to keep it from clipping at 0dB.
;Macro key G9 is set completely in the keyboard's software. It is simply: {F2}{7}{enter}, which increases the gain of any selected clips by 7dB.

#!r::audioMonoMaker(1) ; macro key G10. 
;Macro key G11 is set completely in the keyboard's software. It is simply: {CTRL}{SHIFT}{m}, which is "From source monitor, match frame"
!]::preset("DeHummer Preset") ;macro key G12. This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

/*
See "Windows Mod - various functions.ahk" for a much more complete explanation of the following macro key assignments
G13: left click ~or~ CTRL SHIFT TAB (just experimenting...)
G14: Activate Notepad++
G15: Activae Word
G16: Activate Firefox, then CTRL TAB on subsequent key presses.
G17: Activate Explorer, then browse through the windows on subsequent key presses
G18: Activate Premiere
*/


;;---I have assigned all of the above keystroke combinations to my MACRO KEYS on my logitech keyboard, so it's really just ONE KEYSTROKE to apply them!


;F1 -> [select clip at playhead] and then [ripple delete] . Note the keyboard shortcuts I have assigned in Premiere, above.
;ripple delete clip (or blank) at playhead - requires target tracking to be ON!!
;Note also that this always selects ALL TARGETED TRACKS, so I usually just use it for cutting single-track A-roll.
;It is possible to have it select ONLY the top layer by toggling on and off "selection follows playhead."
F1::Send u^+!d

; control shift r = reverse selected clip
^+r::
Send ^r{tab}{tab}{space}{enter}
return

;This disables a menu accelerator in premiere, ignoring the pressing of ALT along with SPACE. Otherwise it will open a dumb menu on the top bar, which I never use.
!space::
Send {space}
Return





sendKeystrokes(bar)
{
	tooltip, sendkeystrokes %bar%
	Send %bar%
}


;you can select something inside of premiere (like a group of clips, or a transition) and then, with this code, you can COPY it and SAVE that clipboard state. I use this in conjunction with my secondary keyboard.
;You need to have insideclipboard.exe installed, and all the file paths properly comfigured.
;Keep in mind that you must RESTART your computer before the clipboard states become usable. IDK why.
saveClipboard(int) {
	sleep 10
	;ClipWait, 0.25 ; this line might not be needed.
	Send ^c
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 16
}

;This is the real magic. With this script, you can PASTE those previously saved clipboard states, at any time.
recallClipboard(int) {
	WinActivate, Adobe Premiere Pro
	tooltip, now loading random text into the clipboard. 
	
	loadFromFile("clipTEXT.clp") ;to create this file, just highlight some plain text, copy it, and use insideclipboard.exe to save it as clipTEXT.clp. The clipboard MUST have some text inside; it CANNOT be completely empty. This has the effect of DELETING all the aspects of the clipboard, EXCEPT for text.
	sleep 15
	loadFromFile("clipTEXT.clp") ;The clipboard must be loaded twice, or it won't work about 70% of the time! I don't know why...
	sleep 15
	;Autohotkey can now delete that string of text, so that no text is accidentlaly pasted into premiere. It doesn't seem to be able to delete EVERYTHING, so the above code is definitely necessary!
	clipboard = 
	;The clipboard is now completely empty.
	sleep 10
	
	;tooltip, now pasting NOTHING into premiere.
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down} ;this is a MUCH more robust way of using the keyboard shortcuts to PASTE, rather than just using "Send ^v"
	sleep 20
	ClipWait, 0.25 ;this may be more time than is necessary. (Though I think it will advance quicker than this if it is able to.)
	SendInput, {v Up}{Ctrl Up}
	sleep 20
	;Send ^v wait, was I supposed to "paste" twice as well? Need to do testing...
	;It is necessary to PASTE this COMPLETELY BLANK clipboard into premiere, or Premiere won't "know" that the clipboard has been completely emptied.
	;If you don't do this, Premiere will just use whatever thing you had previously copied inside of Premiere.
	sleep 30
	;tooltip, "clip" . %int% . ".clp" ;this code doesn't work

	loadFromFile("clip" . int . ".clp") ;now we are loading the previously saved clipboard file!
	sleep 15
	loadFromFile("clip" . int . ".clp") ;This must be done twice, or it doesn't work! I don't know why!! :D
	sleep 15
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	sleep 50
	ClipWait, 0.25
	SendInput, {v Up}{Ctrl Up}
	sleep 10
	tooltip,
	
}


saveToFile(name) {
	;code below does not use any fancy variables. It's a bare string. Unfortunately, I can't find a way to make it work better...
	;change this path ----|                  and this one --------|    to your own folder locations.
	;    	              |										  |
	;                     v									  	  v
	RunWait, %comspec% /c C:\InsideClipboard.exe /saveclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	
	
	;just saving the below lines of code, which didn't work because %pathh% nor %Exec% variables could not be defined properly. Or something... IDK....
	;RunWait, %comspec% /c %Exec% /saveclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	;RunWait, %comspec% /c %Exec% /saveclp %name%, %pathh%
	
}

loadFromFile(name) {
	; You'll need to change these paths too!
	RunWait, %comspec% /c C:\InsideClipboard.exe /loadclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
}




;----------------------------------------------------





F24::

FileRead, key, C:\Users\TaranVanHemert\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt
 
tippy(key) ;this makes a temporary tooltip that reveals the key that was pressed.
 
presetActions := Object()
sendKeystrokesActions := Object()
recallClipboardActions := Object()
currentSection := ""

 
;This loop will read all the key value pairs (e.g. keybinds).
Loop, read, C:\Users\TaranVanHemert\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keyActions.txt
{
    if (A_LoopReadLine == "preset") or (A_LoopReadLine == "sendKeystrokes") or (A_LoopReadLine == "recallClipboard")
    {
        currentSection := A_LoopReadLine
        continue
    }
    else if (A_LoopReadLine == "")
        continue
   
    if (currentSection == "preset")
    {
        action := StrSplit(A_LoopReadLine, ":")
        presetActions[action[1]] := action[2]
    }
    else if (currentSection == "sendKeystrokes")
    {
        action := StrSplit(A_LoopReadLine, ":")
        sendKeystrokesActions[action[1]] := action[2]
    }
    else if (currentSection == "recallClipboard")
    {
        action := StrSplit(A_LoopReadLine, ":")
        recallClipboardActions[action[1]] := action[2]
    }
}
 
if presetActions[key] != ""
{
    ; Keybind for preset exists
    preset(presetActions[key])
}
else if sendKeystrokesActions[key] != ""
{
    ; Keybind for sendKeystrokes exists
    sendKeystrokes(sendKeystrokesActions[key])
}
else if recallClipboardActions[key] != ""
{
    ; Keybind for recallClipboard exists
    recallClipboard(recallClipboardActions[key])
}
else
    tooltip, Keybind not found! :(
Return ;from F24
 
 
 /*  FYI:  Keyactions.txt is filled with text exactly like this:
preset
o:flip horizontal
p:flip vertical
i:multiply

leftbracket:pop in motion
rightbracket:pop out motion

sendKeystrokes
r:^!+{F1}
f:^!+{F2}

;these refer to the audio leftener and audio rightener.
minus:#!l
equals:#!r
;this is mapped to "remove effects" in premiere.
enter:^!e
;These literally just pass through the exact same keystroke.
num0:{Numpad0}
num1:{Numpad1}
 */
 
 
 
 
 
 
 
 

#IfWinNotActive ahk_exe Adobe Premiere Pro.exe ; this is so that you can use the additional copy/paste features OUTSIDE of premiere also.
; I HAVE NOT VERIFIED THAT THIS WORKS....! I THINK THIS IS A BAD IDEA ACTUALLY! AAAAGHHHGHGH
F24::
FileRead, key, C:\Users\TaranVanHemert\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt
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

;audioMonoMaker() will open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source.
audioMonoMaker(track)
{
BlockInput, SendAndMouse ;prevent mouse from moving
BlockInput, On
BlockInput, MouseMove
global tToggle = 1
;msgbox, track is %track%
if (track = 1)
{
	;msgbox, this is the RIGHT audio track
	addPixels = 36
}
else if (track = 0)
{
	addPixels = 0
	;msgbox, this is for the LEFT audio track
}
Send ^!+a ;control alt shift a --- ; audio channels shortcut, asigned in premiere - dont use this key combo anywhere else
sleep 550
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
MouseGetPos, xPosAudio, yPosAudio

; MouseMove, 2197, 1503, 0 ;moved the mouse onto the expected location of the "okay" box, which has a distinct blue color, which will let us know the box has appeared.
; I am still working to improve this script. It is disabled for now.
; waiting = 0
; loop
	; {
	; waiting = waiting + 1
	; sleep 50
	; tooltip, waiting
	; msgbox, waiting
	; if (waiting > 50)
		; {
		; msgbox, break
		; goto, ending
		
		; }
	; if (PixelGetColor, 2197,1503 = "0x134762")
		; {
			; break
		; }
	; }

MouseMove, 1795 + addPixels, 880, 0
sleep 50
MouseGetPos, Xkolor, Ykolor
sleep 50
PixelGetColor, kolor, %Xkolor%, %Ykolor%
; 080808 = color when cursor is over the box
; 1F1F1F = color when cursor NOT over the box
; DDDDDD = color when there is a checkmark already in the box
; note that these colors will be different depending on your UI brightness set in premiere.
;msgbox, kolor = %kolor%
If (kolor = "0x080808") ;"kolor" is the variable name rather than "color" because "color" might be already used for something else in AHK.
{
	click left
}
else if (kolor = "0xDDDDDD")
{
	; Do nothing. There was a checkmark in this box already.
}
sleep 5
MouseMove, 1795 + addPixels, 917, 0
sleep 30
MouseGetPos, Xkolor2, Ykolor2
sleep 10
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 30
;msgbox, k2 = %k2%
If (k2 = "0x080808")
{
	click left
}
else if (k2 = "0xDDDDDD")
{
	; Do nothing. There was a checkmark in this box already
}
;msgbox, k2 color was %k2%
sleep 5
Send {enter}
ending:
MouseMove, xPosAudio, yPosAudio, 0
BlockInput, off
BlockInput, MouseMoveOff ;return mouse control to the user.
} ; monomaker




;JUNKED CODE BEOW -- was trying to make an array or something in AHK...
; Array := object()
; object := {o:flip vertical, p:flip horizontal, i:multiply}
; F23:: ;this code DOES NOT WORK...?
; FileRead, keypressed, C:\Users\TaranVanHemert\Documents\keypressed.txt
; tippy(keypressed) ;this makes a temporary tooltip
; keyActions := { "o" : preset("flip horizontal"), "p" : preset("flip vertical"), "i" : "multiply" } 
; keyActions[keypressed]
; value := keyActions[keypressed]
; msgbox, the value is %value% 
; Return
