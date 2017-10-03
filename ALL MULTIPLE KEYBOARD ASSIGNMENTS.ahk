SetWorkingDir, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files
;the above will set A_WorkingDir. It must be done in the autoexecute area, BEFORE the code below.


Menu, Tray, Icon, shell32.dll, 283
;gui must be first, or it does not work for some reason...
#Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\gui.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\All Premiere Functions.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Almost All Windows Functions.ahk

;NOTE FOR PEOPLE:
;Using #include is pretty much the same as pasting the entire script into THIS script. So basically, I'm just importing all the functions that I have created in those scripts, so that I can refer to them here.
;So, this script has all the keyboard assignments, and the other #included scripts have all the functions. I had to slipt it up this way so that I can also directly launch those functions, using means OTHER than a keyboard, like the Stream Deck's "open file" feature.


#NoEnv
SendMode Input
#InstallKeybdHook ;danger, this is untested right now
#UseHook On ;danger, also untested.



#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.



detecthiddenwindows, on

;THIS SCRIPT NO LONGER USES LUAMACROS TO REPROGRAM THE SECOND KEYBOARD. IF YOU WANT THAT CODE, PLEASE GO TO "2nd keyboard if using luamacros.ahk"

;I currently use Intercept.exe: http://orbiter-forum.com/showthread.php?t=30829

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;____________________________________________________________________________________
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
;_______________________________________________________________________________________________



;_____________________________________________________________________________
;                                                                             
;					   2ND KEYBOARD USING INTERCEPTOR   		   	  		  ;_____________________________________________________________________________
;please watch https://www.youtube.com/watch?v=y3e_ri-vOIo if you need help.
;DANGER: installing interception may cause your USB devices to stop working sometimes, because it is limited to supporting only 10 of each device class. You have to uninstall it to fix that. I will make a follow up video with new information, but it is currently in that video's description.


;#if (getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.
#if (getKeyState("F23", "P"))

F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.

;I converted the "numpad5" key on the 2nd keyboard into a CTRL, by using intercept.

;~VK25::Keyshower(A_thishotkey, "nudge clip right 5 frames") ;----virtual keys are okay... scancodes might be better, if you want the physical KEY itself, unchanged by chift or numlock.
;~VK27::Keyshower(A_thishotkey, "nudge clip left? 5 frames")

~^numpad1::
Keyshower("add marker color 1 (taran mod)")
marker()
send !{numpad1}
return

;this one does not work, probably because interceptor doesn't do multiple remappings...
~^numpad5::
Keyshower("add marker color 2 (taran mod)") ;intercept converted this one from numlock into a harmless numpad5.
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

; capslock::msgbox, , ,i hate capslock!, 1000
capslock::capslock


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


h::preset("100 to 120 zoom")
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

;;Lctrl::msgbox LEFT ctrl ;this must be commented out for the sake of numpad5, which was converted into left ctrl.
;None of these modifiers should even happen, I have allowed modifiers to pass through normally.
Lwin::msgbox LEFT win
Lalt::msgbox LEFT alt

space::tippy("2nd space") ;change this to EXCLUSIVE "play" only?

;Ralt::msgbox Ralt - doesnt work
Rwin::msgbox Right Win - doesnt work
;Rshift::msgbox RIGHT SHIFT lol

;SC06E::msgbox,,,this was right WINkey,0.5
SC06F::msgbox,,,testing scan codes,0.5
SC062::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~CANNED PRE ROLLS") ;remapped away from appskey, it seemed to cause problems.
Rctrl::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~INTEGRATIONS")
;SC065::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~ For Review") ;this is remapped from ALT. JK, SC065 is F14, do not use.
appskey::msgbox, this is the right click appskey KEY I guess

;these were all formerly runExplorer()
PrintScreen::InstantExplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard")
ScrollLock::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7
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

+numlock::msgbox, "shift numpadlock"
numlock::SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
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


;--------------END OF 2ND KEYBOARD IF USING INTERCEPTOR~~~~~~~~~~~~~~~~~~~~~


#IfWinActive

!F2::
openApp("ahk_class ConsoleWindowClass", "C:\Users\TaranWORK\Downloads\Intercept - use this one\intercept.exe")
openApp("ahk_class ConsoleWindowClass", "intercept.exe")
;must have both of these or it wont work.
sleep 100
;send y
return


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

numpad3::
;https://stackoverflow.com/questions/23028005/autohotkey-able-to-capture-firefox-tab
;this is a terrible solution, I think i will look into AAC instead
; https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=126248#p126248
SetTitleMatchMode 2

needle := "Linus Media Group Inc. - Calendar"

WinActivate, Firefox
Loop {
  WinGetTitle, title
  IfWinNotActive, Firefox
    break
  if (InStr(title,needle))
    Break
  Else
    send ^{PgUp}
  sleep 50
}

return

;numpad4::tippy("sort Explorer by date")


numpad4::
IfWinActive, ahk_class CabinetWClass
	{
	send {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...
	tippy("sort Explorer by date")
	}
return

numpad5::
IfWinActive, ahk_class CabinetWClass
	{
	send {alt}vo{enter} ;sort by name
	tippy("sort Explorer by name")
	}
return

numpad6::
if WinActive("ahk_class CabinetWClass") ;an explorer window
	{
	Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field in explorer
	}
return

numpad7::instantexplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard") 
numpad8::instantexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
Numpad9::instantexplorer("C:\Users\TaranWORK\Videos\Desktop") ;shadowplay folder opener
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

NumpadEnter::msgbox,,, numpad F21 enter,1

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
	; else
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
;~~~~~~~~~~~~~END OF 4TH KEYBOARD OVERALL~~~~~~~~~~~~~~~~~~~~~~~~


	
	
;BEGIN secondary layer of main keyboard, with CAPSLOCK remapped to F20
#if (getKeyState("F20", "P"))
F20::return 

escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9
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
F12::return

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

a::
s::
d::
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
space::tippy("3rd space")
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol
SC06E::msgbox,,,right WINkey,0.5
SC06F::msgbox,,,SC06F,0.5
SC062::msgbox,,,SC062,0.5
Rctrl::msgbox,,,Rctrl,0.5
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
; ;end 5th keyboard with F20

				
		
#IfWinActive
 

;STREAM DECK??

;;^+] is apparently also addGain()
~^+8::addGain()
~^+9::reSelect()
;;^+0 is already the effects panel find box function.
; - is something
; = is play/pause outside of premiere
;;;;;;;;;;;END OF KEY FOR STREAM DECK (soon to be obsolete, since i will launch directly);;;;;;

;---------------------------------------------



;BEGIN KEYBOARD 4, FULL AZIO KEYBOARD
#if (getKeyState("F24", "P"))
F24::return ;F24

escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9
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
F12::return

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
\::tippy("you pressed %A_thishotkey%")
capslock::msgbox, , ,i hate capslock!, 1000

a::
s::
d::
f::
g::
h::
j::
k::
l::
`;::
'::
enter::return
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
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol
SC06E::msgbox,,,right WINkey,0.5
SC06F::msgbox,,,SC06F,0.5
SC062::msgbox,,,SC062 aka APPSKEY,0.5
Rctrl::msgbox,,,Rctrl,0.5
appskey::msgbox, this is the appskey KEY maybe

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
;END OF FULL AZIO KEYBOARD



;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------


;okay, so these keys MUST be AFTER the intercept.exe launched keys, otherwise BOTH scripts will be called, which is bad. IDK why, but putting them down here fixes the problem.

#ifWinActive
!,::msgbox, A_workingDir should be %A_WorkingDir%
!.::msgbox, TaranDir should be %TaranDir%

^numpad1:: ;EASE IN AND EASE OUT
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
tooltip,
return

/*
G9: ctrl shift ] - add 7 gain, OR go to prev comment in Word.

See "Windows Mod - various functions.ahk" for a much more complete
explanation of the following macro key assignments
G13: "back" (varies per app)
G14: Activate Notepad++
G15: Activae Word
G16: Activate Firefox, then CTRL TAB on subsequent key presses.
G17: Activate Explorer, then browse through the windows on subsequent key presses
G18: Activate Premiere
*/

#IfWinActive ahk_exe Adobe Premiere Pro.exe

~^+0::
;Keyshower("effects Panel CLEAR",,1)
effectsPanelType("") ;set to macro key G1 on my logitech G15 keyboard. ;This just CLEARS the effects panel search bar so that you can type something in.
return
~^+-::preset("Warp Stabilizer Preset") ;macro key G2. I wish it would also press "analyse..."
;;;~^+=::effectsPanelType("presets") ;set to macro key G3. ;Types in "presets," which reveals my own entire list of presets. ;;I have canceled this one in favor of a global pause/play.
~^+=::sendinput, {space} ;Macro key G3

~^+,::audioMonoMaker("left")
;macro key G4. Using the WIn key is prooobably a terrible idea; I do not reccomend it...... :(
~^+.::audioMonoMaker("right")
; macro key G5. ;

!]::preset("DeHummer Preset") ;This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

;dynamically reassignable preset funtions - now discontinued
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

; F18::preset(savedpreset1)
*/

;+++++++++++++++++++++++++++++++
#IfWinActive


;Below is some code to pause/play the timeline in Premiere, when the application is NOT the active window (on top.) This means that I can be reading through the script, WHILE the video is playing, and play/pause as needed without having to switch back to premeire every single time.
#IfWinNotActive ahk_class Premiere Pro
;;macro key G3, when NOT in Premiere.
^+=::
Keyshower("pause/play Premiere when not active",,1,-400)
;Window Class3 is actually the Effect Controls panel... but play/pausing still works if that panel is selected. Trying to bring focus to the TIMELINE itself is really dangerous and unpredictable, since its Class# is always changing, based upon how many sequences, and other panels, that might be open.
ControlFocus, DroverLord - Window Class11,ahk_exe Adobe Premiere Pro.exe
;If we don't use ControlFocus first, ControlSend experiences bizzare and erratic behaviour, only able to work when the video is PLAYING, but not otherwise, but also SOMETIMES working perfectly, in unknown circumstances. Huge thanks to Frank Drebin for figuring this one out; it had been driving me absolutely mad. https://www.youtube.com/watch?v=sC2SeGCTX4U
; Window Class11 is the Program monitor, at least on my machine.
;I tried windowclass3, (the effect controls) but that does not work, possibly due to its possible tiue to stuff in the bins, which would play instead sometimes.

sleep 10
;ControlSend,DroverLord - Window Class3,^!+5,ahk_exe Adobe Premiere Pro.exe
;that is my shortcut for the Effect Controls.
sleep 10
;ControlSend,DroverLord - Window Class3,^!+3,ahk_exe Adobe Premiere Pro.exe

;that is my shortcut for the Timeline.
;this is to ensure that it doesn't start playing something in the source monitor, or a bin somewhere.
sleep 10
ControlSend,DroverLord - Window Class11,{ctrl up}{shift up}{space down},ahk_exe Adobe Premiere Pro.exe
sleep 30
ControlSend,DroverLord - Window Class11,{space up},ahk_exe Adobe Premiere Pro.exe
; ControlSend,,{space}, ahk_exe Adobe Premiere Pro.exe
return



;Here we have a mster list of all function key assignments

#IfWinActive ahk_exe Adobe Premiere Pro.exe


~F1::Send u^+!d ;u is [select clip at playhead] and ctrl alt shift d is [ripple delete]
;F2 is set in premiere to the [GAIN] panel.
;F3 is set in premiere to the [MODIFY CLIP] panel. 
;~F4::untwirl() ;I never use this, it is too dumb. needs improvement.
~F4::masterClipSelect() ;this has not been programmed yet
~F5::clickTransformIcon2()
~F6::cropClick()
;~F7::unused
;F8::unused
;F9::unused
;F10::unused
;F11::unused
;F12::unused
;F13 - key G13, "back" in windows mods script.

;Macro key G12 on my K95 keyboard is set to F14.
#IfWinActive ahk_exe winword.exe
~F14::F3 ;in Word, the F3 shortcut is "go to next comment."


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;I was having trouble with cross-talk on F14... so writing it this way allows me to use it.
;~F14:: ;the virtual key and scan code below refer to F14.
~VK7DSC065::
global VFXkey = "F14"
instantVFX("scale")
return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G11
~F15::
global VFXkey = "F15"
instantVFX("anchor_point_vertical")
return

;F16 is maybe available?

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
;F22 - FREE
;F23 is for the 2nd keyboard, the Logitech K120. Will maintain for sake of tutorials.
;F24 (SC076) is the FULL AZIO KEYBOARD. Not yet configured. ;F24 used to be used for LuaMacros.

SC075::msgbox, SC075 is just before SC076 which is F24
SC077::msgbox, I can call this F25 
SC078::msgbox, I can call this F26

;;---------------------------------------------------


#IfWinActive ahk_exe Adobe Premiere Pro.exe

^w::closeTitler()

~+k::kbShortcutsFindBox()

; control g = make 200% speed
;^g::
;Send ^r200{Enter}
;return

; control h = make 50% speed
;^h::
;Send ^r50{Enter}
;return


;+++++++++++++++++++++++++++++++


;;MACRO KEY G9;;
#IfWinActive ahk_exe WINWORD.EXE
^+]::Send {F2} ;set to "go to previous comment" in Word.
;this and the other one does NOT show up in the key visualizer? look into that...
#IfWinActive ahk_exe Adobe Premiere Pro.exe

~^+]::Send {F2}7{enter} ;adds 7 gain.


; control shift r = reverse selected clip
^+r::Send ^r{tab}{tab}{space}{enter}



#IfWinActive ahk_exe Adobe Premiere Pro.exe
;This disables a menu accelerator in premiere, ignoring the pressing of ALT along with SPACE. Otherwise it will open a dumb menu on the top bar, which I never use.
; !space::
; Send {space}
; Return

;Just kidding, I want to use alt space to rewind and then play. Premiere's version of this SUCKS because it brings you back to where you started
; the ~ is only there so that the keystroke visualizer can see this keypress. Otherwise, it should not be used.
Lwin::
~!space::
Send s ;"stop" command (From JKL remapped to ASD.)
Send +{left}
Send +{left}
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


#IfWinActive
;experiemntal thing to super duper check window IDs...
!`::
WinGet, ActiveId, ID, A
msgbox, %ActiveId%
;returns 0x1c0b9c ... and only 3 unique codes for each of the 3 Premiere windows I have on my 3 monitors. Does NOT consider subwindows, though maaaaybe it can get that going....
ControlGetFocus, OutputVar, A
msgbox, %OutputVar%
return


;script reloader, but it only works on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;TITLE BAR REMOVER
;;ctrl backslash is a nice shortcut in MACINTOSH Premiere for hiding the title bar. There is no Windows equivalent... unless you use autohotkey!
;;https://jacksautohotkeyblog.wordpress.com/2016/05/27/autohotkey-toggles-and-the-ternary-operator-beginning-hotkeys-part-18/
^\::
  If (toggle := !toggle)
    WinSet, Style, -0xC00000, A
  else
    WinSet, Style, +0xC00000, A
Return

#IfWinActive

;;shortcut to CLOSE FIREFOX with no bullshit or fanfare or annoying dialouge boxes that try to argue with you. Just completely nuke it from orbit so we can start over
^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide




;saving this for future use
/*
#if (getKeyState("F24", "P"))
F24::return ;F24

escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9
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
F12::return

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
capslock::msgbox, , ,i hate capslock!, 1000

a::
s::
d::
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
space::tippy("3rd space")
Ralt::msgbox, Ralt - doesnt work
Rwin::msgbox, Right Win 
Rshift::msgbox RIGHT SHIFT lol
SC06E::msgbox,,,right WINkey,0.5
SC06F::msgbox,,,SC06F,0.5
SC062::msgbox,,,SC062,0.5
Rctrl::msgbox,,,Rctrl,0.5
appskey::msgbox, this is the appskey KEY I guess


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

