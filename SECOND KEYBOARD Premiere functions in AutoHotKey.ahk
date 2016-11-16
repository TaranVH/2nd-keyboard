#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;The ABOVE CODE ^^^ was automatically generated when I made a new .ahk document. I don't know how essential it is.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#SingleInstance force ;only one instance of this script may run at a time!

/*
##########################################################################################################
Lots of explanatory videos about how to use this and other AHK scripts can be found on my youtube channel!
                           https://www.youtube.com/user/TaranVH/videos                                    
##########################################################################################################


Scroll down to the line that contains:
2ND KEYBOARD IF USING INTERCEPTOR
if you are interested in using interceptor for your 2nd keyboard.
[video explanation to come.]


Scroll down to the line that contains:
2ND KEYBOARD USING LUAMACROS... NOW OBSOLETE!
if you are interested in using luamacros for your 2nd keyboard.
(It's not as good as interceptor, but I am keeping that code in because I talk about it in this LTT video!)
https://www.youtube.com/watch?v=Arn8ExQ2Gjg
(Note that it uses F23 now, instead of F24.)



*/

savedpreset1 = 100scale
savedpreset2 = 2.4 limiter



applicationname=SecondKeyboardd
statusy = 1850
; statusy = 1700
statusx = 30
statusheight = 80
statusheight2 = 110
statuswidth=500
statuswidth2=700
font=Arial


;++++++++++++++++++++++++++++++++++++++++++++++
; GUI FOR KEYBOARD 1 COMMANDS
Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
Gui,Color,222222
Gui,Font,C00FFFF S27 W200 Q5, Arial
Gui,Add,Text,Vtextt,KEY GOES HERE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWW WWWWWWWWWWW
Gui,Font,c44FF55 S20 W990 norm, Arial
Gui,Add,Text,Vnamee,THE TYPE OF FUNCTIONand the SELECTION WWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWW WWWWWWWWWWW
Gui,Font,cEE6622 S20 W300 norm, Arial
Gui,Add,Text,Vkeyb,1st KEYBOARD IT BE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWWW WWWWWWWWWW

Winset, ExStyle, +0x20, %applicationname%
Gui +E0x20 +LastFound +ToolWindow +disabled

Gui,Show,X%statusx% Y%statusy% W%statuswidth% H%statusheight% noactivate ,%applicationname%

GuiControl,,textt, testing visualizer

;WinSet, Transparent, N ; SecondKeyboardd
WinSet, Transparent, 255
WinSet, ExStyle, +0x00000020, ahk_id %hwnd%
WinSet, TransColor, 111111


;+++++++++++++++++++++++++++++++++++++++++++++++
; GUI FOR KEYBOARD 2 COMMANDS
Gui KB2: New
Gui KB2: +Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui KB2: Margin,0,0
Gui KB2: Color,000000
Gui KB2: Font,CFF0000 S15 W500 Q5, Franklin Gothic
Gui KB2: Add,Text,Vline1,gui 2 is HEEEERRRREEE WWWWWWWWWWWWWWWWWWWWWWW WWWWWW WWWW
Gui KB2: Font,CFFFF00 S20 W200 Q5, Arial
Gui KB2: Add,Text,Vline2,gui 2 line twwwwoooooo WWWWWWWWWWWWWW WWWWWWW WWWWWWWWWWW
Gui KB2: Font,CFF00FF S20 W200 Q5, Arial
Gui KB2: Add,Text,Vline3,gui 2 line 33333333333333333333 - WWWWWWWWW WWWWW WWWWWWW

Gui KB2: Show,X%statusx% Y%statusy% W%statuswidth2% H%statusheight2% noactivate ,%applicationname%

GuiControl,,line1, 2ND KEYBOARD
GuiControl,,line2, line 2 on gui 2
GuiControl,,line3, line 3 on gui 2


SetTimer,revealtimer,-2500
SetTimer,revealtimer2,-2500





#ifwinactive
Keyshower(yeah, functionused := "", alwaysshow := 0) ;very badass function that shows key presses and associated commands, both from the primary and secondary keyboards (keyboard 2 must be configured using intercept.exe!)
{
;msgbox, keyshower
;the "NA" is extremely important to allow this window to be VISIBLE but not interfere with anything.
;msgbox, %A_priorhotkey% %A_thishotkey%


if (A_priorhotkey = "F24" || A_priorhotkey = "~numpadleft" || A_priorhotkey = "~numpadright") ;please pretend that numpad left and right are not here....
	{
	;this was sent from the 2nd keyboard, using interceptor. Interceptor presses F24, then the key, then releases the key, then releases F24. Very simple, but very effective.
	Gui, kb2: show, NA 
	Gui, hide

	GuiControl kb2:,line1, %A_space%FROM 2ND KEYBOARD
	GuiControl kb2:,line2, %A_space%%A_thishotkey%
	GuiControl kb2:,line3, %A_space%%functionused%(`"%yeah%`")
	SetTimer,revealtimer2,-2000
	;msgbox, , , testing now, 1
	}
else if (A_priorhotkey = "F22")
	{
		;this space reserved for keyboard 3! ... and so on.
		;(F23 was used for the 2nd keyboard using luamacros. I am keeping it for compatibility reasons.)
	}
else if (alwaysshow = 1)
	{
	
	;This space can be used for any keys that the normal visualizer does not notice. please ignore for now...
	Gui, show, NA 
	Gui, kb2: hide
	StringReplace, fixedHotkey, A_thishotkey, ^, ctrl%A_space%, All
	StringReplace, fixedHotkey, fixedHotkey, +, shift%A_space%, All
	StringReplace, fixedHotkey, fixedHotkey, !, alt%A_space%, All
	GuiControl,,textt, %A_space%%fixedHotkey% ;%A_priorhotkey%
	GuiControl,,namee, %functionused%(`"%yeah%`")
	GuiControl,,keyb, 
	SetTimer,revealtimer,-2000
	
	}
else
	{
	;there is no "modifier" key or anything else associated. Therefore, this was a single keypress sent from the primary keyboard.
	;do nothing. This visualization is taken care of by keystroke viz.ahk
	}

}



revealkey(selectionn, keyy, functionn) ;this funciton is now obsolete...
{
;now
;msgbox, revealkey %keyy% %selectionn%
Gui,Show, 
GuiControl,,textt, %keyy%
GuiControl,,namee, %functionn%  (%selectionn%)
GuiControl,,keyb, second keyboard
SetTimer,revealtimer,-1500
}


revealtimer:
Gui, hide
return

revealtimer2:
Gui, kb2: hide
Return


;++++++++++++++++++++++++GUI stuff end.+++++++++++++++++++++++++++++


;SC04C::shift ;<- very experimental code. This is the scancode for numpad5. Necessary if you want to convert it to a modifier key....


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
;;;;;;/temporary tooltip maker;;;;;;



;function to start, then activate any given application
openApp(theClass, theEXE, theTitle := ""){
Keyshower(theEXE, "openApp") ;leads to a function that shows the keypresses onscreen
IfWinNotExist, %theClass%
	Run, % theEXE
if not WinActive(theClass)
	{
	WinActivate %theClass%
	;WinGetTitle, Title, A
	WinRestore %theTitle%
	}
}



#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! (until canceled with a lone "#IfWinActive")



; HELLO, poeple who want info about making a second keyboard! scroll down past all this crap until you get to "F24::"
; here's Tom's video about how the keyboard works with the F24 key and luaMacros: https://youtu.be/lIFE7h3m40U?t=16m9s
; (though I now use 'F23' instead. The principle is the same.)
; so you also need LUAmacros as well, of course.
; However, interecept.exe is even better! I'll make a video about this, soon.



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
; ctrl alt shift 7		effects --- (NOT the Effect Controls panel) --- Note that this is SHIFT 7 by default, which is dumb because that's a "&"
; ctrl alt shift 4		program monitor
; ctrl alt shift a 		audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; F2					gain
; F3					audio channels --- (but this might change in the future.)
; ctrl shift m			From source monitor, match frame. -- awkward to press by hand. This is done with a macro instead.
; ctrl \				select find box --- This is such a useful function when you pair it the the effects panel!!
; ctrl alt F			select find box 
;                                                                                                                        
; Be aware that sometimes other programs like PUUSH can overlap with your customized shortcuts.                          
;_______________________________________________________________________________________________________________________



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

effectsPanelType(item)
{
Keyshower(item,"effectsPanelType")
Send ^+!7 ;set in premiere to "effects" panel
Send ^\ ;set in premiere to "select find box"
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
;to use this script yourself, carefully go through  testing the script and changing the values, ensuring that the script works, one line at a time. use message boxes to check on variables and see where the cursor is. remove those message boxes later when you have it all working!
#IfWinActive ahk_exe Adobe Premiere Pro.exe
preset(item)
{

Keyshower(item,"preset")


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

^!g::preset("Lumetri Color BLANK") ;macro key G4. This is a completely BLANK lumetri preset, untwirled and ready for me to change specific values.
^!h::preset("Lumetri shadows up") ;macro key G5. This preset increases brightness, contrast, and saturation slightly, and adds a slight vingette. I use this often
^!j::preset("Lumetri BRIGHT") ;macro key G6. This lumetri preset adds a LOT of brightness, and saturation to balance. I use it for very dark shots.

#!l::audioMonoMaker("left") ;macro key G7. Using the WIn key is prooobably a terrible idea; I do not reccomend it...... :(
!l::preset("2.4 limiter") ;macro key G8. A compressor and limiter for the audio, to keep it from clipping at 0dB.
;Macro key G9 is set completely in the keyboard's software. It is simply: {F2}{7}{enter}, which increases the gain of any selected clips by 7dB.

#!k::audioMonoMaker("right") ; macro key G10. ; I had this set to win alt R, but now that interferes with Windows Game Bar, which I couldn't disable even by changing registry files...
;Macro key G11 is set completely in the keyboard's software. It is simply: {CTRL}{SHIFT}{m}, which is "From source monitor, match frame"
!]::preset("DeHummer Preset") ;macro key G12. This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

;IMPORTANT NOTE:
;for all of the above shortcuts, and many others, I have mapped them in premiere, in the new visual keyboard shortcuts mapper, to various
;commands from the CAPTURE PANEL. This is becasue I needed to be able to visualize which keystrokes were being used by AHK and other programs
;OUTSIDE of premiere, and premiere provides no way of doing this. It's a feature I should ask for...

;I NEVER USE the capture panel.


/*
See "Windows Mod - various functions.ahk" for a much more complete explanation of the following macro key assignments
G13: CTRL SHIFT TAB
G14: Activate Notepad++
G15: Activae Word
G16: Activate Firefox, then CTRL TAB on subsequent key presses.
G17: Activate Explorer, then browse through the windows on subsequent key presses
G18: Activate Premiere
*/

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


+F18::
sendinput, ^a
sleep 20
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
;msgbox, text in clipboard = %clipboard%
savedpreset1 = %clipboard%
return

+F17::
sendinput, ^a
sleep 20
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
;msgbox, text in clipboard = %clipboard%
savedpreset2 = %clipboard%
return

F17::
preset(savedpreset2)
;msgbox, savedpreset2 %savedpreset2%

;msgbox, %savedpreset2%
return

F18::preset(savedpreset1)
;;;;;;;;;;;;;;;END OF FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;more premiere mods / macros.;;;;;;;;

;F1 -> [select clip at playhead] and then [ripple delete] . Note the keyboard shortcuts I have assigned in Premiere, above.
;ripple delete clip (or blank) at playhead - requires target tracking to be ON!!
;Note also that this always selects ALL TARGETED TRACKS, so I usually just use it for cutting single-track A-roll.
;It is possible to have it select ONLY the top layer by toggling on and off "selection follows playhead."
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~F1::Send u^+!d
;#if

; control shift r = reverse selected clip
~^+r::
Send ^r{tab}{tab}{space}{enter}
return

;This disables a menu accelerator in premiere, ignoring the pressing of ALT along with SPACE. Otherwise it will open a dumb menu on the top bar, which I never use.
; !space::
; Send {space}
; Return

;Just kidding, I want to use alt space to rewind and then play. Premiere's version of this SUCKS because it brings you back to where you started
; the ~ is only there so that the keystroke visualizer can see this keypress. Otherwise, it should not be used.
~!space::
Send s ;"stop" command (From JKL remapped to ASD.)
Send +{left}
sleep 10
Send d ;"shuttle right" command.
return


~sc11C::
~numpadEnter::
;this is the scancode for the numpad enter key.
;keystroke viz.ahk does not properly notice this key (always combining it the regular Enter) so I am making a visualizer for it here.
Keyshower("program monitor zoom to fit - taran mod",,1)

return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
sendKeystrokes(bar) ;this is super stupid and i want to get rid of it but i can't. it's launched from LUA 2nd keyboard...
{
	tooltip, sendkeystrokes %bar%
	Send %bar%
}



SFXActions(leSound)
{
keyShower(leSound, "insertSFX")
CoordMode, mouse, Screen
CoordMode, pixel, Screen
BlockInput, On
SetKeyDelay, 0 ;for instant writing of text
MouseGetPos, xpos, ypos
send ^+x ;shortcut in premiere for "remove in/out points.
sleep 10
send ^+{F1}
sleep 10
; Send ^!+` ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?
send ^{F11} ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
sleep 10
;msgbox how about naow?
Send ^\ ;premiere shortcut to "select find box"
; sleep 200
; Send +{delete}
; sleep 600
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
send ^+{F1}
;send {F18} ;shortcut in premiere for "source assignment preset 1" which highlights A3 and V4. CTRL SHIFT F1 is also used. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
sleep 400 ;we are waiting for the search to complete....

;PixelGetColor, zecolor, -6000, 200, alt slow rgb ; this does not work - either it gets FFFFFF or 000000. multiple monitors screw up this function...??
;msgbox, %zecolor% 

;Send {enter} ;this SOMETIMES highlights the object in the bin but USUALLY does not??

;ControlClick, x-6000 y200
;ControlClick, x-6000 y200, , , left, 1, NA Pos ; , ExcludeTitle, ExcludeText]
;; Controlclick does NOT work. Looks like the cursor itself MUST be moved into the position.
;Click -6000, 200 ;without moving the cursor, this clicks on the top leftmost object in the top leftmost bin on my 3rd monitor --- the bin that is highlighted by pressing ctrl F11.
; CoordMode, mouse, window
; Click 170, 224 

MouseMove, -6000, 200, 0
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
tooltip, CLICK!!!
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.

sleep 20
tooltip, so did that work?

; ; Send {tab} ; tabs down, in order to select the sound effect. If there is a folder, it gets in the way....
; ; sleep 100
; ; Send {esc} ;deselects the naming field but keeps the thumbnail selected, albeit weirdly
; ; sleep 200
; ; Send ^+y ; opens in source monitor
; ; sleep 200
; ; ;Send ^+!. ;Premiere's shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.

;send ^!+4 ;select program monitor
sleep 10
;send ^!+0 ;select timeline
sleep 10
send ^+F1 ;my shortcut for "assign source assignment preset 1" in Premiere. The preset has V4 and A3 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
sleep 50
Send ^/ ;Premiere's shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
sleep 30
send ^!+0 ;this is set in premiere to highlight/switch to the timeline. important so that you aren't still stuck in the bin. If this is used more than once, it will unfortunately cycle thorugh all available sequences...
tooltip,
BlockInput, off
BlockInput, MouseMoveOff
}



;you can select something inside of premiere (like a group of clips, or a transition) and then, with this code, you can COPY it and SAVE that clipboard state. I use this in conjunction with my secondary keyboard.
;You need to have insideclipboard.exe installed, and all the file paths properly comfigured.
;Keep in mind that you must RESTART your computer before the clipboard states become usable. IDK why.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
saveClipboard(int) {
	StringReplace, int, int, +, , All ;replace + with nothing. This is just in case A_thishotkey contains + if shift was used!
	StringReplace, int, int, !, , All ;replace ! with nothing. This is just in case A_thishotkey contains ! if alt was used!
	StringReplace, int, int, ^, , All ;replace ^ with nothing. This is just in case A_thishotkey contains ^ if ctrl was used!
	msgbox, , , saving as %int%, 0.6
	tooltip, saving as %int%
	sleep 10
	;ClipWait, 0.25 ; this line might not be needed.
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
	sleep 20
	SendInput, {c up}{Ctrl up}
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 16
	tooltip,
}

;This is the real magic. With this script, you can PASTE those previously saved clipboard states, at any time.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
recallClipboard(int) {
	keyShower(int, "recallClipboard")
	WinActivate, Adobe Premiere Pro
	tooltip, "now loading random text into the clipboard."
	
	loadFromFile("clipTEXT.clp") ;to create this file, just highlight some plain text, copy it, and use insideclipboard.exe to save it as clipTEXT.clp. The clipboard MUST have some text inside; it CANNOT be completely empty. This has the effect of DELETING all the aspects of the clipboard, EXCEPT for text.
	sleep 15
	loadFromFile("clipTEXT.clp") ;The clipboard must be loaded twice, or it won't work about 70% of the time! I don't know why...
	sleep 15
	;Autohotkey can now delete that string of text, so that no text is accidentlaly pasted into premiere. It doesn't seem to be able to delete EVERYTHING, so the above code is definitely necessary!
	clipboard = 
	;The clipboard is now completely empty.
	sleep 10
	
	; send ^{F9} ;toggle video tracks (hopefully off)
	; send ^{F9} ;toggle video tracks (hopefully off)
	; send ^+{F9} ;toggle audio tracks (hopefully off)

	
	tooltip, now pasting NOTHING into premiere....
	WinActivate, Adobe Premiere Pro ;extremely important
	SendInput, {Shift Down}{Shift Up}
	sleep 10
	SendInput, {Ctrl Down}{v Down} ;this is a MUCH more robust way of using the keyboard shortcuts to PASTE, rather than just using "Send ^v"
	ClipWait, 0.25 ;this may be more time than is necessary. (Though I think it will advance quicker than this if it is able to.)
	SendInput, {v Up}{Ctrl Up}
	sleep 20
	
	; send ^{F8} ;enable track 8 video
	; send ^+{F8} ;enable track 8 audio
	
	
	;It is necessary to PASTE this COMPLETELY BLANK clipboard into premiere, or Premiere won't "know" that the clipboard has been completely emptied.
	;If you don't do this, Premiere will just use whatever thing you had previously copied inside of Premiere.
	clipboard = 
	sleep 30
	;tooltip, "clip" . %int% . ".clp" ;this code doesn't work
	tooltip, now preparing to paste %int%
	;msgbox, %int%
	loadFromFile("clip" . int . ".clp") ;now we are loading the previously saved clipboard file!
	sleep 15
	loadFromFile("clip" . int . ".clp") ;This must be done twice, or it doesn't work! I don't know why!! :D
	sleep 15
	WinActivate, Adobe Premiere Pro ;this is extremely important.... otherwise, it will try to paste into the command prompt or something. You must ensure the correct program is pasted into.
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	ClipWait, 0.50
	SendInput, {v Up}{Ctrl Up}
	sleep 10
	; send ^{F9} ;toggle video tracks (hopefully off)
	; send ^+{F9} ;toggle audio tracks (hopefully off)
	tooltip,
	
}




#ifwinactive ;everything below this line can happen in any application!

saveToFile(name) {
	;code below does not use any fancy variables. It's a bare string. Unfortunately, I can't find a way to make it work better...
	;change this path ----|                  																 and this one --------|    to your own folder locations.
	;    	              |																										  |
	;                     v																									  	  v
	RunWait, %comspec% /c C:\Users\TaranWORK\Downloads\Taran_extra_keyboards\insideclipboard\InsideClipboard.exe /saveclp %name%, c:\Users\TaranWORK\Downloads\Taran_extra_keyboards\insideclipboard\clipboards\
	
	
	;just saving the below lines of code, which didn't work because %pathh% nor %Exec% variables could not be defined properly. Or something... IDK....
	;RunWait, %comspec% /c %Exec% /saveclp %name%, c:\Users\TaranWORK\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	;RunWait, %comspec% /c %Exec% /saveclp %name%, %pathh%
	
}

loadFromFile(name) {
	; You'll need to change these paths too!
	RunWait, %comspec% /c C:\Users\TaranWORK\Downloads\Taran_extra_keyboards\insideclipboard\InsideClipboard.exe /loadclp %name%, c:\Users\TaranWORK\Downloads\Taran_extra_keyboards\insideclipboard\clipboards\
}



#ifwinactive ;everything below this line can happen in any application!
runexplorer(foo){
keyShower(foo, "runExplorer")
run, % foo
}


SendKey(theKEY, fun := "", sometext := ""){
;msgbox sendkey has recieved %lols%
keyShower(sometext, fun)
; keyShower(theKEY, fun, sometext)
Sendinput {%theKEY%}
}



#IfWinActive

!F2::
openApp("ahk_class ConsoleWindowClass", "C:\Users\TaranWORK\Downloads\Intercept - use this one\intercept.exe")
openApp("ahk_class ConsoleWindowClass", "intercept.exe")
sleep 100
;send y
return





;VK27  SC04D  == numpad right (shift numpad6)
;VK66  SC04D  == numpad 6
;VK25  04B	 == numpad left
;VK64  04B	 == numpad 4



#if GetKeyState("F9") && GetKeyState("F24") ;experimental stuff, just ignore it.
numpad6::msgbox, lol
F24::msgbox, lel
shift::msgbox, lal
right::msgbox, right
#if


;_______________________2ND KEYBOARD IF USING INTERCEPTOR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; #if (getKeyState("F24", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
#if (getKeyState("F24", "P"))
F24::return ;this is the dedicated 2nd keyboard "modifier key." You MUST allow it to return, and cannot use it for anything else.



;I converted the numpad "5" button on the 2nd keyboard into a SHIFT.... by using intercept.
;it works pretty well, BUT I don't reccomend it. Use CTRL instead. if you use shift, the names of the keys change.
;for example, it's not +numpad6, it's actually numpadright instead. But some programs just interpret this as a normal "right." It's dumb.


~numpadLeft::Keyshower("Nudge clip Left 5 frames")
;~VK25::Keyshower(A_thishotkey, "nudge clip right 5 frames") ;----virtual keys are okay... scancodes might be better, if you want the physical KEY itself, unchanged by chift or numlock.
;~VK27::Keyshower(A_thishotkey, "nudge clip left? 5 frames")
~numpadRight::Keyshower("nudge clip RIGHT 5 frames")


~numpadEnd::Keyshower("add marker color 1 (taran mod)")
~numpadclear::Keyshower("add marker color 2 (taran mod)") ;intercept converts this one from numlock into a harmless numpad5.
~+numpadmult::Keyshower("add marker color 3 (taran mod)")
~numpadpgdn::Keyshower("add marker color 4 (taran mod)")
~numpadhome::Keyshower("add marker color 5 (taran mod)")
~+numpaddiv::Keyshower("add marker color 6 (taran mod)")
~numpadins::Keyshower("add marker color 7 (taran mod)")
~numpadpgup::Keyshower("add marker color 8 (taran mod)")




escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9

;C:\ProgramData\NVIDIA Corporation\GeForce Experience\Update ;location to disable GFEv3



F1::SFXActions("")
F2::SFXActions("Whoosh19-Short") ;you may not use spaces for filenames of sounds that you want to retreive in this way... since searching in premiere will disregard spaces in a a weird way... returning multiple wrong results....
F3::SFXActions("Whoosh7-Short")
F4::SFXActions("Whoosh2-Short")
F5::SFXActions("SimpleWhoosh12")
F6::SFXActions("SimpleWhoosh11")
F7::SFXActions("SimpleWhoosh10")
F9::SFXActions("SimpleWhoosh3")
F8::SFXActions("SimpleWhoosh8")
F10::SFXActions("woosh2")
F11::SFXActions("woosh1")
; F12 is not used here if it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;

`::msgbox tilde or weird quote thing??
1::SFXActions("bleep")
2::
3::
4::
5::SFXActions("")
6::SFXActions("record scratch")
7::SFXActions("")
8::SFXActions("")
9::SFXActions("")
0::SFXActions("pop")
-::audioMonoMaker("left")
=::audioMonoMaker("right")
backspace::preset("2.4 limiter") ; msgbox, , ,back spayce!, 100

;;;;;next line;;;;;;;;

tab::msgbox you pressed tab. :P

;This was the old code, before I realized I can just use A_thishotkey and assign all of them at once!!
; q::recallClipboard("q")
; w::recallClipboard("w")
; e::recallClipboard("e")
q::
w::
e::
r::
t::recallClipboard(A_thishotkey)

+q::
+w::
+e::
+r::
+t::saveClipboard(A_thishotkey)

y::preset("pop in transform")
u::preset("pop out transform")
i::preset("multiply")
o::preset("flip vertical")
p::preset("flip horizontal")
[::preset("pop in motion")
]::preset("pop out motion")
\::return ; "full reset mod" that I still have not programmed....

;;;;;next line;;;;;;;;

capslock::msgbox, , ,i hate capslock!, 1000


a::
s::
d::
f::
g::recallClipboard(A_thishotkey)

+a::
+s::
+d::
+f::
+g::saveClipboard(A_thishotkey) ;need to erase the SHIFT if I want to do it this way...?


h::preset("zoom slow")
j::preset("anchor and position to 0") ;no panning involved here.
k::preset("zoom fast")
l::preset("ltt color")
`;::preset("blur with edges") ;msgbox this is a semicolon! ;lol, the syntax highlighting gets this one wrong.
'::preset("Warp Stabilizer Preset")
enter::Sendinput ^!e

;;;;;next line;;;;;;;;

Lshift::return ;msgbox, , ,you pressed Left shift - you should never see this message if you let it pass normally, 5
;now I use it as a modifier for some of the other numpad keys.
z::
x::
c::
v::
b::recallClipboard(A_thishotkey)

+z::
+x::
+c::
+v::
+b::saveClipboard(A_thishotkey)

n::preset("pan left")
;m::preset("pan down")

m::preset("a0p0 pan down")
,::preset("pan right")
.::preset("corner pin")
/::preset("crop full")

;;;;;next area;;;;;;;;

;None of these modifiers should even happen, I have allowed modifiers to pass through normally.
Lctrl::msgbox LEFT ctrl
Lwin::msgbox LEFT win
Lalt::msgbox LEFT alt

space::tippy("2nd space") ;change this to EXCLUSIVE "play" only?

Ralt::msgbox Ralt - doesnt work
Rwin::msgbox Right Win - doesnt work
Rshift::msgbox RIGHT SHIFT lol

SC062::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~CANNED PRE ROLLS") ;remapped from appskey, it seemed to cause problems.
Rctrl::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~INTEGRATIONS")
appskey::msgbox, this is the right click appskey KEY I guess

PrintScreen::runexplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard")
ScrollLock::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7
SC061::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7

CtrlBreak::msgbox, CTRL BREAK - maybe the default output of the pause/break key??
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key?? WHAT CAN I BELEVE ANYMORE??

insert::runexplorer("Z:\Linus\1. Linus Tech Tips\Pending")
home::runexplorer("Z:\Linus\6. Channel Super Fun")
pgup::runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")

delete::runexplorer("N:\Linus Tech Tips")
end::runexplorer("N:\Channel Super Fun")
pgdn::runexplorer("N:\Fast As Possible")

up::preset("push up")
down::preset("push down")
left::preset("push left")
right::preset("push right")

;;;;;next area;;;;;;;;

numpad0::SendKey("numpad0", , "sky blue")
numpad1::SendKey(A_thishotkey, ,"blue-green")
numpad2::SendKey(A_thishotkey, ,"nudge down")
numpad3::SendKey(A_thishotkey, ,"orange")
numpad4::SendKey(A_thishotkey, ,"nudge left")
numpad5::msgbox, this text shhould not appear. ;return ;I have remapped this to "shift" in interceptor. Scan Code 04C.
numpad6::SendKey(A_thishotkey, ,"nudge right")
numpad7::SendKey(A_thishotkey, ,"purple")
numpad8::SendKey(A_thishotkey, ,"nudge up")
numpad9::SendKey(A_thishotkey, ,"dark green") ;this is a nice way to do it where you can affect multiple key assignments at the same time!! :D


numlock::SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
numpadDiv::SendKey("numpadDiv", ,"clip blue")
numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::openApp("ahk_class AU3Reveal", "AU3_Spy.exe", "Active Window Info") ;msgbox, , , num minus, 0.5
; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe") ;msgbox, , , num ADD, 0.5
numpadAdd::openApp("ahk_class ConsoleWindowClass", "intercept.exe") ;msgbox, , , num ADD, 0.5
numpadEnter::Sendinput #d;msgbox, , , num enter, 0.5
numpadDot::openApp("ahk_class Photoshop", "Photoshop.exe") ;msgbox, , , num dot, 0.5


/*
;These are now unused - I realized that keeping them as modifiers (allowing them to pass through normally) is more valuable then as single keys.
SC060::msgbox sc060, which I have assigned from LEFT SHIFT using intercept.exe
SC061::msgbox sc061, right shift
SC062::msgbox sc062, L CTRL
SC063::msgbox sc063, L WIN
SC064::msgbox sc064, L ALT
*/
SC065::msgbox sc065, R ALT
SC066::msgbox sc066, R WIN
SC067::msgbox sc067, R CTRL


SC045::msgbox sc045... num lock but actually pause/break?????


SC07F::msgbox sc7F is as high as I could go, after 80 they become unusable for some reason.
SC080::msgbox sc080... this does not register.
SC0FF::msgbox FF ...this does not register.


#if
#IfWinActive
;--------------END OF 2ND KEYBOARD IF USING INTERCEPTOR~~~~~~~~~~~~~~~~~~~~~










;---------------;2ND KEYBOARD USING LUAMACROS... NOW OBSOLETE!;-------------------
#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! remove the first ; from the next line if you want the 2nd keyboard script to work in any application!
;#IfWinActive ;---- If this code is NOt commented out, it will allow for everything below this line to work in ANY application.

~F23::

FileRead, key, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt
 
tippy(key) ;this makes a temporary tooltip that reveals the key that was pressed.
 
presetActions := Object()
sendKeystrokesActions := Object()
recallClipboardActions := Object()
recallSFX := Object()
sectionview := ""
currentSection := ""


;This loop will read all the key value pairs (e.g. keybinds).
Loop, read, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keyActions.txt
{
    if (A_LoopReadLine == "preset") or (A_LoopReadLine == "sendKeystrokes") or (A_LoopReadLine == "recallClipboard") or (A_LoopReadLine == "SFXActions")
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
	else if (currentSection == "SFXActions")
    {
        action := StrSplit(A_LoopReadLine, ":")
        recallSFX[action[1]] := action[2]
    }
}
 
if presetActions[key] != ""
{
    ; Keybind for preset exists
    preset(presetActions[key])
	Revealkey("Preset", key, presetActions[key])
}
else if sendKeystrokesActions[key] != ""
{
    ; Keybind for sendKeystrokes exists
    sendKeystrokes(sendKeystrokesActions[key])
	Revealkey("send keystrokes", key, sendKeystrokesActions[key])
}
else if recallClipboardActions[key] != ""
{
    ; Keybind for recallClipboard exists
    recallClipboard(recallClipboardActions[key])
	Revealkey("Recall Clipboard", key, recallClipboardActions[key])
}
else if recallSFX[key] != ""
{
    ; Keybind for SFXactions exists
    SFXActions(recallSFXActions[key])
	Revealkey("Recall sound effect", key, recallSFXActions[key])
}
else
    tooltip, Keybind not found! :(
; Comment out the following line if you DON'T want an annoying visualizer that tells you that you just pressed a key on your secondary keyboard

Return ;from F23


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
 
 
 ;2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222

 
 
 












#IfWinActive ahk_exe Adobe Premiere Pro.exe

;audioMonoMaker() will open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source.
audioMonoMaker(track)
{
CoordMode,Mouse,Screen
CoordMode,pixel,Screen
;SetTitleMatchMode, 2
;DetectHiddenWindows, On

BlockInput, SendAndMouse ;prevent mouse from moving
BlockInput, On
BlockInput, MouseMove


Keyshower(track,"audioMonoMaker")

global tToggle = 1
;msgbox, track is %track%
if (track = "right")
{
	;msgbox, this is for the RIGHT audio track. As usual, your number will be smaller, since I have 150% UI scaling enabled.
	addPixels = 36
}
else if (track = "left")
{
	addPixels = 0
	;msgbox, this is for the LEFT audio track
}
Send ^!+a ;control alt shift a --- ; audio channels shortcut, asigned in premiere - dont use this key combo anywhere else
;sleep 600
sleep 15

;this doesn't work, the panel thinks its loaded even before any controls appear on it.
; WinWaitActive, Modify Clip, OS_ViewContainer, 3 ;waits 3 seconds. ;ahk_class #32770 is the audio channels panel, according to window spy.
; if ErrorLevel
; {
    ; tooltip, WinWait timed out.
	; tooltip, no color found, go to ending
	; goto, ending
; }
; else
; {
	; msgbox,,, window was found maybe, 0.1

; }

MouseGetPos, xPosAudio, yPosAudio

;/*
MouseMove, 2222, 1600, 0 ;moved the mouse onto the expected location of the "okay" box, which has a distinct white color when the cursor is over it, which will let us know the panel has appeared.

; msgbox where am i, cursor says
MouseGetPos, MouseX, MouseY

waiting = 0
loop
	{
	waiting ++
	sleep 50
	tooltip, waiting = %waiting%`npixel color = %thecolor%
	MouseGetPos, MouseX, MouseY
	PixelGetColor, thecolor, MouseX, MouseY, RGB
	if (thecolor = "0xF0F0F0" || thecolor = "0xF1F1F1")
		{
		tooltip, COLOR WAS FOUND
		;msgbox, COLOR WAS FOUND 
		break
		}
		
	if (waiting > 10)
		{
		tooltip, no color found, go to ending
		goto, ending
		}
	}
	
	
;*/
CoordMode, Mouse, Client
CoordMode, Pixel, Client

MouseMove, 160 + addPixels, 288, 0 ;this is relative to the audio channels window itself. Again, you should reduce these numbers by like 33%...?, since i use 150% UI scaling.
;msgbox, now we should be on a check box
sleep 50

MouseGetPos, Xkolor, Ykolor
sleep 50
PixelGetColor, kolor, %Xkolor%, %Ykolor%

; INFORMATION:
; 2b2b2b or 464646 = color of empty box
; cdcdcd = color when cursor is over the box
; 9a9a9a = color when cursor NOT over the box
; note that these colors will be different depending on your UI brightness set in premiere.
; For me, the default brightness of all panels is 313131 and/or 2B2B2B

;msgbox, kolor = %kolor%
If (kolor = "0x2b2b2b" || kolor = "0x464646") ; "kolor" is the variable name rather than "color" because "color" might be already used for something else in AHK.
{
	;msgbox, box is empty
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
}
else if (kolor = "0x9a9a9a" || k2 = "0xcdcdcd") ;this coordinate, of course, should be directly on top of the box, but NOT where there is a checkmark, since the check mark is now the same color as the bare panel...
{
	; Do nothing. There was a checkmark in this box already.
}
sleep 5
MouseMove, 160 + addPixels, 321, 0
sleep 30
MouseGetPos, Xkolor2, Ykolor2
sleep 10
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 30
;msgbox, k2 = %k2%
If (k2 = "0x2b2b2b" || k2 = "0x464646")
{
	;msgbox, box is empty. i should click
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
	;msgbox, did clicking happen?
}
else if (k2 = "0x9a9a9a" || k2 = "0xcdcdcd")
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

} ; monomaker!!!!!!!!!!!!



;JUNKED CODE BEOW -- was trying to make an array or something in AHK...
; Array := object()
; object := {o:flip vertical, p:flip horizontal, i:multiply}
; F23:: ;this code DOES NOT WORK...?
; FileRead, keypressed, C:\Users\TaranWORK\Documents\keypressed.txt
; tippy(keypressed) ;this makes a temporary tooltip
; keyActions := { "o" : preset("flip horizontal"), "p" : preset("flip vertical"), "i" : "multiply" } 
; keyActions[keypressed]
; value := keyActions[keypressed]
; msgbox, the value is %value% 
; Return


;script reloader, but it only works on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return



^!+F2::msgbox, 2nd keyboard is still working