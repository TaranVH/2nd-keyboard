SetWorkingDir, C:\AHK\2nd-keyboard\support_files
;the above will set A_WorkingDir. It must be done in the autoexecute area.
;SetNumLockState, on ;This doesn't work, needs to be done in admin mode.
;SetScrollLockState, off
Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something
;when you get to #include, it means the END of the autoexecute section.
;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the line below:

global savedCLASS = "ahk_class Notepad++"
global savedEXE = "notepad++.exe" ;BEFORE the #include is apparently the only place these can go.


#Include C:\AHK\2nd-keyboard\gui.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk

;-------------------------------------------------------------------------
; HELLO PEOPLES 
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
;
; IF YOU HAVE NOT USED AHK BEFORE, YOU MUST TAKE THIS TUTORIAL:
;  https://autohotkey.com/docs/Tutorial.htm
;
; IMPORTANT NOTE:
; Using #include is pretty much the same as pasting an entire script into 
; THIS script. So basically, I'm just importing all the functions that I
; have created in those scripts, so that I can refer to them here.
;
; So, this script has all the keyboard assignments, and the other
; #included scripts have all the functions. I had to split it up this way 
; so that I can also directly launch those functions using means OTHER
; than a keyboard, like the Stream Deck's "open file" feature.
;
; ANOTHER NOTE:
; If you have CUE (Corsair Utility Engine) open, and your keyboard selected 
; (in all its RGB glory,) it will take a lot longer to switch between applications. 
; to fix this lag, simply close CUE, or select some other "demo" peripheral.
;------------------------------------------------------------------------
;
;THIS SCRIPT NO LONGER USES LUAMACROS TO REPROGRAM THE SECOND KEYBOARD. IF YOU WANT THAT CODE, PLEASE GO TO "2nd keyboard if using luamacros.ahk"
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; WATCH THESE VIDEOS TO UNDERSTAND YOUR OPTIONS FOR ADDING EXTRA KEYBOARDS:
; https://www.youtube.com/playlist?list=PLH1gH0v9E3ruYrNyRbHhDe6XDfw4sZdZr
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

; Also, I will put shortcuts to all the AHK scripts that I use into my startup folder... which will be here:
;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;  and\or here:
;  C:\Users\[YOUR_USERNAME]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup


#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
detecthiddenwindows, on

SetNumLockState, AlwaysOn ;i think this only works if launched as admin.



;____________________________________________________________________________
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
;-----------------------------------------------------------------------------
; ctrl alt s                     select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
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
;_______________________________________________________________________________________________


;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING INTERCEPTOR (Logitech K120)  
;____________________________________________________________________
;please watch https://www.youtube.com/watch?v=y3e_ri-vOIo if you need help.
;DANGER: installing interception may cause your USB devices to stop working sometimes, because it is limited to supporting only 10 of each device class. You have to uninstall it to fix that. Here is a follow up video with new information: https://www.youtube.com/watch?v=Hn18vv--sFY


;#if ( \\\\\\\\\\\\\\\getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.


;;;;;;;;;;;;;BEGIN K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS;;;;;;;;;;;;;;;;;
#if (getKeyState("F23", "P")) ;THIS is the line that makes all the lines below, possible.


F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.
;;also, you must NEVER use F23 for anything else. Doing so will sometimes allow and F23 keystroke to pass through unwrapped, which can cause big problems with cross-talk.

;SC06E::return ;;This is F23's scan code. Using this line acts as some insurance against cross-talk. comment this in if you have issues.


;Keep in mind, these use the CTRL modifier, as indicated by the ^
~^numpad1::
Keyshower("add marker color 1 (taran mod)")
marker()
send !{numpad1}
return

;I converted the "numpad5" key on the 2nd keyboard into a CTRL key, by using intercept. All my keyboard bindings can be found in: keyremap.ini

;intercept converted this the numlock key into a harmless numpad5.
~^numpad5::
Keyshower("add marker color 2 (taran mod)")
marker()
send !{numpad2}
return

~^numpadmult::
Keyshower("add marker color 3 (taran mod)")
marker()
send !{numpad3}
return

~^numpad3::
Keyshower("add marker color 4 (taran mod)")
marker()
send !{numpad4}
return

~^numpad7::
Keyshower("add marker color 5 (taran mod)")
marker()
send !{numpad5}
return

~^numpaddiv::
Keyshower("add marker color 6 (taran mod)")
marker()
send !{numpad6}
return

~^numpad0::
Keyshower("add marker color 7 (taran mod)")
marker()
send !{numpad7}
return

~^numpad9::
Keyshower("add marker color 8 (taran mod)")
marker()
send !{numpad8}
return


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
F12::search() ;"search" is also used on ^+j 
; F12 must not used here IF it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;

`::msgbox tilde or weird quote thing??
1::insertSFX("bleep")
2::
3::
4::
5::insertSFX("")
6::insertSFX("record scratch")
7::preset("180 hue angle")
8::preset("PAINT WHITE")
9::preset("PAINT BLACK")
0::insertSFX("pop")
-::audioMonoMaker("left")
=::audioMonoMaker("right")
backspace::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\cutting_room_floor")

;;;;;next line;;;;;;;;

tab::msgbox,,, you pressed tab. :P,0.8

;This was the old code, before I realized I can just use A_thishotkey and assign all of them at once!!
; q::recallClipboard("q")
; w::recallClipboard("w")
; e::recallClipboard("e")
q::preset("T wipe straight 135")
w::preset("T wipe straight 225")

e::preset("T wipe soft 135")
r::preset("T wipe soft 225")

+q::preset("T wipe WHITE LINE 135")
+w::preset("T wipe WHITE LINE 225")

+e::preset("T wipe exposure 135")
+r::preset("T wipe exposure 225")

;t::preset("T wipe WHITE LINE 315")
t::recallClipboard("t")
+t::saveClipboard("t")

;;;still need to improve and fix the clipboard scriptypoo
;;t::recallClipboard(A_thishotkey)
;;+t::saveClipboard(A_thishotkey)

y::preset("autogate -25")
u::preset("red red red")
i::preset("multiply")
o::preset("flip vertical")
p::preset("flip horizontal")
[::preset("T impact flash MED")
]::preset("T Impact Pop")
\::
instantExplorer("Z:\Linus\9 - Tools\1-Sound Effects")
sleep 20
search() ;immediately highlights the search bar so you can search for a sound effect. Sadly this does not always seem to work...
sleep 250
search()
return

;;;;;next line;;;;;;;;

; capslock::msgbox, , ,i hate capslock!, 1000
capslock::capslock

a::preset("T wipe straight 45")
s::preset("T wipe straight 315")

d::preset("T wipe soft 45")
f::preset("T wipe soft 315")

+a::preset("T wipe WHITE LINE 45")
+s::preset("T wipe WHITE LINE 315")

+d::preset("T wipe exposure 45")
+f::preset("T wipe exposure 315")



;g::recallClipboard(A_thishotkey)
;+g::saveClipboard(A_thishotkey)

g::preset("mosaic preset")
h::preset("invert preset")
j::preset("fast zoom")
k::preset("100 to 120 zoom")
l::preset("25% blur and darkener")
`;::preset("blur with edges") ;lol, it's not a comment until here -- the syntax highlighting gets this one wrong.
'::preset("Warp Stabilizer Preset")
enter::enter

;;;;;next line;;;;;;;;

Lshift::Lshift
;;msgbox, , ,you pressed Left shift - you should never see this message if you let it pass normally, 5
;now I use it as a modifier for some of the other numpad keys.
z::preset("T wipe soft down")
x::preset("T wipe soft up")
c::preset("T wipe soft left")
v::preset("T wipe soft right")
b::preset("Drop Shadow Preset")


n::preset("anchor and position to 0") ;no panning involved here.
m::preset("a0p0 pan down")
,::preset("crop 50 LEFT")
.::preset("crop 50 RIGHT")
/::preset("crop full")

;;;;;next area;;;;;;;;

;;Lctrl::msgbox LEFT ctrl ;this must be commented out for the sake of numpad5, which was converted into left ctrl.
;None of these modifiers should even happen, I have allowed modifiers to pass through normally.
Lwin::msgbox,,, LEFT win,0.5
Lalt::msgbox,,, LEFT alt,0.5

;Ralt::msgbox Ralt - doesnt work
;Rwin::msgbox Right Win - doesnt work
Rshift::instantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Music")
;SC061::instantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Music")
;msgbox RIGHT SHIFT lol

;SC06E::msgbox,,,this was right WINkey,0.5 ;;NEVER use super modifier keys in this way! bad idea!!! cross talk!!!!!
SC06F::msgbox,,,testing scan codes,0.5
SC062::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations\~CANNED PRE ROLLS") ;remapped away from appskey, it seemed to cause problems.

Rctrl::preset("50% stereo")
space::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations")
;SC065::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~ For Review") ;this is remapped from ALT. JK, SC065 is F14, do not use.
appskey::msgbox, this is the right click appskey KEY I guess

; PrintScreen::InstantExplorer("Z:\Linus\Team_Documents\TARAN THINGS")
PrintScreen::
IfWinNotExist, ahk_class TvnWindowClass
	Run, C:\Program Files\TightVNC\tvnviewer.exe
if WinExist("ahk_exe tvnviewer.exe")
	WinActivate ahk_exe tvnviewer.exe
return

ScrollLock::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7
;pause::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery")
;numlock::msgbox, hello again
SC061::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7

CtrlBreak::msgbox, CTRL BREAK - maybe the default output of the pause/break key??
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key?? WHAT CAN I BELEVE ANYMORE??

pgdn::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Pending")
end::InstantExplorer("Z:\Linus\5. Fast As Possible\1. Pending")
delete::InstantExplorer("Z:\Linus\6. Channel Super Fun")

pgup::InstantExplorer("N:\Linus Tech Tips")
home::InstantExplorer("N:\Fast As Possible") ;runexplorer("N:\Fast As Possible")
insert::InstantExplorer("N:\Channel Super Fun")

up::preset("push up")
down::preset("push down")
left::preset("push left")
right::preset("push right")

;;;;;next area;;;;;;;;

numpad0::SendKey("numpad0", , "sky blue")
numpad1::SendKey(A_thishotkey, ,"blue-green")
numpad2::SendKey(A_thishotkey, ,"nudge down")
numpad3::
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	SendKey(A_thishotkey, ,"orange")
if WinActive("ahk_exe chrome.exe")
	sendinput, ^+{tab} ;go to previous tab in chrome
return

numpad4::SendKey(A_thishotkey, ,"nudge left")
numpad5::msgbox, this text should never appear. I have remapped numpad5 to "left ctrl" in interceptor. scan code 1d,0,0.
numpad6::SendKey(A_thishotkey, ,"nudge right")
numpad7::SendKey(A_thishotkey, ,"purple")
numpad8::SendKey(A_thishotkey, ,"nudge up")
numpad9::SendKey(A_thishotkey, ,"dark green")

+numlock::msgbox, "shift numlock"
numlock::
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	{
	tippy("numlock")
	SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
	}
else
	search()
return

numpadDiv::SendKey("numpadDiv", ,"clip blue")
numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::openApp("ahk_class AU3Reveal", "AU3_Spy.exe", "Active Window Info") ;msgbox, , , num minus, 0.5
; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe") ;msgbox, , , num ADD, 0.5
numpadAdd::openApp("ahk_class Notepad++", "notepad++.exe") ;msgbox, , , num ADD, 0.5
numpadEnter::switchToChrome()


numpadDot::openApp("ahk_class Photoshop", "Photoshop.exe") ;msgbox, , , num dot, 0.5

/*
;These are now unused - I realized that keeping them as modifiers (allowing them to pass through normally) is more valuable then as single keys.
SC060::msgbox sc060, which I have assigned from LEFT SHIFT using intercept.exe
SC061::msgbox sc061, right shift
SC062::msgbox sc062, L CTRL
SC063::msgbox sc063, L WIN
SC064::msgbox sc064, L ALT
*/
; SC065::msgbox sc065, R ALT ;;;of is this F14? IDK
; SC066::msgbox sc066, R WIN
; SC067::msgbox sc067, R CTRL


SC045::msgbox sc045... pause/break, but MAYBE numlock???

;scancode scan code information
SC07F::msgbox sc7F is as high as I could go, after 80 they become unusable for some reason.
SC080::msgbox sc080... this does not register.
SC0FF::msgbox sc0FF ...this does not register.

#if
#IfWinActive

;____________END OF K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS____________


#IfWinActive

; !F2::
; openApp("ahk_class ConsoleWindowClass", "C:\Users\TaranWORK\Downloads\Intercept - use this one\intercept.exe")
; openApp("ahk_class ConsoleWindowClass", "intercept.exe")
; ;must have both of these or it wont work.
; sleep 100
; ;send y
; return


;experimenting with scan codes. here is a list of blank ones.
;https://developer.mozilla.org/en/docs/Web/API/KeyboardEvent/code
; #if (getKeyState("F1", "P"))
; F1::return 

;IN HERE, WE ARE SENDING THE FIRST SCANCODE KEYSTOKES. win key assignemtns will recieve.

#ifwinactive

; F10::sendinput, {F14} ;scancode 065 but firefox says 9C - maybe is in hex.
; F11::
; tooltip, yeah 05A
; sleep 500
; sendinput, {SC05A} ;just after F23, but is not F24.
; tooltip,
; return
; 2::sendinput {SC05B} ;just before F13
; 3::send {SC05E}
; 4::send {SC05F}
; 5::send {SC060}
; 6::sendinput {SC061}
; 7::sendinput {SC037} ;numpadmultiply
; 8::sendinput {SC038} ;alt left (lol)
; 9::sendinput {SC06A}
; 0::sendinput {SC06B}
;***************
;{SC0E8} is taken by one of my own scripts.*****



#if

;scan code scancodes information
;according to https://msdn.microsoft.com/en-us/library/aa299374(v=vs.60).aspx it only goes up to 53
;but SC076 is f24 apparently?
/*
SC159:: ; Replace 159 with your key's value.
MsgBox, %A_ThisHotKey% was pressed.
return

*/

;3RD KEYBOARD CODE WAS HERE (was actually just a shitty numpad) - used F22 - but has been replaced with the stream deck.



;; https://autohotkey.com/board/topic/53346-explorer-view-mode/
; GroupAdd, Explorer, ahk_class CabinetWClass
; GroupAdd, Explorer, ahk_class ExploreWClass
; #IfWinActive, ahk_group Explorer




/*
;~~~~~~~~~JELLY COMB NUMPAD USING F21~~~~~~~~~~~
;#if (getKeyState("F21", "P") and If WinActive("ahk_exe Adobe Premiere Pro.exe"))
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

numpad3::sortExplorerByName()

numpad6::sortExplorerByDate()

numpad5::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	{
	ExplorerViewChange_ICONS(exphWnd)
	}
return

numpad4::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	{
	ExplorerViewChange_Window(exphWnd)
	}
return

numpad7::instantexplorer("C:\AHK\2nd-keyboard") 
numpad8::instantexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
Numpad9::instantexplorer("C:\Users\TaranWORK\Videos\Desktop") ;shadowplay folder opener

NumpadDiv::
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field in explorer
;msgbox,,, 4th keyboard %A_thishotkey%,0.6
return

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

NumpadEnter::msgbox,,, numpad F21 enter,0.3

numpadMult::instantexplorer("C:\Users\TaranWORK\Videos\Base Profile")


NumpadDot::
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	send !p ;choose poster frame shortcut in Premiere
return

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
	{
	msgbox,,, you pressed the equals key!,1
	; ;InputBox, password, Enter Password, (your input will be hidden), hide 
	; InputBox, UserInput, Phone Number, Please confirm murdering of premiere, , 640, 480
	; if UserInput = "="
		; {
		; MsgBox, You entered "%UserInput%"
		; Run, %comspec% /c "taskkill.exe /F /IM Adobe Premiere Pro.exe",, hide 
		; }	
	; else***
		; return
	}
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
#if
*/
;________________END OF 4TH KEYBOARD OVERALL______________________


	
	
;BEGIN secondary layer of main keyboard, using CAPSLOCK remapped to F20
#if (getKeyState("F20", "P"))
F20::return 

escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9
F1::send ^+{pgup}
F2::send ^+{pgdn} ;for firefox tab moving
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::return

`::tooltip, llllll
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
backspace::return

;;;;;next line;;;;;;;;

tab::msgbox,,, you pressed tab. :P,0.8

q::
w::
e::
r::
t::
y::
u::
i::
o::
p::
[::
]::
\::return
capslock::msgbox, , ,you should not ever see this text, 1000

a::tooltip,fancy A
s::tooltip,fancy S
d::tooltip,fancy D
f::
g::
h::
j::
k::
l::
`;::
'::
;;;;;next line;;;;;;;;

Lshift::return
z::
x::
c::
v::
b::return
n::
m::
,::
.::
/::return
Lwin::msgbox, LEFT win
Lalt::msgbox, LEFT alt
space::tooltip,
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol
; SC06E::msgbox,,,right WINkey,0.5
;;terrible idea to use F23 for that. Must never use super function keys for modifier key remapping. (super = F23 and up)
SC06F::msgbox,,,SC06F,0.5
SC062::msgbox,,,SC062,0.5
Rctrl::msgbox,,,Rctrlll,0.5
appskey::msgbox, this is the appskey KEY I guess

;these were all formerly runExplorer()
PrintScreen::
ScrollLock::return
SC061::msgbox, scancode061
CtrlBreak::msgbox, CTRL BREAK?
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key???

pgdn::
end::
delete::
pgup::
home::
insert::

up::
down::
left::
right::

;;;;;next area;;;;;;;;

numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::

+numlock::
numlock::
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::return
numpadDot::
/*
;These are now unused - I realized that keeping them as modifiers (allowing them to pass through normally) is more valuable then as single keys.
SC060::msgbox sc060, which I have assigned from LEFT SHIFT using intercept.exe
SC061::msgbox sc061, right shift
SC062::msgbox sc062, L CTRL
SC063::msgbox sc063, L WIN
SC064::msgbox sc064, L ALT
*/
#if				
;_________________end fake 5th keyboard with capslock remapped to F20__________________

				
		
#IfWinActive
 

;BEGIN KEYBOARD 4, FULL AZIO KEYBOARD
#if (getKeyState("F24", "P")) ;and WinActive("ahk_exe Adobe Premiere Pro.exe") ;; bad idea to have the "and [something]", this means the keyboard behaves normally, any time you are NOT in Premiere...
F24::return ;F24

escape::
msgbox,,,you pressed escape. this might cause like problems maybe,0.9
tooltip, 
return
F1::tooltip, Yes hello
F2::tooltip,
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::tooltip, you pressed  %A_thishotkey%

`::tooltip, 22222
1::gotofiretab("AHK needed","https://docs.google.com/document/d/1xsjjKYggXYig_4lfBMJ6LDGRZ9VOvDd7SCSTSi7GwN8/edit")
2::gotofiretab("LTT note","https://docs.google.com/document/d/1CWjC7DWyXGIFDaSwXzUsdHmdktvgV0kdgNOFEK7wf7U/edit")
3::
4::
5::
6::tooltip, you pressed  %A_thishotkey%
7::
8::
9::
0::
-::
=::tooltip, you pressed  %A_thishotkey%
backspace::send, ^+!r

;;;;;next line;;;;;;;;

; tab::msgbox,,, you pressed tab. :P,0.8
;VIDEO TRACKER
tab::
gotofiretab("Video Tracker LTT - Google","https://docs.google.com/spreadsheets/d/1FmuWOCKHxZbxS5XbwpVDP4M27BjTAJJ67B0yoSXUN9k/edit#gid=0")
; WinActivate ahk_exe firefox.exe
; sleep 10
; WinGet, the_current_id, ID, A
; vRet := JEE_FirefoxFocusTabByName(the_current_id, "Video Tracker LTT - Google")
; ;tooltip, vret is %vRet%
; if (vRet = 0)
	; run, firefox.exe https://docs.google.com/spreadsheets/d/1FmuWOCKHxZbxS5XbwpVDP4M27BjTAJJ67B0yoSXUN9k/edit#gid=0
return

q::
w:: ;sendinput, +{F12}^w
e::
r::
t::
y::
u::
i::
o::
p::
[::
]::tooltip, you pressed  %A_thishotkey%
\::run, C:\Program Files (x86)\Corsair\Corsair Utility Engine\CUE.exe


;CAPSLOCK IS TRELLO
capslock::gotofiretab("Production Planner | Trello","https://trello.com/b/NevTOux8/ltt-production-planner")

;remapped from left shift. CALENDAR
; SC060::gotofiretab("Linus Media Group Inc. – Calendar","https://calendar.google.com/calendar/b/0/r")
SC060::gotofiretab("2018","https://calendar.google.com/calendar/b/0/r")

;; ask about URLs: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114


;FROM LEFT CTRL. INBOX
SC062::gotofiretab("Linus Media Group Inc. Mail","https://mail.google.com/mail/u/0/#inbox")
;or a tab that says "says..."
a::recallClipboard("a")
+a::saveClipboard("a")
s::recallClipboard("s")
+s::saveClipboard("s")
d::recallClipboard("d")
+d::saveClipboard("d")
f::recallClipboard("f")
+f::saveClipboard("f")
g::
h::
j::
k::
l::tooltip, you pressed  %A_thishotkey%
`;::
'::send, ^+!, ;this is the premiere shortcut for "show audio keyframes" (on timeline)
enter::
if WinActive("ahk_class Premiere Pro")
	{
	prFocus("timeline")
	sleep 10
	sendinput, ^!+n ;toggle audio names
	}
return


;;;;;next line;;;;;;;;

Lshift::tooltip, you pressed  %A_thishotkey%
z::
if WinActive("ahk_class Premiere Pro")
	send ^+6 ;track targeting presets in premiere.
return
x::
if WinActive("ahk_class Premiere Pro")
	send ^+7 ;track targeting presets in premiere.
return
c::
if WinActive("ahk_class Premiere Pro")
	send ^+8 ;track targeting presets in premiere.
return
v::
if WinActive("ahk_class Premiere Pro")
	send ^+9 ;track targeting presets in premiere.
return
b::
if WinActive("ahk_class Premiere Pro")
	send ^+0 ;IDK
return
n::
if WinActive("ahk_class Premiere Pro")
	send ^+- ;IDK
return

m::send, ^r ;in premiere, the Speed/duration panel
,::send, ^+m ;in premiere, Time interpolation > Frame sampling
.::send, ^+k ;in premiere, Time interpolation > Frame blending
/::send, ^+o ;in premiere, Time interpolation > optical flow
;these should perhaps highlight the timeline first...

;l control    Linus Media Group Inc. Mail

Lwin::msgbox, LEFT win. ;but this won't happen, it was swapped with another key...

;Lalt has been remapped to SC064, which is F13.
;NOTE that this can interfere with normal F13 keypresses elsewhere in this script...
; SC064::
; IfWinNotExist, ahk_exe Adobe Media Encoder.exe
	; run, C:\Program Files\Adobe\Adobe Media Encoder CC 2017\Adobe Media Encoder.exe ;ahk_exe Adobe Media Encoder.exe
; if WinExist("ahk_exe Adobe Media Encoder.exe")
	; WinActivate ahk_exe Adobe Media Encoder.exe
; ;tooltip, ran ME
; return



space::tooltip,
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol

SC06F::msgbox,,,SC06F,0.5
;SC062::msgbox,,,SC062 aka APPSKEY,0.5 ;for some reason, might open last active window...

; SC063::msgbox,,,SC063 was previously LWIN,0.5
SC063::
;msgbox,,,sc063,0.5
;msgbox,,, trying to open VNC,0.5
IfWinNotExist, ahk_class TvnWindowClass
	Run, C:\Program Files\TightVNC\tvnviewer.exe
if WinExist("ahk_exe tvnviewer.exe")
	WinActivate ahk_exe tvnviewer.exe
return
;F14::msgbox,,, wtf is this doing here???,0.6
appskey::msgbox, this is the appskey KEY maybe
SC05A::msgbox,,, was remapped from ALT. now SC05A,0.5
Rctrl::tooltip, rctrl
PrintScreen::
ScrollLock::return
SC061::msgbox,,, scancode061,1
CtrlBreak::msgbox, CTRL BREAK?
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key???

pgdn::tooltip, you pressed  %A_thishotkey%
end::tooltip, you pressed  %A_thishotkey%
delete::sendinput, ^!+j ;lock/unlock all audio tracks
pgup::tooltip, you pressed  %A_thishotkey%
home::tooltip, you pressed  %A_thishotkey%
insert::sendinput, ^!+l ;lock/unlock all video tracks

up::
tooltip, uppp
WinGetPos,,, Width, Height, A
WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
return

down::
left::
right::tooltip, you pressed  %A_thishotkey%

;;;;;next area;;;;;;;;

numpad0::
if WinActive("ahk_class Premiere Pro")
	sendinput, ^!+9 ;activate lumetri scopes
return

numpad1::monitorKeys("source","^!+[",0) ;Safe margins (source monitor)

numpad2::monitorKeys("program","^!+]",0)  ;safe margins (program monitor)

;WE ARE STILL INSIDE THE AZIO KEYBOARD

numpad3::return

numpad4::monitorKeys("source","^{numpad1}") ;source monitor res to 1/1

numpad5::monitorKeys("program","^+1") ;program monitor resolution to 1/1

numpad6::tooltip, you pressed  %A_thishotkey%

numpad7::monitorKeys("source","^{numpad5}") ;source monitor res to 1/2. ^{numpad2} does not work because CTRL SHIFT ALT 2 is the shortcut for the source monitor. cross talk.

numpad8::monitorKeys("program","^+2") ;program monitor res to 1/2

numpad9::tooltip, you pressed  %A_thishotkey%

;+numlock::
numlock::monitorKeys("source","^{numpad3}") ;source monitor res to 1/4

numpadDiv::monitorKeys("program","^+3") ;program monitor res to 1/4

numpadMult::send, +`` ;premiere shortcut for "Maximize (program?) Monitor"
numpadSub::tooltip, you pressed  %A_thishotkey%
numpadAdd::sendinput, ^!{F10}
numpadEnter::sendinput, ^!m ;mute/unmute mic - shadowplay ;unfortunately ctrl alt m is also NEW COMMENT in google sheets... i might wish to change it

numpadDot::tooltip, you pressed  %A_thishotkey%
/*
;These are now unused - I realized that keeping them as modifiers (allowing them to pass through normally) is more valuable then as single keys.
SC060::msgbox sc060, which I have assigned from LEFT SHIFT using intercept.exe
SC061::msgbox sc061, right shift
SC062::msgbox sc062, L CTRL
SC063::msgbox sc063, L WIN
SC064::msgbox sc064, L ALT
*/

SC070::msgbox,,, SC070 - "Keyboard intl 2 INSIDE OF F24", 0.5

#if
;END OF FULL AZIO KEYBOARD





;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------

;------------


;okay, so these keys MUST be AFTER the intercept.exe launched keys, otherwise BOTH scripts will be called, which is bad. IDK why, but putting them down here fixes the problem.
;addendum: if #IfWinActive ahk_exe explorer.exe is BEFORE the 2nd keybaord code, it executes all by itself. So yeah, the secondary keybaords must be before all else.


; ____________________________________________________________________ 
;|                                                                    |
;|        PRIMARY KEYBOARD, (Corsair K95 RGB) AHK KEY ASSIGNMENTS     |
;|____________________________________________________________________|


;;;~~~~~~FUNCTION KEYS IN VARIOUS PROGRAMS~~~~

#IfWinActive ahk_class MozillaWindowClass ;or ahk_class Chrome_WidgetWin_1
!F1::send ^+{pgup}
!F2::send ^+{pgdn}
; F2 & f20::send ^+{pgdn}

F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab


F3::send ^w ;control w, which closes a tab
F4::send {mButton} ; middle mouse button, which opens a link in a new tab.



#IfWinActive

#IfWinActive ahk_class Chrome_WidgetWin_1
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w ;control w, which closes a tab
F4::send {mButton} ; middle mouse button, which opens a link in a new tab.

#IfWinActive ahk_exe notepad++.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 
F4::F2 ;this is to regain what I lost when I used F2 and F3 for tab navigation.

#IfWinActive ahk_exe Photoshop.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; ;RIP Monty Oum https://youtu.be/qSuTnCFqMkw?t=1m21s
; #IfWinActive ahk_exe Photoshop.exe
; F1::sendinput {alt down}iac{alt up}


#IfWinActive, ahk_group ExplorerGroup ;this does not work...
; ctrl L, alt D, or F4 will highlight the address bar. But in different ways..?
;IDK if I need this script at all anymore.
^+!d::
sleep 10
Sendinput !d
sleep 10
return


;;;;;;;;;;;;;;EXPLORER SHORTCUTS;;;;;;;;;;;;;;;;;
; #IfWinActive, ahk_class #32770 ahk_exe Adobe Premiere Pro.exe ;this is specifically premiere's save/load dialoge.

#if WinActive("ahk_class #32770") and WinActive("ahk_exe ShareX.exe") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Sendinput, !{up} ; go DOWN one folder level in explorer


; left & right::msgbox, hello
#if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save Project") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Sendinput, !{up} ; go DOWN one folder level in explorer


#if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save As") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Send !{up} ; go DOWN one folder level in explorer


+`::Send !{left} ;shift tilde will go "back" in explorer

~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field

home::
send {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...
tippy("sort Explorer by date")
return

#if


#if WinActive("ahk_class #32770") and WinActive("ahk_exe chrome.exe") ;An Explorer window as launched by Chrome
`::Send !{up} ;DOWN one folder level in explorer

#if WinActive("ahk_class #32770") and WinActive("ahk_exe firefox.exe") ;An Explorer window as launched by Firefox
`::Send !{up} ;DOWN one folder level in explorer



;------------------------------------------





#IfWinActive ahk_exe explorer.exe ;IDK if there is any meaningful difference for using the ahk_exe rather than the ahk_CLASS

;Oh, if you are on the desktop, the EXE is the same, but the class is not. So if you hit ALT F4, you go into the shutdown menu. Not good. So i think the class is a better indicator that you are, specifically, in an Explorer WINDOW.






#IfWinActive, ahk_class CabinetWClass ;this is also explorer
F3::
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return
;this converts F3 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.


;The script below worked fine 99% of the time. But if you have a FILE selected, and that file has a preview thingy showing, it would NOT work -- instead, it would highlight the menu accleration. Sad!! Manually hitting ALT UP  would still work in that situation, though.
;After some experimentation, I discovered that adding a small delay between virtual keystrokes is essential for this to work in those situations.

;`::Send !{up} ;go DOWN one folder level in explorer. Discontinued.

`::
Sendinput, {alt Down}
sleep 5
sendinput, {up} ; this is the up arrow key ; ALT+UP will go down(or "up?") one folder level in explorer
sleep 5
Sendinput, {alt Up} ;this is just the virtual ALT keystroke going up.
return


+`::Send !{left} ;shift tilde will go "back" in explorer

~left & right::
;msgbox,,, hellllllo,0.5
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field - very useful!!
return

home::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_Window(exphWnd) ;list mode
return


end::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_ICONS(exphWnd)
return


;these are not very reliable, I have been REALLY trying to get a direct execution of this command. might need C++ for that, IDK.
pgup::send, {alt}vo{enter} ;sort by name
pgdn::send, {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...

;+++++++++ SHORTCUTS THAT WORK IN ALL PROGRAMS +++++++++
#IfWinActive

;;shortcut to CLOSE FIREFOX with no bullshit or fanfare or annoying dialouge boxes that try to argue with you. Just completely nuke it from orbit so we can start over
^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide


;shortcut to forcefully CLOSE PREMIERE ALREADY, WITH NO BULLSHIT. BULLDOZE IT FLAT, BURN IT, SALT THE EATH, NUKE IT FROM ORBIT. JUST FUCKING DIE!!!
;This doesn't work. Might need C++ for this...
^!+p::
Run, %comspec% /c "taskkill.exe /IM /Adobe Premiere Pro.exe /T /F" ;,, hide
sleep 100
;Run, %comspec% /c "taskkill.exe /F /PID 72536",, hide
tooltip, killed premiere
sleep 100
tooltip,
return

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;-----BEGIN FUNCTION KEYS PAIRED WITH CTRL --------
;;---These are mostly application switching keys.---
#IfWinActive

;Macro key G13
;F13:: ;it's more reliable to use the scan code, i guess? Maybe because I used "F13::" elsewhere.
SC064::back()

;macro key G16
^F1::switchToFirefox()
+^F1::switchToOtherFirefoxWindow() ;^+F1 ^+{F1}

;macro key G17
^F2::switchToExplorer()
!^F2::closeAllExplorers()

;macro key G18
^F3::switchToPremiere()

;macro key G15
^F4::switchToWord()
+^F4::switchWordWindow() ; AKA, ^+F4 ^+{F4}

;No K95 macro key assigned:
^F5::switchToChrome()
;also, CTRL works a little funny when the function uses CTRL TAB to switch tabs. This might be better assigned to ALT F5 or something.

;macro key G14
+^F6::
windowSaver()
msgbox,,, savedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%, 0.6
Return

;Macro key G14
^F6::
;I had to learn just now to use the parameter to pass "savedCLASS" even though it's already a global variable. Just works better this way... but really IDK what i am doing.
;msgbox,,, switching to `nsavedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%,0.3
switchToSavedApp(savedCLASS) 
return

;No K95 macro key assigned:
^F9::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.
^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")

; ^F11 is taken by filemover.ahk
; ^F12 is also taken by filemover.ahk
;NOTE: ^F12 (ctrl F12) is forbidden by Premiere, since it opens the Premiere CONSOLE. interesting.

;;------END OF CTRL FUNCITON KEYS----------

#IfWinActive
;winkey Z opens the CLOCK / CALENDAR. ;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#z::
Send #b{left}{left}{enter}
Return

#IfWinActive
Joy1::msgbox you hit Joy1
Joy2::msgbox you hit Joy2
Joy3::msgbox you hit Joy3
;I could never get any of these working

#ifWinActive
!,::msgbox, A_workingDir should be %A_WorkingDir%
!.::msgbox, TaranDir should be %TaranDir%
Xbutton1::return
Xbutton2::return ;these are both on the side of my mouse and I don't like accidentally hitting them.


;-----BEGIN ASSIGNMENT OF ALL 18 K95 MACRO KEYS--------

#IfWinActive
;macro key G1 on K95. universal SEARCH EVERYTHINGER
; this used to have a ~ to let it pass through... not sure why. it was creating an ENTER keypress effect in notepad++ so i removed it.
^+J::search()


#ifWinActive
;MACRO KEY G2 on the K95
^numpad0::
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	easeInAndOut()
else
	return ;for now, this key does nothing in other applications
return


;~^+K::preset("Warp Stabilizer Preset") ;macro key G2 used to be the stabilizer preset.
;~^+=::effectsPanelType("presets") ;this WAS macro key G3. ;Types in "presets," which reveals my own entire list of presets. ;;I have canceled this one in favor of a global pause/play.

#ifWinActive
;macro key G3
^+L::stopPlaying()
;Outside of premiere, it will STILL work to pause/play the timeline, due to some other code somewhere else...
;;NOTE that this shows up also as a huge bit of script when premiere is NOT in focus, must be moved to All Premiere Functions.

#ifWinActive ahk_exe Adobe Premiere Pro.exe
;macro key G4.
~^+,::audioMonoMaker("left")
; macro key G5.
~^+.::audioMonoMaker("right")

#ifWinNotActive ahk_exe Adobe Premiere Pro.exe
;macro key G4.
~^+,::msgbox,,,Macro G4 not yet assigned outside premiere,0.7
; macro key G5.
~^+.::msgbox,,,Macro G5 not yet assigned outside premiere,0.7

#IfWinActive 
;Macro key G6
~^+U::reSelect() ;formerly ^+9

/*

G7:  F17 - rotation
G8:  F19 - V1 A1 locker
G9:  ctrl shift ] - add 7 gain
G10: F18 - Horizontal Anchor
G11: F15 - Vertical Anchor
G12: F14 - Scale
*/

;;note to self - try to get this script here working
;Macro Key G12
#IfWinActive ahk_exe winword.exe
~F14::F2 ;F2 is set to "go to previous comment" in Word.
;;all the below code CANNOT work as long as there is ~VK7DSC065:: present. this needs to be done NOT with the # thingies. will improve this code later.
; tooltip, wat
; sendinput, {F2} ;set to "go to previous comment" in Word.
; ; IfWinExist, Microsoft Office Word, OK ;checks to see if the annoying "do you want to continue searching from the beginning of the document" dialouge box is present.
	; ; sendinput, {escape}
; return

;put selected text into a lengthend comment in premiere.
F12::
sendinput, ^a
sleep 80
sendinput, ^c
sleep 15
WinActivate ahk_class Premiere Pro
sleep 10
send, ^!d ;ctrl alt D is  "deselect all" (clips on the timeline)
sleep 20
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 20
send, ^`; ;CTRL SEMICOLON is my premiere shortcut for "(add) marker."
sleep 10
send, ^`; ;if you press it again, it opens that comment.
sleep 50
send, {left}
send, ^v ;pastes the text into the title area
sleep 10
;sleep 500
send, +{tab} ;shift tab will make it highlight the "duration" field
sleep 10
send, 00:00:04:00
sleep 10
send, {enter}
return

#IfWinActive
/*
See "Almost_All_Windows_Functions.ahk" for a much more complete explanation of the following macro key assignments

G13: "back" (varies per app)
G14: Activate Notepad++
G15: Activae Word
G16: Activate Firefox, then CTRL TAB on subsequent key presses.
G17: Activate Explorer, then browse through the windows on subsequent key presses
G18: Activate/switch to Premiere
*/


#IfWinActive ahK_exe Adobe Premiere Pro.exe
;TITLE BAR REMOVER
;;ctrl backslash is a nice shortcut in MACINTOSH Premiere for hiding the title bar. There is no Windows equivalent... unless you use autohotKey!
;;WARNING THOUGH - i think this script makes premiere less stable. I hardly use it...
;;https://jacKsautohotKeyblog.wordpress.com/2016/05/27/autohotKey-toggles-and-the-ternary-operator-beginning-hotKeys-part-18/
^\::
  If (toggle := !toggle)
    WinSet, Style, -0xC00000, A
  else
    WinSet, Style, +0xC00000, A
Return


#IfWinActive ahK_exe Adobe Premiere Pro.exe
;tab::7 ;"7" is set to enable/disable for now. just testing stuff
appskey::sendinput, ^!k ;in premiere, CTRL ALT K is "clear selected marker." You can't assign it DIRECTLY to appskey, so I do it here.
^w::closeTitler()
~+K::KbShortcutsFindBox()

;no longer used:
!]::preset("DeHummer Preset") ;This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

;Pressing ALT W will send CTRL ALT SHIFT W, which is set to "Trim Next Edit to Playhead" in Premiere. This is to get around Premiere's menu acceleration, and annoying warning noise. Otherwise, I could have just assigned these commands directly to ALT Q and ALT W.
!w::^!+w ;"Trim Next Edit to Playhead" (not RIPPLE trim.)
!q::^!+q ;"Trim Previous Edit to Playhead" (not RIPPLE trim.)


#IfWinActive ahK_exe Adobe Premiere Pro.exe

~^+]::Send {F2}7{enter} ;adds 7 gain.

; control shift r = reverse selected clip
^+r::Send ^r{tab}{tab}{space}{enter}


#IfWinActive ahK_exe Adobe Premiere Pro.exe


;This script is to stop, rewind 3 seconds, and then play. Premiere's version of this SUCKS because it brings you bacK to where you started
; the ~ is only there so that the KeystroKe visualizer can see this Keypress. Otherwise, it should not be used.
;Lwin::
~!space::
Rwin::
Send s ;"stop" command (From JKL remapped to ASD.)
Send +{left}
Send +{left}
Send +{left}
sleep 10
Send d ;"shuttle right" command. Might be best to instead have it on a key combo that includes CTRL....
return

;;no longer used:
; control g = maKe 200% speed
;^g::
;Send ^r200{Enter}
;return
;;no longer used:
; control h = maKe 50% speed
;^h::
;Send ^r50{Enter}
;return


;----ALL STANDARD FUNCTION KEYS IN PREMIERE------

#IfWinActive ahk_exe Adobe Premiere Pro.exe
~F1::
Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
;Send ^c ;ctrl c is [copy] ;was just testing a thing for a guy.
Send ^+!d ;ctrl alt shift d  is [ripple delete]
return
;F2 is set in premiere to the [GAIN] panel.
;F3 is set in premiere to the [MODIFY CLIP] panel. 

#IfWinActive ahK_exe Adobe Premiere Pro.exe
;; instant cut at cursor (UPON KEY RELEASE)
~F4::
;keywait, F4
;tooltip, |
send, b ;blade tool
send, {shift down}
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton}
send, {shift up}
sleep 10
send, v ;selection tool
return
;;the code below turned out to not be necessary.
; F4 Up::
; ;tooltip, 
; send, {lbutton}
; send, {shift up}
; sleep 10
; send, v ;selection tool
; return

~F5::clickTransformIcon2()
~F6::cropClick()

#IfWinActive ahK_exe Adobe Premiere Pro.exe
;Disable single clip at cursor
~F7::
send, ^!d ;ctrl alt d is DESELECT
send, v ;selection tool
send, {alt down}
send, {lbutton}
send, {alt up}
send, {home} ;disable
return

#IfWinActive ahK_exe Adobe Premiere Pro.exe
;Delete single clip at cursor
~F8::
send, ^!d ;ctrl alt d is DESELECT
send, v ;selection tool
send, {alt down}
send, {lbutton}
send, {alt up}
send, c ;delete
return

~F9::masterClipSelect() ;this has not been fully programmed yet

;F10:: ;unused for now. Acts as a menu accelerator in Windows applications!! why the heck do they think they also need ALT, then???
;F11:: ;unused. "Full screen" in Firefox and chrome.
;F12:: ;unused. "Inspector" in Firefox and chrome.


;;**********************MEDIA KEYS IN PREMIERE**********************

;;the top rightmost keys on my K95.
Media_Stop::^numpad7
Media_Prev::^numpad8
Media_Play_Pause::^numpad9
Media_Next::^numpadMult
;Volume_Mute::^numpadDiv
;These are assigned to some of the new LABEL COLORS in premiere, using Premiere's own shortcut assignement panel.


;;^^^^^^^^^^PREMIERE SUPER FUCTION KEYS (F13 and up)^^^^^^^^^^^^^^^

#IfWinActive ahk_exe Adobe Premiere Pro.exe

;F13 - from macro key G13, "back" in windows mods script.

;~VK7DSC065:: ;Use this for F14 instead, if you have issues with cross-talk
~F14::
global VFXkey = "F14"
instantVFX("scale")
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G11
~F15::
global VFXkey = "F15" ;the VFXkey variable has to be defined NOW. IDK why.
instantVFX("anchor_point_vertical")
return

;F16 is still available

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G7
~F17::
global VFXkey = "F17"
instantVFX("rotation")
return

;Macro key G10
~F18::
global VFXkey = "F18"
instantVFX("anchor_point")
return

;Macro key G8
~F19::tracklocker()
~+F19::tracklocker()

#IfWinActive

+capslock::capslock ;only SHIFT CAPSLOCK will now turn on capslock, freeing the real capslock key to be used as a MODIFIER KEY, just like CTRL.
+F20::capslock ;because I actually used my Corsair keyboard to remap capslock to F20 DIRECTLY, this is the real line that I need to give myself the REAL capslock key.
capslock::F20 ;not needed if you can do it directly, with a Corsair keyboard

;F20 is triggered by capslock, and adds a 2nd layer to keyboard #1.
;F21 - Jelly comb 22 key numpad. will free this up later by using some other scan code
;F22 - FREE FOR NOW, PROBABLY
;F23 is for the 2nd keyboard, the Logitech K120. Will maintain for sake of tutorials.
;F24 (SC076) is the FULL AZIO KEYBOARD. ;F24 used to be used for LuaMacros.

;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
;There are still keys beyond F24! Check out my Table_of_all_scan_codes.xlsx for more information. Very useful to have those.
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

;Below here is a bunch of potentialy useful stuff, for future development. Some of it can be tirggered by my Corsair keyboard, and some of it cannot.
;note to self -- seriously need to standardize what  i am substituting for modifier keys here...

#IfWinActive
;VKEASC05C::tooltip, VirtualKey:EA ScanCode:05C
SC05C::tooltip, SC05C - "Keyboard Intl' 6"
SC05D::tooltip, SC05D - cannot find a corsair trigger
SC05E::tooltip, SC05E - cannot find a corsair trigger
SC05F::tooltip, SC05F - cannot find a corsair trigger

;SC060::tooltip, SC060 - cannot find a corsair trigger. Sub for Left shift??
SC061::tooltip, SC061 - cannot find a corsair trigger
;SC062::tooltip, SC062 - cannot find trigger ;but this is used from intercept.exe
SC063::tooltip, SC063 - cannot find a corsair trigger - Labeled as "Help"

; SC064 - F13
; SC065 - F14
; SC066 - F15
; SC067 - F16
; SC068 - F17
; SC069 - F18
; SC06A - F19
; SC06B - F20
; SC06C - F21
; SC06D - F22
; SC06E - F23

SC06F::tooltip,  SC06F - cannot find trigger

SC070::msgbox,,, SC070 - "Keyboard intl 2", 0.5

VKE9::msgbox,,, VKE9 ??? - "Keyboard Lang 2", 0.5 ;does not work from Corsair keyboard
;VKE9SC071::msgbox,,, VKE9 SC071 ??? - Keyboard Lang 2, 0.5 ;;this will not register as an allowed hotkey
SC071::msgbox,,, SC071 - "Keyboard Lang 2", 0.5 ;does not work from Corsair keyboard
SC072::msgbox,,, SC072 - "Keyboard Lang 1", 0.5 ;also does not work from Corsair keyboard
SC073::msgbox,,, SC073 - "Keyboard Intl' 1", 0.5 ; "Keyboard Intl' 1"

SC074::msgbox,,, SC074 - cannot find trigger, 0.5
SC075::msgbox,,, SC075 - cannot find trigger - this is just before SC076 which is F24, 0.5
;SC076::tooltip, this is F24
SC077::msgbox,,, SC077 - "Keyboard Lang 4", 0.5
SC078::msgbox,,, SC078 - "Keyboard Lang 3", 0.5
SC079::msgbox,,, SC079 - "Keyboard Intl' 4", 0.5

SC07A::tooltip, SC07A - cannot find trigger
SC07B::tooltip, SC07B - cannot find trigger
SC07C::tooltip, SC07C - cannot find trigger

SC07D::msgbox,,, SC07D - "Keyboard Intl' 3", 0.5
SC07E::tooltip, SC07E - "Brazillian `,"

SC07F::tooltip, SC07F - cannot find trigger

;After SC07F, Autohotkey seems to have trouble picking them up. Not sure why.



;;---------------------------------------------------



;+++++++++++++++++++++++++++++++
;macro for moving GOOGLE SHEETS' B-roll matrix information into WORD
#IfWinActive ;ahk_class MozillaWindowClass
#IfWinNotActive ahk_exe Adobe Premiere Pro.exe
;Macro key G12
F17::
sendinput, ^c
sleep 100
;WinActivate ahk_exe firefox.exe
; send ^{F4} ;shortcut for activate word, and if active, move to next comment.
; msgbox, EXTREMELY WEIRD - the above code would CLOSE THE TAB. IDK what kind of cross-talk was going on... will look into that later.
switchToWord()
sleep 100
send ^v
sleep 100
send {enter}
sleep 10
; send ^{F4} ;only use this line if switchToWord() is not directly available.
;;;;msgbox,,, just before,0.5
switchToWord()
sleep 10
;;;;msgbox,,, thingy is over,0.5
;WinActivate ahk_class MozillaWindowClass
;sometimes this code activates the paragraph thingy, which is CTRL SHIFT 8. will look for other cross talk.
return






#IfWinActive
;experiemntal thing to super duper checK window IDs...
!`::
WinGet, ActiveId, ID, A
msgbox, %ActiveId%
;returns 0x1c0b9c ... and only 3 unique codes for each of the 3 Premiere windows I have on my 3 monitors. Does NOT consider subwindows, though maaaaybe it can get that going....
ControlGetFocus, OutputVar, A
msgbox, %OutputVar%
return


;script reloader, but it only worKs on this one :(
#ifwinactive ahK_class Notepad++
^r::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return


#IfWinActive

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

;saving this blanK Keyboard for future use
/*
#if (getKeyState("F24", "P"))
F24::return ;F24

escape::msgbox,,, you pressed escape. this might cause liKe problems maybe, 0.9
F1::
F2::
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::tooltip, you pressed %A_thishotKey%

`::
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
bacKspace::return

;;;;;next line;;;;;;;;

tab::msgbox,,, you pressed tab. :P,0.8

q::
w::
e::
r::
t::
y::
u::
i::
o::
p::
[::
]::
\::return
capslocK::msgbox, , ,i hate capslocK!, 1000

a::
s::
d::
f::
g::
h::
j::
K::
l::
`;::
'::
;;;;;next line;;;;;;;;

Lshift::return
z::
x::
c::
v::
b::return
n::
m::
,::
.::
/::return
Lwin::msgbox, LEFT win
Lalt::msgbox, LEFT alt
space::tippy("3rd space")
Ralt::msgbox, Ralt - doesnt worK
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol
SC06E::msgbox,,,right WINKey,0.5
SC06F::msgbox,,,SC06F,0.5
SC062::msgbox,,,SC062,0.5
Rctrl::msgbox,,,Rctrl,0.5
appsKey::msgbox, this is the appsKey KEY I guess


PrintScreen::
ScrollLocK::return
SC061::msgbox, scancode061
CtrlBreaK::msgbox, CTRL BREAK?
pause::msgbox, is this the PAUSE Key?? IDK
BreaK::msgbox, Maybe THIS is the pause/breaK Key???

pgdn::
end::
delete::
pgup::
home::
insert::

up::
down::
left::
right::

;;;;;next area;;;;;;;;

numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::

+numlocK::
numlocK::
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::return
numpadDot::
/*
;These are now unused - I realized that Keeping them as modifiers (allowing them to pass through normally) is more valuable then as single Keys.
SC060::msgbox sc060, which I have assigned from LEFT SHIFT using intercept.exe
SC061::msgbox sc061, right shift
SC062::msgbox sc062, L CTRL
SC063::msgbox sc063, L WIN
SC064::msgbox sc064, L ALT
*/



#if

;;;discontinued stuff below:


;;;discontinued because now they are direct launch, no need to go through a shortcut.
; #IfWinActive
; ;These are mapped from the stream deck. Note that this actually includes a SHIFT keypress, due to the weird effects of numlock being on or off, which acts as if SHIFt is down... or up... whatever.
; ; So, rather than ^+!numpad1:: ... instead, you have to do:
; ^!numpadend::instantexplorer("C:\AHK\2nd-keyboard") 
; ^!NumpadDown::instantexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
; ^!numpadpgdn::instantexplorer("C:\Users\TaranWORK\Videos\Desktop") ;shadowplay folder opener

;------------


;;;Script to use F11 and F12 as scroll down and up! Useful for wacom tablet users who don't have a scrol wheel.
;;i found the code here https://stackoverflow.com/questions/24001634/how-can-i-bind-my-mouse-wheel-to-scroll-down-with-a-key-and-this-key-is-ahk
; *F11::
; While GetKeyState("F11", "p")
; {
    ; SendInput, {WheelDown}
    ; Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
; }
; return

; F12::
; ;msgbox,,,you pressed F9,0.6
; While GetKeyState("F12", "p")
; {
    ; SendInput, {Wheelup}
    ; Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
; }
; return

;;;----------

; #IfWinActive

; ;control alt shift T -- click on the address bar for any youtube video, and this will link you to the thumbnail!
; ^!+T::
; Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/sddefault.jpg{enter}
; ; Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/maxresdefault.jpg{enter}

; ;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
; ;http://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg
; return