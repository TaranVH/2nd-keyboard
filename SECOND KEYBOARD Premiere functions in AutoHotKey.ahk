#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetWorkingDir C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files
; the above is what the variable %A_WorkingDir% refers to.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; HELLO, poeple who want info about making a second keyboard, using LUAmacros! Scroll down past all this stuff until you get to LINE 240.
; if you want to make the 2nd keyboard with intercept.exe instead, (far superior!) please scroll down to LINE 1695!

; Here's my LTT video about how I use the 2nd keyboard with Luamacros: https://www.youtube.com/watch?v=Arn8ExQ2Gjg
; And Tom's video, which unfortunately does not have info on how to actually DO it: https://youtu.be/lIFE7h3m40U?t=16m9s
; so you also need LUAmacros as well, of course.
; Luamacros: http://www.hidmacros.eu/forum/viewtopic.php?f=10&t=241#p794
; AutohotKey: https://autohotkey.com/

; However, interecept.exe is even better! I'll make a video about how to install and use it, eventually.
; Intercept.exe: http://orbiter-forum.com/showthread.php?t=30829

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;_______________________________________________________________________________________________________________________
;                                                                                                                       
; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm
; 
; 
;RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU
; KEYS                    PREMIERE FUNCTIONS
;---------------------------------------------------------------------------------
; u                     select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
; backspace             ripple delete --- but I don't use that in AutoHotKey because it's dangerous. This should be changed to something else; I use SHIFT C now.
; shift c               ripple delete --- very convenient for left handed use. Premiere's poor track targeting makes ripple delete less useful than it could be.
; ctrl alt shift d      ripple delete --- I never type this in manually - long shortcuts like this are great for using AHK or a macro to press them.
; delete                delete
; c                     delete --- I also have this on "C" because it puts it directly under my left hand. Very quick to press without having to move my hand.
; ctrl r                speed/duration panel
; shift 1               toggle track targeting for AUDIO LAYER 1
; shift 2               toggle track targeting for AUDIO LAYER 2. And so on up to 8.
; alt 1                 toggle track targeting for VIDEO LAYER 1
; alt 2                 toggle track targeting for VIDEO LAYER 2. And so on up to 8. I wish there were DEDICATED shortcuts to enable and disable ALL layers
; ctrl p                toggle "selection follows playhead"
; ctrl alt shift 3      Application > Window > Timeline (default is shift 3)
; ctrl alt shift `      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 1      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 4      Application > Window > program monitor (Default is SHIFT 4)
; ctrl alt shift 7      Application > Window > Effects   (NOT the Effect Controls panel) (Default is SHIFT 7) --- The defaults are stupid. SHIFT 7 is an ampersand if you happen to be in a text box somewhere...
; F2                    gain
; F3                    audio channels --- To be pressed manually by the user. (this might change in the future.)
; ctrl alt shift a      audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; shift F               From source monitor, match frame.
; ctrl /                Overwrite (default is "." (period))
; ctrl b                select find box --- This is such a useful function when you pair it the the effects panel!!
; ctrl alt F            select find box 
; ctrl shift 6			Apply source assignment preset 1 (set to V5 and A3)
;                                                                                                                        
; Be aware that sometimes other programs like PUUSH can overlap/conflict with your customized shortcuts.                          
;______________________________________________________________________________________________________________________



;defining some variables below:

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


prFocus(panel) ;this function allows you to have ONE spot where you define your personal shortcuts that "focus" panels in premiere.
{
;panel := """" . panel . """" ;this adds quotation marks around the parameter so that it works as a string, not a variable.
;Send ^!+1 ;bring focus to a random bin, in order to "clear" the current focus on any and all bins
Send ^!+7 ;bring focus to the effects panel, in order to "clear" the current focus on the MAIN monitor
if (panel = "effects")
	goto theEnd ;Send ^!+7 ;do nothing. the shortcut has already been pressed.
else if (panel = "timeline")
	Send ^!+3 ;if focus had already been on the timeline, this would have switched to the next sequence in some arbitrary order.
else if (panel = "program")
	Send ^!+4
else if (panel = "project") ;AKA a "bin" or "folder"
	Send ^!+1
else if (panel = "effect controls")
	Send ^!+5
theEnd:

}
;end of prFocus()


#ifwinactive
Keyshower(yeah, functionused := "", alwaysshow := 0) ;very badass function that shows key presses and associated commands, both from the primary and secondary keyboards (keyboard 2 must be configured using intercept.exe!)
{
;msgbox, keyshower
;the "NA" is extremely important to allow this window to be VISIBLE but not interfere with anything.
;msgbox, %A_priorhotkey% %A_thishotkey%


if (A_priorhotkey = "F23" || A_priorhotkey = "~numpadleft" || A_priorhotkey = "~numpadright") ;please pretend that numpad left and right are not here....
	{
	;this was sent from the 2nd keyboard, using interceptor. Interceptor presses F23, then the key, then releases the key, then releases F23. Very simple, but very effective.
	Gui, kb2: show, NA 
	Gui, hide
	;msgbox,,,what is hapening,1
	GuiControl kb2:,line1, %A_space%FROM 2ND KEYBOARD
	GuiControl kb2:,line2, %A_space%%A_thishotkey%
	GuiControl kb2:,line3, %A_space%%functionused%(`"%yeah%`")
	SetTimer,revealtimer2,-2000
	;msgbox, , , testing now, 1
	}
else if (A_priorhotkey = "F22")
	{
		Gui, kb2: show, NA 
		Gui, hide
		;msgbox,,,what is hapening,1
		GuiControl kb2:,line1, %A_space%FROM THIRD KEYBOARD
		GuiControl kb2:,line2, %A_space%%A_thishotkey%
		GuiControl kb2:,line3, %A_space%%functionused%(`"%yeah%`")
		SetTimer,revealtimer2,-2000
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



;22222222222222222222222222222222222222222222222222222222222222222222222222
;---------------2ND KEYBOARD USING LUAMACROS-------------------------------
;ALL THIS CODE IS OBSOLETE -- I'm only keeping it for people who watched
;my DIY 87-macro keyboard video: https://www.youtube.com/watch?v=Arn8ExQ2Gjg
;
;TO THOSE PEOPLE: The code below will work, but I have had more luck and
;stability using intercept.exe instead of luamacros. There's a video
;about it here: https://www.youtube.com/watch?v=y3e_ri-vOIo
/*

#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! remove the first ; from the next line if you want the 2nd keyboard script to work in any application!
;#IfWinActive ;---- If this code is NOt commented out, it will allow for everything below this line to work in ANY application.
~F24::
FileRead, key, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt
tippy(key) ; this function will just launch a quick tooltip that shows you what key you pressed. OPTIONAL.
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
insertSFX("buzz")
else if(key = "F7")
insertSFX("ding")
else if(key = "F8")
insertSFX("bleep")
else if(key = "F9")
insertSFX("woosh")
else if(key = "F10")
insertSFX("woosh TSFX")
else if(key = "F11")
insertSFX("bwoop")
else if(key = "F12")
insertSFX("pop")
else if(key = "F5")
insertSFX("SEARCH")

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

;THIS CODE IS ALL STUPID. never use keyboard macros to communicate inside AHK.
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
;CODE ABOVE IS SUPER STUPID -- WILL CHANGE.


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
;THE BLOCK OF CODE ABOVE is the original, simple Luamacros-dependant script.
*/


recallTransition(foo)
{
;Do nothing.
;this function was deleted, it never worked very well.
}


;;;;;;temporary tooltip maker;;;;;;
Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere%,,,8
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,,,,8
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




;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

effectsPanelType(item := "lol")
{
Keyshower(item,"effectsPanelType")
;prFocus("effects") ;reliably brings focus to the effects panel
Send ^+!7 ;CTRL SHIFT ALT 7 -- set in premiere to "effects" panel
sleep 10
Send ^b ;CTRL B --set in premiere to "select find box"
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


;;;;;;;;;;FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!;;;;;;;;;;;;
; preset() is my most used, and most useful AHK function! There is no good reason why Premiere doesn't have this functionality.
;keep in mind, I use 150% UI scaling, so your pixel distances for commands like mousemove WILL be different!
;to use this script yourself, carefully go through  testing the script and changing the values, ensuring that the script works, one line at a time. use message boxes to check on variables and see where the cursor is. remove those message boxes later when you have it all working!
#IfWinActive ahk_exe Adobe Premiere Pro.exe
preset(item)
{

if IsFunc("Keyshower")
   Keyshower(item,"preset") ;YOU DO NOT NEED THIS LINE. -- it simply displays keystrokes on the screen for the sake of tutorials.
else
   ;do nothing


ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto theEnding ;and this line is here just in case the function is called while not inside premiere.

;Setting the coordinate mode is really important. This ensures that pixel distances are consistant for everything, everywhere.
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window


;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
BlockInput, SendAndMouse
BlockInput, On

SetKeyDelay, 0 ;this ensures that any text AutoHotKey "types in," will input instantly, rather than one letter at a time.
MouseGetPos, xposP, yposP ;---stores the cursor's current coordinates at X%xposP% Y%yposP%

;Send ^+!7 ;CTRL SHIFT ALT 7 --- you must set this in premiere's keyboard shortcuts menu to "effects" panel
prFocus("effects") ;more reliably uses the above shortcut to set focus to the effects panel.

sleep 5 ;"sleep 5" means the script will wait for 5 milliseconds before the next command. This is done to give Premiere some time to load its own things.
Send ^b ;CTRL B -- set in premiere to "select find box"
sleep 5
;Any text in the Effects panel's find box has now been highlighted. There is also a blinking "text insertion point" at the end of that text. This is the vertical blinking line, or "caret." 

MouseMove, %A_CaretX%, %A_CaretY%, 0
;and fortunately, AHK knows the exact X and Y position of this caret. So therefore, we can find the effects panel find box, no matter what monitor it is on, with 100% consistency.
sleep 10

MouseGetPos, , , Window, classNN
WinGetClass, class, ahk_id %Window%
;msgbox, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;;;I think ControlGetPos is not affected by coordmode??  Or at least, it gave me the wrong coordinates if premiere is not fullscreened... https://autohotkey.com/docs/commands/ControlGetPos.htm 
ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
;;my results:  59, 1229, 252, 21,      Edit1,    ahk_class Premiere Pro

;now we have found a lot of useful informaiton about this find box. Turns out, we don't need most of it...
;we just need the X and Y coordinates of the "upper left" corner...

;comment in the following line to get a message box of your current variable values. The script will not advance until you dismiss the message box.
;MsgBox, xx=%XX% yy=%YY%

MouseMove, XX-25, YY+10, 0 ;-----------------------moves cursor onto the magnifying glass
;msgbox, should be in the center of the magnifying glass now.
sleep 5
;This types in the text you wanted to search for. Like "pop in." We can do this because the entire find box text was already selected by Premiere. Otherwise, we could click the magnifying glass if we wanted to , in order to select that find box.
Send %item%

sleep 30
MouseMove, 62, 95, 0, R ;----------------------relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the preset's icon. In my case, it is inside the "presets" folder, then inside of another folder, and the written name sohuld be compeltely unique so that it is the first and only item.
;msgbox, The cursor should be directly on top of the preset's icon. `n If not, the script needs modification.
MouseGetPos, iconX, iconY, Window, classNN ;---now we have to figure out the ahk_class of the current panel we are on. It used to be DroverLord - Window Class14, but the number changes anytime you move panels around... so i must always obtain the information anew.
WinGetClass, class, ahk_id %Window% ;----------"ahk_id %Window%" is important for SOME REASON. if you delete it, this doesnt work.
;msgbox, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
ControlGetPos, xxx, yyy, www, hhh, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
MouseMove, www/4, hhh/2, 0, R ;-----------------clicks in about the CENTER of the Effects panel. This clears the displayed presets from any duplication errors. VERY important. without this, the script fails 20% of the time.
MouseClick, left, , , 1 ;-----------------------the actual click
sleep 10

MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the effect's icon
sleep 35
MouseClickDrag, Left, , , %xposP%, %yposP%, 0 ;---drags this effect to the cursor's pervious coordinates, which should be above a clip.
sleep 10
MouseClick, middle, , , 1
;Send ^+!0 ;--------------------------------------CTRL SHIFT ALT 0 (zero) - set in Premiere to returns focus to the timeline. doesn't work for multiple timelines :(
;MouseClick, left, , , 1 ;------------------------returns focus to the timeline. Can be annoying if it selects something...
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work if you get stuck!! Cool.

;IfInString, Haystack, %Needle%
;if %item% has CROP in it
;IfInString, %item%, CROP
IfInString, item, CROP
{
	;msgbox, that has "CROP" in it.
	sleep 160
	cropClick()
}


theEnding:
}
;END of preset()


;That's the end of the function. Now we make shortcuts to CALL that function, each with a different parameter!

;All of these refer to presets I have already created and named in Premiere
;note that using ALT for these is kind of stupid... they can interfere with menus.
;ALT C, for example, will always open Premiere's CLIP menu. So I can't use that anywhere.
;Using the WIN key is also ill-advised.

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;F20 is available?
^+0::effectsPanelType("") ;set to macro key G1 on my logitech G15 keyboard. ;This just CLEARS the effects panel search bar s o that you can type something in.
^+-::preset("Warp Stabilizer Preset") ;macro key G2. I wish it would also press "analyse..."
^+=::effectsPanelType("presets") ;set to macro key G3. ;Types in "presets," which reveals your own entire list of presets.


;^!g::preset("Lumetri Color BLANK") ;macro key G4. This is a completely BLANK lumetri preset, untwirled and ready for me to change specific values.
;^!h::preset("Lumetri shadows up") ;macro key G5. This preset increases brightness, contrast, and saturation slightly, and adds a slight vingette. I use this often

^+,::audioMonoMaker("left")
;macro key G4. Using the WIn key is prooobably a terrible idea; I do not reccomend it...... :(
^+.::audioMonoMaker("right")
; macro key G5. ;

;^!j::preset("Lumetri BRIGHT") ;macro key G6. This lumetri preset adds a LOT of brightness, and saturation to balance. I use it for very dark shots.

;!l::preset("2.4 limiter") ;macro key G8. A compressor and limiter for the audio, to keep it from clipping at 0dB.
;Macro key G9 is set completely in the keyboard's software. It is simply: {F2}{7}{enter}, which increases the gain of any selected clips by 7dB.

;Macro key G11 is set completely in the keyboard's software. It is simply: {CTRL}{SHIFT}{m}, which is "From source monitor, match frame"

!]::preset("DeHummer Preset") ;This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

;IMPORTANT NOTE:
;for all of the above shortcuts, and many others, I have mapped them in premiere,
;in the new visual keyboard shortcuts mapper, to various useless commands from the
;CAPTURE PANEL. (which I never use) This is becasue I needed to be able to visualize
;which keystrokes were being used by AHK and other programs OUTSIDE of premiere,
;and premiere provides no way of doing this. It's a feature I should ask for...


/*
See "Windows Mod - various functions.ahk" for a much more complete
explanation of the following macro key assignments
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

;these have been discontinued
/*
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

; F17::
; preset(savedpreset2)
; ;msgbox, savedpreset2 %savedpreset2%

; ;msgbox, %savedpreset2%
; return

; F18::preset(savedpreset1)
*/



#IfWinActive ahk_exe WINWORD.EXE

^+]::Send {F3} ;set to "go to next comment" in Word.

#IfWinActive ahk_exe Adobe Premiere Pro.exe
^+]::Send {F2}7{enter} ;adds 7 gain.


;;;;more premiere mods / macros.;;;;;;;;

;F1 -> [select clip at playhead] and then [ripple delete] . Note the keyboard shortcuts I have assigned in Premiere, above.
;ripple delete clip (or blank) at playhead - requires target tracking to be ON!!
;Note also that this always selects ALL TARGETED TRACKS, so I usually just use it for cutting single-track A-roll.
;It is possible to have it select ONLY the top layer by toggling on and off "selection follows playhead."
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~F1::Send u^+!d
;#if

; control shift r = reverse selected clip
^+r::
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


; ;~sc11C::
; ~numpadEnter::
; ;this is the scancode for the numpad enter key.
; ;keystroke viz.ahk does not properly notice this key (always combining it the regular Enter) so I am making a visualizer for it here.
; Keyshower("program monitor zoom to fit - taran mod",,1)

; return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
sendKeystrokes(bar) ;this is super stupid and i want to get rid of it but i can't. it's launched from LUA 2nd keyboard...
{
	tooltip, sendkeystrokes %bar%
	Send %bar%
}



insertSFX(leSound)
{
keyShower(leSound, "insertSFX")
CoordMode, mouse, Screen
CoordMode, pixel, Screen
coordmode, Caret, screen


BlockInput, mouse
BlockInput, On
SetKeyDelay, 0 ;for instant writing of text
MouseGetPos, xpos, ypos
send ^+x ;ctrl shift x -- shortcut in premiere for "remove in/out points.
sleep 10
send ^+6 ;ctrl shift 6 - source assignment preset 1. (sets it to A3.)
sleep 10
; Send ^!+` ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?
send ^!+1 ;CTRL ALT SHIFT 1 -- ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
;msgbox, waiting for premiere to select that bin....
sleep 20
;msgbox how about naow?
; 
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box." Make sure there are NO OTHER conflicting shortcuts on this key, like "create new bin," which would stop it from working.
; send +{backspace} ;to delete anything that might be written in the bin, so that the caret coordinates are always accurate.

; msgbox, okay now what
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
send ^+6 ;source assignment preset 1, again.
sleep 400 ;we are waiting for the search to complete....

MouseMove, -6000, 250, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.
;msgbox, wheres de mouse?
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
tooltip, CLICK!!!
sleep 10
send ^+6 ;source assignment preset 1, again.
sleep 5
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box."
sleep 10
Send +{backspace} ;deletes the search text so that the bin returns to normal view with all SFX visible.
sleep 10
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.

sleep 20
tooltip, so did that work?
;msgbox, clicked, mouse should be back at original coordinates.

;send ^!+4 ;select program monitor
sleep 10
;send ^!+3 ;select timeline
sleep 10
send ^+6 ;my shortcut for "assign source assignment preset 1" in Premiere. The preset has V4 and A3 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
sleep 50
Send ^/ ;CTRL FORWARD SLASH -- SET TO "OVERWRITE" in premiere. Premiere's default shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
sleep 30
; Send mbutton ;this will MIDDLE CLICK to reselect whatever panel your cursor was hovering over before you engaged this function.
send ^!+3 ;this is set in premiere to highlight/switch to the timeline. important so that you aren't still stuck in the bin. If this is used more than once, it will unfortunately cycle thorugh all available sequences...
tooltip,
BlockInput, off
BlockInput, MouseMoveOff
}
;;end of insertSFX()


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
	;deactivate keyboard and mouse
	keyShower(int, "recallClipboard")
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
	
	if (transition = 0)
	{
		target("v1", "off", "all", 5) ;this will disable all video layers, and enable only layer 5.
		;Send +{F16} ;this will soon be linked to the target() function.
		tooltip, only layer 5 was turned on should be
		sleep 150
		
	}
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
	Send ^!d ;this is to deselect any clips that might be selected in the timeline.
	
} ;end of recall Clipboard()

#ifwinactive ;everything below this line can happen in any application!

;;script to TARGET or UNTARGET any arbitrary track
F16::
tooltip all video tracks ON
target("v1", "on", "all")
return
^F16::target("v1", "off", "all")
+F16::target("v1", "off", "all", 5)



Target(v1orA1, onOff, allNoneSolo := 0, numberr := 0)
{
;tooltip, now in TARGET function
; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos xPosCursor, yPosCursor
prFocus("timeline") ;brings focus to the timeline.
wrenchMarkerX := 400
wrenchMarkerY := 800 ;the upper left corner for where to begin searching for the timeline WRENCH and MARKER icons -- the only unique and reliable visual i can use for coordinates.
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
	xTime := xTime - targetdistance
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
		send +9 ;command in premiere to "toggle ALL video track targeting."
		sleep 10
		if (onOff = "on")
			{
			;tippy("turning ON")
			send +9 ; do it again to TARGET everything.
			}
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	else if (v1orA1 = "a1")
		{
		send !9 ;command in premiere to "toggle ALL audio track targeting."
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
		send +9 ;command in premiere to "toggle ALL video track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send +9 ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	if (v1orA1 = "a1")
		{
		send !9 ;command in premiere to "toggle ALL audio track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send !9 ; do it again to UNTARGET everything.
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
tooltip,
tooltip,,,,2
sleep 10
}
;END of TRACK TARGETER



#ifwinactive


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


#ifwinactive
; =================================================================
; someone elses' code that works horribly so i dont use it
; https://autohotkey.com/board/topic/7129-run-a-program-or-switch-to-an-already-running-instance/
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;       MS Outlook might have multiple windows open (main window and email
;       windows).  This parm allows activating a specific window.
; ===============================================================
RunOrActivate(Target, WinTitle = "")
{
	; Get the filename without a path
	SplitPath, Target, TargetNameOnly

	Process, Exist, %TargetNameOnly%
	If ErrorLevel > 0
		PID = %ErrorLevel%
	Else
		Run, %Target%, , , PID

	; At least one app (Seapine TestTrack wouldn't always become the active
	; window after using Run), so we always force a window activate.
	; Activate by title if given, otherwise use PID.
	If WinTitle <> 
	{
		SetTitleMatchMode, 2
		WinWait, %WinTitle%, , 3
		;TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
		WinActivate, %WinTitle%
	}
	Else
	{
		WinWait, ahk_pid %PID%, , 3
		;TrayTip, , Activating PID %PID% (%TargetNameOnly%)
		WinActivate, ahk_pid %PID%
	}


	SetTimer, RunOrActivateTrayTipOff, 1500
}

; Turn off the tray tip
RunOrActivateTrayTipOff:
	SetTimer, RunOrActivateTrayTipOff, off
	TrayTip
Return

; Example uses...
;#b::RunOrActivate("C:\Program Files\Seapine\TestTrack Pro\TestTrack Pro Client.exe")


;;runexplorer()
#ifwinactive ;everything below this line can happen in any application!
runexplorer(foo){
; send {ctrl} ;sending even a single keystroke from the secondary keyboard will prevents the taskbar icon from sometimes flashing pointlessly rather than opening.
send {SC0E8} ;scan code of an unassigned key
sleep 5
Run, %foo%

keyShower(foo, "runExplorer")
; WinWait, ahk_pid %PID%, , 3
; ;TrayTip, , Activating PID %PID% (%TargetNameOnly%)
; WinActivate, ahk_pid %PID%

; sleep 10
; WinGet, winid ,, A ; <-- need to identify window A = acitive
; sleep 10
; WinActivate ahk_id %winid%
; run, %foo%
; run, % foo ;the problem with this is that sometims the window is highlighted red in the app tray, but it doesn't actually open itself...
; explorerpath:= "explorer " foo
; Run, %explorerpath% ;the problem here is that it opens a new window instead of switching to the old one...
;RunOrActivate(foo) ;this thing just acts super slowly and horribly.... jeeezz...
}
;; end of runexplorer() -- it's also called explorerLaunch() on another script, which is dumb...



;obsolete... i THINK???
SendKey(theKEY, fun := "", sometext := ""){
;msgbox sendkey has recieved %lols%
keyShower(sometext, fun)
; keyShower(theKEY, fun, sometext)
Sendinput {%theKEY%}
}


;for further reading:
;   https://autohotkey.com/board/topic/60985-get-paths-of-selected-items-in-an-explorer-window/
saveLocation2()
{
f_text = 0
SetTitleMatchMode Slow
WinGet, f_window_id, ID, A


WinGetClass, f_class, ahk_id %f_window_id%
;;msgbox,,,%f_class%, 1
if f_class in ExploreWClass,CabinetWClass ; if the window class is an Explorer window of either kind.
{
; WinGetTitle, Title, ahk_class CabinetWClass
WinGetTitle, title, ahk_id %f_window_id% ;super lame way to do this, does not always work.
;msgbox, address is `n%title%

FileDelete, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
FileAppend, %title% , C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
SavedExplorerAddress = %title%
msgbox, , , %title%`n`nwas saved as root, 1
}
else
	msgbox,,, this is not an explorer window you chump,1
}

;;;^!+p::savelocation2()

;the function below is unused for this ahk script...
Explorer_GetSelection(hwnd="") {
	;msgbox, now in getselection
    hwnd := hwnd ? hwnd : WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
        for window in ComObjCreate("Shell.Application").Windows
            if (window.hwnd==hwnd)
    sel := window.Document.SelectedItems
    for item in sel
    ToReturn .= item.path "`n"
	;msgbox, %ToReturn% is toreturn
    return Trim(ToReturn,"`n")
}


saveLocation()
{
;msgbox, this will copy the currently highlighted text and replace the contents of C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt with it.
sendinput, ^a
sleep 20
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
FileDelete, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
FileAppend, %clipboard% , C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
msgbox, , , it worked, 0.5
}
;end of savelocation()




#IfWinActive ahk_exe Adobe Premiere Pro.exe

;audioMonoMaker() will open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source.
audioMonoMaker(track)
{
sleep 10
;msgbox,,, what the hell,0.6
CoordMode,Mouse,Screen
CoordMode,pixel,Screen
;SetTitleMatchMode, 2
;DetectHiddenWindows, On

BlockInput, SendAndMouse
BlockInput, On
BlockInput, MouseMove ;prevents mouse from moving

Keyshower(track,"audioMonoMaker") ;you can delete this line, you don't need it.

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
;WARNING - this was cross-talking with !+a, causing a preset("blur with edges") macro to be executed. I dont know how to avoid. maybe change order...??
; fun fact, if you send this keystroke AGAIN, it does NOT close the panel, which is great... that means you can press the button anytime, and it will always result in an open panel.
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
MouseMove, 2222, 1625, 0 ;moved the mouse onto the expected location of the "okay" box, which has a distinct white color when the cursor is over it, which will let us know the panel has appeared.

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
	if (thecolor = "0xE8E8E8")
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
sleep 5
MouseMove, 160 + addPixels, 321, 0
sleep 30
MouseGetPos, Xkolor2, Ykolor2
sleep 10
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 30
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

} ; monomaker!!!!!!!!!!!!


#ifwinactive

!`::
WinGet, ActiveId, ID, A
msgbox, %ActiveId%
;returns 0x1c0b9c ... and only 3 unique codes for each of the 3 Premiere windows I have on my 3 monitors. Does NOT consider subwindows, though maaaaybe it can get that going....
ControlGetFocus, OutputVar, A
msgbox, %OutputVar%
return





;BEGIN savage-folder-navigation CODE!
;I got MOST of this code from https://autohotkey.com/docs/scripts/FavoriteFolders.htm
;and modified it to work with any given keypress, rather than middle mouse click as it had before.

InstantExplorer(f_path,pleasePrepend := 0)
{
if pleasePrepend = 1
	{
	FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	;msgbox, current f_path is %f_path%
	f_path = %SavedExplorerAddress%\%f_path% ;no need to use . to concatenate
	;msgbox, new f_path is %f_path%
	}
;for Keyshower, put code here to find the first / and remove the string before it. otherwise you can't see the final folder name
Keyshower(f_path,"InstExplor")

f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable.
;msgbox, f_path is now finally %f_path%
;SoundBeep, 900, 400
; These first few variables are set here and used by f_OpenFavorite:
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
if f_class in #32770,ExploreWClass,CabinetWClass  ; if the window class is a save/load dialog, or an Explorer window of either kind.
	ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%

/*
if f_AlwaysShowMenu = n  ; The menu should be shown only selectively.
{
	if f_class in #32770,ExploreWClass,CabinetWClass  ; Dialog or Explorer.
	{
		if f_Edit1Pos =  ; The control doesn't exist, so don't display the menu
			return
	}
	else if f_class <> ConsoleWindowClass
		return ; Since it's some other window type, don't display menu.
}
; Otherwise, the menu should be presented for this type of window:
;Menu, Favorites, show
*/

; msgbox, A_ThisMenuItemPos %A_ThisMenuItemPos%
; msgbox, A_ThisMenuItem %A_ThisMenuItem%
; msgbox, A_ThisMenu %A_ThisMenu%

;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; msgbox, f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; f_OpenFavorite:
;msgbox, BEFORE:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; Fetch the array element that corresponds to the selected menu item:
;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
if f_path =
	return
if f_class = #32770    ; It's a dialog.
{
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		; IF window Title is NOT "export settings," with the exe "premiere pro.exe"
			;go to the end or do something else, since you are in Premiere's export media dialouge box... which has the same #23770 classNN for some reason...
		

		ControlFocus, Edit1, ahk_id %f_window_id% ;this is really important.... it doesn't work if you don't do this...
		tippy("DIALOUGE WITH EDIT1`n`nLE controlfocus of edit1 for f_window_id was just engaged.", 1000)
		; msgbox, is it in focus?
		; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
		; sleep 10
		; click
		; sleep 10
		; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
		;msgbox, edit1 has been clicked maybe
		
		; Activate the window so that if the user is middle-clicking
		; outside the dialog, subsequent clicks will also work:
		WinActivate ahk_id %f_window_id%
		; Retrieve any filename that might already be in the field so
		; that it can be restored after the switch to the new folder:
		ControlGetText, f_text, Edit1, ahk_id %f_window_id%
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		ControlSend, Edit1, {Enter}, ahk_id %f_window_id%
		Sleep, 100  ; It needs extra time on some dialogs or in some cases.
		ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
		;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
		return
	}
	; else fall through to the bottom of the subroutine to take standard action.
}
;for some reason, the following code just doesn't work well at all.
/*
else if f_class in ExploreWClass,CabinetWClass  ; In Explorer, switch folders.
{
	tooltip, f_class is %f_class% and f_window_ID is %f_window_id%
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		tippy("EXPLORER WITH EDIT1 only 2 lines of code here....", 1000)
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		msgbox, ControlSetText happened. `nf_class is %f_class% and f_window_ID is %f_window_id%`nAND f_Edit1Pos is %f_Edit1Pos%
		; Tekl reported the following: "If I want to change to Folder L:\folder
		; then the addressbar shows http://www.L:\folder.com. To solve this,
		; I added a {right} before {Enter}":
		ControlSend, Edit1, {Right}{Enter}, ahk_id %f_window_id%
		return
	}
	; else fall through to the bottom of the subroutine to take standard action.
}
*/

else if f_class = ConsoleWindowClass ; In a console window, CD to that directory
{
	WinActivate, ahk_id %f_window_id% ; Because sometimes the mclick deactivates it.
	SetKeyDelay, 0  ; This will be in effect only for the duration of this thread.
	IfInString, f_path, :  ; It contains a drive letter
	{
		StringLeft, f_path_drive, f_path, 1
		Send %f_path_drive%:{enter}
	}
	Send, cd %f_path%{Enter}
	return
}

; Since the above didn't return, one of the following is true:
; 1) It's an unsupported window type but f_AlwaysShowMenu is y (yes).
; 2) It's a supported type but it lacks an Edit1 control to facilitate the custom
;    action, so instead do the default action below.
tippy("end was reached.",333)
;SoundBeep, 800, 300 ;this is nice but the whole damn script WAITS for the sound to finish before it continues...
; Run, Explorer %f_path%  ; Might work on more systems without double quotes.


;msgbox, f_path is %f_path%

; SplitPath, f_path, , OutDir, , ,
; var := InStr(FileExist(OutDir), "D")

; if (var = 0)
	; msgbox, directory does not exist
; else if var = 1
	Run, %f_path%  ; I got rid of the "Explorer" part because it caused redundant windows to be opened, rather than just switching to the existing window
;else
;	msgbox,,,Directory does not exist,1


}
;end of instant explorer


; #IfWinActive
; ^F2::
; IfWinNotExist, ahk_class CabinetWClass
	; Run, explorer.exe

; GroupAdd, taranexplorers2, ahk_class CabinetWClass
; if WinActive("ahk_exe explorer.exe")
	; GroupActivate, taranexplorers2, r
; else
	; WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
; Return





#ifwinactive

;;;; SCRIPT TO ALWAYS OPEN THE MOST RECENTLY SAVED OR AUTOSAVED FILE OF A GIVEN FILETYPE, IN ANY GIVEN FOLDER (AND ALL SUBFOLDERS.);;;;

;;script partially obtained from https://autohotkey.com/board/topic/57475-open-most-recent-file-date-created-in-a-folder/
openlatestfile(directory, filetype)
{

if directory = 1
	{
	FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	;msgbox, current directory is`n%directory%
	directory = %SavedExplorerAddress%
	;msgbox, new directory is`n%directory%
	}


;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.


Keyshower(directory,"openlatestfile")


;I need some method of excluding ~$ files, since those clutter everything up (MS Word .docx ...)

;msgbox, directory is %directory%`n and filetype is %filetype%
Loop, Files,%directory%\*%filetype%, FR
{

If (A_LoopFileTimeModified>Rec)
  {
  IfNotInString, A_LoopFileFullPath, ~$
	FPath=%A_LoopFileFullPath%
  Rec=%A_LoopFileTimeModified%
  }
}

MsgBox 4,, Select YES to open the latest %filetype% at Fpath:`n`n%Fpath%
IfMsgBox Yes
	{
	Run %Fpath%
	}
}
;; end of openlatestfile()

; ; USING THE SCRIPT
; !n::
; examplePath = "Z:\Linus\6. Channel Super Fun\Flicking football"
; openlatestfile(examplePath, ".prproj") ;<--- notice how i INCLUDE the period in the parameters. IDK if it might be better to add the period later.
; return


;script reloader, but it only works on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return




; #ifwinactive
; F16::
; sleep 1000
; sendinput {SC061}
; tooltip, YEAH
; sleep 100
; tooltip,
; return


~F6::cropClick()

;;;CLICK ON THE 'CROP' TRANSFORM BUTTON IN ORDER TO SELECT THE CROP ITSELF
cropClick()
{
BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor

effectControlsX = 10
effectControlsY = 200 ;the coordinates of roughly where my Effect Controls usually are located on the screen
CoordMode Pixel ;, screen
CoordMode Mouse, screen

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are done with default UI brightness, plus 150% UI scaling in Windows.
ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+300, effectControlsY+1000, %A_WorkingDir%\CROP transform button.png
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2
    tippy("NO CROP WAS FOUND")
	goto resetcropper
	}
if ErrorLevel = 2
	{
    tippy("Could not conduct the search!")
	goto resetcropper
	}
if ErrorLevel = 0
	{
	MouseMove, FoundX+10, FoundY+10, 0 ;this moves the cursor onto the little square thingy.
	;msgbox, is the cursor in position?
	sleep 5
	click left
	}

resetcropper:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10
return
	
}
;end of CROP CLICK

#ifwinactive

reselect()
{
;alt k??
Send ^!+7 ; shortcut for select Effects panel
sleep 1
Send ^!+3 ; shortcut for select timeline
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
send {F2}
sleep 5
send %amount%
sleep 5
send {enter}
}
;end of addGain()


#IfWinActive


;#if GetKeyState("F9") && GetKeyState("F23") ;experimental stuff, just ignore it.
;VK27  SC04D  == numpad right (shift numpad6)
;VK66  SC04D  == numpad 6
;VK25  SC04B  == numpad left
;VK64  SC04B  == numpad 4
;#if







;_____________________________________________________________________________
;                                                                             
;					   2ND KEYBOARD IF USING INTERCEPTOR   			  		  ;_____________________________________________________________________________
;please watch https://www.youtube.com/watch?v=y3e_ri-vOIo if you need help.


;#if (getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.
#if (getKeyState("F23", "P"))

F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," and cannot use it for anything else.

;I converted the numpad "5" button on the 2nd keyboard into a SHIFT.... by using intercept.
;it works pretty well, BUT I don't reccomend it. Use CTRL instead. if you use shift, the names of the keys change.
;for example, it's not "+numpad6", it's actually "numpadright" instead. But some programs just interpret this as a normal "right." It's dumb.

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

F2::insertSFX("Whoosh19-Short") ;you may not use spaces for filenames of sounds that you want to retreive in this way... since searching in premiere will disregard spaces in a a weird way... returning multiple wrong results....
F3::insertSFX("Whoosh7-Short")
F4::insertSFX("Whoosh2-Short")
F5::insertSFX("SimpleWhoosh12")
F6::insertSFX("SimpleWhoosh11")
F7::insertSFX("SimpleWhoosh10")
F9::insertSFX("SimpleWhoosh3")
F8::insertSFX("SimpleWhoosh8")
F10::insertSFX("woosh2")
F11::insertSFX("woosh1")
; F12 is not used here if it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;

`::msgbox tilde or weird quote thing??
1::insertSFX("bleep")
2::
3::
4::
5::insertSFX("")
6::insertSFX("record scratch")
7::insertSFX("")
8::insertSFX("")
9::insertSFX("")
0::insertSFX("pop")
-::audioMonoMaker("left")
=::audioMonoMaker("right")
backspace::preset("2.4 limiter") ; msgbox, , ,back spayce!, 100

;;;;;next line;;;;;;;;

tab::msgbox,,, you pressed tab. :P,0.8

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
+g::saveClipboard(A_thishotkey)


h::preset("zoom motion 110")
j::preset("anchor and position to 0") ;no panning involved here.
k::preset("zoom motion 115")
l::preset("ltt color")
`;::preset("blur with edges") ;lol, the syntax highlighting gets this one wrong.
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

,::
preset("crop 50 LEFT")
;sleep 200
;cropClick()
return

.::
preset("crop 50 RIGHT")
;sleep 200
;cropClick()
return

/::
preset("crop full")
;sleep 150
;cropClick()
return

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
home::runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")
pgup::runexplorer("Z:\Linus\6. Channel Super Fun")

delete::runexplorer("N:\Linus Tech Tips")
end::runexplorer("N:\Fast As Possible") ;runexplorer("N:\Fast As Possible")
pgdn::runexplorer("N:\Channel Super Fun")

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
numpad5::msgbox, this numpad5 text shhould not appear. ;return ;I have remapped this to "shift" in interceptor. Scan Code 04C.
numpad6::SendKey(A_thishotkey, ,"nudge right")
numpad7::SendKey(A_thishotkey, ,"purple")
numpad8::SendKey(A_thishotkey, ,"nudge up")
numpad9::SendKey(A_thishotkey, ,"dark green")

+numlock::msgbox, "shift numpadlock"
numlock::SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
numpadDiv::SendKey("numpadDiv", ,"clip blue")
numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::openApp("ahk_class AU3Reveal", "AU3_Spy.exe", "Active Window Info") ;msgbox, , , num minus, 0.5
; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe") ;msgbox, , , num ADD, 0.5
numpadAdd::openApp("ahk_class Notepad++", "notepad++.exe") ;msgbox, , , num ADD, 0.5
numpadEnter::sendinput ^{F5} ; this goes to chrome instant application switcher in WINDOWS MOD - various functions .ahk.  ; openApp("ahk_class Chrome_WidgetWin_1", "chrome.exe")

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

;scancode scan code information
SC07F::msgbox sc7F is as high as I could go, after 80 they become unusable for some reason.
SC080::msgbox sc080... this does not register.
SC0FF::msgbox sc0FF ...this does not register.


#if
#IfWinActive


;--------------END OF 2ND KEYBOARD IF USING INTERCEPTOR~~~~~~~~~~~~~~~~~~~~~


#IfWinActive

!F2::
openApp("ahk_class ConsoleWindowClass", "C:\Users\TaranWORK\Downloads\Intercept - use this one\intercept.exe")
openApp("ahk_class ConsoleWindowClass", "intercept.exe")
;must have both of these or it wont work.
sleep 100
;send y
return


;doing some scancode testing here:

SC070::tooltip sc070
SC075::tooltip sc075
SC07A::tooltip sc07A
SC07B::tooltip sc07B
SC07C::tooltip sc07C
SC07D::tooltip sc07D
SC07E::tooltip sc07E ...this does register.
SC07F::tooltip sc07F is as high as I could go

SC080::tooltip sc080... this does not register.
SC081::tooltip sc081... this does not register.
SC082::tooltip sc082... this does not register.
SC083::tooltip sc083... this does not register.
SC084::tooltip sc084... this does not register.
SC085::tooltip sc085... this does not register.
SC086::tooltip sc086... this does not register.

SC0FB::tooltip sc0FB ...this does not register.
SC0FC::tooltip sc0FC ...this does not register.
SC0FD::tooltip sc0FD ...this does not register.



SC0FE::tooltip sc0FE ...this does not register.
SC0FF::tooltip sc0FF ...this does not register.

#if

;scan code scancodes information
;according to https://msdn.microsoft.com/en-us/library/aa299374(v=vs.60).aspx it only goes up to 53
;but SC076 is f24 apparently?
/*
SC159:: ; Replace 159 with your key's value.
MsgBox, %A_ThisHotKey% was pressed.
return



*/

;~~~~BEGINNING OF 3RD KEYBOARD (just a USB numpad) USING INTERCEPTOR~~~~~~~~
#if (getKeyState("F22", "P"))
;and if <premiere> is running <--add that later
F22::
; FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
send {SC0E8} ;scan code of an unused unassigned key. This is important to prevent taskbar flashing.
return

;Z:\Linus\1. Linus Tech Tips\Pending\Luke Personal Rig Update
NumpadDot::InstantExplorer("Delivery",1) ;capitalization is important! I think...
numpad0::InstantExplorer("Thumbnail",1) ;the "1" is there to tell it to use a saved location
numpad1::InstantExplorer("music",1)
numpad2::InstantExplorer("Graphics",1)
numpad3::InstantExplorer("Extra videos",1)
numpad4::InstantExplorer("music",1)
numpad5::InstantExplorer("L-Roll",1)
numpad6::InstantExplorer("ALL FOOTAGE",1)
numpad7::InstantExplorer("\",1) ;MAIN, ROOT FOLDER
numpad8::InstantExplorer("Scripts",1)
NumpadDiv::InstantExplorer("Project",1) 

Numpad9::openlatestfile(1, ".docx")
numpadMult::openlatestfile(1, ".prproj") ;very special... always opens the MOST RECENT .prproj no matter WHAT sub folder it is in.



NumpadAdd::
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
Return


;NumpadSub::tooltip, subtract - check autosave maybe

;SC00E::tooltip, backspace

; ^numpad7::saveLocation()
^numpad7::saveLocation2()



; numpadsub::
; msgbox,,,lel,1
; return

numpadsub::
if WinActive("ahk_exe explorer.exe")
	sendinput ^w
return

^numpadsub::WinClose, ahk_group taranexplorers

;;the code below WORKS, but does not block the normal "-" keystroke no matter what i have tried...
; #If (getKeyState("F22", "P")) and WinActive("ahk_exe explorer.exe")
; numpadsub::
; sendinput ^w
; msgbox,,,multiple #ifs used sucessfully ,1
; return

#if
;~~~~~~~~~END OF 3RD KEYBOARD (just a USB numpad) USING INTERCEPTOR~~~~~~~~~~




;~~~~~~~~~BEGIN 4TH KEYBOARD using F21
#if (getKeyState("F21", "P"))
F21::return 


numpad0::
prFocus("program") ;the following shortcut only works if the program monitor is in focus...
send ^{numpadEnter} ;zoom to fit program monitor
prFocus("timeline")
return
numpad1::
prFocus("program")
send ^{numpadSub} ;zoom out program monitor
prFocus("timeline")
return
numpad2::
prFocus("program")
send ^{numpadAdd} ;zoom in program monitor
prFocus("timeline")
return

numpad3::
msgbox,,,hi,0.5
runexplorer("C:\ProgramData\NVIDIA Corporation\GeForce Experience\Update")
return


numpad4::
IfWinActive, ahk_exe explorer.exe
{
	send {alt}vo{down}{enter}
	tippy("sort Explorer by date")
	Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
}
return
numpad5::
IfWinActive, ahk_exe explorer.exe
{
	send {alt}vo{enter}
	tippy("sort Explorer by name")
	Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
}
return
numpad6::
numpad7::
numpad8::
Numpad9::
NumpadDiv::msgbox,,, 4th keyboard %A_thishotkey%,0.6

backspace::
prFocus("program")
send ^+4 ;set program monitor resolution to 1/8th
tippy("wat")
prFocus("timeline")
return
NumpadSub::
prFocus("program")
send ^+3 ;res to 1/4
prFocus("timeline")
return
NumpadAdd::
prFocus("program")
send ^+2 ;res to 1/2
prFocus("timeline")
return

TAB::
prFocus("program")
send ^+1 ;set resolution to 1/1
prFocus("timeline")
return

NumpadEnter::tippy("nope")



numpadMult::
NumpadDot::send !p ;choose poster frame shortcut in Premiere


#if
;~~~~END OF 4TH KEYBOARD (mechanical Jelly) USING INTERCEPTOR~~~~

; https://www.reddit.com/r/MechanicalKeyboards/comments/4kf2gk/review_jellycomb_mechanical_numpad/
; https://autohotkey.com/board/topic/29542-rebinding-alt-061/
; this is for the jellycomb numpad 4th keyboard's TOP ROW of keys:
$*~LAlt::
Loop 10
	Hotkey, % "*Numpad" A_Index-1, HandleNum, on
keywait, LAlt ; replace with "Sleep 100" for an alternative
Loop 10
	Hotkey, % "*Numpad" A_Index-1, HandleNum, off
If (Ascii_Unicode_Input = "061")
	msgbox,,, you pressed the equals key!,1
If (Ascii_Unicode_Input = "040")
{
	prFocus("Effect Controls") ;the following shortcut only works if the Effect Controls panel is in focus...
	send ^!p ;shortcut for pin to clip
	prFocus("timeline")
}
If (Ascii_Unicode_Input = "041")
	msgbox,,, you pressed the close parenthisesis key!,1
Ascii_Unicode_Input := ""
return

HandleNum:
Ascii_Unicode_Input .= SubStr( A_ThisHotkey, 0 )
return

;END OF 4TH KEYBOARD OVERALL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

				
; ;BEGIN 5th keyboard - jelly comb compact with F20
; #if (getKeyState("F20", "P"))
; F21::return 


; numpad1::
; numpad2::
; numpad3::
; numpad4::
; numpad5::
; numpad6::
; numpad7::
; numpad8::
; Numpad9::
; numpad0::

; NumpadDiv::
; numpadMult::
; numpadadd::
; numpadsub::
; NumpadDot::msgbox,,, 5th keyboard %A_thishotkey%,0.6
; backspace::msgbox,,,lolbackspace,1
; n::msgbox,,,was N,1 ;this was remapped in intercep.exe from NUMLOCK to N
; NumpadEnter::msgbox,,,enterrr,1

; #if
; ;end 5th keyboard with F20
				
				
				
#IfWinActive
 



;STREAM DECK BEGIN -- 6th keyboard ---------

!+q::return ;q is unused
!+w::insertSFX("bell")
!+e::insertSFX("woosh1")
!+r::insertSFX("pop")
;!+t::return ;send ^!p ;shortcut for pin to clip
;!+a::preset("blur with edges") ;this was interfering with the monomaker... huge cross talk issues with this, and actually all the rest of them too....
!+s::audioMonoMaker("right")
!+d::audioMonoMaker("left")
!+f::reselect()
!+g::addGain()
!+z::preset("crop") ;the cropClip function is now auto-triggered.
!+x::preset("crop 50 LEFT")
!+c::preset("crop 50 RIGHT")
;!+v::Send F19 ;~F19::tracklocker() ; this is pointless, I'm just gonna have the key hit F19 from the start. aLSO, tracklocker() was moved to another ahk script.
;!+b::return ;instead, the key will hit CTRL SHIFT 0 straight away. (Effects panel find box selector mod.)

;in premiere, these are listed as Capture Panel>log Clip... which i never use, so it is just showing that these shortcuts HAVE been used by autohotkey.
;currently, a full stream deck folder full of only shortcuts
^!numpad0::
^!numpad1::
^!numpad2::
^!numpad3::
^!numpad4::
^!numpad5::
^!numpad6::
^!numpad7::
^!numpad8::
^!numpad9::

^!numpadDiv::
^!numpadMult::
^!numpadSub::
^!numpadAdd::return

#WinActivateForce

;And this is for the Explorer panel thingy on my stream deck. !+
+!y::savelocation2()
+!u::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery")
+!i::runexplorer("Z:\Linus\1. Linus Tech Tips\Pending")
+!o::runexplorer("N:\Linus Tech Tips")

+!h::InstantExplorer("Graphics",1)
+!j::InstantExplorer("ALL FOOTAGE",1)
+!k::openlatestfile(1, ".prproj")
+!l::runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")
+!`;::runexplorer("N:\Fast As Possible") ;notepad++ syntax highlighting is wrong here.

+!n::InstantExplorer("Thumbnail",1)
+!m::InstantExplorer("Delivery",1)
+!,::openlatestfile(1, ".docx")
+!.::runexplorer("Z:\Linus\6. Channel Super Fun")
+!/::runexplorer("N:\Channel Super Fun")

;experimenting with scan codes. here is a list of blank ones.
;https://developer.mozilla.org/en/docs/Web/API/KeyboardEvent/code
#if

;6F is CTRL ??

^F13::
tooltip, yeah
sleep 500
send {SC05A} ;just after F23, but is not F24.
tooltip,
return
^F14::send {SC05A} ;just before F13
^F15::send {SC05E}
;^F16::send {SC05F}
^F17::send {SC060}
^F18::send {SC061}
^F19::send {SC062}
^F20::
^F21::
^F22::

;{SC0E8} is taken by one of my own scripts.