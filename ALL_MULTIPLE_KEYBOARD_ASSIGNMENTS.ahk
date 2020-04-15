SetWorkingDir, C:\AHK\2nd-keyboard\support_files
;the above will set A_WorkingDir. It must be done in the autoexecute area.
;SetNumLockState, on ;This doesn't work, needs to be done in admin mode.
;SetScrollLockState, off
Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something
;when you get to #include, it means the END of the autoexecute section.
;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the line below:

; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe" ;BEFORE the #include is apparently the only place these can go.
;This has now been changed to Teams (Hangouts replacement) since I use that a lot mroe now, and Notepad++ already has a button on numpad+ on the K120 keyboard.
;This is for macro key G14 by the way.
global savedCLASS = "ahk_class Chrome_WidgetWin_1"
global savedEXE = "Teams.exe"


#Include C:\AHK\2nd-keyboard\gui.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk
#include C:\AHK\2nd-keyboard\After_Effects_Functions.ahk
SetKeyDelay, 0 ;warning ---this was absent for some reason. i just added it back in. IDK if I removed it for a reason or not...

;-------------------------------------------------------------------------
; HELLO PEOPLES 
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
; ;
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

; Also, I will put shortcuts to all the AHK scripts that I use into my startup folder... which is here for all users:
;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;  Or here for just one user:
;  C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup


;For some of the firefox/chrome shortcuts, you have to install the ACC library into AutoHotKey (it's pretty easy, just follow the instructions on this page.)
;https://www.autohotkey.com/boards/viewtopic.php?f=6&t=26201
;one such function is JEE_FirefoxFocusTabByName

#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
#MaxThreadsPerHotkey 1
#KeyHistory 500 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
; https://www.autohotkey.com/docs/commands/GetKey.htm


detecthiddenwindows, on

SetNumLockState, AlwaysOn ;i think this only works if launched as admin.

;Avoid using stupid CTRL when alt is released https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
;#MenuMaskKey vk07  ; vk07 is (was) unassigned. See my full list of scan codes and virtual keys to see what else is available: 
#MenuMaskKey sc08A  ; vk07 is (was) unassigned. See my full list of scan codes and virtual keys to see what else is available: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0

;_________________________________________________________________________________________
;                                                                                                                       
; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm
;__________________________________________________________________________________________
; 
;----------------------------------------------------------------------------------
; RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU
; THESE ARE ESSENTIAL FOR THE SCRIPTS TO WORK PROPERLY.
;----------------------------------------------------------------------------------
; KEYS                  PREMIERE FUNCTIONS
;----------------------------------------------------------------------------------
; ctrl alt s            select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
; backspace             ripple delete --- but I don't use that in AutoHotKey because it's dangerous. This should be changed to something else; I use SHIFT C now.
; shift c               ripple delete --- very convenient for left handed use. Premiere's poor track targeting makes ripple delete less useful than it could be.
; ctrl alt shift d      ripple delete --- I never type this in manually - long shortcuts like this are great for using AHK or a macro to press them.
; delete                delete
; c                     delete --- I also have this on "C" because it puts it directly under my left hand. Very quick.
; ctrl r                speed/duration panel
; shift 1               toggle track targeting for AUDIO LAYER 1
; shift 2               toggle track targeting for AUDIO LAYER 2. And so on up to 8.
; alt 1                 toggle track targeting for VIDEO LAYER 1
; alt 2                 toggle track targeting for VIDEO LAYER 2. And so on up to 8. I wish there were DEDICATED shortcuts to enable and disable ALL layers
; ctrl p                toggle "selection follows playhead"
; ctrl alt shift 3      Application > Window > Timeline (default is shift 3)
; ctrl alt shift 1      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 4      Application > Window > program monitor (Default is SHIFT 4)
; ctrl alt shift 5      Application > Window > Effect Controls (Default is SHIFT 5)
; ctrl alt shift 7      Application > Window > Effects   (NOT the Effect Controls panel) (Default is SHIFT 7) --- The defaults are stupid. SHIFT 7 is an ampersand if you happen to be in a text box somewhere...
; F2                    gain
; F3                    audio channels --- To be pressed manually by the user. (this might change in the future.)
; ctrl alt shift a      audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; shift F               From source monitor, match frame.
; ctrl /                Overwrite (default is "." (period))
; ctrl b                select find box --- This is such a useful function when you pair it the the effects panel!!
; ctrl alt F            select find box 
; ctrl shift 6			Apply source assignment preset 1 (set to V5 and A3)
; ctrl ; (semicolon)	Add Marker
; ctrl alt k			Remove selected marker
; ctrl shift alt 9 		activate lumetri scopes
; ctrl alt D   			"deselect all" (clips on the timeline)
; ctrl alt shift K 	 	"shuttle stop"
; CTRL SEMICOLON 		"(add) marker."
; ctrl shift alt R		is "reset to saved layout" (workspace)
; Media_Stop::^numpad7 ;select label group
;                                                                                                                      
; Be aware that sometimes other programs like PUUSH can overlap/conflict with your customized shortcuts.                          
;_______________________________________________________________________________________________
;
;
; NOTE:
; SC0E8: "scan code of an unassigned key" that I use to tell the computer "yeah, treat this like a keyboard,"
; SC0E9: Nullify ALT's sticky key effect. See for more info: Alt_menu_acceleration_DISABLER.ahk
; VK07:  #menumaskkey https://autohotkey.com/docs/commands/_MenuMaskKey.htm



;these are sent from the stream deck.
;I didn't use CTRL and SHIFT and stuff because I wanted NO CROSS TALK!!
;COPY 1 2 and 3
SC062::ClipBoard_1 := GetFromClipboard() ;zoom
vk2A::ClipBoard_2 := GetFromClipboard()	 ;Printer
SC16B::ClipBoard_3 := GetFromClipboard() ;launch (0)

;PASTE 1 2 and 3
;I might have to use proper functions to get these to type faster
SC16D::SendInput {Raw}%ClipBoard_1%		;launch_media
vk2B::SendInput {Raw}%ClipBoard_2%		;Execute
SC121::SendInput %ClipBoard_3% 	;launch (1)

;note to self, this is where to go for tap dance stuff
; https://autohotkey.com/board/topic/35566-rapidhotkey/

currentTool = "v" ;This is super useful and important for a Premiere script, you'll see...

#if

;this is pause/break. I'm using it for debugging...
sc045::
^sc045::
+sc045::
!sc045::
ctrlbreak::
^ctrlbreak::
tooltip, pause break
sleep 100
tooltip,
KeyHistory
sleep 10
return 
;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING HASU USB TO USB (Logitech K120)  
;____________________________________________________________________
; watch [link NYA] to understand how this works.
; https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/

;#if ( \\\\\\\\\\\\\\\getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.


;;;;;;;;;;;;;BEGIN K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS;;;;;;;;;;;;;;;;;
#if (getKeyState("F23", "P")) ;This is the line that makes all the lines below possible.


F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.
;;This also means that you must NEVER use F23 for anything else. Doing so will sometimes allow a key to pass through unwrapped, which can cause big problems with cross-talk.

;SC06E::return ;;This is F23's scan code. Using this line acts as some more insurance against cross-talk. comment this in if you have issues.



escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9

F1::return
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
F12::instantExplorer("N:\Team_Documents\N_TARAN_THINGS\prompter and cutting_room_floor") ;"FLOOR"



;F12::search() ;"search" is also used on ^+j 
; F12 must not used here IF it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;
;;;;K120 keyboard;;;;;

`::msgbox tilde or weird quote thing?? K120
1::insertSFX("bleep")
2::
3::return
4::
tooltip, this happens on key down
keywait, 4 ;waits for the key to go up
tooltip, and this happens on key up. dang
return
5::insertSFX("")
6::insertSFX("record scratch")
7::preset("180 hue angle")
8::preset("PAINT WHITE")
9::preset("PAINT BLACK")
0::insertSFX("pop")
-::audioMonoMaker("left")
=::audioMonoMaker("right")
backspace::
if WinActive("New TightVNC Connection") ;if we are at the thingy that asks for a password or whatever
	{
	Sendinput, {enter}
	goto tvnEND ;LOL ARE YOU TRIGGERED BY THIS!!? DESPAIR!! DESPAIR!!!!
	}
IfWinNotExist, ahk_class TvnWindowClass
	Run, C:\Program Files\TightVNC\tvnviewer.exe
if WinExist("ahk_exe tvnviewer.exe")
	WinActivate ahk_exe tvnviewer.exe
tvnEND:
;all done
return

;;;;;next line;;;;;;;;
;;;;;K120 keyb;;;;;;;;

tab::msgbox,,,K120 - you pressed tab. :P,0.8

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


;;t::recallClipboard(A_thishotkey)
;;+t::saveClipboard(A_thishotkey)

y::preset("autogate -25")
u::preset("90 IRE")
i::preset("multiply")
o::preset("flip vertical")
p::preset("flip horizontal")
[::preset("T impact flash MED")
]::preset("T Impact Pop")

\::
instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\SFX")
sleep 20
search() ;immediately highlights the search bar so you can search for a sound effect. Sadly this does not always seem to work...
sleep 250
search() ;so i do it again here. still doesn't always work.
return

;;;;;next line;;;;;;;;
;;;;K120 keyboard;;;;;

; capslock::msgbox, , ,i hate capslock!, 1000
;capslock::capslock

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
j::preset("110 to 100 zoom")
k::preset("100 to 120 zoom")
l::preset("25% blur and darkener")
`;::preset("blur with edges") ;lol, it's not a comment until here -- the syntax highlighting gets this one wrong.
'::preset("Warp Stabilizer Preset")
enter::enter

;;;;;next line, still inside the K120;;;;;;;;

;Lshift::Lshift
;;msgbox, , ,you pressed Left shift - you should never see this message if you let it pass normally, 5
;now I use it as a modifier for some of the other numpad keys.
z::preset("T wipe soft left")
x::preset("T wipe soft down")
c::preset("T wipe soft up")
v::preset("T wipe soft right")

+z::preset("T wipe exposure left")
+x::preset("T wipe exposure down")
+c::preset("T wipe exposure up")
+v::preset("T wipe exposure right")


b::preset("Drop Shadow Preset")


n::preset("anchor and position to 0") ;no panning involved here.
m::preset("a0p0 pan down")
,::preset("crop 50 LEFT")
.::preset("crop 50 RIGHT")
/::preset("crop full")

;;;;;next area;;;;;;;;
;;;;K120 keyboard;;;;;


;;Lctrl::msgbox,,, LEFT ctrl,0.5 ;this must be commented out for the sake of numpad5, which was converted into left ctrl.

;None of these modifiers should ever be triggered. I have blocked them and replaced with something else. What is below is just here for diagnostic purposes.
; Lwin::msgbox,,, LEFT win,0.5
; Lalt::msgbox,,, LEFT alt,0.5
; Rshift::msgbox,,, RIGHT shift,0.5 




F20::msgbox,,, K120 capslock to F20,0.5
;;SC062 was once the remap of appskey, but it seemed to cause problems.


;;Lshift -to-> SC070-International 2 -back-to-> Lshift. This is easier than having to re-flash the QMK chip...
SC070::Lshift

SC071 up::tooltip, [F23] LCtrl -to-> SC071-Language 2
SC072 up::tooltip, [F23] LWin -to-> SC072-Language 1
SC073 up::tooltip, [F23] LAlt -to-> SC073-International 1

SC077::instantExplorer("N:\Team_Documents\N_TARAN_THINGS") ;;tooltip, [F23] RAlt -to-> SC077-Language 4
SC078::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\LOGOS") ;;tooltip, [F23] RWin -to-> SC078-Language 3
SC079::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\BGs") ;tooltip, [F23] AppsKey -to-> SC079-International 4
SC07B::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\Screenshots") ;K120 rCTRL:: -to-> SC07B:International5 
;;Rshift is staying as Rshift for the time being.

SC07D::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS") ;K120 RShift -to-> SC07D: International3 --to--> \TARAN ASSETS\

space::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations")

;;;;;;;-----------------------------------------

PrintScreen::InstantExplorer("V:\1. LTT vault 2") ;will make tapdance keys one day...
ScrollLock::InstantExplorer("N:\Fast As Possible")
;scroll lock WAS reassigned to SC061 back when i used interception
SC07E::InstantExplorer("N:\Linus Tech Tips")
;;Pause -to-> SC07E:Brazilian comma

; CtrlBreak::msgbox, CTRL BREAK - maybe the default output of the pause/break key??
; pause::msgbox, is this the PAUSE key?? IDK
; Break::msgbox, Maybe THIS is the pause/break key?? WHAT CAN I BELEVE ANYMORE??

insert::InstantExplorer("Z:\Linus\2. Tech Linked\5. Transcode\_TL Delivery")
home::InstantExplorer("Z:\Linus\5. Fast As Possible\_FAP Transcoding\_FAP Delivery") 
pgup::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\_LTT DELIVERY")

delete::InstantExplorer("Z:\Linus\2. Tech Linked\3. Pending")
end::InstantExplorer("Z:\Linus\5. Fast As Possible\1. Pending")
pgdn::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Pending")

up::preset("push up")
down::preset("push down")
left::preset("push left")
right::preset("push right")


;;=========== THE K120 NUMPAD ==============;;


; ^numpad1::
; Keyshower("add marker color 1 (taran mod)")
; marker()
; send ^+{numpad1}
; return

; ;I converted the "numpad5" key on the 2nd keyboard into a CTRL key.

; ;the following assignment is no longer relevant, i think.
; ^numpad5::
; Keyshower("add marker color 2 (taran mod)")
; marker()
; send ^+{numpad2}
; return
; ;the above assignment is no longer relevant

; ; ^numpadmult::
; ; Keyshower("add marker color 3 (taran mod)")
; ; marker()
; ; send ^+{numpad3}
; ; return

numpadmult::
Keyshower("add marker color 3 (taran mod)")
marker()
send ^!{numpad3} ;shortcut for Set marker color 3
return


; ^numpad3::
; Keyshower("add marker color 4 (taran mod)")
; marker()
; send ^+{numpad4}
; return

; ^numpad7::
; Keyshower("add marker color 5 (taran mod)")
; marker()
; send ^+{numpad5}
; return

; ; ^numpaddiv::
; ; Keyshower("add marker color 6 (taran mod)")
; ; marker()
; ; send ^+{numpad6}
; ; return

numpaddiv::
send ^!{numpad6} ;shortcut for CREATE marker color 6 (white)

;;;the below code is no longer necessary, since Adobe added shortcuts to create markers of any color!
; Keyshower("add marker color 6 (taran mod)")
; marker()
; sleep 10
; send ^!{numpad6} ;this WAS the shortcut for Set marker color 6
return

; ^numpad0::
; Keyshower("add marker color 7 (taran mod)")
; marker()
; send ^+{numpad7}
; return

; ^numpad9::
; Keyshower("add marker color 8 (taran mod)")
; marker()
; send ^+{numpad8}
; return


;;;STILL IN THE K120 KEYBOARD

;;NumLock -to-> SC05C-International 6
SC05C::
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	{
	tippy("numlock")
	SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
	}
else
	search()
return

numpadins::
numpad0::SendKey("numpad0", , "sky blue")
numpadend::
numpad1::
;openApp("", ahk_exe waifu2x-caffe.exe, waifu2x-caffe)
;SendKey(A_thishotkey, ,"blue-green")
IfWinNotExist, ahk_exe waifu2x-caffe.exe
	Run, C:\waifu2x-caffe\waifu2x-caffe.exe
if not WinActive(ahk_exe waifu2x-caffe.exe)
	{
	WinActivate ahk_exe waifu2x-caffe.exe
	;WinGetTitle, Title, A
	WinRestore waifu2x-caffe
	}
; I had to do this directly because it has the same AHK_class as a regular explorer window, so my usual use od openApp() woudln't work. Oh teh wells.
return

numpaddown::
numpad2::SendKey(A_thishotkey, ,"nudge down")
numpadpgdn::
numpad3::
if WinActive("ahk_exe Adobe Premiere Pro.exe"){
	Keyshower("add marker color 4 (taran mod)")
	marker()
	send ^!{numpad4} ;set marker color 3
	sleep 5
	marker() ;Go inside that marker so that you can start typing a comment
	;;SendKey(A_thishotkey, ,"orange")
	}
	
if WinActive("ahk_exe chrome.exe")
	sendinput, ^+{tab} ;go to previous tab in chrome
return

numpadleft::
numpad4::SendKey(A_thishotkey, ,"nudge left")
numpadclear::
numpad5::numpad5
;numpad5::Rctrl ;because I use it... well, as a ctrl key. baka.
numpadright::
numpad6::SendKey(A_thishotkey, ,"nudge right")
numpadhome::
numpad7::SendKey(A_thishotkey, ,"purple")
numpadup::
numpad8::SendKey(A_thishotkey, ,"nudge up")
numpadpgup::
numpad9::SendKey(A_thishotkey, ,"yellow")


;numpadDiv::SendKey("numpadDiv", ,"clip blue")
;numpadMult::SendKey("numpadmult", ,"pink")

numpadSub::


If Not WinExist("ahk_class AU3Reveal")
	openApp("ahk_class AU3Reveal", "C:\Program Files\AutoHotkey\WindowSpy.ahk", "Active Window Info")
; else
	; msgbox, heyyyy ;doesn't work for some raisin.
; if WinExist("ahk_class AU3Reveal")
	; msgbox, heyyo
	;WinClose, Window Spy

return



; numpadAdd::openApp("ahk_class Adobe Media Encoder CC", "Adobe Media Encoder.exe") ;msgbox, , , num ADD, 0.5
numpadAdd::openApp("ahk_class Notepad++", "notepad++.exe") ;msgbox, , , num ADD, 0.5
numpadEnter::switchToChrome()

numpaddel::
numpadDot::openApp("ahk_class Photoshop", "Photoshop.exe") ;msgbox, , , num dot, 0.5




#if
#IfWinActive

;-----------------------------------------------------------------------
;--------END OF K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS--------
;-----------------------------------------------------------------------


;3RD KEYBOARD CODE WAS HERE (was actually just a shitty numpad) - used F22 - but has been replaced with the stream deck.


;; https://autohotkey.com/board/topic/53346-explorer-view-mode/
; GroupAdd, Explorer, ahk_class CabinetWClass
; GroupAdd, Explorer, ahk_class ExploreWClass
; #IfWinActive, ahk_group Explorer





#if
;~~~~(mechanical Jelly) USING INTERCEPTOR (No longer used)~~~~
; But the code for the ALT characters is really clever, and I've seen it nowhere else, so I am saving it here for all of y'all
; https://www.reddit.com/r/MechanicalKeyboards/comments/4kf2gk/review_jellycomb_mechanical_numpad/
; https://autohotkey.com/board/topic/29542-rebinding-alt-061/

; this is for the jellycomb numpad 4th keyboard's TOP ROW of keys:
; $*~LAlt::
; Loop 10
	; Hotkey, % "*Numpad" A_Index-1, HandleNum, on
; keywait, LAlt ; replace with "Sleep 100" for an alternative
; Loop 10
	; Hotkey, % "*Numpad" A_Index-1, HandleNum, off
; If (Ascii_Unicode_Input = "061")
	; {
	; msgbox,,, you pressed the equals key!,1
	; ; ;InputBox, password, Enter Password, (your input will be hidden), hide 
	; ; InputBox, UserInput, Phone Number, Please confirm murdering of premiere, , 640, 480
	; ; if UserInput = "="
		; ; {
		; ; MsgBox, You entered "%UserInput%"
		; ; Run, %comspec% /c "taskkill.exe /F /IM Adobe Premiere Pro.exe",, hide 
		; ; }	
	; ; else***
		; ; return
	; }
; If (Ascii_Unicode_Input = "040")
; {
	; prFocus("Effect Controls") ;the following shortcut only works if the Effect Controls panel is in focus...
	; send ^!p ;shortcut for pin to clip
	; prFocus("timeline")
; }
; If (Ascii_Unicode_Input = "041")
	; msgbox,,, you pressed the close parenthisesis key!,1
; Ascii_Unicode_Input := ""
; return

; HandleNum:
; Ascii_Unicode_Input .= SubStr( A_ThisHotkey, 0 )
; return
; #if

;___________________END OF JELLY NUMPAD______________________


	
/*
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
;;;this is the fake F20 capslock layer;;;

tab::msgbox,,,within F20 - you pressed tab. :P,0.8

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
;;;this is the fake F20 capslock layer;;;
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

Rctrl::msgbox,,,Rctrlll,0.5
appskey::msgbox, this is the appskey KEY I guess

;;;F20 capslock keyboard;;;

;these were all formerly runExplorer()
PrintScreen::
ScrollLock::return
SC061::msgbox, scancode061
CtrlBreak::msgbox, CTRL BREAK?
pause::msgbox, is this the PAUSE key?? IDK
Break::msgbox, Maybe THIS is the pause/break key???

;;;this is the fake F20 capslock layer;;;

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
;;;this is the fake F20 capslock layer;;;

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

#if				
;_________________end fake 5th keyboard with capslock remapped to F20__________________

*/
				
		
#IfWinActive
 
 
 ;;;;testing shit
 
 

;+F12::gotofiretab("Calendar - April 2019","https://calendar.google.com/calendar/b/0/r") 

 
 ;;;;;okay done with testing

;BEGIN KEYBOARD 4, FULL AZIO KEYBOARD
#if (getKeyState("F24", "P")) ;and WinActive("ahk_exe Adobe Premiere Pro.exe") ;; bad idea to have the "and [something]", this means the keyboard behaves normally, any time you are NOT in Premiere...
F24::return ;F24

escape::return ;need to make this release all modifier keys and F24 like it did before
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
F12::tooltip, you pressed F24 then %A_thishotkey%

;`::tooltip, tilde thing 
`::
gotofiretab("ADDENDUM to 4hr","https://docs.google.com/document/d/1YRr5O2PN10PRtAMZHUJJhh6_2FXANjaHTGYH0RadTaI/edit")
return


1::gotofiretab("AHK needed","https://docs.google.com/document/d/1xsjjKYggXYig_4lfBMJ6LDGRZ9VOvDd7SCSTSi7GwN8/edit")
2::gotofiretab("LTT note","https://docs.google.com/document/d/1CWjC7DWyXGIFDaSwXzUsdHmdktvgV0kdgNOFEK7wf7U/edit")
3::gotofiretab("LTT To Do - Google Docs","https://docs.google.com/document/d/1Gi8sruMEBEQG3WHPM2jaFOQ1oR1A8bSz47vSxB9NfBQ/edit")
4::gotofiretab("Music Hypercube - Google Docs","https://docs.google.com/document/d/11hIiENqLMtuQRLV4FjZMRY2uNFLtPw5QW6fivMix9VE/edit")

5::
6::tooltip, you pressed F24 then %A_thishotkey%
7::
8::
9::
0::
-::
=::tooltip, you pressed F24 then %A_thishotkey%
backspace::send, ^+!r ;ctrl shift alt r is "reset workspace"

;;;;;next line;;;;;;;;

; tab::msgbox,,, you pressed tab. :P,0.8
;VIDEO TRACKER
tab::gotofiretab("Fast As Possible | Trello","https://trello.com/b/yUSFtaXn/fast-as-possible")
; WinActivate ahk_exe firefox.exe
; sleep 10
; WinGet, the_current_id, ID, A
; vRet := JEE_FirefoxFocusTabByName(the_current_id, "Video Tracker LTT - Google")
; ;tooltip, vret is %vRet%
; if (vRet = 0)
	; run, firefox.exe https://docs.google.com/spreadsheets/d/1FmuWOCKHxZbxS5XbwpVDP4M27BjTAJJ67B0yoSXUN9k/edit#gid=0
;return

;;;this is the azio F24 keyboard;;;

q::
;controlsend, Qt5QWindowIcon2, ^!+r, ahk_exe obs64.exe
;tooltip, did that work?6
;return
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
]::tooltip, you pressed F24 then %A_thishotkey%
\::run, C:\Program Files (x86)\Corsair\Corsair Utility Engine\CUE.exe

;;;this is the azio F24 keyboard;;;

;F20 IS CAPSLOCK
;CAPSLOCK IS TRELLO
F20::
capslock::gotofiretab("Production Planner | Trello","https://trello.com/b/NevTOux8/ltt-production-planner")

;LEFTSHIFT > SC070 / International2 > Firefox calendar open
;SC070::gotofiretab("Linus Media Group Inc. – Calendar","https://calendar.google.com/calendar/b/0/r") ;even though i directly copied the text, it does not work. and IDK how to split a string so I'll have to write in the months manually...

;;;this is(was) Lshift::
SC070::gotofiretab("Calendar - April 2020","https://calendar.google.com/calendar/b/0/r") ;even though i directly copied the text, it does not work. and IDK how to split a string so I'll have to write in the months manually...
;SC070::gotofiretab("2018","https://calendar.google.com/calendar/b/0/r")
;en dash –
;em dash –
;; ask about URLs: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114

;;;this is still the azio F24 keyboard;;;

;LEFTCTRL -> SC071/Lang2 -> GMAIL INBOX
SC071 up::gotofiretab("Linus Media Group Inc. Mail","https://mail.google.com/mail/u/0/#inbox","says...")
;or a tab that says "says..."
; a::recallClipboard("a")
; +a::saveClipboard("a")
; s::recallClipboard("s")
; +s::saveClipboard("s")
; d::recallClipboard("d")
; +d::saveClipboard("d")
; f::recallClipboard("f")
; +f::saveClipboard("f")
a::
s::
d::
f::
g::
h::return
j::sendinput, ^!o ;render audio
k::sendinput, ^!i ;render entire work area (in to out)
l::return
`;::tooltip, you pressed  %A_thishotkey% ;fun fact, the syntax highlighting gets this wrong. ";" is escaped, and therefore is not actually a comment.
'::send, ^+!, ;this is the premiere shortcut for "show audio keyframes" (on timeline)
enter::
if WinActive("ahk_class Premiere Pro")
	{
	prFocus("timeline")
	sleep 10
	sendinput, ^!+n ;toggle audio names
	}
return

SC07D::
;(AZIO keyboard) RShift -to-> SC07D:International3 -to-> Show Through Edits
if WinActive("ahk_class Premiere Pro")
	{
	prFocus("timeline")
	sleep 10
	sendinput, ^!+/ ;my "show through edits" shortcut in Premiere
	}
return

;;;;;next line;;;;;;;;
;;;this is the azio F24 keyboard;;;
;;;oh god the chaos of my code. it's awful but it works somehow

;Lshift::tooltip, you pressed F24 then %A_thishotkey%
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

;;;this is the azio F24 keyboard;;;

space::tooltip,
; Ralt::msgbox, Ralt - doesnt work
; Rwin::msgbox, Right Win 
; Rshift::msgbox RIGHT SHIFT lol

;Lwin -to-> SC072:Lang1
SC072 up::
switchToTeams()

;switchToSavedApp(ahk_class Chrome_WidgetWin_1)
;windowSwitcher(ahk_class Chrome_WidgetWin_1, ahk_exe Teams.exe)
;ahk_class Chrome_WidgetWin_1
;ahk_exe Teams.exe

;msgbox,,,sc072,0.5
;msgbox,,, trying to open VNC,0.5

; IfWinNotExist, ahk_class TvnWindowClass
	; Run, C:\Program Files\TightVNC\tvnviewer.exe
; if WinExist("ahk_exe tvnviewer.exe")
	; WinActivate ahk_exe tvnviewer.exe
	
return




appskey::msgbox, "this is the appskey KEY maybe. You should never see this message."

;AZIO Ralt -to-> SC077:Lang4 -to-> pin to clip
SC077::
tippy("pin to clip")
prFocus("effect controls")
send, ^!p ;my premiere shortcut for pin to clip is ctrl alt P
sleep 20
return


;RWin -to->> sc078:Lang3 -to->> OBS
SC078::
tooltip, rightWin -> SC078:Lang3 -> OBS
IfWinNotExist, ahk_class Qt5QWindowIcon ;this is broken, plz fix
	Run, C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe
if WinExist("ahk_exe tvnviewer.exe")
	WinActivate ahk_exe obs64.exe
return

PrintScreen::return
ScrollLock::return
SC061::msgbox,,, scancode061,1
;CtrlBreak::msgbox, CTRL BREAK?
;pause::msgbox, is this the PAUSE key?? IDK
;Break::msgbox, Maybe THIS is the pause/break key???

pgdn::tooltip, you pressed F24 then %A_thishotkey%
end::tooltip, you pressed F24 then %A_thishotkey%
delete::sendinput, ^!+j ;lock/unlock all audio tracks
pgup::tooltip, you pressed F24 then %A_thishotkey%
home::tooltip, you pressed F24 then %A_thishotkey%
insert::sendinput, ^!+l ;lock/unlock all video tracks

up::
tooltip, uppp
WinGetPos,,, Width, Height, A
WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
return

down::
left::
right::tooltip, you pressed F24 then %A_thishotkey%

;;;;;next area;;;;;;;;
;;;this is the azio F24 keyboard;;;

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

numpad6::tooltip, you pressed F24 then %A_thishotkey%

numpad7::monitorKeys("source","^{numpad5}") ;source monitor res to 1/2. ^{numpad2} does not work because CTRL SHIFT ALT 2 is the shortcut for the source monitor. cross talk.

numpad8::monitorKeys("program","^+2") ;program monitor res to 1/2

numpad9::tooltip, you pressed F24 then %A_thishotkey%

;+numlock::
SC05C::monitorKeys("source","^{numpad3}") ;source monitor res to 1/4

numpadDiv::monitorKeys("program","^+3") ;program monitor res to 1/4

numpadMult::send, +`` ;premiere shortcut for "Maximize (program?) Monitor"
numpadSub::tooltip, you pressed F24 then %A_thishotkey%
numpadAdd::sendinput, +!{F10} ;default is shift alt F10, and i hate thingies that dont use the ctrl key
numpadEnter::
sendinput, ^!m ;mute/unmute mic - shadowplay ;unfortunately ctrl alt m is also NEW COMMENT in google sheets... i might wish to change it
tippy("this should work")
return

numpadDot::
sendinput, !{F9}
return
;tooltip, you pressed F24 then %A_thishotkey%


;SC070::msgbox,,, SC070 - "Keyboard intl 2 INSIDE OF F24", 0.5

#if
;END OF FULL F24 AZIO KEYBOARD





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


;okay, so these keys MUST be AFTER the HASU USB QMK launched keys, otherwise BOTH scripts will be called, which is bad. IDK why, but putting them down here fixes the problem.
;addendum: if #IfWinActive ahk_exe explorer.exe is BEFORE the 2nd keybaord code, it executes all by itself. So yeah, the secondary keyboards must be before all else.


; __________________________________________________________ 
;|                                                          |
;| PRIMARY KEYBOARD, (Corsair K95 RGB) AHK KEY ASSIGNMENTS  |
;|__________________________________________________________|
;					(\__/)  ||
;					(•ㅅ•)  ||
;					/ 　 \づ|| 

;;;~~~~~~FUNCTION KEYS IN VARIOUS PROGRAMS~~~~

;;FIREFOX KEYS
#IfWinActive ahk_class MozillaWindowClass ;or ahk_class Chrome_WidgetWin_1
!F1::send ^+{pgup}
!F2::send ^+{pgdn}
; F2 & f20::send ^+{pgdn}

F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab

;these are for when I am music surfing
End::send ^+{tab} ;control shift tab, which goes to the next tab
PgDn::send ^{tab} ;control tab, which goes to the previous tab

PgUp::send ^w ;control w, which closes a tab

;these are also for music surfing.
;macro key G8
F19::up
;macro key G11
F15::down
;macro key G9
^+J::enter ;not particularly stable, but I'm out of function keys...

F3::send ^w ;control w, which closes a tab
F4::send {mButton} ; middle mouse button, which opens a link in a new tab.



#IfWinActive ahk_exe AfterFX.exe
F1::twirlAE(1)
F2::twirlAE(0)

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
;;U CAN GET TO PHOTOSHOP SHORTCUTS BY HITTING CTRL SHIFT K
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^o ;this WAS ctrl W instead, but i wanted to use that for duplicating layers. so i do. Also note that CTRL E is combining layers.

;F4 is AVAILABLE

;F5 super rasterize layer. move that code here.
;F6 convert to sRGB
;F7 convert to LAB

;F8 is now LENS BLUR (default is INFO window.)
;F9 is AVAILABLE

;F10 is SMOOTH SELECTION? I don't feel great about it.
;F11 is EXPAND SELECTION by 1
;+F11 should make CONTRACT SELECTION by 1

; F12 is 200% nearest
; ^F12 is 300% Nearest
; +F12 is 50% bicubic sharper?
; ^+F12 is 50% Nearest? Maybe switch with the previous one.
;
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; ;RIP Monty Oum https://youtu.be/qSuTnCFqMkw?t=1m21s
; #IfWinActive ahk_exe Photoshop.exe
; F1::sendinput {alt down}iac{alt up}





;;;;;;;;;;;;;;EXPLORER SHORTCUTS;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;EXPLORER SHORTCUTS;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;EXPLORER SHORTCUTS;;;;;;;;;;;;;;;;;



;; ----- Maybe mothball this one ------;;;;;;
#IfWinActive, ahk_group ExplorerGroup ;this does not work...
; ctrl L, alt D, or F4 will highlight the address bar. But in different ways..?
;IDK if I need this script at all anymore.
^+!d::
sleep 10
Sendinput !d
sleep 10
return
;; ----- Maybe mothball that one ------;;;;;;


;;just some tests
; #IfWinActive
; F10::send, {SC10d} 
; F11::send, {SC10e} 
; F12::send, {SC10f} 



; #IfWinActive, ahk_class #32770 ahk_exe Adobe Premiere Pro.exe ;this is specifically premiere's save/load dialoge.

#if WinActive("ahk_class #32770") and WinActive("ahk_exe ShareX.exe") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Sendinput, !{up} ; go DOWN one folder level in explorer


; left & right::msgbox, hello
#if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save Project") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Sendinput, !{up} ; go DOWN one folder level in explorer


#if WinActive("ahk_class #32770") and WinActive("ahk_exe Adobe Premiere Pro.exe") and WinActive("Save As") ;this is very specifically premiere's save/load dialoge, and it is NOT the Export Settings window.

`::Send !{up} ; go DOWN one folder level in explorer


;;+`::Send !{left} ;shift tilde will go "back" in explorer

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
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
F6::RemoveDashes() ;when saving Audioblocks sound effects, because filenames with dashes or underscores in them cannot be searched for in Windows' fole system, which is also stupid. So this makes it so  that i don't have to manaully remove those or retype the filenames.

#if WinActive("ahk_class #32770") and WinActive("ahk_exe 4kvideodownloader.exe") 
`::Send !{up} ;DOWN one folder level in 4k video downloader
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field

#if WinActive("ahk_class #32770") and WinActive("ahk_exe WINWORD.exe")
`::Send !{up} ;DOWN one folder level 
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field



#IfWinActive ahk_exe explorer.exe ;IDK if there is any meaningful difference for using the ahk_exe rather than the ahk_CLASS

;Oh, if you are on the desktop, the EXE is the same, but the class is not. So if you hit ALT F4, you go into the shutdown menu. Not good. So i think the class is a better indicator that you are, specifically, in an Explorer WINDOW.



#IfWinActive, ahk_class CabinetWClass ;this is also explorer

; https://www.winhelponline.com/blog/master-list-keyboard-shortcuts-windows-10/

;because I'm probably transferring images from explorer to firefox or vice-versa, and I want to be able to still easily go from one tab to the next.

F1::switchToFirefox() ;I'm not so sure about this.

;F2:: ;Windows default for renaming a file or folder.

F3::
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return
;this converts F3 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.
;F3 by default: "Search for a file or folder in File Explorer"

;F4:: is Windows default to highlight the Address bar, I believe

;F5:: is windows default to refresh. gonna keep THAT one!

;F6:: Windows default is "Cycle through screen elements in a window or on the desktop." We don't need THAT!
;F6::RemoveDashes()

;F7:: unused currently

;F8:: unused currently

;F9:: unused currently

;F10:: "Activate the Menu bar in the active app." This is the same as ALT menu acceleration, which i hate of course.

;F11:: unused currently. But in fact it acts as a full screen-ifier. Don't need that.

;F12:: unused currently


;;`::Send !{up} ;go DOWN one folder level in explorer. Discontinued.
;;The script above worked fine 99% of the time. But if you have a FILE selected, and that file has a preview thingy showing, it would NOT work -- instead, it would highlight the menu acceleration. Sad!! Manually hitting ALT UP  would still work in that situation, though.
;;After some experimentation, I discovered that adding a small delay between virtual keystrokes is essential for this to work in those situations.
;so instead, I have to use the script below:
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
;note to self, check for stuck modifier keys on this one too...
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field - very useful!!
return


home::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_Window(exphWnd) ;list mode
return


end::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_ICONS(exphWnd) ;icon mode
return


; ;these are not very reliable, I have been REALLY trying to get a direct execution of this command. might need C++ for that, IDK.
; ; pgup::send, {alt}vo{enter} ;sort by name
; ; pgdn::send, {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...


pgup::
sortByName() ;doesn't work both ways...
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field. wish i knew how to do this with DLL calls though.
return
;sort by name

pgdn::sortByDate()
;sort by date modified

; ; ^F12:: ;test SHGetNameFromPropertyKey
; ; vName := "System.ItemNameDisplay"
; ; PROPERTYKEY := ""
; ; VarSetCapacity(PROPERTYKEY, 20, 0)
; ; DllCall("propsys\PSGetPropertyKeyFromName", Str,vName, Ptr,&PROPERTYKEY)

; ; MsgBox, % DllCall("propsys\PSGetNameFromPropertyKey", Ptr,&PROPERTYKEY, PtrP,vAddrName)
; ; vName := StrGet(vAddrName, "UTF-16")
; ; MsgBox, % vName ;System.ItemNameDisplay
; ; DllCall("ole32\CoTaskMemFree", Ptr,vAddrName)
; ; return


;+++++++++ SHORTCUTS THAT WORK IN ALL PROGRAMS +++++++++
#IfWinActive

; ;;shortcut to CLOSE FIREFOX with no bullshit or fanfare or annoying dialouge boxes that try to argue with you. Just completely nuke it from orbit so we can start over
; ^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide


; ;shortcut to forcefully CLOSE PREMIERE ALREADY, WITH NO BULLSHIT. BULLDOZE IT FLAT, BURN IT, SALT THE EATH, NUKE IT FROM ORBIT. JUST FUCKING DIE!!!
; ;.......This doesn't work.... Might need C++ for this...
; ^!+p::
; Run, %comspec% /c "taskkill.exe /IM /Adobe Premiere Pro.exe /T /F" ;,, hide
; sleep 100
; ;Run, %comspec% /c "taskkill.exe /F /PID 72536",, hide
; tooltip, killed premiere
; sleep 100
; tooltip,
; return

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
!^F2::closeAllExplorers() ;aaah, this doesn't work from premiere because I swapped it out with a direct launch on that key. riiight.

;macro key G18
^F3::switchToPremiere()

;macro key G15
^F4::switchToWord()
+^F4::switchWordWindow() ; AKA, ^+F4 ^+{F4}

;No K95 macro key assigned:
^F5::switchToChrome()
;also, CTRL works a little funny when the function uses CTRL TAB to switch tabs. This might be better assigned to ALT F5 or something.

;SHIFT and then macro key G14
+^F6::
windowSaver()
msgbox,,, savedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%, 0.6
Return

;Macro key G14
^F6::
;I had to learn just now to use the parameter to pass "savedCLASS" even though it's already a global variable. Just works better this way... but really IDK what i am doing.
;msgbox,,, switching to `nsavedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%,0.3
;switchToSavedApp(savedCLASS, savedEXE) ;obsolete
windowSwitcher(savedCLASS, savedEXE) 
return

;No K95 macro key assigned:
^F9::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.

; ; ^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")

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
; !,::msgbox, A_workingDir should be %A_WorkingDir%
; !.::msgbox, TaranDir should be %TaranDir%
; Xbutton1::return
; Xbutton2::F20
;but they do do stuff in premiere now.

;---------------------BEGIN ASSIGNMENT OF ALL 18 K95 MACRO KEYS---------------------

#IfWinActive
;macro key G1 on K95. universal SEARCH EVERYTHINGER
; this used to have a ~ to let it pass through... not sure why. it was creating an ENTER keypress effect in notepad++ so i removed it.
;uh actually this is G9?

;^+J:: ;this is the old shortcut that would require the 11ms delay.
F21 & F8::search()


#ifWinActive
;MACRO KEY G2 on the K95
^numpad0::
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	{
	sleep 11 ;this sleep for 11 milliseconds is to avoid the infamous STUCK MODIFIERS error, because i have my K95 command holding this down for 10 ms, and it would release ctrl at some arbitrary point during the AHK script execution! Makes perfect sense now...
	;might wanna reduce the delay all to 5ms if 10ms feels too long. and YES i can feel time differences in incremements of 10ms... but no lower.
	easeInAndOut()
	}
else
	return ;for now, this key does nothing in other applications
return


;~^+K::preset("Warp Stabilizer Preset") ;macro key G2 used to be the stabilizer preset.
;~^+=::effectsPanelType("presets") ;this WAS macro key G3. ;Types in "presets," which reveals my own entire list of presets. ;;I have canceled this one in favor of a global pause/play. 

#ifWinActive
;macro key G3
^+L::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
stopPlaying()
return
;Outside of premiere, it will STILL work to pause/play the timeline, due to some other code somewhere else...
;;NOTE that this shows up also as a huge bit of script when premiere is NOT in focus, must be moved to All Premiere Functions.

#ifWinActive ahk_exe Adobe Premiere Pro.exe

;macro key G4.
;I've removed the ~ that was in front of them.
;;;^+,::audioMonoMaker("left") ;this function doesn't work as well anymore and I don't need it as much lately.
^+,::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
preset("50%")
return

; macro key G5.
;;;;^+.::audioMonoMaker("right")
^+.::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
preset("50%") ;this is a temporary assignment until I can get a better thing for this key.
return

;note that i have capslock remapped to F20
F20::home
; and "home" is set to "disable (clip)" in premiere.
;you can actually do this directly. I'm not sure why I set it up that way....



; #ifWinActive ahk_exe Adobe Premiere Pro.exe


; !f::f
; !e::e
; !c::c
; !s::s
; !m::m
; !g::g
; !v::v
; !w::w
; !h::h



#ifWinNotActive ahk_exe Adobe Premiere Pro.exe
;macro key G4.
^+,::msgbox,,,Macro G4 not yet assigned outside premiere,0.7
; macro key G5.
^+.::msgbox,,,Macro G5 not yet assigned outside premiere,0.7

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G6
;modifiers -- I removed the ~
^+U::
sleep 11 ;I need this because I put a 10ms delay before the key UP events in iCue. I had to do THAT because otherwise it would go too fast for AHK to even notice. Without this delay, those up events will happen while the function is running, which can lead to modifier keys that are virtually stuck DOWN, which is super bad and annoying.
reSelect() ;formerly ^+9
;;;in premiere, ctrl shift u is now assigned to SUPER PURPLE temporarily at least.
return

;G6 is assigned to single left click in iCue if the "All" profile is active, which it is (automatically) unless Premiere is active. I only have the two profiles - premiere, and everything else.

#IfWinActive ahk_exe firefox.exe
F18::Send, !+5 ;alt shift 5 is "strikethrough" in Google docs...

#IfWinActive ahk_exe chrome.exe
F18::Send, !+5 ;alt shift 5 is "strikethrough" in Google docs...

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

;Script to put a word comment into a lengthend marker in Premiere.
;note to self, move this to where it belongs
F12::
sendinput, ^a
sleep 80
sendinput, ^c
sleep 15
WinActivate ahk_class Premiere Pro
sleep 20
prFocus("timeline")
sleep 30
Send,{LCtrl up}
Send,{RCtrl up}
sleep 1
Send,{RAlt up}
Send,{RAlt up}
sleep 1
Send,{LShift up}
Send,{RShift up}
sleep 2
send, ^!d ;ctrl alt D is  "deselect all" (clips on the timeline)
sleep 20
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 30
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 20
send, ^`; ;CTRL SEMICOLON is my premiere shortcut for "(add) marker."
sleep 10
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 10
send, ^`; ;if you press it again, it opens that comment.
sleep 50
send, {left} ;IDK why this is here but it's important.
send, ^v ;pastes the text into the title area
sleep 10
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
;sleep 500
send, +{tab} ;shift tab will make it highlight the "duration" field
sleep 10
send, 00:00:04:00
sleep 10
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 10
;unstick any modifier keys, UGH what a pain this is to deal with
Send,{LCtrl up}
Send,{RCtrl up}
sleep 1
Send,{RAlt up}
Send,{RAlt up}
sleep 1
Send,{LShift up}
Send,{RShift up}
sleep 10
send, {enter}
sleep 10
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
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


; #IfWinActive ahK_exe Adobe Premiere Pro.exe
; ;TITLE BAR REMOVER
; ;;ctrl backslash is a nice shortcut in MACINTOSH Premiere for hiding the title bar. There is no Windows equivalent... unless you use autohotKey!
; ;;WARNING THOUGH - i think this script makes premiere less stable. I hardly use it...
; ;;https://jacKsautohotKeyblog.wordpress.com/2016/05/27/autohotKey-toggles-and-the-ternary-operator-beginning-hotKeys-part-18/
; ^\::
  ; If (toggle := !toggle)
    ; WinSet, Style, -0xC00000, A
  ; else
    ; WinSet, Style, +0xC00000, A
; Return

;UPDATE:
;Premiere in Windows now HAS this feature by default!! But there is no visible shortcut for it in the shortcuts mapper, strangely enough. anyway, that makes my script obsolete. yay!


#IfWinActive ahK_exe Adobe Premiere Pro.exe
;tab::7 ;"7" is set to enable/disable for now. just testing stuff
appskey::sendinput, ^!k ;in premiere's shortcuts panel, CTRL ALT K is set to "clear selected marker." You can't assign it DIRECTLY to appskey, so I do it here.

^w::closeTitler()

;;;below thing is no longer needed. Premiere now has this feature by default.
;~+K::KbShortcutsFindBox() ;this one DOES need the ~ so that capital Ks will work in the titler, and so that the keyboard shortcuts panel will actually launch when it is pressed.
;Note, if you don't arealdy know —the ~ is dangerous since it can lead to stuck modifier keys. I still don't know exactly why, or how to stop it.

;no longer used:
;!]::preset("DeHummer Preset") ;This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

;Pressing ALT W will send CTRL ALT SHIFT W, which is set to "Trim Next Edit to Playhead" in Premiere. This is to get around Premiere's menu acceleration, and annoying warning noise. Otherwise, I could have just assigned these commands directly to ALT Q and ALT W.
!w::^!+w ;"Trim Next Edit to Playhead" (not RIPPLE trim.)
!q::^!+q ;"Trim Previous Edit to Playhead" (not RIPPLE trim.)
; for more information: https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.ahk


; !f::f
; !e::e
; !c::c
; !s::s
; !m::m
; !g::g
; !v::v
;;!w::w
; !h::h

!f::return
!e::return
!c::return
!s::return
!m::return
!g::return
!v::return

!h::return



#IfWinActive ahk_exe Adobe Premiere Pro.exe

F21::return
;^+]:: ;I decided that if a trigger key uses certain modifiers,
;then those same modifiers must not turn up in in the macro itself... this is troublesome...
;update - turns out i need 11ms of delay instead.
F21 & F7::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
Send {F2}7{enter} ;adds 7 gain. ; +7db 

;note to self, maybe have some code here to fix a stuck shift or CTRL key...
;update to note, that is no longer needed!
return

F21 & F8::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
search()
return

; control shift r = reverse selected clip
^+r::Send ^r{tab}{tab}{space}{enter}


#IfWinActive ahk_exe Adobe Premiere Pro.exe


;This script is to stop, rewind 3 seconds, and then play. Premiere's version of this SUCKS because it brings you back to where you started
; the ~ is only there so that the keystroke visualizer can see this keypress. Otherwise, it should not be used.
;Lwin::
;~!space:: ;note, the ~ might result in stuck modifier keys, so i am not using it anymore...
!space::
Rwin::
Send s ;"stop" command (From JKL remapped to ASD.)
Send +{left}
Send +{left}
Send +{left}
sleep 10
Send d ;"shuttle right" command. Might be best to instead have it on a key combo that includes CTRL....
return

;;no longer used:
; control g = make 200% speed
;^g::
;Send ^r200{Enter}
;return
;;no longer used:
; control h = make 50% speed
;^h::
;Send ^r50{Enter}
;return


;----ALL STANDARD FUNCTION KEYS IN PREMIERE------
;;;PREMIEREKEYS;;; <--for easy searching

#IfWinActive ahk_exe Adobe Premiere Pro.exe
F1::
Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
;Send ^c ;ctrl c is [copy] ;was just testing a thing for a guy.
Send ^+!d ;ctrl alt shift d  is [ripple delete]
return
;F2 is set in premiere to the [GAIN] panel.
;F3 is set in premiere to the [MODIFY CLIP] panel. 

#IfWinActive ahK_exe Adobe Premiere Pro.exe
;; instant cut at cursor (UPON KEY RELEASE) -- super useful! even respects snapping!
;note to self, move this to premiere_functions already
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4::
;keywait, F4
;tooltip, |
send, b ;selects the blade tool
send, {shift down} ;makes the blade tool affect all (unlocked) tracks
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
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

F5::clickTransformIcon2()
F6::cropClick()

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;;DELETE SINGLE CLIP AT CURSOR
F9::
prFocus("timeline") ; you can't just send ^+!3 because it'll change the sequence if you do. you have to go to the effect controls fiurst. that is what this function does.
send, ^!d ;ctrl alt d is DESELECT. this only works if the timeline is in focus.
send, v ;selection tool
send, {alt down}
send, {lbutton}
send, {alt up}
send, c ;delete
return

;this code is to remind me to do a thing, when i am rendering anyway.
~^e::
TrayTip, Make an EDL, Hey did you export an EDL yet, 2, 32
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;cut single clip at cursor.
Xbutton1::
;F7::
send, ^!d ;ctrl alt d is DESELECT
send, b ;blade tool
;keywait, F7 ;waits for the key to go UP.

send, {alt down}
keywait, %A_thishotkey% ;waits for the key to go UP.
send, {lbutton}
send, {alt up}
sleep 10
send, %currentTool%
return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Disable single clip at cursor - must turn this into a proper function.
Xbutton2::
;F8::
send, ^!d ;ctrl alt d is DESELECT
send, v ;selection tool
send, {alt down}
send, {lbutton}
send, {alt up}
send, {home} ;disable
sleep 10
;I have a fancy way of figuring out which tool i WAS using. Is just be a thing that listens for v t r y b x h p and saves that as a string.

send, %currentTool%
return




;~F9::masterClipSelect() ;this has not been fully programmed yet
;F10:: ;unused for now. Acts as a menu accelerator in Windows applications!! why the heck do they think they also need ALT, then???
;F11:: ;unused. "Full screen" in Firefox and chrome.
;F12:: ;unused. "Inspector" in Firefox and chrome.

;============== CURRENT TOOL REMEMBERER ================

;IMPORTANT - these are MY keyboard assignments for tools
;Your own assignments will probably be different!
~v::
~t::
~r::
~y::
~b::
~x::
~h::
~p::
currentTool = %A_thishotkey% ;so, %currentTool% might become r or y or v. Whatever the last tool is that I selected.
return

;;**********************MEDIA KEYS IN PREMIERE**********************
#IfWinActive ahk_exe Adobe Premiere Pro.exe
;;the top rightmost keys on my K95.
Media_Stop::^numpad7 ;select label group
;Media_Prev::^numpad8
Media_Prev::
send {down}
sleep 1
send u
sleep 1
send 0
sleep 1
return

Media_Play_Pause::^numpad9
Media_Next::^numpadMult
;Volume_Mute::^numpadDiv
;These are assigned to some of the new LABEL COLORS in premiere, using Premiere's own shortcut assignment panel.


;===================================================================
#ifWinActive ahk_exe firefox.exe
!x::!+x ;this is the shortcut for Nuke Anything Enhanced.

;these are shortcuts for youtube's interface to slow down, pause/play, and speed up.
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,


;;&&&&&&&&&&&&&& KEY ASSIGNMENTS FOR PHOTOSHOP &&&&&&&&&&&&&&&&&&&&&
#IfWinActive ahk_exe Photoshop.exe

;;-----------------IMPORTANT NOTE--------------------:
;;In Photoshop,
;;alt F13 rotates 15 degrees clockwise
;;alt F14 rotates 15 degrees counter clockwise
;;alt F15 is zoom out
;;alt F16 is zoom in
;;They cannot be remapped in Photoshop. Nor do they show up in the list you get when you press the Summarize button in Photoshop's shortcuts menu.
;;https://twitter.com/TaranVH/status/1129206615515705344
;;https://forums.adobe.com/thread/1453594


;anyway, f14 is labeled "scale" already on my Corsair K95, so I'm going to use it for brush resizing in Photoshop.
F14::
tooltip, f14
sendinput {Lalt down}
sendinput {Rbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F14 ;waits for F14 to be released
sleep 1
sendinput {Rbutton up}
sendinput {Lalt up}
tooltip,
return

;This will work, but ONLY if you don't have some OTHER AutoHotKey script running, even one that has nothing to do with Photoshop specifically. .... in THAT case, the keys end up being not fully blocked, and can slip through.

;actually, just to keep things safe, I'm going to manually block them.
!F14::
!F15::
;!F16::
;!F17::
;do nothing.
return

;;ATTENTION WACOM TABLET USERS. I APOLOGISE FOR BREAKING YOUR SHIT. WACOM/ADOBE COULD THINK OF NO WAY TO LIKE, INTERFACE DIRECTLY. THEY HAD TO GO AND STEAL SOME OBSCURE SHORTCUTS THAT THEY THOUGHT NOBODY WOULD USE. WELL THEY DIDN'T KNOW THAT TARAN "MACRO" VAN HEMERT WAS ON THE CASE.
;;ANYWAY, YOU CAN JUST REMOVE THE ABOVE STUFF AND GET YOUR WACOM SHORTCUTS BACK. (Thread about wacom stuff: https://forums.adobe.com/thread/1453594)

F5::
sendinput, {F5} ;this is my shortcut for "Rasterize > Layer"
sleep 1
sendinput, ^!+{F5} ;this is my shortcut for "Rasterize > Layer style"
;You're not allowed to put both of these commands on the same shortcut, but to that I say BULLSHIT, I DO WHAT I WANT.
sleep 10
sendinput, ^!k ;ctrl alt K is my photoshop shortcut for Layer Mask > Apply.
return



;This is absolutely bizarre. When I had the below shortcuts in their own separate script,, F15 and F14 when paired with alt and right mouse button clicks, and manual LEFT mouse button clicks,, would zoom in and rotate the canvas, respectively. IDK wtf is going on with that.

;fix stupid requirement to hold CTRL for photoshop zooming...
-::
send, ^- ;zoom out
sleep 5
;send, {ctrl up} ;I've had issues with modifier keys getting stuck
return

=::
send, ^= ;zoom in
sleep 5
;send, {ctrl up} ;I've had issues with modifier keys getting stuck
return



;;&&&&&&&&&&&&&&&&&&&& PHOTOSHOP END &&&&&&&&&&&&&&&&&&&&&

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

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G7
~F17::
global VFXkey = "F17"
instantVFX("rotation")
return

;F16 is not currently used for anything

;Macro key G10
~F18::
global VFXkey = "F18"
instantVFX("anchor_point")
return

;Macro key G8
~F19::tracklocker()
~+F19::tracklocker()

#IfWinActive


;
;;I can't use ~ thingies or these keys can very easily get stuck...
;oh boy THIS RIGHT HERE IS A MESS i gotta clean up someday. caplock sometimes gets stuck or maybe it's just the shift key(s). gotta make this better. work better.
Rshift & Lshift::capslock
Lshift & Rshift::capslock
^capslock::capslock ;only CTRL CAPSLOCK will now turn on capslock, freeing the real capslock key to be used as a MODIFIER KEY, just like CTRL.
^F20::capslock ;because I actually used my Corsair keyboard to remap capslock to F20 DIRECTLY, this is the real line that I need to give myself the REAL capslock key.
~F20 & LCTRL::Capslock ;IN CASE THE CAPslock key goes down first.
;capslock::F20 ;not needed if you can do it directly, with a Corsair keyboard

;F20 is triggered by capslock, and adds a 2nd layer to keyboard #1.
;F21 - reserved for a 4th and probably final keyboard
;F22 - FREE FOR NOW, PROBABLY
;F23 is for the 2nd keyboard, the Logitech K120. Will maintain for sake of tutorials.
;F24 (SC076) is the FULL AZIO KEYBOARD. ;F24 used to be used for LuaMacros.

;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
; There are still keys beyond F24! Check out 
; https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
; for more information. Very useful to know. If you're a Taran.
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

;Below here is a bunch of potentially useful stuff, for future development. Some of it can be triggered by my Corsair keyboard, and some of it cannot.

#IfWinActive



<#WheelUp::
sendinput, {Volume_Up}
sendinput, {SC0E9}
return

<#WheelDown::
sendinput, {Volume_Down}
sendinput, {SC0E9}
return
;;holding the windows key and scrolling will now change the volume.
;;I'm only gonna use this for laptops that don't have dedicated volume keys.
;;also this script sucks because it still launches the windows menu but IDK how to resolve that right now and it's just not worth figuring out.

;;https://jacksautohotkeyblog.wordpress.com/2016/03/08/windows-volume-control-using-your-mouse-wheel-and-the-autohotkey-if-directive-beginning-hotkeys-part-6/



; 




;;---------------------------------------------------


;+++++++++++++++++++++++++++++++
;macro for moving GOOGLE SHEETS' or EXCEL's B-roll matrix information into WORD
; #IfWinActive ;ahk_class MozillaWindowClass
; #IfWinNotActive ahk_exe Adobe Premiere Pro.exe

#if WinActive("ahk_exe EXCEL.exe") or WinActive("ahk_exe firefox.exe") ;might have to add chrome to this eventually.

;Macro key G7 i think
F17::
doAnEnter := 1
sendinput, ^c
sleep 100
;WinActivate ahk_exe firefox.exe
; send ^{F4} ;shortcut for activate word, and if active, move to next comment.
; msgbox, EXTREMELY WEIRD - the above code would CLOSE THE TAB. IDK what kind of cross-talk was going on... will look into that later.
if WinActive("ahk_exe EXCEL.exe")
	doAnEnter := 0 ;sooo if you're copying out of Excel rather than google sheets, the copied cell has it's own "return," so you don't need to add one.
switchToWord()
sleep 100
send ^v
sleep 100
if (doAnEnter = 1)
	send {enter}
sleep 10
; send ^{F4} ;only use this line if switchToWord() is not directly available.
;;;;msgbox,,, just before,0.5
; switchToWord()
sendinput, {F2} ;in word, "go to previous comment."
sleep 10
;;;;msgbox,,, thingy is over,0.5
;WinActivate ahk_class MozillaWindowClass
;sometimes this code activates the paragraph thingy, which is CTRL SHIFT 8. will look for other cross talk.
return


;#if WinActive("ahk_exe firefox.exe")
#ifWinActive ahk_exe firefox.exe
;Macro key G11 to left click. Just because I hate clicking on the tiny little play buttons on apmmusic.ca and this reduces RSI by sharing the load with my left hand.
F15::Lbutton
; sendinput, Lbutton
; tooltip, hi
; return

;;shift tilde will full screen  a page
;+`::send, {F11}

; ;experimental caps lock to full screen for firefox:
; F20::send, {F11}

;"scale" key will fullscreen firefox now. (macro G12)
F14::send, {F11}



#IfWinActive
;experiemntal thing to super duper checK window IDs...
!`::
WinGet, ActiveId, ID, A
msgbox, %ActiveId%
;returns 0x1c0b9c ... and only 3 unique codes for each of the 3 Premiere windows I have on my 3 monitors. Does NOT consider subwindows, though maaaaybe it can get that going....
ControlGetFocus, OutputVar, A
msgbox, %OutputVar%
return

^+end::checkFullness()



;script reloader, but it only worKs on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return


;#IfWinActive
;;;https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/



F9::ConvertSentence()
; ^+F9::Convert_Cap()

; Convert_Cap()
; {
 ; Clip_Save:= ClipboardAll                                                 ; save original contents of clipboard
 ; Clipboard:= ""                                                           ; empty clipboard
 ; Send ^c{delete}                                                          ; copy highlighted text to clipboard
 ; StringLower Clipboard, Clipboard                                         ; convert clipboard to desired case
 ; Send %Clipboard%                                                         ; send desired text
 ; Len:= Strlen(Clipboard)
 ; Send +{left %Len%}                                                       ; highlight text
 ; Clipboard:= Clip_Save                                                    ; restore clipboard
; }

ConvertSentence()
{
	click left
	click left
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard
	Clipboard := RegExReplace(Clipboard, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
	Len:= Strlen(Clipboard)
    SendInput, ^v ;pastes new text
	Send +{left %Len%}
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave
}


;;;;;;;**************this is where I had a blank, 4th, "F22" keyboard all set up, but I moved it. **************
;;;;I don't actaully use 4 total keyboards in my work. Well, not yet.









;::---::— ;this one just results in â€” being typed.
:*:--- ::{Asc 0151}
;converts three dashes into an EM dash. https://superuser.com/questions/857338/how-to-add-the-em-dash-to-my-keyboard

; ^-:: ;en dash (150/x96)
; Send –
; Return

; !-:: ;em dash (151/x97)
; Send —
; Return

; !^-:: ;bullet (149/x95)
; Send •
; Return
;;https://www.experts-exchange.com/questions/29046416/Favorite-way-to-make-an-em-dash.html




;;;Script to use F11 and F12 to scroll down and up! Useful for wacom tablet users who don't have a scroll wheel.
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

;;MODS - script to fix stuck modifier keys
;this is ANY key though
; KeyList := "Shift|a|b|c|d|e|f|g|h|i|j" ; and so on

; Loop, Parse, KeyList, |
; {
    ; If GetKeystate(A_Loopfield, "P")
        ; Send % "{" A_Loopfield " Up}"
; }

; KeyList := "Shift|ctrl|alt" ; and so on

; Loop, Parse, KeyList, |
; {
    ; If GetKeystate(A_Loopfield, "P")
        ; Send % "{" A_Loopfield " Up}"
; }

#ifwinactive

;;i used this to delete premiere title styles quickly.
; numpadsub::
; click right
; sleep 5
; send d
; sleep 5
; send d
; sleep 5
; send {enter}
; sleep 5
; send {enter}
; return

^+!Escape::ExitApp

^+/::sendinput, !{F9}
;
;
