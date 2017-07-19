SetWorkingDir, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files
;the above will set A_WorkingDir. It must be done in the autoexecute area, BEFORE the code below.

#Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\gui.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\All Premiere Functions.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\Almost All Windows Functions.ahk

Menu, Tray, Icon, shell32.dll, 283

#NoEnv
SendMode Input
#InstallKeybdHook ;danger, this is untested right now
#UseHook On ;danger, also untested.

Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!

#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm



detecthiddenwindows, on

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; HELLO, poeple who want info about making a second keyboard, using LUAmacros! Scroll down past all this stuff until you get to "2ND KEYBOARD USING LUAMACROS"
; if you want to make the 2nd keyboard with intercept.exe instead, (far superior!) please scroll down to LINE 1695!

; Here's my LTT video about how I use the 2nd keyboard with Luamacros: https://www.youtube.com/watch?v=Arn8ExQ2Gjg
; And Tom's video, which unfortunately does not have info on how to actually DO it: https://youtu.be/lIFE7h3m40U?t=16m9s
; so you also need LUAmacros as well, of course.
; Luamacros: http://www.hidmacros.eu/forum/viewtopic.php?f=10&t=241#p794
; AutohotKey: https://autohotkey.com/

; However, interecept.exe is even better! I'll make a video about how to install and use it, eventually.
; Intercept.exe: http://orbiter-forum.com/showthread.php?t=30829

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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


;22222222222222222222222222222222222222222222222222222222222222222222222222
;--------------------2ND KEYBOARD USING LUAMACROS--------------------------
;ALL THIS CODE IS OBSOLETE -- I'm only keeping it for people who watched
;my DIY 87-macro keyboard video: https://www.youtube.com/watch?v=Arn8ExQ2Gjg
;
;TO THOSE PEOPLE: The code below will work, but I have had more luck and
;stability using intercept.exe instead of luamacros. There's a video
;about it here: https://www.youtube.com/watch?v=y3e_ri-vOIo
;--------------------------------------------------------------------------
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
preset("impact flash long") ;it turns out you can SAVE transition presets from the effect controls triple line mnu button. But only cross dissolve and 3rd party transitions. I use filmimpact.net and red giant universe transitions. Lot of good free ones!
else if(key = "home") 
preset("impact flash med")
else if(key = "pageup")
preset("impact flash short")
else if(key = "delete") ;DISSOLVE TRANSITIONS
preset("cross dissolve long")
else if(key = "end")
preset("cross dissolve med")
else if(key = "pagedown")
preset("cross dissolve short")
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

else if(key = "up") ;impact push transitions - fun fact, you can SAVE TRANSITION PRESETS if they are cross dissolve or from a 3rd party. In the effect controls triple line menu.
preset("push up")
else if(key = "left")
preset("push left")
else if(key = "down")
preset("push down")
else if(key = "right")
preset("push right")

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

Return ;from luamacros F24
;THE BLOCK OF CODE ABOVE is the original, simple Luamacros-dependant script.
*/



;_____________________________________________________________________________
;                                                                             
;					   2ND KEYBOARD IF USING INTERCEPTOR   			  		  ;_____________________________________________________________________________
;please watch https://www.youtube.com/watch?v=y3e_ri-vOIo if you need help.


;#if (getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.
#if (getKeyState("F23", "P"))

F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.

;I converted the "numpad5" key on the 2nd keyboard into a CTRL, by using intercept.

;~VK25::Keyshower(A_thishotkey, "nudge clip right 5 frames") ;----virtual keys are okay... scancodes might be better, if you want the physical KEY itself, unchanged by chift or numlock.
;~VK27::Keyshower(A_thishotkey, "nudge clip left? 5 frames")


;4 is orange

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

;;Lctrl::msgbox LEFT ctrl ;this must be commented out for the sake of numpad5, which was converted into left ctrl.
;None of these modifiers should even happen, I have allowed modifiers to pass through normally.
Lwin::msgbox LEFT win
Lalt::msgbox LEFT alt

space::tippy("2nd space") ;change this to EXCLUSIVE "play" only?

Ralt::msgbox Ralt - doesnt work
Rwin::msgbox Right Win - doesnt work
Rshift::msgbox RIGHT SHIFT lol

SC062::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~CANNED PRE ROLLS") ;remapped away from appskey, it seemed to cause problems.
Rctrl::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~INTEGRATIONS")
appskey::msgbox, this is the right click appskey KEY I guess

PrintScreen::runexplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard")
ScrollLock::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7
SC061::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery") ;"   ;msgbox, , , this key is NO GOOD TO USE!`nmaybe, 0.7

CtrlBreak::msgbox, CTRL BREAK - maybe the default output of the pause/break key??
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key?? WHAT CAN I BELEVE ANYMORE??

pgdn::runexplorer("Z:\Linus\1. Linus Tech Tips\Pending")
end::runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")
delete::runexplorer("Z:\Linus\6. Channel Super Fun")

pgup::runexplorer("N:\Linus Tech Tips")
home::runexplorer("N:\Fast As Possible") ;runexplorer("N:\Fast As Possible")
insert::runexplorer("N:\Channel Super Fun")

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
; SC065::msgbox sc065, R ALT ;;;of is this F14? IDK
; SC066::msgbox sc066, R WIN
; SC067::msgbox sc067, R CTRL


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




;~~~~~~~~~BEGIN 4TH KEYBOARD using F21~~~NICE MECHANICAL ONE~~~~~~~~~~~
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
;~~~~~~~~~~~~~END OF 4TH KEYBOARD OVERALL~~~~~~~~~~~~~~~~~~~~~~~~

	
	
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

; !+q::return ;q is unused
; !+w::insertSFX("bell")
; !+e::insertSFX("woosh1")
; !+r::insertSFX("pop")
; ;!+t::return ;send ^!p ;shortcut for pin to clip
; ;!+a::preset("blur with edges") ;this was interfering with the monomaker... huge cross talk issues with this, and actually all the rest of them too....
; !+s::audioMonoMaker("right")
; !+d::audioMonoMaker("left")
; !+f::reselect()
; !+g::addGain()
; !+z::preset("crop") ;the cropClip function is now auto-triggered.
; !+x::preset("crop 50 LEFT")
; !+c::preset("crop 50 RIGHT")
;!+v::Send F19 ;~F19::tracklocker() ; this is pointless, I'm just gonna have the key hit F19 from the start. aLSO, tracklocker() was moved to another ahk script.
;!+b::return ;instead, the key will hit CTRL SHIFT 0 straight away. (Effects panel find box selector mod.)

;in premiere, these are listed as Capture Panel>log Clip... which i never use, so it is just showing that these shortcuts HAVE been used by autohotkey.
;currently, a full stream deck folder full of only shortcuts

;;^+] is apparently also addGain()
~^+8::addGain()
~^+9::reSelect()
;;^+0 is already the effects panel find box function.
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
; +!u::runexplorer("Z:\Linus\1. Linus Tech Tips\Transcode\Delivery")
; +!i::runexplorer("Z:\Linus\1. Linus Tech Tips\Pending")
; +!o::runexplorer("N:\Linus Tech Tips")

+!h::InstantExplorer("Graphics",1)
+!j::InstantExplorer("ALL FOOTAGE",1)
+!k::openlatestfile(1, ".prproj")
; +!l::runexplorer("Z:\Linus\5. Fast As Possible\1. Pending")
+!`;::runexplorer("N:\Fast As Possible") ;notepad++ syntax highlighting is wrong here.

+!n::InstantExplorer("Thumbnail",1)
+!m::InstantExplorer("Delivery",1)
+!,::openlatestfile(1, ".docx")
; +!.::runexplorer("Z:\Linus\6. Channel Super Fun")
; +!/::runexplorer("N:\Channel Super Fun")
#ifWinActive

;;;;;;;;;;;END OF KEY FOR STREAM DECK (soon to be obsolete, since i will launch directly);;;;;;


;experimenting with scan codes. here is a list of blank ones.
;https://developer.mozilla.org/en/docs/Web/API/KeyboardEvent/code


;6F is CTRL ??

; ^F13::
; tooltip, yeah
; sleep 500
; send {SC05A} ;just after F23, but is not F24.
; tooltip,
; return
; ^F14::send {SC05A} ;just before F13
; ^F15::send {SC05E}
; ;^F16::send {SC05F}
; ^F17::send {SC060}
; ^F18::send {SC061}
; ^F19::send {SC062}
; ^F20::
; ^F21::
; ^F22::

; ;{SC0E8} is taken by one of my own scripts.


;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------
;---------------ALL NORMAL KEY ASSIGNMENTS---------------------


;okay, so these keys MUST be AFTER the intercept.exe launched keys, otherwise BOTH scripts will be called, which is bad. IDK why, but putting them down here fixes the problem.

#ifWinActive
!,::msgbox, A_workingDir should be %A_WorkingDir%
!.::msgbox, TaranDir should be %TaranDir%



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
~^+=::effectsPanelType("presets") ;set to macro key G3. ;Types in "presets," which reveals my own entire list of presets.

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
; F9::
; tooltip, wat
; WinGetTitle, Title, A
; WinActivate, ahk_exe Adobe Premiere Pro.exe
; ;WinWaitActive, ahk_exe Adobe Premiere Pro.exe
; ;sleep 1000
; Send {space}
; WinActivate, %Title%
; tooltip,
; return


;Below is some code to pause/play the timeline in Premiere, when the application is NOT the active window (on top.) This means that I can be reading through the script, WHILE the video is playing, and play/pause as needed without having to switch back to premeire every single time.
#IfWinNotActive ahk_class Premiere Pro
F8::
^+=::
Keyshower("pause/play Premiere when not active",,1,-400)
;Window Class3 is actually the Effect Controls panel... but play/pausing still works if that panel is selected. Trying to bring focus to the TIMELINE itself is really dangerous and unpredictable, since its Class# is always changing, based upon how many sequences, and other panels, that might be open.
ControlFocus, DroverLord - Window Class3,ahk_exe Adobe Premiere Pro.exe
;If we don't use ControlFocus first, ControlSend experiences bizzare and erratic behaviour, only able to work when the video is PLAYING, but not otherwise, but also SOMETIMES working perfectly, in unknown circumstances. Huge thanks to Frank Drebin for figuring this one out; it had been driving me absolutely mad. https://www.youtube.com/watch?v=sC2SeGCTX4U
sleep 15
ControlSend,DroverLord - Window Class11,{ctrl up}{shift up}{space down},ahk_exe Adobe Premiere Pro.exe
sleep 40
ControlSend,DroverLord - Window Class11,{space up},ahk_exe Adobe Premiere Pro.exe
; ControlSend,,{space}, ahk_exe Adobe Premiere Pro.exe
return



; ;#IfWinNotActive ahk_exe Adobe Premiere Pro.exe
; #IfWinActive ;ahk_class Premiere Pro
; F8::
; SetTitleMatchMode, 1
; detecthiddenwindows, on
; ;SetKeyDelay, 0, 50
; tooltip, "play/pause in premiere"
; sleep 10
; ;ControlSend, DroverLord - Window Class3,{space}, ahk_exe Adobe Premiere Pro.exe
; ; ControlSend,,{space}, ahk_class Premiere Pro
; ; ControlSend,ahk_parent,8, ahk_exe Adobe Premiere Pro.exe
; ; ControlSend,edit1,9, ahk_exe Adobe Premiere Pro.exe
; ControlSend,,{space}, ahk_class Premiere Pro
; ;ControlGet, OutputVar, Hwnd,, ClassNN:	DroverLord - Window Class3, Adobe Premiere Pro
; ;ControlSend,,J, ahk_id %OutputVar%
; ; sleep 100
; ; ControlSend,ahk_parent,{8 up}, ahk_exe Adobe Premiere Pro.exe
; sleep 10
; tooltip,
; return


#IfWinActive ahk_exe Adobe Premiere Pro.exe


~F1::Send u^+!d ;u is [select clip at playhead] and ctrl alt shift d is [ripple delete]
;F2 is set in premiere to the [GAIN] panel.
;F3 is set in premiere to the [MODIFY CLIP] panel. 
~F4::untwirl() ;I never use this, it is too dumb. needs improvement.
~F5::clickTransformIcon2()
~F6::cropClick()
~F7::masterselect() ;this has not been programmed yet
;F8::unused
;F9::unused
;F10::unused
;F11::unused
;F12::unused
;F13 - key G13, "back" in windows mods script.

;Macro key G12 on my Logitech G15 keyboard is set to F14.
#IfWinActive ahk_exe winword.exe
F14::F3 ;in Word, the F3 shortcut is "go to next comment."
#IfWinActive ahk_exe Adobe Premiere Pro.exe
;I was having trouble with cross-talk on F14... so writing it this way allows me to use it for use.
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

~F19::tracklocker()
~+F19::tracklocker()

;F20 is available?
;F21 - will free this up by using some other scan code
;F22 - will free this up by using some other scan code
;F23 is for the 2nd keyboard, and intercept.exe
;F24 is reserved for Luamacros, just for the sake of compatibility
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

;;---------------------------------------------------

;;;;;;;;shortcuts for creating markers, then makign them into specific colors.;;;;;;;;;;;;
; #IfWinActive ahk_exe Adobe Premiere Pro.exe
; ~numpadend::
; marker()

; send !{numpad1}
; return

; ;suuposedly shift numpad 5, but remapped from numlock, if interceptor is working....
; numpadclear::
; marker()
; send !{numpad2}
; msgbox,,, alt numpad2,0.5
; return

; +numpadmult::
; marker()
; send !{numpad3}
; return

; numpadpgdn::
; marker()
; send !{numpad4}
; return

; numpadhome::
; marker()
; send !{numpad5}
; return

; +numpaddiv::
; marker()
; send !{numpad6}
; ;tooltip, DIV num8
; return

; numpadins::
; marker()
; send !{numpad7}
; return

; numpadpgup::
; marker()
; send !{numpad8}
; return


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
