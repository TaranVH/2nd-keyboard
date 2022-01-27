SetWorkingDir, C:\AHK\2nd-keyboard\support_files
;the above will set A_WorkingDir. It must be done in the autoexecute area.
; ; ;SetNumLockState, on ;This doesn't work, needs to be done in admin mode.
; ; ;SetScrollLockState, off

Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something

; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe" 
;This has now been changed to Teams (Hangouts replacement) since I use that a lot mroe now, and Notepad++ already has a button on numpad+ on the K120 keyboard.
;This is for macro key G14 by the way.
global savedCLASS = "ahk_class Chrome_WidgetWin_1"
global savedEXE = "Teams.exe" ;BEFORE the #include is apparently the only place these can go.
;psApp := ComObjActive("Photoshop.Application") ;This is AMAZING and allows me to directly trigger photoshop actions using AHK scripts. Game changer! search "psApp" to see them all.

;when you get to #include, it means the END of the autoexecute section.
;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the single line below:
#Include C:\AHK\2nd-keyboard\gui.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\AHK\2nd-keyboard\Almost_All_Windows_Functions.ahk
#include C:\AHK\2nd-keyboard\After_Effects_Functions.ahk
#include C:\AHK\2nd-keyboard\Photoshop_Functions.ahk

;; #include causes the script to behave as though the specified file's contents are present at this exact position.
;; https://www.autohotkey.com/docs/commands/_Include.htm



SetKeyDelay, -1 ;warning ---this was absent for some reason. i just added it back in. IDK if I removed it for a reason or not...

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

; Also, I will put windows shortcuts to all the AHK scripts that I use into my startup folder... which is here for all users:
;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;  Or here for just one user:
;  C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;  There is also one here??
;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp


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
;#MenuMaskKey sc08A  ; vk07 is (was) unassigned. See my full list of scan codes and virtual keys to see what else is available: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
#MenuMaskKey vk07

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
; RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU.
; YOU MUST ADD THESE ASSIGNMENTS TOO. THEY ARE ESSENTIAL FOR THE SCRIPTS TO WORK.

; YOU CAN SEE/USE ALL MY PREMEIRE SHORTCUTS, THEY ARE HERE! https://github.com/TaranVH/2nd-keyboard/blob/master/Settings_and_shortcuts/

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
; ctrl p                toggle "selection follows playhead" (for human to use)
; ctrl alt shift 3      Application > Window > Timeline (default is shift 3)
; ctrl alt shift 1      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 4      Application > Window > program monitor (Default is SHIFT 4)
; ctrl alt shift 5      Application > Window > Effect Controls (Default is SHIFT 5)
; ctrl alt shift 7      Application > Window > Effects   (NOT the Effect Controls panel) (Default is SHIFT 7) --- The defaults are stupid. SHIFT 7 is an ampersand if you happen to be in a text box somewhere...
; F2                    gain
; F3                    audio channels --- To be pressed manually by the user. (this might change in the future.)
; ctrl alt shift a      audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; shift F               From source monitor, match frame.
; ctrl /                Overwrite (the default is "." (period))
; ctrl b                select find box - This is such a useful function when you pair it the the effects panel!!
; ---ctrl alt F         select find box —OBSOLETE ---
; ctrl shift 6			Apply source assignment preset 1 (set to V5 and A3)
; ctrl ; (semicolon)	Add Marker
; ctrl alt k			Remove selected marker
; ctrl shift alt 9 		activate lumetri scopes
; ctrl alt D   			"deselect all" (clips on the timeline)
; ctrl alt shift K 	 	"shuttle stop"
; CTRL SEMICOLON 		"(add) marker."
; ctrl shift alt R		is "reset to saved layout" (workspace)
; Media_Stop::^numpad7  select label group
; ctrl alt P            pin to clip
; ^!+j 					lock/unlock all audio tracks
; ^!+l 					lock/unlock all video tracks
; ^!+, 					show audio keyframes (on timeline)
; ^!+n 					toggle audio names (on timeline)
; ^!+/ 					Show through edits
; ^+6					Source Assignment Preset 1
; ^+7					Source Assignment Preset 2 (reserved)
; ^+8					Source Assignment Preset 3 (reserved)
; ^+9					Source Assignment Preset 4 (reserved)
; ^+m					Time interpolation > Frame sampling
; ^+k					Time interpolation > Frame blending
; ^+o		 			Time interpolation > optical flow


;----------------------------------------------------------------------------------
; KEYS                  PHOTOSHOP FUNCTIONS
;----------------------------------------------------------------------------------
;^!h 					vertical flip
;^h 					horizontal flip


; Be aware that sometimes other programs like PUUSH can overlap/conflict with your customized shortcuts.                          
;___________________________________________________________________________________
;
; NOTE:
; SC0E8: "scan code of an unassigned key" that I use to tell the computer "yeah, treat this like a keyboard,"
; SC0E9: Nullify ALT's sticky key effect. See for more info: Alt_menu_acceleration_DISABLER.ahk
; VK07:  #menumaskkey https://autohotkey.com/docs/commands/_MenuMaskKey.htm


;;;;OLD CLIPBOARD METHOD IS BELOW;;;;;;;;
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




; SC062::Copy(1)		;zoom
; vk2A::Copy(2)		;Printer
; SC16B::Copy(3)		;launch (0)

; SC16D::paste(1)		;launch_media
; vk2B::paste(2)		;Execute
; SC121::paste(3) 	;launch (1)

;note to self, this is where to go for tap dance stuff
; https://autohotkey.com/board/topic/35566-rapidhotkey/




currentTool = "v" ;This is super useful and important for a Premiere script, you'll see...



#if

; ;this is pause/break. I'm using it for debugging...

^sc045::
+sc045::
!sc045::
sc045::
; ;scratch that, I think the * (hook??) makes it insensitive to modifiers.
;;;scratch THAT, turns out CTLR SHIFT numlock will trigger if I use the line below... so i'm back to using the 3 lines above.
;*sc045::
tooltip, pause break
sleep 100
tooltip,
KeyHistory
sleep 10
return 


; ;;;for parsec, for windows that are outside the range of the new, smaller resolution... This works GREAT for parsec stuff, cause your resolution has been lowered maybe, and some dialouge boxes are outside the edge now. this will fix!
; +F12::
; tooltip, moving the active window to the center of the screen!
; WinGetPos,,, Width, Height, A
; WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
; ;WinMove, 50, 50
; ; to try to rescue the tangent ripple UI which has gone missing off the side of a monitor long ago and cannot be brought back with anything I've tried!.
; ;edit: it worked!!!!!
; sleep 30
; tooltip,
; return


; ; ctrlbreak::
; ; ^ctrlbreak::
;both removed from here because they're useless.
;https://autohotkey.com/board/topic/110524-how-to-create-a-hot-key-for-ctrl-scrolllock-vs-ctrl-pause/



;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING HASU USB TO USB (Logitech K120)  
;____________________________________________________________________
; watch https://www.youtube.com/watch?v=GZEoss4XIgc to understand how this works.
; https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/

;;ignore these next two lines, I don't rememebr what i was experiementing with, but i chose not to do it.
;;;#if (getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;;;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.


;;;;;;;;;;;;;BEGIN K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS;;;;;;;;;;;;;;;;;
#if (getKeyState("F23", "P")) ;This is the line that makes all the lines below possible.


F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.
;;This also means that you must NEVER use F23 for anything else. Doing so will sometimes allow a key to pass through unwrapped, which can cause big problems with cross-talk.

;SC06E::return ;;This is F23's scan code. Using this line acts as some more insurance against cross-talk. comment this in if you have issues.



escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9

F1::
FileRead, SECRET_TEXT, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SECRET_TEXT_NOT_ON_GITHUB.txt
Sendinput, %SECRET_TEXT%
; sleep 10
return

F2::
FileRead, SECRET_TEXT, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SECRET_TEXT_2.txt
Sendinput, %SECRET_TEXT%
; sleep 10
return

F3::
letext := "Emily Seddon - @emilypls"
sendinput, %letext%
return

F4::
letext := "Marcus Blackstock - @kacboy"
sendinput, %letext%
return


;F2::insertSFX("Whoosh19-Short") ;you may not use spaces for filenames of sounds that you want to retreive in this way... since searching in premiere will disregard spaces in a a weird way... returning multiple wrong results....
; F3::insertSFX("Whoosh7-Short")
; F4::insertSFX("Whoosh2-Short")
; F5::insertSFX("SimpleWhoosh12")
; F6::insertSFX("SimpleWhoosh11")
; F7::insertSFX("SimpleWhoosh10")
; F9::insertSFX("SimpleWhoosh3")
; F8::insertSFX("SimpleWhoosh8")
; F10::insertSFX("woosh2")

F11::
;https://autohotkey.com/board/topic/64576-the-definitive-autofire-thread/
;autoclicker
 ; While GetKeyState("F11","p"){
  ; click
  ; Sleep 50
 ; }
 
return



;F12::instantExplorer("N:\Team_Documents\N_TARAN_THINGS\prompter and cutting_room_floor") ;"FLOOR"
F12::instantExplorer("C:\Users\Taran\Downloads") ;open the downloads folder, yup.



;F12::search() ;"search" is also used on ^+j 
; F12 must not used here IF it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;
;;;;K120 keyboard;;;;;

`::msgbox tilde or weird quote thing?? K120
;1::preset("T wipe straight left")
1::DrakeynPreset("T wipe straight left")
2::preset("T wipe straight down")
3::preset("T wipe straight up")
4::preset("T wipe straight right")
; 4::
; tooltip, this happens on key down
; keywait, 4 ;waits for the key to go up
; tooltip, and this happens on key up. dang
; return
5::insertSFX("")
6::insertSFX("record scratch")
7::preset("180 hue angle")
8::preset("PAINT WHITE")
9::preset("PAINT BLACK")
0::preset("MOVE IN A0")
; 0::insertSFX("pop")
-::audioMonoMaker("left")
=::audioMonoMaker("right")

; backspace::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS")
backspace::openTightVNC()

;;;;;next line;;;;;;;;
;;;;;K120 keyb;;;;;;;;

tab::msgbox,,,K120 - you pressed tab. :P,0.8

q::preset("T wipe straight 315")
w::preset("T wipe straight 45")

e::
KeyWait, e ;waits for E to be RELEASED!
;NOTE, this worked great, so it is now a part of preset(), so it is no longer needed here.
;I'm keeping it here as a LESSON FOR YOU ALL because it doens't actually do anything bad.
preset("T wipe soft 315")
return

r::preset("T wipe soft 45")


+q::preset("T wipe WHITE LINE 315")
+w::preset("T wipe WHITE LINE 45")

+e::preset("T wipe exposure 315")
+r::preset("T wipe exposure 45")


t::recallClipboard("t")
+t::saveClipboard("t")


;;t::recallClipboard(A_thishotkey)
;;+t::saveClipboard(A_thishotkey)

y::preset("autogate -25")
u::preset("90 IRE")
i::preset("multiply")

o::
if WinActive("ahk_exe adobe premiere pro.exe")
	preset("flip vertical")
if WinActive("ahk_exe Photoshop.exe")
	sendinput, ^!h ;my photoshop shortcut for vertical flip
return

p::
if WinActive("ahk_exe adobe premiere pro.exe")
	preset("flip horizontal")
if WinActive("ahk_exe Photoshop.exe")
	sendinput, ^h ;my photoshop shortcut for horizontal flip
return

[::preset("T impact flash MED")
]::preset("T Impact Pop")

\::
instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\SFX")
; sleep 20
; search() ;immediately highlights the search bar so you can search for a sound effect. Sadly this does not always seem to work...
; sleep 250
; search() ;so i do it again here. still doesn't always work.
return

;;;;;next line;;;;;;;;
;;;;K120 keyboard;;;;;

; capslock::msgbox, , ,i hate capslock!, 1000
;capslock::capslock

a::preset("T wipe straight 225")
s::preset("T wipe straight 135")

d::preset("T wipe soft 225")
f::preset("T wipe soft 135")

+a::preset("T wipe WHITE LINE 225")
+s::preset("T wipe WHITE LINE 135")

+d::preset("T wipe exposure 225")
+f::preset("T wipe exposure 135")



;g::recallClipboard(A_thishotkey)
;+g::saveClipboard(A_thishotkey)

g::preset("mosaic preset")
h::preset("invert preset")
j::preset("110 to 100 zoom")
k::preset("100 to 120 zoom")
l::preset("25% blur and darkener")
`;::preset("blur with edges") ;lol, it's not a comment until here -- the syntax highlighting gets this one wrong.
'::preset("a0p0 pan down")
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
m::preset("Warp Stabilizer Preset")
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




F20::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS")
;F20::msgbox,,, K120 capslock to F20,0.5
;;SC062 was once the remap of appskey, but it seemed to cause problems.


;;Lshift -to-> SC070-International 2 -back-to-> Lshift. This is easier than having to re-flash the QMK chip...
SC070::Lshift

SC071 up::instantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Product Shots") ;[F23] LCtrl -to-> SC071-Language 2
; SC071 up::tooltip, [F23] LCtrl -to-> SC071-Language 2
SC072 up::tooltip, [F23] LWin -to-> SC072-Language 1
SC073 up::tooltip, [F23] LAlt -to-> SC073-International 1

SC077::instantExplorer("N:\Team_Documents\N_TARAN_THINGS") ;;tooltip, [F23] RAlt -to-> SC077-Language 4
SC078::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\LOGOS") ;;tooltip, [F23] RWin -to-> SC078-Language 3
SC079::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\BGs") ;tooltip, [F23] AppsKey -to-> SC079-International 4
SC07B::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\Screenshots") ;K120 rCTRL:: -to-> SC07B:International5 


SC07D::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\TARAN ASSETS\GRAPHICS") ;K120 RShift -to-> SC07D: International3 --to--> \TARAN ASSETS\

space::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations")
+space::InstantExplorer("V:\10. Assets & Integrations vault 2")

;;;;;;;-----------------------------------------

PrintScreen::InstantExplorer("V:\17. SC vault 2") ;will make tapdance keys one day...
ScrollLock::InstantExplorer("N:\Fast As Possible")
;scroll lock WAS reassigned to SC061 back when i used interception
SC07E::InstantExplorer("N:\Linus Tech Tips")
;;Pause -to-> SC07E:Brazilian comma

; CtrlBreak::msgbox, CTRL BREAK - maybe the default output of the pause/break key??
; pause::msgbox, is this the PAUSE key?? IDK
; Break::msgbox, Maybe THIS is the pause/break key?? WHAT CAN I BELEVE ANYMORE??

insert::InstantExplorer("Z:\Linus\17. Short Circuit\SC Transcode\_SC Delivery")
home::InstantExplorer("Z:\Linus\5. Fast As Possible\_FAP Transcoding\_FAP Delivery") 
pgup::InstantExplorer("Z:\Linus\1. Linus Tech Tips\Transcode\_LTT DELIVERY")

delete::InstantExplorer("Z:\Linus\17. Short Circuit\Pending")
end::InstantExplorer("Z:\Linus\5. Fast As Possible\1. TQ Pending")
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


;;;STILL IN THE K120 KEYBOARD. WE ARE ON ITS NUMPAD

;;NumLock -to-> SC05C-International 6
; SC05C::
; switchToWindowSpy()
; return
; IfWinActive, ahk_exe Adobe Premiere Pro.exe
	; {
	; tippy("numlock")
	; SendKey("numpad5", ,"red") ;msgbox, , , NUMLOCK - oh god... some keyboards behave very differently with this key! , 0.5
	; }
; else
	; search()
; return


;NumLock -to-> SC05C-International 6
SC05C::
;WinMinimize, A
return


numpadins:: ;(this is SHIFT NUMPAD0)
numpad0::openApp("ahk_class Photoshop", "Photoshop.exe")
;;;numpad0::SendKey("numpad0", , "sky blue") ;;old assignment


numpadend:: ;(this is SHIFT NUMPAD1)
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

; numpaddown::
; numpad2::SendKey(A_thishotkey, ,"nudge down")

numpaddown::
numpad2::
switchToEdge()

;windowSwitcher("ahk_class Chrome_WidgetWin_1", "msedge.exe")
;windowSwitcher(theClass, theEXE)
; ahk_class Chrome_WidgetWin_1
; ahk_exe msedge.exe
; ahk_pid 36788

return


numpadpgdn:: ;(this is SHIFT numpad3, OR what happens with numlock enabled, i think. it's weird.)
numpad3::

IfWinNotExist, ahk_exe vivaldi.exe
	Run, vivaldi.exe
if WinActive("ahk_exe vivaldi.exe")
	{
	Sendinput, {blind}^{tab}
	}
else
	{
	windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe")
	}

;C:\Users\Taran\AppData\Local\Vivaldi\Application

;tooltip, switch to Vivaldi
; dothisCLASS = "ahk_class Chrome_WidgetWin_1"
; dothisEXE = "vivaldi.exe"
;windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe")

; ; ahk_class Chrome_WidgetWin_1
; ; ahk_exe vivaldi.exe
; ; ahk_pid 24096

return


numpadleft::
numpad4::send, ^{F7} ;ctrl F7, open Everything Search.
;SendKey(A_thishotkey, ,"nudge left")

numpadclear::
numpad5::openApp("AE_CApplication_17.5", "AfterFX.exe")
;numpad5::Rctrl ;because I use it... well, as a ctrl key. baka.

numpadright::
numpad6::openApp("ahk_class Photoshop", "Photoshop.exe")
;numpad6::SendKey(A_thishotkey, ,"nudge right")

numpadhome::
numpad7::return
;SendKey(A_thishotkey, ,"purple")

numpadup::
numpad8::SendKey(A_thishotkey, ,"nudge up")

numpadpgup::
numpad9::switchToAudacity()
; numpad9::SendKey(A_thishotkey, ,"yellow")


;numpadDiv::SendKey("numpadDiv", ,"clip blue")
;numpadMult::SendKey("numpadmult", ,"pink")


; numpadSub::
; ;open tight VNC
; openTightVNC()
; return

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
; numpadEnter::switchToChrome()
numpadEnter::switchToFirefox()

numpaddel::
numpadDot::
;hyello
WinMinimize, A

return ;msgbox, , , num dot, 0.5




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
;BEGIN secondary layer of main keyboard, using CAPSLOCK remapped to F20.
;;;UPDATE: I decided not to do this, at least for now. I currently use the capslock key to enable/disable clips on Premiere's timeline.
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
 


;BEGIN KEYBOARD 4, FULL AZIO KEYBOARD
; To understand how this works: https://www.youtube.com/watch?v=GZEoss4XIgc
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
F11::tooltip, you pressed F24 then %A_thishotkey%
F12::
tooltip, moving the active window to the center of the screen!
WinGetPos,,, Width, Height, A
WinMove, A,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
;WinMove, 50, 50
; to try to rescue the tangent ripple UI which has gone missing off the side of a monitor long ago and cannot be brought back with anything I've tried!.
;edit: it worked!
return

;`::tooltip, tilde thing 
`::
gotoChromeTab("ADDENDUM - Google Docs","https://docs.google.com/document/d/1YRr5O2PN10PRtAMZHUJJhh6_2FXANjaHTGYH0RadTaI/edit")
return


1::gotoChromeTab("AHK needed","https://docs.google.com/document/d/1xsjjKYggXYig_4lfBMJ6LDGRZ9VOvDd7SCSTSi7GwN8/edit")
2::gotoChromeTab("LTT To Do - Google Docs","https://docs.google.com/document/d/1Gi8sruMEBEQG3WHPM2jaFOQ1oR1A8bSz47vSxB9NfBQ/edit")
3::gotoChromeTab("Lnotes - Google Docs","https://docs.google.com/document/d/1CWjC7DWyXGIFDaSwXzUsdHmdktvgV0kdgNOFEK7wf7U/edit")

4::gotoChromeTab("Music Hypercube - Google Docs","https://docs.google.com/document/d/11hIiENqLMtuQRLV4FjZMRY2uNFLtPw5QW6fivMix9VE/edit")

5::tooltip, you pressed F24 then %A_thishotkey%

6::
;ExportJPG
;original:  https://autohotkey.com/board/topic/118890-photoshop-com-booleans-exportdocument/
app := ComObjActive("Photoshop.Application")
doc := app.activeDocument
options := ComObjCreate("Photoshop.ExportOptionsSaveForWeb")
options.Quality := 90
options.Format := 6 ; 6=jpeg 13=png 17=tif
options.Optimized := ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true, 0 = false

;inputBox, filename, file name, file name(no extension)
filename := app.activeDocument

WinActivate, ahk_class Photoshop
doc.export(doc.path . filename.name . ".jpg",SAVEFORWEB:=2,options)
;this works, but it does
;thumb-atx-12-vo.psd.jpg
;instead of
;thumb atx 12 vo.jpg
return
	
	
	
	

7::
;ExportJPG v2
;will return to this. it's possible i can copy this code driectly.
app := ComObjActive("Photoshop.Application")
doc := app.activeDocument
options := ComObjCreate("Photoshop.ExportOptionsSaveForWeb")
options.Quality := 90
options.Format := 6 ; 6=jpeg 13=png 17=tif
options.Optimized := ComObj(0xB, -1) ; 0xB = VT_Bool || -1 = true, 0 = false

msgbox % app.activeDocument.fullname ;this does work actaully.
filename := app.activeDocument.name ;sadly this uses hyphens and includes the extension
msgbox, %filename% ;this also works, AND even shows it wihtout having hyphens. weird.


WinActivate, ahk_class Photoshop
doc.export(doc.path . filename . ".jpg",SAVEFORWEB:=2,options)
;i think you look at ExportOptionsSaveForWeb...


return

;; https://feedback.photoshop.com/conversations/photoshop/photoshop-how-to-quick-save-as-jpg-and-overwrite-a-image-with-one-click/5f5f45c14b561a3d425e1fa1
; var saveName = docRef.fullName + ".jpg" ??

8::
9::
0::
-::
=::tooltip, you pressed F24 then %A_thishotkey%
backspace::send, ^+!r ;ctrl shift alt r is "reset workspace"

;;;;;next line;;;;;;;;

; tab::msgbox,,, you pressed tab. :P,0.8
;VIDEO TRACKER
tab::gotoChromeTab("Techquickie | Trello","https://trello.com/b/yUSFtaXn/fast-as-possible")
; tab::gotoFireTab("Fast As Possible | Trello","https://trello.com/b/yUSFtaXn/fast-as-possible")
; WinActivate ahk_exe firefox.exe
; sleep 10
; WinGet, the_current_id, ID, A
; vRet := JEE_FirefoxFocusTabByName(the_current_id, "Video Tracker LTT - Google")
; ;tooltip, vret is %vRet%
; if (vRet = 0)
	; run, firefox.exe https://docs.google.com/spreadsheets/d/1FmuWOCKHxZbxS5XbwpVDP4M27BjTAJJ67B0yoSXUN9k/edit#gid=0
;return

;;;this is the Azio keyboard that is wrapped in F24;;;

q::
;HUGE SHOUT OUT TO MICHAEL BUNZEL FOR EMAILING ME WITH THE FANTASTIC CODE!
if WinActive("ahk_class Photoshop")
{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("50% smaller - bilinear", "taran actions")
}
return

;some reading https://www.autohotkey.com/docs/commands/ComObjError.htm

; Below you'll find a simple AHK function with proper error handling to
; run actions. Feel free to replace the message boxes with whatever kind
; of error handling you prefer.
; Best,
; Mike

; ; example call:
; RunPhotoshopAction("action name", "action set name")

; RunPhotoshopAction(action, actionSet)
; {
    ; try {
        ; psApp := ComObjActive("Photoshop.Application")
    ; }
    ; catch e {
        ; MsgBox, % "Unable to connect to running Photoshop instance: " e.message
    ; }

    ; try {
        ; if(psApp.Documents.Count < 1)
            ; return

        ; psApp.DoAction(action, actionSet)
    ; }
    ; catch e {
        ; MsgBox, % "Photoshop API error: " e.message
    ; }
; }

w::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("50% smaller NN", "taran actions")
}
return

e::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("200% nearest neighbor", "taran actions")
}
return

r::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("300% Nearest Neighbor", "taran actions")
}
return

t::
if WinActive("ahk_class Photoshop")
{
psApp := ComObjActive("Photoshop.Application")
psApp.DoAction("Surface blur - dejpeg", "taran actions")
}
return

y::
;really cool script that MIXES the color under your cursor, with the one already in the forground swatch. like real painting! works perfectly and instantly... so cool!
;one disadvantage is that it's mixing with the color AFTER software calibration has been applied. not great. also is it gamma correct? le hmmmmmmmm
;https://www.autohotkey.com/boards/viewtopic.php?t=4984

		; sample under cursor color
		MouseGetPos X, Y
		PixelGetColor sample, %X%, %Y%, RGB 
		SplitRGBColor(sample,R,G,B) ; convert sample to RGB
		; get ps foreground color
		appRef := ComObjActive("Photoshop.Application")
		fgc :=  appRef.ForegroundColor.rgb
		;mix with sampled color
		MixRGB(0.15,fgc.Red,fgc.Green,fgc.Blue,R,G,B,ORed,OGrn,OBlu)
		; set ps foreground to mixed color
		solidColorRef := ComObjCreate("Photoshop.SolidColor")
		solidColorRef.rgb.red := ORed
		solidColorRef.rgb.green := Ogrn
		solidColorRef.rgb.blue := OBlu
		appRef.ForegroundColor := solidColorRef
		Return
	
SplitRGBColor(RGBColor, ByRef Red, ByRef Green, ByRef Blue)
	{
    Red := RGBColor >> 16 & 0xFF
    Green := RGBColor >> 8 & 0xFF
    Blue := RGBColor & 0xFF
	}	

MixRGB(alph,R,G,B,RR,GG,BB,ByRef ORed,ByRef OGrn,ByRef OBlu)
	{
	ORed:=Floor(alph*RR+(1-alph)*R)
	OGrn:=Floor(alph*GG+(1-alph)*G)
	OBlu:=Floor(alph*BB+(1-alph)*B)
	}

simpleRGB(RGBColor, ByRef TRed, ByRef TGreen, ByRef TBlue)
	{
    Red := RGBColor >> 16 & 0xFF
    Green := RGBColor >> 8 & 0xFF
    Blue := RGBColor & 0xFF
	}	

;u::tooltip, you pressed F24 then %A_thishotkey%
u::
;SETTING a foreground or background color directly.
;autohotkey.com/boards/viewtopic.php?p=29050#p29050

;in this case, it sets it to gray. but i can use any color i want! and with some more scripting, the notation will become very easy. just call a funciton with one parameter.
appRef := ComObjActive("Photoshop.Application")
solidColorRef := ComObjCreate("Photoshop.SolidColor")

solidColorRef.rgb.red := 66
solidColorRef.rgb.green := 66
solidColorRef.rgb.blue := 66
;(cause you can also do it in CMYK.)

;oh, here is the documentation. page 135. https://www.adobe.com/content/dam/acom/en/devnet/photoshop/pdfs/photoshop-cc-vbs-ref.pdf
; solidColorRef.rgb.hexvalue := FFFFFF ;this sadly does not work

appRef.ForegroundColor := solidColorRef
;msgbox % appRef.BackgroundColor.rgb.hexvalue
;tooltip % appRef.ForegroundColor.rgb.hexvalue
Return


i::sendinput, {U+2611} ; check box! ☑
o::sendinput, {ASC 0176} ;the degree symbol! °
p::sendinput, {U+00A0} ;a blank character that is NOT a space. It's from braille. Very useful for changing around websites sometimes.

[::
]::tooltip, you pressed F24 then %A_thishotkey%
\::run, C:\Program Files (x86)\Corsair\Corsair Utility Engine\CUE.exe

;;;this is the azio F24 keyboard;;;

;F20 IS CAPSLOCK
;CAPSLOCK IS TRELLO
F20::
capslock::gotoChromeTab("Production Planner | Trello","https://trello.com/b/NevTOux8/ltt-production-planner")

;;;this is(was) Lshift::
;Lshift:: / LEFTSHIFT -to-> SC070 / International2 -to-> Chrome calendar open
; SC070::gotofiretab("Calendar - October 2020","https://calendar.google.com/calendar/b/0/r")
SC070::gotoChromeTab("Calendar - October 2021","https://calendar.google.com/calendar/u/0/r")
;even though i directly copied the text, it does not work. and IDK how to split a string so I'll have to write in the months manually...
;SC070::gotofiretab("2018","https://calendar.google.com/calendar/b/0/r")
;en dash –
;em dash –
;; ask about URLs: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114


;;;***this is still the azio F24 keyboard***;;;


;LEFTCTRL -> SC071/Lang2 -> GMAIL INBOX
SC071 up::
;tooltip, hewwo test
gotoChromeTab("Linus Media Group Inc. Mail","https://mail.google.com/mail/u/0/#inbox","says...")
return
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
;this is amazing. I can launch photoshop actions DIRECTLY from AHK, without needing to go through one of the 44 very restricted shortcuts!!
;if WinActive("ahk_class Photoshop")
;	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("WHITE TO ALPHA - WHOLE LAYER", "taran actions")
;	}
return

s::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("expand selection 1px", "taran actions")
	}
return

d::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("smooth selection", "taran actions")
	}
return

f::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("invert selection", "taran actions")
	}
;this is BETTER than going through the keyboard shortcut CTRL SHIFT I. I'll probably start doing more and more stuff this way...
return

g::
if WinActive("ahk_class Photoshop")
	{
	psApp := ComObjActive("Photoshop.Application")
	psApp.DoAction("add layer mask action", "taran actions")
	}
return

h::return
j::sendinput, ^!o ;render audio
k::sendinput, ^!i ;render entire work area (in to out)
l::return
`;::tooltip, you pressed  %A_thishotkey% ;fun fact, the syntax highlighting gets this wrong. ";" is escaped, and therefore is not actually a comment.
'::send, ^!+, ;this is the premiere shortcut for "show audio keyframes" (on timeline)
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

;these were to zoom and reset the source monitor. now i use numpad - + and enter for both source and program monitors, since it's panel dependant anyway.
; z::sendinput, ^!+z
; x::sendinput, ^!+x
; c::sendinput, ^!+c
; z::^z ;undo
; x::
; sendinput, ^y ;redo
; ;tooltip, redo
; return

x::send, ^2 ; premiere preset for "real drop shadow 2" via excalibur.
z::send, ^1 ;this is the premiere preset "90 IRE websites" in Excalibur. Trying it out.

c::preset("drop shadow REAL 2")

;Lshift::tooltip, you pressed F24 then %A_thishotkey%
; z::
; if WinActive("ahk_class Premiere Pro")
	; send ^+6 ;track targeting presets in premiere.
; return
; x::
; if WinActive("ahk_class Premiere Pro")
	; send ^+7 ;track targeting presets in premiere.
; return
; c::
; if WinActive("ahk_class Premiere Pro")
	; send ^+8 ;track targeting presets in premiere.
; return
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
;these should perhaps highlight the timeline first...?

;l control    Linus Media Group Inc. Mail

Lwin::msgbox, LEFT win. you should NEVER be seeing this messagebox ;but this won't happen, it was swapped with another key...

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


SC073 up::preset("L 90 IRE websites") ;tooltip, AZIO [F24] LAlt -to-> SC073-International 1

space::tooltip, ;this murders tooltips, lol.
; Ralt::msgbox, Ralt - doesnt work
; Rwin::msgbox, Right Win 
; Rshift::msgbox RIGHT SHIFT lol

;Lwin -to-> SC072:Lang1. It MUST be done as an UP event. It does not manifest any other way. Bizzare.
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
if WinActive("ahk_class Premiere Pro")
	{
	tippy("pin to clip")
	prFocus("effect controls")
	send, ^!p ;my premiere shortcut for pin to clip: CTRL ALT P
	}
else
	{
	msgbox, you are not in premiere but you pressed Ralt on the AZIO keyboard.
	}
return


;RWin -to->> sc078:Lang3 -to->> OBS
SC078::
;This doesn't work because the AZIO keyboard does not HAVE a RWIN key, HAH!!
return

; SC079::
; tooltip, "[AZIO] AppsKey -to-> SC079-International 4"
; sleep 200
; tooltip,
; return

SC079::
;ControlSend, wxWindowNR57, ^+0, ahk_exe audacity.exe
;ControlSend, wxWindowNR57, +T, ahk_exe audacity.exe
;ControlSend,, +T, ahk_exe audacity.exe
;ControlSend,, {ctrl down}0{ctrl up}, ahk_exe audacity.exe
ControlSend, wxWindowNR57, {ctrl down}0{ctrl up}, ahk_exe audacity.exe

; Audacity
; ahk_class wxWindowNR
; ahk_exe audacity.exe
; ahk_pid 24760

return


SC07B::WinMinimize, A
; SC07B:: ;rCTRL:: -to-> SC07B:International5
; ;tooltip, rightCTRL -> SC078:Lang3 -> OBS
; if Not WinExist("ahk_exe obs64.exe")
	; {
	; msgbox,,, OBS is opening`, hold your horses.,0.8
	; ;Run, C:\Program Files\obs-studio\bin\64bit\obs64.exe
	; Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit)
	; }
; if WinExist("ahk_exe obs64.exe")
	; WinActivate ahk_exe obs64.exe
; return




PrintScreen::return
ScrollLock::return
SC061::msgbox,,, scancode061,1
;CtrlBreak::msgbox, CTRL BREAK?
;pause::msgbox, is this the PAUSE key?? IDK
;Break::msgbox, Maybe THIS is the pause/break key???

pgdn::
end::tooltip, you pressed F24 then %A_thishotkey%
delete::sendinput, ^!+j ;lock/unlock all audio tracks

pgup::
home::tooltip, you pressed F24 then %A_thishotkey%
insert::sendinput, ^!+l ;lock/unlock all video tracks




; ;up::tooltip, you pressed F24 then %A_thishotkey%
; up::
	; While(GetKeyState("up","P")){
		; Mousemove,25,0,,R
		; sleep 1
	; }
; return

; down:: 
; MouseClick, left,,, 1, 0, D ; Hold down the left mouse button. 
; ;tooltip, hi
; Loop 
; { 
; Sleep, 30
; MouseMove, 1, 0, 0, R
; GetKeyState, state, down, P 
; if state = U
	; break
; } 
; MouseClick, left,,, 1, 0, U
; return



; left::tooltip, you pressed F24 then %A_thishotkey%
left::
MouseClick, left,,, 1, 0, D ; Hold down the left mouse button. 
;tooltip, hi
Loop 
{ 
Sleep, 16
MouseMove, -5, 0, 0, R
GetKeyState, state, left, P 
if state = U
	break
} 
MouseClick, left,,, 1, 0, U
return

right::
click down
MouseMove, -2200, 0, 100, R
click up
return


up::
down::
;left::
;right::
return



;;;;;next area;;;;;;;;
;;;this is the azio F24 keyboard;;;

numpad0::
keywait, %A_priorhotkey% 
if WinActive("ahk_class Premiere Pro")
	{
	sleep 1
	sendinput, {blind}{SC0EE} ;scan code of an unassigned key
	sleep 1
	sendinput, ^!+9 ;activate lumetri scopes panel
	sleep 25
	prFocus("timeline")
	sleep 2
	;NOTE TO SELF: see MODS NEW left alt while still in premiere.txt for debugging info about when this caused a problem. Left alt was never sent back UP becvause it was interrupted by numpad0 or F24 being released, and i don't know how to prevent that issue.
	sendinput, {blind}{SC0ED}
	; sendinput, {lAlt up}
	; sendinput, {lCtrl up}
	; sendinput, {lShift up}
	;MODSL()
	}
return

numpadend:: ;this is SHIFT NUMPAD1, just in case i guess.
numpad1::monitorKeys("source","^!+[",0) ;Safe margins (source monitor)

numpad2::monitorKeys("program","^!+]",0)  ;safe margins (program monitor)

;WE ARE STILL INSIDE THE AZIO KEYBOARD

numpad3::tooltip, you pressed F24 then %A_thishotkey%

numpad4::monitorKeys("source","^{numpad1}") ;source monitor res to 1/1

numpad5::monitorKeys("program","^+1") ;program monitor resolution to 1/1

numpad6::tooltip, you pressed F24 then %A_thishotkey%

numpad7::monitorKeys("source","^{numpad5}") ;source monitor res to 1/2. ^{numpad2} does not work because CTRL SHIFT ALT 2 is the shortcut for the source monitor. cross talk.

numpad8::monitorKeys("program","^+2") ;program monitor res to 1/2

numpad9::tooltip, you pressed F24 then %A_thishotkey%

;+numlock::
SC05C::monitorKeys("source","^{numpad3}") ;source monitor res to 1/4

numpadDiv::monitorKeys("program","^+3") ;program monitor res to 1/4

numpadMult::tooltip, you pressed F24 then %A_thishotkey%

;send, +`` ;premiere shortcut for "Maximize or restore ACTIVE FRAME." Note that ` is the "escape character," so i have to use it twice.


numpadSub::sendinput, !{F9} ;alt F9 is shadowplay record
numpadAdd::sendinput, !{F10} ;shadowplay retroactive record last X minutes.
;SHIFT ALT F10 is to toggle the ability of the replay to go on and off. that's not confusing right? Shadowplay toggle instant replay on/off


numpadEnter::
sendinput, ^!m ;mute/unmute mic - shadowplay ;unfortunately ctrl alt m is also NEW COMMENT in google sheets... i might wish to change it
;tippy("this should work")
return

numpadDot::
sendinput, !{F9} ;shadowplay record. (temporary assignment.)
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
#IfWinActive ahk_class MozillaWindowClass
!F1::send ^+{pgup} ;this will MOVE a tab to the left
!F2::send ^+{pgdn} ;this will MOVE a tab to the right.
; F2 & f20::send ^+{pgdn}

F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab

;these are for when I am music surfing
End::send ^+{tab} ;control shift tab, which goes to the next tab
PgDn::send ^{tab} ;control tab, which goes to the previous tab

PgUp::send ^w ;control w, which closes a tab

;these are also for APMmusic.ca surfing.
;macro key G8, labeled as horizontal anchor.
F18::up
;macro key G11, labeled as vertical anchor.
F15::down

;macro key G9: labeled as rotation.
F17::enter ;idk if this is the corect assignment now that i moved keys.
;also i dont remember why i did that

F3::send ^w ;control w, which closes a tab
F4::send {mButton} ; middle mouse button, which opens a link in a new tab.



;PHOTOSHOP
;f1 - not on help anymnore
;f2 none
;f3 none
;f4 pixel grid
;F5 - rasterize layer
;F6 RGB color
;F7 LAB color
;f8 - none ... vector mask custom action?
;f9 -none?
;F10 - smooth selection!
;f11 - expand selection 1px
;f12 - 200% Nearest neighbor



;;AFTER EFFECTS
#IfWinActive ahk_exe AfterFX.exe
;super useful, and a feature that AE should definteily have. PRIMARY [GAMEPLAY] LOOP!!
F1::twirlAE(1)
F2::twirlAE(0)

;CHROME
#IfWinActive ahk_class Chrome_WidgetWin_1
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w ;control w, which closes a tab
F4::send {mButton} ; middle mouse button, which opens a link in a new tab.

F14::send, {F11} ;scale key is fullscreen key meow. ;;this line went missing somehow, wtf?

;these are also for APMmusic.ca surfing.
;macro key G8, labeled as horizontal anchor.
F18::up
;macro key G11, labeled as vertical anchor.
F15::down


#IfWinActive ahk_exe notepad++.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 
F4::F2 ;this is to regain what I lost when I used F2 and F3 for tab navigation.



;;;;;;;;;;;;;SCREENSHOT RELATED KEYS;;;;;;;;;;;;
;;;;;;;;;;;;;SCREENSHOT RELATED KEYS;;;;;;;;;;;;
;;;;;;;;;;;;;SCREENSHOT RELATED KEYS;;;;;;;;;;;;

#IfWinActive

;I had the scroll lock key set to shareX's "copy region to clipboard," and used it constantly.
;(printscreen will save region to file as...)
;but the trouble is that the scroll lock state is acctually used by two programs: Excel, and teracopy.
;In excel, having it on will cause the arrow keys to scroll the view, rather than moving from one cell to the other.
;in Teracopy, scroll lock can be used to bypass teracopy and use normal Explorer-based copying, which i prefer for smaller operations.
; Anyway, so that i can actually toggle the scroll lock state, I'm gonna make the scroll lock key send SHIFT PRINTSCREEN, and I'll have SHIFT SCROLL LOCK actually send a normal scroll lock key event. Derpy, but it works for now.

scrolllock::+printscreen ;shareX's "copy region to clipboard." I had it on ALT, but this would open and then close the top menu bar quickly, which is just something I don't wanna have to deal with if it ever goes wrong.
+scrolllock::scrolllock ;toggles the true scroll lock state.
^scrolllock::scrolllock ;also toggles the true scroll lock state.



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

F6::RemoveDashes()

#if WinActive("ahk_class #32770") and WinActive("ahk_exe firefox.exe") ;An Explorer window as launched by Firefox
`::Send !{up} ;DOWN one folder level in explorer
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
Media_Next::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
F6::RemoveDashes() ;when saving Audioblocks sound effects, because filenames with dashes or underscores in them cannot be searched for in Windows' file system, which is also stupid. So this makes it so  that i don't have to manaully remove those or retype the filenames.

#if WinActive("ahk_class #32770") and WinActive("ahk_exe 4kvideodownloader.exe") 
`::Send !{up} ;DOWN one folder level in 4k video downloader
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
Media_Next::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field

#if WinActive("ahk_class #32770") and WinActive("ahk_exe WINWORD.exe")
`::Send !{up} ;DOWN one folder level 
~left & right::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
Media_Next::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field


#IfWinActive ahk_exe explorer.exe ;IDK if there is any meaningful difference for using the ahk_exe rather than the ahk_CLASS

;Oh, if you are on the desktop, the EXE is the same, but the class is not. So if you hit ALT F4, you go into the shutdown menu. Not good. So i think the class is a better indicator that you are, specifically, in an Explorer WINDOW.



#IfWinActive, ahk_class CabinetWClass ;this is also WINDOWS EXPLORER

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

F10::return ; "Activate the Menu bar in the active app." This is the same as ALT menu acceleration, which i hate of course.

F11::return ; It acts as a full screen-ifier. Don't need that.

;F12:: unused currently

;I USE THIS ALL THE TIME:
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

;I USE THIS RARELY
+`::Send !{left} ;shift tilde will go "back" in explorer

~left & right::
;msgbox,,, hellllllo,0.5
;note to self, check for stuck modifier keys on this one too...
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field - very useful!!
return

Media_Next::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field

home::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_Window(exphWnd) ;list mode
return


end::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_ICONS(exphWnd) ;icon mode
return

;;;YOU ARE STILL IN THE WINDOWS EXPLORER SHORTCUTS


; ;these are not very reliable. I have replaced them with sortByName() and sortByDate()
; ; pgup::send, {alt}vo{enter} ;sort by name
; ; pgdn::send, {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...


pgup::
sortByName() ;doesn't work both ways...
Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field. wish i knew how to do this with DLL calls though.
return
;sort by name

pgdn::
sortByDate()
;Send,{LCtrl down}{NumpadAdd}{LCtrl up}
return
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

;Macro key G13, which is assigned to F13, which is scan code 064.
;F13:: ;it's more reliable to use the scan code, i guess? Maybe because I used "F13::" elsewhere.
SC064::back()


;macro key G16
;This WAS firefox, but I'm switching to Chrome, purely because it has a better multi-page screenshot function. (My old solution for multi-page screenshots in Firefox is no longer teneble.) And it DOES now have smart upscale, and has the nuke anything plugin working properly. Otherwise, I'd stick with firefox. 
; ; ^F1::switchToFirefox()
; ; +^F1::switchToOtherFirefoxWindow() ;^+F1 ^+{F1}
^F1::switchToChrome()
+^F1::switchToOtherChromeWindow() ;^+F1 ^+{F1}

;macro key G17

^F2::switchToExplorer()

!^F2::closeAllExplorers() ;aaah, this doesn't work from premiere because I swapped it out with a direct launch on that key. riiight.

;macro key G18
^F3::switchToPremiere()
+^F3::send, {F12} ;full screen

;macro key G15
^F4::switchToWord()
+^F4::switchWordWindow() ; AKA, ^+F4 ^+{F4}

;No K95 macro key assigned:
^F5::switchToChrome()
;also, CTRL works a little funny when the function uses CTRL TAB to switch tabs. This might be better assigned to ALT F5 or something.


;Macro key G14
^F6::
;I had to learn just now to use the parameter to pass "savedCLASS" even though it's already a global variable. Just works better this way... but really IDK what i am doing.
;msgbox,,, switching to `nsavedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%,0.3
;switchToSavedApp(savedCLASS, savedEXE) ;obsolete
windowSwitcher(savedCLASS, savedEXE) 
return

;SHIFT and then macro key G14
+^F6::
windowSaver()
msgbox,,, savedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%, 0.6
Return

;^F7 is Everything search.

;No K95 macro key assigned:
; ^F8::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.


;^F9 is FREE i think.

; ; ^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")

; ^F11 is taken by filemover.ahk
; ^F12 is also taken by filemover.ahk

;NOTE: ^F12 (ctrl F12) is forbidden by Premiere's shortcuts panel, since it opens the Premiere CONSOLE. interesting.

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

;----FIRST WE DO GLOBAL APPLICATION ASSIGNMENTS.-------
#IfWinActive

; ;F21::return ;I didn't have this here until 2020 04 15, so idk if I actually need it...

; ;;;update for the above line: "F21::Return" MAY cause the stuck modifiers error? Here's the keyhistory:
; 84  06C	s	d	0.48	F21            	
; 71  03C	h	d	0.00	F2             	
; 71  03C	s	u	0.02	F2             	
; A2  01D	i	d	0.00	LControl      <? AHK automatic 	
; 84  06C	s	u	0.00	F21           < it gets tangled inside F21...
; A0  02A	i	d	0.00	LShift         	
; 79  044	i	d	0.00	F10            	
; 79  044	i	u	0.00	F10            	
; A0  02A	i	u	0.00	LShift         	
;										<Lcontrol should have been sent UP.
; A0  02A	i	d	0.02	LShift         	<and this is the next command to be sent, and it is behaving normally.
; 79  044	i	d	0.00	F10            	
; 79  044	i	u	0.00	F10            	
; A0  02A	i	u	0.00	LShift         	
; ;and then notice how Lcontrol is NOT sent back up. Only down.


;macro key G1 on K95. IT'S MY UNIVERSAL SEARCH EVERYTHING-ER
;^+J::search() ;old shortcut
F21 & F1::search() ;it will go straight to effectsPanelType() if Premiere is active.


#ifWinActive

;Note that i have other premiere extended function key assignments somewhere around line 2090. Yeah it's a bit of a mess.
	
;^numpad0:: ;this was the old shortcut
;MACRO KEY G2 on the K95
F21 & F2::
keywait, %A_priorhotkey% ;avoid stuck modifiers
IfWinActive, ahk_exe Adobe Premiere Pro.exe
	{
	easeInAndOut()
	}
else IfWinActive, ahk_exe AfterFX.exe
	{
	sendinput, {F9} ;F9 is 'ease in and out' in after effects.
	}
else
	{
	;TBD (to be developed)
	tooltip, "F21 and F2 - for now this key does nothing outside of Premiere"
	sleep 150
	tooltip,
	}
return


;~^+K::preset("Warp Stabilizer Preset") ;macro key G2 used to be the stabilizer preset.
;~^+=::effectsPanelType("presets") ;this WAS macro key G3. ;Types in "presets," which reveals my own entire list of presets. ;;I have canceled this one in favor of a global pause/play. 

#ifWinActive
;Macro key G3:: on the K95
;^+L:: ;this was the old shortcut. modifier keys are bad because they can get stuck down...
F21 & F3::
stopPlaying()
return
;Outside of premiere, it will STILL work to pause/play the timeline, due to some other code somewhere else...
;;NOTE that this shows up also as a huge bit of script when premiere is NOT in focus, must be moved to All Premiere Functions.


#ifWinNotActive ahk_exe Adobe Premiere Pro.exe
;macro key G4
;F21 & F4::msgbox,,,TBD. Macro G4 not yet assigned outside premiere,0.7 ;It was CTRL SHIFT ,

;macro key G5
;F21 & F5::msgbox,,,TBD. Macro G5 not yet assigned outside premiere,0.7 ;It was CTRL SHIFT .

;macro key G6
;F21 & F6::Lbutton
;G6 is assigned to single left click when not in premiere. I mostly use it in Firefox when perusing the apmmusic.ca library, since my hand is over there anyway. Gotta save my hands from RSI!

;Macro key G10
#IfWinActive ahk_exe firefox.exe
;f19 is tracklocker in premiere 
F19::Sendinput, !+5 ;alt shift 5 is "strikethrough" in Google docs...
; F18::
; sendinput, {Ralt down}
; sleep 2
; sendinput, {Rshift down}
; sleep 2
; Sendinput, 5 ;alt shift 5 is "strikethrough" in Google docs...
; sleep 2
; sendinput, {Rshift up}
; sleep 2
; sendinput, {Ralt up}
; ;this now causes a super annoying BEEDLEDEBOOO windows noise, even with alt nullifier closed, and i have no idea how to fix it.
; ;;okay i figured something out. it happens when you hit ALT and then hit 5. so i think it IS my new alt nullifier not working as well as the old one?

; ; 1B  001	#	d	0.17	Escape         	
; ; 1B  001	 	u	0.13	Escape         	
; ; 81  069	h	d	0.26	F18            	
; ; A4  038	i	d	0.00	LAlt           	
; ; A0  02A	i	d	0.02	LShift         	
; ; 35  006	i	d	0.00	5              	
; ; 35  006	i	u	0.00	5              	
; ; A0  02A	i	u	0.00	LShift         	
; ; A4  038	i	u	0.01	LAlt           	
; ; 81  069	s	u	0.11	F18            	
; ; 13  045	h	d	1.98	Pause          	
; ; 13  045	s	u	0.06	Pause     

return



#IfWinActive ahk_exe chrome.exe
F19::Sendinput, !+5 ;alt shift 5 is "strikethrough" in Google docs...

;keys for video speed up and slow down, on youtube.
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

;;note to self - try to get this script here working
;Macro Key G12 (labeled "scale")
;;;note to self 2: I have no idea what the above note is talking about.


#IfWinActive ahk_exe vivaldi.exe
;keys for video speed up and slow down, on youtube.
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,

#IfWinActive ahk_exe msedge.exe
;keys for video speed up and slow down, on youtube.
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,



#IfWinActive ahk_exe winword.exe
~F14::F2 ;F2 is set to "go to previous comment" in Word.
;;;;NEW assignment: Macro key G6, currently labeled "reselect."
;;;;F21 & F6::F2 ;F2 is set to "go to previous comment" in Word.
F18::^k ;this is strikethrough now.


#IfWinActive ahk_exe winword.exe
F11::
;Word absolutely sucks at following URLs. Rather than just open them in your default browser, it first tries to load the URL itself to see if it CAN be followed. sometimes this fails. It locks up Word for anywhere from 2 to 30 seconds. Miserable. so I'm making my own macro to opwn links instead.

;first we need to deselect any text. word doesn't seem to have a proper way to do this. CTRL D doesn't do it.
;https://answers.microsoft.com/en-us/msoffice/forum/all/my-esc-key-wont-deselect-text-in-word-although-it/4f8020cf-f565-e011-8dfc-68b599b31bf5
;shift F5 is some weird bullshit that ISN'T deselect.
sendinput, {escape}
sleep 10
sendinput, {left}
sleep 10

;then, highlight the "sentance," (which turns out to be a full URL, as forward slashes are treated like spaces) then copy, change to red, then go to chrome and paste the URL in a new tab.
send, ^{click} ;CTRL left click to make sure se have the carat on the URL in the comments, but the CTRL is used so that the link is NOT follwed, as I changed that settins so that ctrl is NOT needed to follow the links normally. uh, yeah.
sleep 10
send, {F8} ;once gets into the mode
;F8 is "extend mode. https://www.zdnet.com/pictures/six-clicks-microsoft-word-tricks-to-make-you-an-instant-expert/4/
sleep 10
send, {F8} ;twice highlights the word with the carat
sleep 10
send, {F8} ;three times highlights the "sentence" (full URL).
;four times would be the whole paragraph
;five times is the whole document I think.
sleep 10
send ^c ;copy to clipboard

sleep 10
sleep 10
send ^r ;ctrl r - I set this up in word's keyboard shortcuts to change text to red. This is my alternative for how the text wont be purple otherwise.
;to do that, go to word logo, options (at the bottom) customize ribbon, keyboard shortcuts:custon, select "all commands," find "color" and then choose color: red. ugh, so complicated.
sleep 10
sleep 10
send, {escape} ;to get out of extend mode. But your selection is still active.
;msgbox, okay hows it look?
sleep 10
;open default browser
switchToChrome()
;switchToFirefox()

;make new tab
sendinput, ^t ;ctrl T
sleep 30

;possibly select address bar.
sendinput, ^l ;ctrl L
sleep 30

;paste
sendinput, ^v ;ctrl V

;enter
sendinput, {enter}

return




#IfWinActive ahk_exe winword.exe

F12::
;Script to put a Word comment into a lengthend marker in Premiere.
BlockInput, On
BlockInput, SendandMouse
sendinput, ^a ;select all (of the text inside of the Word comment)
sleep 80
sendinput, ^c ;copy to clipboard
sleep 15
WinActivate ahk_class Premiere Pro
sleep 20
prFocus("timeline")
sleep 30
;unstick modifier keys.
Send,{LCtrl up}
Send,{RCtrl up}
Send,{RAlt up}
Send,{RAlt up}
Send,{LShift up}
Send,{RShift up}
sleep 10
send, ^!d ;ctrl alt D is  "deselect all" (clips on the timeline)
sleep 20
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 30
send, ^!+k ;ctrl alt shift K is  "shuttle stop" Sometimes it doens't happen the first time, so I wait and do it again.
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
;unstick any modifier keys.
Send,{LCtrl up}
Send,{RCtrl up}
Send,{RAlt up}
Send,{RAlt up}
Send,{LShift up}
Send,{RShift up}
sleep 10
send, {enter}
sleep 10
send, ^!+k ;ctrl alt shift K is  "shuttle stop"
sleep 1

BlockInput, MouseMoveOff
BlockInput, Off
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





;;;vvvvvvvvv VARIOUS PREMIEREKEYS that are not function keys! vvvvvvvvvvvvv

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;tab::7 ;"7" is set to enable/disable for now. just testing stuff
appskey::sendinput, ^!k ;in premiere's shortcuts panel, CTRL ALT K is set to "clear selected marker." You can't assign it DIRECTLY to appskey, so I do it here.

;^w::closeTitler()

;Pressing ALT W will send CTRL ALT SHIFT W, which is set to "Trim Next Edit to Playhead" in Premiere. This is to get around Premiere's horrible menu acceleration, and annoying warning noise. Otherwise, I would have just assigned these commands directly to ALT Q and ALT W.
!w::^!+w ;"Trim Next Edit to Playhead" (not RIPPLE trim.)
!q::^!+q ;"Trim Previous Edit to Playhead" (not RIPPLE trim.)
; for more information: https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.ahk

!f::return
!e::return
!c::return
!s::return
!m::return
!g::return
;!v::return
!v::sendinput, ^!+v ; this is "paste on highest enabled track" in Excalibur. ...hmm mit doesn't work unless you go fast... annoying...... idk why, will look into it later.
;!w::return ;ALT W is used for Trim Next Edit to Playhead, though indirectly. See above.
!h::return

; control shift r = reverse selected clip
; no need for 11ms of delay, since I am pressing this one myself.
;though it does also use the CTRL key, so i dunno! maybe it shouldn't.
^+r::Send ^r{tab}{tab}{space}{enter}



#IfWinActive ahk_exe Adobe Premiere Pro.exe
;This script is to stop, rewind 3 seconds, and then play. Premiere's version of this SUCKS because it brings you back to where you started
; the ~ is only there so that the keystroke visualizer can see this keypress. Otherwise, it should not be used.
;Lwin::
;~!space:: ;note, the ~ might result in stuck modifier keys, so i am not using it anymore...

;;;disabled now that I am trying out Excalibur
; ; !space::

Rwin::
Send s ;premiere "stop" command (From JKL remapped to ASD.)
Send +{left} ;"step back many frames" (which i have set to like, 10 in the premiere preferences.)
Send +{left}
Send +{left}
sleep 10
Send d ;"shuttle right" command. Might be best to instead have it on a key combo that includes CTRL....
return








;;---------------- ALL STANDARD FUNCTION KEYS IN PREMIERE --------------------
;;;PREMIEREKEYS;;; <--for easy searching

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Ripple delete clip at playhead!! This was the first AHK script I ever wrote, I think!
F1::
Send ^!s ;ctrl alt s  is assigned to [select clip at playhead]
sleep 1
Send ^+!d ;ctrl alt shift d  is [ripple delete]
sleep 1
return

;F2 is set in premiere to the [GAIN] panel.

;F3 is set in premiere to the [MODIFY CLIP] panel. 

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;; instant cut at cursor (UPON KEY RELEASE) -- super useful! even respects snapping!
;note to self, move this to premiere_functions already
;this is NOT suposed to stop the video playing when you use it, but now it does for some reason....
F4::
;keywait, F4
;tooltip, |
send, b ;This is my Premiere shortcut for the RAZOR tool. You can use another shortcut if you like, but you have to use that shortcut here.
send, {shift down} ;makes the blade tool affect all (unlocked) tracks
keywait, F4 ;waits for the key to go UP.
;tooltip, was released
send, {lbutton} ;makes a CUT
send, {shift up}
sleep 10
send, v ;This is my Premiere shortcut for the SELECTION tool. again, you can use whatever shortcut you like.
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

;F7:: is export frame (to .png) - this is more likely to change.

;F8:: is also export frame (to .png)

;;DELETE SINGLE CLIP AT CURSOR
F9::
prFocus("timeline") ;This will bring focus to the timeline. ; you can't just send ^+!3 because it'll change the sequence if you alkready have the timeline in focus. You have to go to the effect controls first. That is what this function does.
send, ^!d ;ctrl alt d is my Premiere shortcut for DESELECT. This shortcut only works if the timeline is in focus, which is why we did that on the previous line!! And you need to deselect all the timeline clips becuase otherwise, those clips will also get deleted later. I think.
send, v ;This is my Premiere shortcut for the SELECTION tool.
send, {alt down}
send, {lbutton}
send, {alt up}
send, c ;I have C assigned to "CLEAR" in Premiere's shortcuts panel.
return

; F10:: IS FREE, but it was "effect controls" for awhile to debug a stuck modifiers issue.
;;NOTE that F10 will induce menu acceleration if you DON'T have it assigned to anything, so you gotta make sure to avoid that.

;F11:: is Toggle Full Screen

;F12:: is Enable Transmit. This displays a copy of the program monitor onto another, even more accurate monitor. Sadly, it does suffer from screen tearing...


;;;;;;----------------------------------------;;;;;;;;;;;;;


;;vvvvvvvvvvvv PREMIERE EXTENDED FUNCTION KEYS (F13 and up)vvvvvvvvvvv
;PREMIEREKEYS

/*
;Premiere, Sorted by Macro key

G7:  F19 - V1 A1 locker
G8:  F18 - Horizontal Anchor
G9:  F17 - rotation
G10: F21 & F9 - 90 IRE
G11: F15 - Vertical Anchor
G12: F14 - Scale
G13: F13 - "Back" in a bin
*/

/*
;Premiere, sorted by Function key.
G13: F13 - "Back" in a bin
G12: F14 - Scale
G11: F15 - Vertical Anchor
	;F16 is free
G7:  F17 - rotation
G10: F18 - Horizontal Anchor
G8:  F19 - V1 A1 locker
	;F20 is "Disable."
G9:  F21 & F9 - add 7 gain. There are others.
	;F22 is free??

	;F23 is the K120 keyboard
	;F24 is the Azio macro keyboard
*/

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

;F16 is not currently used for anything. free.

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;Macro key G7
~F17::
global VFXkey = "F17"
instantVFX("rotation")
return



;Macro key G8
~F18::
global VFXkey = "F18"
instantVFX("anchor_point")
return


;Macro key G7
~F19::tracklocker()
~+F19::tracklocker() ;idk why i have this working for SHIFT as well, but i suspect it actually works differently within the function, if shift is being held down? IDK MAN.

F20::home ;yes, this does actually press the HOME key, rather than hitting the 4 letters that make up the WORD "home."
;note that in iCue, I have capslock remapped to F20
; and in premiere's keyboard shortcuts panel, "home" is set to "Disable (clip)" 
; But you can actually assign Disable (clip) to F20 directly. So I'm not sure why I set it up that way... I may change this later.
;update -- i have HOME and F20 both assigned to "enable" in premiere. hopefully that'll work.
;update again... after switching to 2021, premiere doens't have F20 assigned there anymore, i THINK. so i re-assigned it there. idk WHAT is going on now.

;;taran note: END is still free inside of premiere.


;F21 is used as a function key in premiere and elsewhere. this is to avoid the stuck modifiers bug associated with pairing keystrokes with CTRL, SHIFT, and/or ALT.

;;------AFTER EFFECTS SUPER FUNCTION KEY ASSIGNMENTS--------


#IfWinActive ahk_exe AfterFX.exe

F14::send, +s ;shift S, to add "scale" parameter
F15::send, +a ;vertical anchor
F18::send, +p ;horizontal anchor
F17::send +r

;macro key G7
F19::sendinput, ^{up} ;select prev layer

;Macro key G10
F21 & F9::sendinput, ^{down} ;select next layer



;;------PREMIERE ONLY F21 ASSIGNMENTS--------

#ifWinActive ahk_exe Adobe Premiere Pro.exe

;Note that i have other premiere extended function key assignments somewhere around line 2090. Yeah it's a bit of a mess.



#ifWinActive ahk_exe Adobe Premiere Pro.exe
;macro key G4.
;^+,::
F21 & F4::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error. Edit: this may or may not be necessary now that I'm no longer using the traditional modifier keys.
;audioMonoMaker("left") ;this function doesn't work as well anymore and I don't need it as much lately.
; preset("50%") ; nah.
preset("90 IRE")
return


#ifWinActive ahk_exe Adobe Premiere Pro.exe
; macro key G5.
;^+.::
F21 & F5::
sleep 11 ;you can remove this if only if you also remove the 10ms delay inside of iCue. Otherwise you get the stuck modifiers error.
;audioMonoMaker("right")
preset("50%") ;TBD. this is a TEMPORARY assignment until I can get a better thing for this key.
return


;Macro key G6
F21 & F6::
sleep 11 
sendinput, ^+U ;TBD. In premiere, ctrl shift u is now assigned to SUPER PURPLE temporarily at least.
;;reSelect() ;TBD. idk what happened, but i guess this function stopped working or I stopped needing it as much. I'll replace G6 with something else.
return





#IfWinActive ahk_exe Adobe Premiere Pro.exe

F21::return
;Macro key G1
;This used to be ^+J:: (CTRL SHIFT J) but that led to a bug where modifier keys would remain stuck in the DOWN state, which screws up a lot of other stuff as you might imagine. I'm talking about virtually stuck, not physically stuck. Just so we're clear.
;Lshift & F21 & F1::msgbox, test. This does not work.
;LShift & s::msgbox, test 2 ; this DOES work...

F21 & F1::
sleep 11 ;;this may or may not be necessary
search()
return

;Macro key G10
F21 & F9::
sleep 11 ;this may not be necessary to avoid the stuck keys bug, as neither F21, nor F9 are used in this macro. However, I guess it's possible that F9 could get stuck down? which would be bad, i guess? Hmmmm.
preset("a0p0 pan down")
;;Send {F2}7{Enter} ;adds 7 gain. ; +7db 
;;note to self, maybe have some code here to fix a stuck shift or CTRL key...
;update to note, that is no longer needed!
return

;;------END PREMIERE ONLY F21 ASSIGNMENTS--------

;F22... is free?

;F23 is the K120 keyboard
;F24 is the Azio macro keyboard

;;;;;;;^^^^^^END of PREMIERE EXTENDED FUNCTION KEYS (F13 and up)^^^^^^^^




#IfWinActive ahk_exe Adobe Premiere Pro.exe
~^e::
;The following is to remind me to do a thing, when i am rendering anyway.
;CTRL E is my shortcut to Export > Media... , so this will pop up and remind me to make an EDL, which we then submit to APMmusic.ca because they like to know what music tracks we've used in our videos. It's a huge pain, but now that I have the EDL export settings configured just how I like them, (by exporting a mostly empty EDL in my premiere project template, kinda like a dry run,) this whole process only takes me like 2 seconds each time.
; Remember that the ~ character allows the key combo to pass through, so this does NOT block the actual Export Media window from appearing.
;also it's a traytip because a messagebox woudl require me to click on it or press ENTER to dismiss it, which is a pain. Also this makes a noise, which i like.

;UPDATE: So, only Linus Tech Tips, and Tech Linked videos, use APM music. So Tech Quickie, LMG Clips, and other channels, don't use them. So I never need to export EDLs for those videos.
;Therefore, I should not be reminded to export an EDL unless I'm editing an LTT or TL video.
;I've been ignoring the notification because it's usually wrong, because I'm usually editing other channels these days.
;Therefore, it is less effective.
;It's far, far better for me to have ONLY relevant notifications coming to me. I turn off everything else. You would not believe how many apps try to send you notifications.
;Anyway, this is an easy fix. I can just look at the premiere title name, since it has the server address, which never changes.
;For reference, here are the server folder paths I'm looking for:
;Z:\Linus\2. Tech Linked\3. TL Pending
;Z:\Linus\1. Linus Tech Tips\Pending
SetTitleMatchMode Slow
WinGetTitle, title, A
itsLTT := InStr(title, "1. Linus Tech Tips")
itsTL := InStr(title, "2. Tech Linked")
;msgbox, title is %title% `n`n%itsLTT%`n%itsTL% ;;debugging.

if (itsLTT or itsTL) ;if either of these is NOT a zero, it will result in TRUE. I think.
	{
	TrayTip, Make an EDL, Hey did you export an EDL yet, 2, 32 ;THIS IS THE NOTIFICAITON
	}
return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;cut single clip at cursor.
Xbutton1::

;if you are NOT using EasyWindowDrag_(KDE).ahk then you can delete the 3 lines below.
tellme := isPremiereUnderCursor(yesno)
if (tellme = 0)
	return


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

;if you are NOT using EasyWindowDrag_(KDE).ahk then you can delete the 3 lines below.
tellme := isPremiereUnderCursor(yesno)
if (tellme = 0)
	return
	
;tooltip, xbutton2 was pressed
; ;so the issue with this is that if I hit this button while Premiere is active, but the cursor is hovering over some OTHER application, it doesn't know that, and will send these  keystrokes to THAT window. Well, at least it'll send stuff after the left click, to that window.
; ;I need to have it DETECT that you have actually clicked on premiere.
; ;note that the code below is for the sake of compatibility with EasyWindowDrag_(KDE).ahk
; MouseGetPos,,,KDE_id
; WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
; ; If KDE_Win
    ; ; return ;I am not sure exactly what this is for
; ; ;tooltip, %KDE_Win%
; WinGetClass,fancyclass,ahk_id %KDE_id%
; If (fancyclass != "Premiere Pro")
	; {
	; tooltip, NOT IN PREMIERE
	; sleep 100
	; tooltip,
	; ;winactivate?
	; WinActivate, ahk_id %KDE_id%
	; goto skipitAMKA
	; }
;;BELOW HERE WE CAN ASSUME THAT WE ARE IN FACT STILL INSIDE OF PREMIERE

send, ^!d ;ctrl alt d is DESELECT
send, v ;selection tool
send, {alt down}
send, {lbutton}
send, {alt up}

send, {home} ;disable

;send, {F20} ;disable??? Alternative to the above.

sleep 10
;I have a fancy way of figuring out which tool i WAS using. Is just be a thing that listens for v t r y b x h p and saves that as a string.

send, %currentTool%

; skipitAMKA:
return


isPremiereUnderCursor(yesno := 1)
{
;so the issue with this is that if I hit this button while Premiere is active, but the cursor is hovering over some OTHER application, it doesn't know that, and will send these  keystrokes to THAT window. Well, at least it'll send stuff after the left click, to that window.
; ;I need to have it DETECT that you have actually clicked on premiere.
MouseGetPos,,,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
; If KDE_Win
    ; return ;I am not sure exactly what this is for
; ;tooltip, %KDE_Win%
WinGetClass,fancyclass,ahk_id %KDE_id%
;tooltip, fancyclass = %fancyclass%
;sleep 1000
If (fancyclass = "DroverLord - Window Class") ;this is in case you use this on a floating Premiere window NOT connected to the main premiere window!
	{
	tooltip, on floating window
	sleep 100
	tooltip,
	return 1
	}
else If (fancyclass != "Premiere Pro")
	{
	tooltip, NOT IN PREMIERE
	sleep 100
	tooltip,
	;winactivate?
	WinActivate, ahk_id %KDE_id%
	return 0
	}
else
	return 1
}



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



Media_Stop::
;;note to self, make sure all the stuff is first UNLINKED from all other stuff, or this won't work.
;Also, be sure that LINKED SELECTION, the timeline option from the top right, is ON. only tyhen will you know this actually worked.
;the other one, "insert or overwrite sequences as nests or induvidual clips," I usually leave OFF, but it doens't matter for this thingy.
tooltip, down
;instant audio and video re-linker. press rapidly or hold down for a little while.
send, {down} ;go to next edit point
sleep 10
tooltip, u
send, u ;select clip at playhead
sleep 10
tooltip, 0 to link
send, 0 ;link
sleep 10
tooltip,
return




Media_Prev::^numpad7 ;select label group

Media_Play_Pause::^numpad9 ;super green color
Media_Next::^numpadMult ;magenta color

;Volume_Mute::^numpadDiv ;nah, I'm keeping this as mute.
;These are assigned to some of the new LABEL COLORS in premiere, using Premiere's own shortcut assignment panel.


;===================================================================
#ifWinActive ahk_exe firefox.exe
;!x::!+x ;this is the shortcut for Nuke Anything Enhanced.

;these are shortcuts for youtube's interface to slow down, pause/play, and speed up.
Media_Next::+.
Media_Play_Pause::k
Media_Prev::+,




;;&&&&&&&&&&& KEY ASSIGNMENTS FOR PHOTOSHOP &&&&&&&&&&&&&&&&&&
;#IfWinActive ahk_exe Photoshop.exe ;kinda obsolete code
#if WinActive("ahk_exe Photoshop.exe")

;;YOU CAN GET TO PHOTOSHOP SHORTCUTS BY HITTING CTRL SHIFT K

^j::PhotoshopExport() ; (as jpeg)
;the above function is found in Photoshop_Functions.ahk

F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^o ;this WAS ctrl W instead, but i wanted to use that for duplicating layers. so i do. Also note that CTRL E is combining layers.

;F4:: is SHOW PIXEL GRID by default, which is quite useful and i want to keep it like that.

;F5:: is my macro to SUPER rasterize a layer. It does 3 things to flatten/rasterize a layer instead of one.
F5::
sendinput, {F5} ;this is my PS shortcut command for "Rasterize > Layer." You may think it's odd to nest a lesser command inside of itself, sort of, but trust me, it actually works great!
sleep 1
sendinput, ^!+{F5} ;this is my shortcut for "Rasterize > Layer style"
;You're not allowed to put both of these commands on the same shortcut, but to that I say BULLSHIT, I DO WHAT I WANT.
sleep 10
sendinput, ^!k ;ctrl alt K is my photoshop shortcut for Layer Mask > Apply.
return

;F6:: convert to sRGB
;F7:: convert to LAB
;F8:: is now My MAKE VECTOR MASK(/layer mask?) ACTION. (The default is the Info window.)

;F9:: is  "convert to smart object" shortcut... not an action.

;F10:: is now SAVE AS JPEG

;F11:: is EXPAND SELECTION by 1
;+F11 should make CONTRACT SELECTION by 1

; F12:: is 200% nearest
; ^F12 is 300% Nearest
; +F12 is 50% bicubic sharper?
; ^+F12 is 50% Nearest? Maybe switch with the previous one.


;anyway, f14 is labeled "scale" already on my Corsair K95, so I'm going to use it for brush resizing in Photoshop.
;This macro is INCREDIBLY USEFUL, and I use it constantly.
F14::
tooltip, F14 ; photoshop brush resize
;I think i need to use COM here to detect if the user has a brush, eraser, rubber stamp, etc etc... and if they do NOT, then i can change to the brush tool? aaaah idk. i think not worth it.
sendinput {Lalt down}
sendinput {Rbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F14 ;waits for F14 to be released
sleep 1
sendinput {Rbutton up}
sendinput {Lalt up}
tooltip,
return

; Here's a whole thread about this, which i found later.
; https://community.adobe.com/t5/photoshop/changing-brush-size-shortcuts-ctrl-alt-second-click-and-drag/td-p/8922180
; I think I'm going to code my own overlay which will work even when not above the canvas, and will have better control over small brushes. I can do this using the photoshop COM or OLE objects and the AHK gui to make my own shapes and things... and package it up into a exe for other poeple and it'll be just great. will take a LOT of coding but it is possible in theory, i think.
;this could be useful for the offsets that i need, but it has no COM integration sadly. https://www.carbodydesign.com/archive/2008/09/30-photoshop-brush-controller/3/
; that's a project for another time...
; https://www.ps-scripts.com/viewtopic.php?f=53&t=24088&start=10
; https://www.adobe.com/content/dam/acom/en/devnet/scripting/estk/javascript_tools_guide.pdf
; newbrush()
; https://www.ps-scripts.com/viewtopic.php?f=77&t=22770&p=143524&hilit=brushes#p143524

;https://community.adobe.com/t5/photoshop/how-to-read-out-current-brush-size-in-javascript/m-p/8045339



;https://community.adobe.com/t5/photoshop/how-to-read-out-current-brush-size-in-javascript/m-p/8045339

; function getCurrentBrushInfo() {

    ; var brsh = {};

    ; var ref = new ActionReference();
	
    ; ref.putEnumerated(charIDToTypeID("capp"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));

    ; var currentBrush = executeActionGet(ref).getObjectValue(stringIDToTypeID("currentToolOptions")).getObjectValue(charIDToTypeID('Brsh'));

    ; brsh.diameter = currentBrush.getDouble(charIDToTypeID('Dmtr'));

    ; brsh.hardness = currentBrush.getDouble(charIDToTypeID('Hrdn'));

    ; brsh.angle = currentBrush.getDouble(charIDToTypeID('Angl'));

    ; brsh.roundness = currentBrush.getDouble(charIDToTypeID('Rndn'));

    ; brsh.spacing = currentBrush.getDouble(charIDToTypeID('Spcn'));

    ; return brsh

; }



;https://stackoverflow.com/questions/44508493/photoshop-javascript-how-to-change-the-brush-mode-with-javascript

;https://www.ps-scripts.com/viewtopic.php?t=7046






;----------------------------------------------------



;and this next one is for the color picker HUD in photoshop. NICE!
;i just wish it worked when i am on the canvas even while NOT above the actual image, but also on the dark grey edges.
;;;oh, this is dangerous because it only works properly if you have the brush tool selected. if you have some other tool, like the move tool, it'll start selecting layers, and change the blend mode and shit. i can solve this by switching to the brush tool first if it's not already present. i can use ps COM actions to do so., will code that all in later.
;this is macro key G11, vertical anchor.
F15::
;tooltip, f15

;https://www.autohotkey.com/boards/viewtopic.php?f=5&t=4236#p23679
ComObjActive("Photoshop.application").currentTool := "paintbrushTool"
;the above code works flawlessly. I am amazed.
;turns out I don't need to check for what tool is active, since choosing a color really only affects the paintbrush.


sendinput {Lalt down}
sendinput {Lshift down}
sendinput {Rbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F15 ;waits for F15 to be released
sleep 1
sendinput {Rbutton up}
sendinput {Lshift up}
sendinput {Lalt up}
;tooltip,
return

; zoom using your mouse movement. alternative assignment.
F19::
sendinput {Rctrl down}
sendinput {space down}
sendinput {Lbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F19 ;waits for F19 to be released
sleep 1
sendinput {Lbutton up}
sendinput {space up}
sendinput {Rctrl up}
return


F20::return ;this caused issues with capslock being rapidly toggled on and off... meaning photoshop might have hardware level access to know what key I'm actually pressing; weird.
; ; zoom using your mouse movement.
; F20::
; ;note that I've rebound my capslock to be F20, using iCue. So it becomes a very useful extra key right on homerow.
; ;in this case, I'm gonna use it for zooming around in photoshop using the mouse. usually you have to press ctrl, space, and left click, all at the same time, and THEN moving the mouse will do stuff. With this macro, you press one key instead of 3.
; sendinput {Rctrl down}
; sendinput {space down}
; sendinput {Lbutton down}
; ;sleep 1 ;just because. Maybe this is a bad idea though.
; keywait, F20 ;waits for F20 to be released
; sleep 1
; sendinput {Lbutton up}
; sendinput {space up}
; sendinput {Rctrl up}
; return

; photoshop, zoom using your mouse movement, again.
F17::
;My Corsiar K95 RGB macro key G7 is set to F18. I'm just trying this macro here as well.
sendinput {Rctrl down}
sendinput {space down}
sendinput {Lbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F17 ;waits for F17 to be released
sleep 1
sendinput {Lbutton up}
sendinput {space up}
sendinput {Rctrl up}
return


; instant hand tool using your mouse movement
F18::
;My Corsiar K95 RGB macro key G9 is set to F17.
sendinput {space down}
sendinput {Lbutton down}
sleep 1 ;just because. Maybe this is a bad idea though.
keywait, F18 ;waits for F18 to be released
sleep 1
sendinput {Lbutton up}
sendinput {space up}
return

;note to self, must make video complaining about how when photoshop flick panning is on, the hand tool is WAY smoother than when it is off. I turn it off because of a very simple premise: when I am not scrolling or moving, I don't want photoshop to be scrolling or moving. I also turn off animated zoom for that reason. KEEP IT SIMPLE.


;The following will circumvent Photoshop's stupid requirement to hold CTRL for zooming...

;;OLD CODE FOR - key:
; -::
; send, ^- ;zoom out
; sleep 5
; ;send, {ctrl up} ;I've had issues with modifier keys getting stuck
; return

;;;NEW CODE FOR - KEY:
;Taran note: This new code will fix this so that it still DOES work when "the Save As" dialouge window is open, since i do want to use the - key to type stuff in those cases.
-::
if WinActive("ahk_class #32770") and WinActive("ahk_exe Photoshop.exe") and WinActive("Save As")
{
	send, - ;normal - keystroke
}
else
{
	send, ^- ;zoom out
sleep 5
}
;send, {ctrl up} ;I've had issues with modifier keys getting stuck
return

=::
send, ^= ;zoom in
sleep 5
;send, {ctrl up} ;I've had issues with modifier keys getting stuck
return


#IfWinActive ahk_exe Photoshop.exe

;macro key G4
;F21 & F4:

;macro key G5
F21 & F5::send, !{backspace} ;alt backspace is "fill with foreground" in photoshop

;macro key G6
F21 & F6::send, ^{backspace} ;ctrl backspace is "fill with background" in photoshop

;;---FYI----
;;In Photoshop,
;;alt F13 rotates 15 degrees clockwise
;;alt F14 rotates 15 degrees counter clockwise
;;alt F15 is zoom out
;;alt F16 is zoom in
;;They cannot be remapped in Photoshop. Nor do they show up in the list you get when you press the Summarize button in Photoshop's shortcuts menu.
;;https://twitter.com/TaranVH/status/1129206615515705344
;;https://forums.adobe.com/thread/1453594


;actually, just to keep things safe, I'm going to manually block some of them.
!F14::
!F15::
;!F16::
;!F17::
;;do nothing.
return

;;ATTENTION WACOM TABLET USERS. I APOLOGISE FOR BREAKING YOUR SHIT. WACOM/ADOBE COULD THINK OF NO WAY TO LIKE, INTERFACE DIRECTLY. THEY HAD TO GO AND STEAL SOME OBSCURE SHORTCUTS THAT THEY THOUGHT NOBODY WOULD USE. WELL THEY DIDN'T KNOW THAT TARAN "MACRO" VAN HEMERT WAS ON THE CASE.
;;ANYWAY, YOU CAN JUST REMOVE THE ABOVE STUFF AND GET YOUR WACOM SHORTCUTS BACK. (Thread about wacom stuff: https://forums.adobe.com/thread/1453594)


;; RIP Monty Oum - https://youtu.be/O6ERELse_QY?t=13933
;; https://youtu.be/qSuTnCFqMkw?t=1m21s <-- the original video is no longer available. (Infonaut: Red vs Blue Hollywood (part 2 of 3))
; #IfWinActive ahk_exe Photoshop.exe
; F1::sendinput, {alt down}iac{alt up}







;;&&&&&&&&&&&&&&&&&&&& PHOTOSHOP END &&&&&&&&&&&&&&&&&&&&&




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
;F21 - being used as a modifier key to avoid the stuck modifiers bug.
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



MouseClick, left,,, 1, 0, U ; Release the mouse button. 

return

;;https://jacksautohotkeyblog.wordpress.com/2016/03/08/windows-volume-control-using-your-mouse-wheel-and-the-autohotkey-if-directive-beginning-hotkeys-part-6/



; 




;;---------------------------------------------------


;+++++++++++++++++++++++++++++++
;macro for moving GOOGLE SHEETS' or EXCEL's B-roll matrix information into WORD
; #IfWinActive ;ahk_class MozillaWindowClass
; #IfWinNotActive ahk_exe Adobe Premiere Pro.exe

#if WinActive("ahk_exe EXCEL.exe") or WinActive("ahk_exe firefox.exe") or WinActive("ahk_exe chrome.exe") ;might have to add chrome to this eventually.

;Macro key G7 i think
F17::
tooltip, F17 comment copier
;;update: this is supposed to put the shot BEFORE the other stuff on the comment, but word 365 doesn't work thatway., will fix later.
doAnEnter := 1
sendinput, ^c
sleep 100
;WinActivate ahk_exe firefox.exe
; send ^{F4} ;shortcut for activate word, and if active, move to next comment.
; msgbox, EXTREMELY WEIRD - the above code would CLOSE THE TAB. IDK what kind of cross-talk was going on... will look into that later.
if WinActive("ahk_exe EXCEL.exe")
	;doAnEnter := 0 ;sooo if you're copying out of Excel rather than google sheets, the copied cell has it's own "return," so you don't need to add one.
	doAnEnter := 0 ;testing thigns...
switchToWord()

sleep 100
send ^v
sleep 100

if (doAnEnter = 1)
	sendinput, {enter}
sleep 100
; send ^{F4} ;only use this line if switchToWord() is not directly available.
;;;;msgbox,,, just before,0.5
; switchToWord()
sendinput, {F3} ;in word, "go to next comment."
sleep 10
;;;;msgbox,,, thingy is over,0.5
;WinActivate ahk_class MozillaWindowClass
;sometimes this code activates the paragraph thingy, which is CTRL SHIFT 8. will look for other cross talk.
tooltip,
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

;"scale" key will fullscreen firefox now. (macro key G12)
F14::send, {F11}


; #ifWinActive ahk_exe SumatraPDF.exe
; ;ahk_class SUMATRA_PDF_FRAME
; ;ahk_exe SumatraPDF.exe
; F14::send, {F11} ;full screen


#IfWinActive
;experiemntal thing to super duper checK window IDs...
!`::
WinGet, ActiveId, ID, A
msgbox, %ActiveId%
;returns 0x1c0b9c ... and only 3 unique codes for each of the 3 Premiere windows I have on my 3 monitors. Does NOT consider subwindows, though maaaaybe it can get that going....
ControlGetFocus, OutputVar, A
msgbox, %OutputVar%
Return

^+end::checkFullness()



;script reloader, but it only worKs on this one :(
#ifwinactive ahk_class Notepad++
^r::
send ^s
sleep 10
Soundbeep, 1000, 500
Reload
Return

F10::RETURN ;gets rid of stupid menu acceleration thing.
F11::RETURN ;gets rid of stupid full screen thing
F12::RETURN ;gets rid of stupid top bar removal thing


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

#IfWinActive ahk_exe winword.exe
:*:--- ::{Asc 0151}

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

^+!t::
;always on top toggle / in front
Winset, Alwaysontop, , A
tooltip, ALWAYS ON TOP TOGGLE
sleep 100
tooltip,
return

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

; ^+!Escape::ExitApp

;^+/::sendinput, !{F9}
;
;


; ~VK3D::
; tooltip, what
; sleep 50
; tooltip,
; return

#ifwinactive

; SC0EB::tooltip, gonna see if keys can be tirggered when i am inside of another function.
; SC0E8::tooltip, sc0e8 EIGHT


; ; ; testing a thing.
;;;;;https://autohotkey.com/board/topic/56123-horizontal-scroll-wheelleftwheelright-in-windows-2003xp/
; ; WheelDown::
; ; send, {WheelRight}
; ; return
; ; WheelUp::
; ; send, {WheelLeft}
; ; return


;testing...



^+F12::
WinGet, the_current_id, ID, A

msgbox,,,the_current_id = %the_current_id%, 2.5

; ("AHK needed","https://docs.google.com/document/d/1xsjjKYggXYig_4lfBMJ6LDGRZ9VOvDd7SCSTSi7GwN8/edit")

vRet := JEE_ChromeFocusTabByName(, "AHK needed", 2)

msgbox,,,vRet = %vRet%, 0.5

return



#ifwinactive
;END::sendinput, {numlock}
;this is for PARSEC only. it's a temporary thing. gotta control numlock somehow!




;;;;;;;;THE BELOW CODE IS FOR SUPER SLOW SCROLLING IN FIREFOX. SADLY, IT TURNS OUT TO NOT BE AS SMOOTH AS AUTOSCROLLING (USING MIDDLE CLICK AND THEN MOVING THE CURSOR SLIGHTLY) SO I'M NOT USING IT FOR NOW...
; F9::
; tooltip, is it working
; ;PostMessage 0x20A, 0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; MouseGetPos mX, mY, WinID, Ctrl
; ;PostMessage 0x20A, 0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; ;PostMessage 0x20A, -0x780000, (mY<<16)|mX, %Ctrl%, ahk_id %WinID%
; PostMessage 0x20A, -0x780000, (30)|mX, %Ctrl%, ahk_id %WinID%
; return

; CoordMode, Mouse, Screen
; return

; WheelUp::
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, 12 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return


;WheelDown::




; F8::
; CoordMode, Mouse, Screen


; WheelUp::
	; CoordMode, Mouse, Screen
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, 120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return

; WheelDown::
	; CoordMode, Mouse, Screen
	; MouseGetPos, m_x, m_y
	; hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; ; WM_MOUSEWHEEL
	; ;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, -120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
; return

/*
F9::
;;https://www.autohotkey.com/boards/viewtopic.php?t=68578
;,PostMessage, 0x20A, 1<<16, 0,, A ;WM_MOUSEWHEEL := 0x20A
	
While GetKeyState("F9", "p")
{
	
	;;;;https://autohotkey.com/board/topic/16505-sending-wheeldown-to-a-control/
    MouseGetPos, m_x, m_y
	hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

	; WM_MOUSEWHEEL
	;	WHEEL_DELTA = 120
	; SendMessage, 0x20A, -2 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
	; SendMessage, Msg  , wParam  , lParam   , Control, WinTitle, [WinText, ExcludeTitle, ExcludeText, Timeout]
	;SendMessage, 0x20A  , -2 << 16  , 1700 << 16|2100 ,, A ;with this, it won't work until window X is 430 or greater. So fuckin weird.
	SendMessage, 0x20A  , -4 << 16  , 700 << 16|700 ,, A ;with this, it won't work until window Y is more than 280. also fuckin weird. also x must be below 695. ugh note i had line 1458 active, uuuugh.
	
	
    Sleep, 5 ; Add a delay if you want to increase the interval between keystokes.
}

return
*/	

;;;;;;; BE SUPER CAREFUL WITH    */   ... IF YOU DO    ;*/    IT LOOKS LIKE IT STILL CANCELS THE COMMENT AREA, ACCORDING TO THE SYNTAX HIGHLIGHTING IN NOTEPAD++ ... BUT IT DOESN'T. THE COMMENT AREA STILL ENXTENDS ALL THE WAY UNTIL A TRUE */ OR TO THE BOTTOM OF THE DOCUMENT.

; ;;https://www.autohotkey.com/boards/viewtopic.php?p=157799#p157799
; #IfWinActive ahk_class MozillaWindowClass
; ;note: tested on Firefox v69
; ;note: the cursor must be over the Firefox window for WM_MOUSEWHEEL/WM_MOUSEHWHEEL to work

; ^+w:: ;mozilla firefox - scroll up/down
; PostMessage, 0x20A, 1<<16, 0,, A ;WM_MOUSEWHEEL := 0x20A
; ;PostMessage, 0x115, 0, 1,, A ;WM_VSCROLL := 0x115 ;SB_LINEUP := 0
; return


;;;/////////END OF FIREFOX SUPER SLOW SCROLLING EXPERIMENT//////////////
