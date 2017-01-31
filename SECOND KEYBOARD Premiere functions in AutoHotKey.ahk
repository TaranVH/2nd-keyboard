#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;The ABOVE CODE ^^^ was automatically generated when I made a new .ahk document. I don't know how essential it is.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#SingleInstance force ;only one instance of this script may run at a time!

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; HELLO, poeple who want info about making a second keyboard, using LUAmacros! Scroll down past all this stuff until you get to LINE 210.
; if you want to make the 2nd keyboard with intercept.exe instead, (far superior!) please scroll down to LINE 1100!

; Here's my LTT video about how I use the 2nd keyboard with Luamacros: https://www.youtube.com/watch?v=Arn8ExQ2Gjg
; And Tom's video, which unfortunately does not have info on how to actually DO it: https://youtu.be/lIFE7h3m40U?t=16m9s
;(KEEP IN MIND, for Luamacros, I now use 'F23' instead. But the principle is exactly the same.)
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
; c                     delete --- I also have this on C, because it puts it directly under my left hand. Very quick to press without having to move my hand.
; ctrl r                speed/duration panel
; shift 1               toggle track targeting for AUDIO LAYER 1
; shift 2               toggle track targeting for AUDIO LAYER 2. And so on up to 8.
; alt 1                 toggle track targeting for VIDEO LAYER 1
; alt 2                 toggle track targeting for VIDEO LAYER 2. And so on up to 8. I wish there were DEDICATED shortcuts to enable and disable ALL layers
; ctrl p                toggle "selection follows playhead"
; ctrl alt shift 0      Application > Window > Timeline (This key CANNOT be easily reassigned in PR2017 due to a bug.) (Default is SHIFT 3)
; ctrl alt shift `      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 1      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 4      Application > Window > program monitor (Default is SHIFT 4)
; ctrl alt shift 7      Application > Window > Effects   (NOT the Effect Controls panel) (Default is SHIFT 7) --- Note that all of the defaults are stupid. SHIFT 7 is just an ampersand if you happen to be in a text box somewhere...
; F2                    gain
; F3                    audio channels --- To be pressed manually by the suer. (this might change in the future.)
; ctrl alt shift a      audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; shift F               From source monitor, match frame. -- awkward to press by hand. This is done with a macro instead.
; ctrl /                Overwrite (default is "." (period))
; ctrl b                select find box --- This is such a useful function when you pair it the the effects panel!!
; ctrl alt F            select find box 
;                                                                                                                        
; Be aware that sometimes other programs like PUUSH can overlap with your customized shortcuts.                          
;_______________________________________________________________________________________________________________________



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
	;msgbox,,,what is hapening,1
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



;222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
;---------------2ND KEYBOARD USING LUAMACROS... (I currently use intercept.exe instead, though!)-------------------

#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! remove the first ; from the next line if you want the 2nd keyboard script to work in any application!
;#IfWinActive ;---- If this code is NOt commented out, it will allow for everything below this line to work in ANY application.
~F23::
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
SFXActions("buzz")
else if(key = "F7")
SFXActions("ding")
else if(key = "F8")
SFXActions("bleep")
else if(key = "F9")
SFXActions("woosh")
else if(key = "F10")
SFXActions("woosh TSFX")
else if(key = "F11")
SFXActions("bwoop")
else if(key = "F12")
SFXActions("pop")
else if(key = "F5")
SFXActions("SEARCH")

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
;THE BLOCK OF CODE ABOVE is the original, simple script.


;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;THE KEYACTIONS CODE BELOW is a fancier way of doing the same thing, that does NOT involve dozens of ELSE IF statements.
;However, it is annoying to use for several reasons, so I am mothballing it. I do NOT reccomend that you use this code.
/*

#IfWinActive ahk_exe Adobe Premiere Pro.exe
~F23::
FileRead, key, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt
tippy(key)

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

Return ;from F23
*/

;;---I DO NOT RECCOMEND THAT YOU USE THE CODE ABOVE. I AM MOTHBALLING IT.---
;;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

/*
;; FYI:  Keyactions.txt is filled with text exactly like this:
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
 
;;END OF 2ND KEYBOARD CODE AS LAUNCHED FROM LUAMACROS.
;;22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222


recallTransition(foo)
{
;Do nothing.
;this function was deleted, it never worked very well.
}




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




;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

effectsPanelType(item := "")
{
Keyshower(item,"effectsPanelType")
Send ^+!7 ;CTRL SHIFT ALT 7 -- set in premiere to "effects" panel
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

Keyshower(item,"preset") ;YOU DO NOT NEED THIS LINE. -- it simply displays keystrokes on the screen for the sake of tutorials.

;Setting the coordinate mode is really important. This ensures that pixel distances are consistant for everything, everywhere.
coordmode, pixel, screen
coordmode, mouse, screen
coordmode, Caret, screen

;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
BlockInput, SendAndMouse
BlockInput, On

SetKeyDelay, 0 ;this ensures that any text AutoHotKey "types in," will input instantly, rather than one letter at a time.
MouseGetPos, xposP, yposP ;-----------------------stores the cursor's current coordinates at X%xposP% Y%yposP%

Send ^+!7 ;CTRL SHIFT ALT 7 --- you must set this in premiere's keyboard shortcuts menu to "effects" panel
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
ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
;;my results:  59, 1229, 252, 21,      Edit1,    ahk_class Premiere Pro

;now we have found a lot of useful informaiton about this find box. Turns out, we don't need most of it... just the X and Y coordinates of the "upper left" corner...

;comment in the following line to get a message box of your current variable values. The script will not advance until you dismiss the message box.
;MsgBox, xx=%XX% yy=%YY%

MouseMove, XX-30, YY, 0 ;-----------------------moves cursor onto the magnifying glass


; below is part of the old code, which is only usable if the "Edit7" never changes.... which it does.
; ControlGetPos, X, Y, Width, Height, Edit7, ahk_class Premiere Pro ;highlights Premier's effects panel SEARCH BAR/FIND BOX specifically. (info gotten from window spy.) For you, it may have a different name.

/*
;this code works, but just wastes time, since we don't actually need to clear the text and then select the box again. The built in premiere shortcut already selects the box for us.
MouseMove, XX+Width-5, YY+Height-20, 0 ;---------moves cursor to the X
sleep 5
MouseClick, left, , , 1 ;------------------------clicks on X, which deletes all text in the find box.
;msgbox, was X clicked?
MouseMove, XX-30, YY, 0 ;-----------------------moves cursor to the magnifying glass, which will select the whole find box again.
sleep 5
MouseClick, left, , , 1 ;------------------------clicks on magnifying glass
;msgbox, was mag clicked?
*/

sleep 5
Send %item%
;This types in the text you wanted to search for. Like "pop in." We can do this because the entire find box text was already selevted by Premiere.

sleep 30
MouseMove, 52, 65, 0, R ;----------------------relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the effect's icon

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
Send ^+!0 ;--------------------------------------CTRL SHIFT ALT 0 (zero) - set in Premiere to returns focus to the timeline. doesn't work for multiple timelines :(
;MouseClick, left, , , 1 ;------------------------returns focus to the timeline. Can be annoying if it selects something...
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work!! Cool.
}
;END of preset()


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

; F17::
; preset(savedpreset2)
; ;msgbox, savedpreset2 %savedpreset2%

; ;msgbox, %savedpreset2%
; return

; F18::preset(savedpreset1)
; ;;;;;;;;;;;;;;;END OF FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;OBSOLETE CODE BELOW. DO NOT USE.
; ;;;;;;;;;;;script that increases or decreases the size of the program monitor, no matter what panel you have selected.;;;;;;;;;;;;;;;;;;;
; #IfWinActive ahk_exe Adobe Premiere Pro.exe
; ; SHORTCUT				MAPPED TO THIS COMMAND IN PREMIERE
; ; ctrl numpad -			"zoom (program) monitor in"
; ; ctrl numpad +			"zoom (program) monitor out"
; ; ctrl numpad enter		"zoom (program) monitor to fit"
; ;the following script is designed to allow you to use numpad + - and enter to increase and decrease the zoom of the program monitor, regardless of what panel is actually in focus.
; ;It's a small but (to me) important workaround.
; ;This script simply puts the program monirot in focus, and adds the control key
; numpadAdd::
; Keyshower("program monitor zoom IN - taran mod",,1)
; weirdNumpadders()
; return

; numpadSub::
; Keyshower("program monitor zoom OUT - taran mod",,1)
; weirdNumpadders()
; return

; sc11C::
; ;numpadEnter::
; Keyshower("program monitor zoom to FIT - taran mod",,1)
; weirdNumpadders()
; return

;;;;;;;;; OBSOLETE CODE ABOVE.

#IfWinActive





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



SFXActions(leSound)
{
keyShower(leSound, "insertSFX")
CoordMode, mouse, Screen
CoordMode, pixel, Screen
BlockInput, On
SetKeyDelay, 0 ;for instant writing of text
MouseGetPos, xpos, ypos
send ^+x ;ctrl shift x -- shortcut in premiere for "remove in/out points.
sleep 10
send ^!1 ;ctrl alt 1 -- source assignment preset 1
sleep 10
; Send ^!+` ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?
send ^{F11} ;CTRL F11 -- ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
sleep 10
;msgbox how about naow?
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box"
; sleep 200
; Send +{delete}
; sleep 600
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
send ^!1 ;source assignment preset 1, again.
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

MouseMove, -6000, 250, 0
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
tooltip, CLICK!!!
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.

sleep 20
tooltip, so did that work?

;send ^!+4 ;select program monitor
sleep 10
;send ^!+0 ;select timeline
sleep 10
send ^!1 ;my shortcut for "assign source assignment preset 1" in Premiere. The preset has V4 and A3 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
sleep 50
Send ^/ ;CTRL /  -- SET TO "OVERWRITE" in premiere. Premiere's default shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
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


#ifwinactive
; ===========================================================================
; https://autohotkey.com/board/topic/7129-run-a-program-or-switch-to-an-already-running-instance/
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;       MS Outlook might have multiple windows open (main window and email
;       windows).  This parm allows activating a specific window.
; ===========================================================================
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




#ifwinactive ;everything below this line can happen in any application!
runexplorer(foo){
run, %foo%
keyShower(foo, "runExplorer")
; run, % foo ;the problem with this is that sometims the window is highlighted red in the app tray, but it doesn't actually open itself...
; explorerpath:= "explorer " foo
; Run, %explorerpath% ;the problem here is that it opens a new window instead of switching to the old one...

;RunOrActivate(foo) ;this thing just acts super slowly and horribly.... jeeezz...
}


;obsolete... i THINK???
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



;_______________________2ND KEYBOARD IF USING INTERCEPTOR_____________________

; #if (getKeyState("F24", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
#if (getKeyState("F24", "P"))
F24::return ;F24 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," and cannot use it for anything else.


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
+g::saveClipboard(A_thishotkey)


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
,::preset("crop 50 LEFT")
.::preset("crop 50 RIGHT")
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
numpad5::msgbox, this numpad5 text shhould not appear. ;return ;I have remapped this to "shift" in interceptor. Scan Code 04C.
numpad6::SendKey(A_thishotkey, ,"nudge right")
numpad7::SendKey(A_thishotkey, ,"purple")
numpad8::SendKey(A_thishotkey, ,"nudge up")
numpad9::SendKey(A_thishotkey, ,"dark green") ;this is a nice way to do it where you can affect multiple key assignments at the same time!! :D

+numlock::msgbox, "shift numpadlock"
numlock::SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
numpadDiv::SendKey("numpadDiv", ,"clip blue")
numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::openApp("ahk_class AU3Reveal", "AU3_Spy.exe", "Active Window Info") ;msgbox, , , num minus, 0.5
; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe") ;msgbox, , , num ADD, 0.5
numpadAdd::openApp("ahk_class ConsoleWindowClass", "intercept.exe") ;msgbox, , , num ADD, 0.5
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


SC07F::msgbox sc7F is as high as I could go, after 80 they become unusable for some reason.
SC080::msgbox sc080... this does not register.
SC0FF::msgbox sc0FF ...this does not register.


#if
#IfWinActive


;--------------END OF 2ND KEYBOARD IF USING INTERCEPTOR~~~~~~~~~~~~~~~~~~~~~




;~~~~BEGINNING OF 3RD KEYBOARD (just a USB numpad) USING INTERCEPTOR~~~~~~~~
#if (getKeyState("F22", "P"))
;and if <premiere> is running <--add that later
F22::
FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
return

;Z:\Linus\1. Linus Tech Tips\Pending\Luke Personal Rig Update
NumpadDot::InstantExplorer(SavedExplorerAddress . "\" . "Delivery" . "\" ) ;capitalization is important! I think...
numpad0::InstantExplorer(SavedExplorerAddress . "\" . "Thumbnail" . "\" )
numpad1::InstantExplorer(SavedExplorerAddress . "\" . "music" . "\" )
numpad2::InstantExplorer(SavedExplorerAddress . "\" . "Graphics" . "\" )
numpad3::InstantExplorer(SavedExplorerAddress . "\" . "Extra videos" . "\" )
numpad4::InstantExplorer(SavedExplorerAddress . "\" . "music" . "\" )
numpad5::InstantExplorer(SavedExplorerAddress . "\" . "L-Roll" . "\" )
numpad6::InstantExplorer(SavedExplorerAddress . "\" . "ALL FOOTAGE" . "\" )
numpad7::InstantExplorer(SavedExplorerAddress) ;MAIN, ROOT FOLDER
numpad8::InstantExplorer(SavedExplorerAddress . "\" . "Scripts" . "\" )
numpad9::InstantExplorer(SavedExplorerAddress . "\" . "Scripts" . "\" ) ; should open latest script
NumpadDiv::InstantExplorer(SavedExplorerAddress . "\" . "Project" . "\" ) 
NumpadMult::tooltip, mult - open latest project i guess


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

^numpad7::
;msgbox, this will copy the currently highlighted text and replace the contents of C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt with it.
sendinput, ^a
sleep 20
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
FileDelete, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
FileAppend, %clipboard% , C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
msgbox, , , it worked, 1
Return

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









#IfWinActive
 
 
/*
;This code is obsolete. It turned out not to work....
weirdNumpadders(){
IfWinnotExist, Audio Gain ;|| Keyboard Shortcuts ;(does not work...);or titler, but that one has no title!!!
{
;msgbox come on
sendinput ^+!7 ;premiere shortcut to activate the effects panel. this is necessary.
sleep 50
sendinput ^+!4 ;shortcut to activate the program monitor. If the program monitor is ALREADY selected, it will cycle to the next sequence. This is stupid. Therefore, another panel (that never cycles through anywhere, and is already always open) must be slected first.
sleep 10
send ^{%A_thishotkey%} ;adds the CTRL key and re-presses the key you just pressed. now that you are in the program monitor, this shortcut will work.
;If there was a way to return focus to the panel you were on before this script was run, I would include that step here. But there's not.... i don't have 2 way communication all the time....
}
else
{
theKey = %A_thishotkey%
StringReplace, theKey, theKey, numpadAdd, {+} ;without curly brakets, this sends a SHIFT instead!
StringReplace, theKey, theKey, numpadSub, -
StringReplace, theKey, theKey, numpadEnter, {enter}
StringReplace, theKey, theKey, sc11C, {enter}
send %theKey%
;tooltip, normal key sent

}
;tooltip, all of my wut
}
*/





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



^!+F2::msgbox, yes, the 2nd keyboard script is still running.

; #ifwinactive
; F16::
; sleep 1000
; sendinput {SC061}
; tooltip, YEAH
; sleep 100
; tooltip,
; return


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

InstantExplorer(f_path)
{
f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable.
;msgbox, f_path is %f_path%
SoundBeep, 900, 400
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
else if f_class in ExploreWClass,CabinetWClass  ; In Explorer, switch folders.
{
	msgbox, f_class is %f_class% and f_window_ID is %f_window_id%
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		tippy("EXPLORER WITH EDIT1 only 2 lines of code here....", 1000)
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		msgbox, set text happened
		; Tekl reported the following: "If I want to change to Folder L:\folder
		; then the addressbar shows http://www.L:\folder.com. To solve this,
		; I added a {right} before {Enter}":
		ControlSend, Edit1, {Right}{Enter}, ahk_id %f_window_id%
		return
	}
	; else fall through to the bottom of the subroutine to take standard action.
}
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
tippy("end was reached.",1000)
SoundBeep, 800, 300
; Run, Explorer %f_path%  ; Might work on more systems without double quotes.
Run, %f_path%  ; I got rid of the "Explorer" part because it caused redundant windows to be opened, rather than just switching to the existing window
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

