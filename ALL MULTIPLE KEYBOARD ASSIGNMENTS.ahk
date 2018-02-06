SetWorkingDir, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files
;the above will set A_WorkingDir. It must be done in the autoexecute area.

SetNumLockState, on ;you won't be able to change the state of numlock when this is used. I think I need admin for this though.
SetScrollLockState, off

Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something

;when you get to #include, it means the END of the autoexecute section.

;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the line below:
#Include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\gui.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\All Premiere Functions.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Almost All Windows Functions.ahk

;-------------------------------------------------------------------------
; HELLO PEOPLES
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
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

#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
detecthiddenwindows, on



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
;        PRIMARY KEYBOARD, (Corsair K95 RGB) AHK KEY ASSIGNMENTS     
;____________________________________________________________________


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

#IfWinActive ahk_exe Photoshop.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; ;RIP Monty Oum https://youtu.be/qSuTnCFqMkw?t=1m21s
; #IfWinActive ahk_exe Photoshop.exe
; F1::sendinput {alt down}iac{alt up}


#IfWinActive, ahk_group ExplorerGroup
; ctrl L, alt D, or F4 will highlight the address bar. But in different ways..?
;IDK if I need this script at all anymore.
^+!d::
sleep 10
Sendinput !d
sleep 10
return


#IfWinActive, ahk_class CabinetWClass
`::Send !{up} ;This allows you to use the TILDE to go DOWN one folder level in explorer save boxes
+`::Send !{left} ;shift tilde will go "back" in explorer save boxes


#IfWinActive ahk_exe explorer.exe ;IDK if there is any meaningful difference for using the ahk_exe rather than the ahk_CLASS

F4::
;this converts F4 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return

`::Send !{up} ;This optional script allows you to use the TILDE to go DOWN one folder level in explorer

F7::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;script to resize name field so the entire field is readable


#IfWinActive

;;shortcut to CLOSE FIREFOX with no bullshit or fanfare or annoying dialouge boxes that try to argue with you. Just completely nuke it from orbit so we can start over
^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide


;shortcut to forcefully CLOSE PREMIERE, WITH NO BULLSHIT. BULLDOZE IT FLAT, BURN IT, SALT THE EATH, NUKE IT FROM ORBIT. JUST FUCKING DIE!!!
^!+p::
Run, %comspec% /c "taskkill.exe /IM /Adobe Premiere Pro.exe /T /F" ;,, hide
sleep 100
;Run, %comspec% /c "taskkill.exe /F /PID 72536",, hide
tooltip, killed premiere
sleep 100
tooltip,
return


#IfWinActive

;F13::
sc064::back()


^F1::switchToFirefox()
+^F1::switchToOtherFirefoxWindow()
^F2::switchToExplorer()
!^F2::closeAllExplorers()

^F3::switchToPremiere()

^F4::switchToWord()
+^F4::switchWordWindow()
^F5::switchToChrome()

+^F6::
windowSaver()
msgbox,,, savedCLASS = %savedCLASS% `nsavedEXE = %savedEXE%, 0.6
Return

^F6::
;I had to learn just now to use the parameter to pass "savedCLASS" even though it's already a global variable. Just works better this way... but really IDK what i am doing.
; msgbox,,, switching to `nsavedCLASS = %savedCLASS% `nEXE = %savedEXE%, 0.5
switchToSavedApp(savedCLASS) ;Macro key G14
return

^F9::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.
^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")

; ^F11 is taken by filemover.ahk
; ^F12 is also taken by filemover.ahk
;NOTE: ^F12 (ctrl F12) is forbidden by Premiere, since it opens the Premiere CONSOLE. interesting.









#IfWinActive
;opens the CLOCK / CALENDAR. ;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#z::
Send #b{left}{left}{enter}
Return


#IfWinActive

;control alt shift T -- click on the address bar for any youtube video, and this will link you to the thumbnail!
^!+T::
Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/sddefault.jpg{enter}
; Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/maxresdefault.jpg{enter}

;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
;http://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg
return



#IfWinActive
Joy1::msgbox you hit Joy1
Joy2::msgbox you hit Joy2
Joy3::msgbox you hit Joy3

Media_Next::
msgbox hiiiee. testing stuff.
return

#ifwinactive



;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING INTERCEPTOR (Logitech K120)  
;____________________________________________________________________
;please watch https://www.youtube.com/watch?v=y3e_ri-vOIo if you need help.
;DANGER: installing interception may cause your USB devices to stop working sometimes, because it is limited to supporting only 10 of each device class. You have to uninstall it to fix that. Here is a follow up video with new information: https://www.youtube.com/watch?v=Hn18vv--sFY


;#if (getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.

;;;;;;;;;;;;;BEGIN K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS;;;;;;;;;;;;;;;;;
#if (getKeyState("F23", "P")) ;THIS is the line that makes all the lines below, possible.

F23::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.

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
backspace::instantExplorer("Z:\Linus\Team_Documents\TARAN THINGS\cutting_room_floor")

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

y::preset("impact flash preset")
u::preset("")
i::preset("multiply")
o::preset("flip vertical")
p::preset("flip horizontal")
[::preset("Impact Pop for full-screen")
]::preset("Impact Pop with undershoot")
\::instantExplorer("Z:\Linus\9 - Tools\1-Sound Effects")

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


h::preset("invert preset")
j::preset("anchor and position to 0") ;no panning involved here.
k::preset("100 to 120 zoom")
l::preset("25% blur and darkener")
`;::preset("blur with edges") ;lol, the syntax highlighting gets this one wrong.
'::preset("Warp Stabilizer Preset")
enter::instantExplorer("Z:\Linus\1. Linus Tech Tips\Assets\Music")
;enter WAS ;Sendinput ^!e

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

n::preset("mosaic preset")
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

;space::tippy("2nd space") ;change this to EXCLUSIVE "play" only?

;Ralt::msgbox Ralt - doesnt work
;Rwin::msgbox Right Win - doesnt work
;Rshift::msgbox RIGHT SHIFT lol

;SC06E::msgbox,,,this was right WINkey,0.5
SC06F::msgbox,,,testing scan codes,0.5
SC062::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations\~CANNED PRE ROLLS") ;remapped away from appskey, it seemed to cause problems.
Rctrl::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations\~INTEGRATIONS")
space::InstantExplorer("Z:\Linus\10. Ad Assets & Integrations")
;SC065::runexplorer("Z:\Linus\10. Ad Assets & Integrations\~ For Review") ;this is remapped from ALT. JK, SC065 is F14, do not use.
appskey::msgbox, this is the right click appskey KEY I guess

;these were all formerly runExplorer()
PrintScreen::InstantExplorer("Z:\Linus\Team_Documents\TARAN THINGS")
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
tippy("numpad3 from jelly comb")
IfWinActive, ahk_class CabinetWClass
	{
	send {alt}vo{enter} ;sort by name
	tippy("sort Explorer by name")
	}
return


numpad6::
IfWinActive, ahk_class CabinetWClass
	{
	Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
	send {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...
	tippy("sort Explorer by date")
	}
return

numpad5::
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	{
	ExplorerViewChange_ICONS(exphWnd)
	
	}
; IfWinActive, ahk_class CabinetWClass
	; {
	
	; ;tippy("numpad55 from jelly comb")
	; ExplorerViewChange_ICONS(explorerHwnd)
	; }
return


	; https://autohotkey.com/boards/viewtopic.php?t=28304
	; WinGet, Win_pid, PID, A
	; PostMessage, 0x111, 28717,0,, ahk_pid %Win_pid%      ;"Thumbnails" (h) (t)
	;PostMessage, 0x111, 28713,0,, ahk_pid %Win_pid%      ;"Icons" (n) (i) (m = Medium icon view)
	
;WinGet, Win_pid, PID, A
;PostMessage, 0x111, 28715,0,, ahk_pid %Win_pid%      ;"List" (l)


numpad4::
; if WinActive("ahk_class CabinetWClass") ;an explorer window
	; {
	; Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field in explorer
	; }
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	{
	ExplorerViewChange_Window(exphWnd)
	}
return

numpad7::instantexplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard") 
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
#if (getKeyState("F24", "P"))
F24::return ;F24

escape::
msgbox,,,you pressed escape. this might cause like problems maybe,0.9
tooltip, 
return
F1::tooltip,
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
F12::tooltip, you pressed  %A_thishotkey%

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
backspace::tooltip, you pressed  %A_thishotkey%

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

q::return
w::sendinput, +{F12}^w
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
SC060::gotofiretab("Calendar","https://calendar.google.com/calendar/b/0/r")

;FROM LEFT CTRL. INBOX
SC062::gotofiretab("Linus Media Group Inc. Mail","https://mail.google.com/mail/u/0/#inbox")
;or a tab that says "says..."
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
'::tooltip, you pressed  %A_thishotkey%
enter::
if WinActive("ahk_class Premiere Pro")
	sendinput, ^!+n ;toggle audio names
return


;;;;;next line;;;;;;;;

Lshift::tooltip, you pressed  %A_thishotkey%
z::send ^+6
x::send ^+7
c::send ^+8
v::send ^+9
b::send ^+0
n::send ^+-
m::
,::
.::
/::tooltip, you pressed  %A_thishotkey%

;l control    Linus Media Group Inc. Mail

Lwin::msgbox, LEFT win

;Lalt has been remapped to SC064, which is F13.
;NOTE that this can interfere with normal F13 keypresses elsewhere in this script...
SC064::
IfWinNotExist, ahk_exe Adobe Media Encoder.exe
	run, C:\Program Files\Adobe\Adobe Media Encoder CC 2017\Adobe Media Encoder.exe ;ahk_exe Adobe Media Encoder.exe
if WinExist("ahk_exe Adobe Media Encoder.exe")
	WinActivate ahk_exe Adobe Media Encoder.exe
;tooltip, ran ME
return



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
delete::sendinput, ^!+k ;lock/unlock all audio tracks
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
;tooltip, numpad 0
if WinActive("ahk_class Premiere Pro")
	sendinput, ^!+9 ;activate lumetri scopes
return
numpad1::
if WinActive("ahk_class Premiere Pro")
	;sendinput, ^!+4 ;Safe margins, source monitor
	prFocus("source")
	sendinput, ^!+[ ;Safe margins, source monitor
	prFocus("timeline")
return
numpad2::
if WinActive("ahk_class Premiere Pro")
	prFocus("program")
	sendinput, ^!+] ;safe margins, program monitor
	prFocus("timeline")
return

;WE ARE STILL INSIDE THE AZIO KEYBOARD

numpad3::return
numpad4::
prFocus("source")
send ^{numpad1} ;res to 1/1
prFocus("timeline")
return

numpad5::
prFocus("program")
send ^+1 ;res to 1/1
prFocus("timeline")
return

numpad6::tooltip, you pressed  %A_thishotkey%
numpad7::
prFocus("source")
send ^{numpad2} ;res to 1/2
prFocus("timeline")
return

numpad8::
prFocus("program")
send ^+2 ;res to 1/2
prFocus("timeline")
return

numpad9::tooltip, you pressed  %A_thishotkey%

;+numlock::
numlock::
prFocus("source")
send ^{numpad3} ;res to 1/4
prFocus("timeline")
return

numpadDiv::
prFocus("program")
send ^+3 ;res to 1/4
prFocus("timeline")
return

numpadMult::tooltip, you pressed  %A_thishotkey%
numpadSub::tooltip, you pressed  %A_thishotkey%
numpadAdd::sendinput, ^!{F10}
numpadEnter::sendinput, ^!m ;mute/unmute mic - shadowplay

numpadDot::tooltip, you pressed  %A_thishotkey%
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
Xbutton1::return
Xbutton2::return ;these are both on the side of my mouse and I don't like accidentally hitting them.



;^numpad1 is now "source monitor, 1/1 resolution.
^numpad0:: ;EASE IN AND EASE OUT
tooltip, yeah
;might be a hell of a lot easier with this kind of code:
; WinMenuSelectItem, Adobe Premiere Pro, , Edit, Ripple Delete 
; WinMenuSelectItem, Adobe Premiere Pro, , Clear
; WinMenuSelectItem, Adobe Premiere Pro, , Temporal Interpolation, Ease In
; WinMenuSelectItem, Adobe Premiere Pro, , Temporal Interpolation, Ease Out
; WinMenuSelectItem, Adobe Premiere Pro, , Spatial Interpolation, Linear

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


#IfWinActive


;macro key G1 on K95. universal SEARCH EVERYTHINGER
; this used to have a ~ to let it pass through... not sure why. it was creating an ENTER keypress effect in notepad++ so i removed it.
^+J::
if winactive("ahk_exe Adobe Premiere Pro.exe")
	{
	;Keyshower("effects Panel CLEAR",,1)
	effectsPanelType("") ;set to macro key G1 on my logitech G15 keyboard. ;This just CLEARS the effects panel search bar so that you can type something in.
	;previously was ^+0
	}
else if winactive("ahk_exe notepad++.exe")
	sendinput ^f
else if winactive("ahk_exe firefox.exe")
	sendinput ^e
else if winactive("ahk_exe chrome.exe")
	sendinput ^e
else if winactive("ahk_class CabinetWClass")
	sendinput ^e
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe

;macro key G2
~^+K::preset("Warp Stabilizer Preset") ;macro key G2. I wish it would also press "analyse..."
;;;~^+=::effectsPanelType("presets") ;set to macro key G3. ;Types in "presets," which reveals my own entire list of presets. ;;I have canceled this one in favor of a global pause/play.

;macro key G3
~^+L::sendinput, {space} ;Macro key G3

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;macro key G4. Using the WIn key is prooobably a terrible idea; I do not reccomend it...... :(
~^+,::audioMonoMaker("left")

; macro key G5.
~^+.::audioMonoMaker("right")

#IfWinActive 
;Macro key G6
~^+U::reSelect() ;formerly ^+9

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#IfWinActive ahk_exe notepad++.exe
F4::F2 ;this is to regain what I lost when I used F2 and F3 for tab navigation.


#IfWinActive ahk_exe Adobe Premiere Pro.exe
!]::preset("DeHummer Preset") ;This uses the Dehummer effect, and its 120 Hz notch preset, to get rid of any electrical hum noise in the audio.

appskey::sendinput, ^!k ;in premiere, CTRL ALT K is "clear selected marker." You can't assign it DIRECTLY to appskey, so I do it here.


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
;Maybe this code really shoudl be in ALL PREMIERE FUNCTIONS.ahk.
#IfWinNotActive ahk_class Premiere Pro
;;macro key G3, when NOT in Premiere.
^+L::
;WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window

Keyshower("[WC1] pause/play Premiere when not active",,1,-400)

;Trying to bring focus to the TIMELINE itself is really dangerous and unpredictable, since its Class# is always changing, based upon how many sequences, and other panels, that might be open.
ControlFocus, DroverLord - Window Class14,ahk_exe Adobe Premiere Pro.exe
;If we don't use ControlFocus first, ControlSend experiences bizzare and erratic behaviour, only able to work when the video is PLAYING, but not otherwise, but also SOMETIMES working perfectly, in unknown circumstances. Huge thanks to Frank Drebin for figuring this one out; it had been driving me absolutely mad. https://www.youtube.com/watch?v=sC2SeGCTX4U
; Window Class14 is the Program monitor, at least on my machine.
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

sleep 10
ControlSend,DroverLord - Window Class14, ^+!5,ahk_exe Adobe Premiere Pro.exe ;this will highlight the EFFECT CONTROLS, which will NOT also stop playback of the source monitor, if it is already playing.
sleep 30

ControlSend,DroverLord - Window Class1,{space},ahk_exe Adobe Premiere Pro.exe
;even though we are sending the "SPACE" to a windowclass that (often) doesn't exist, because we already highlighted the effect controls, the space will go to the effect controls panel. (it hasb't failed to do so yet, at least.)


; ControlSend,,{space}, ahk_exe Adobe Premiere Pro.exe

;in case premiere was accidentally switched to, this will switch the user back to the original window.
if not WinActive(lolClass)
	WinActivate, %lolclass%

return



;Here we have a mster list of all function key assignments

#IfWinActive ahk_exe Adobe Premiere Pro.exe


~F1::Send u^+!d ;u is [select clip at playhead] and ctrl alt shift d is [ripple delete]
;F2 is set in premiere to the [GAIN] panel.
;F3 is set in premiere to the [MODIFY CLIP] panel. 
~F4::masterClipSelect() ;this has not been fully programmed yet
~F5::clickTransformIcon2()
~F6::cropClick()
;~F7::unused
;F8::unused
;F9::unused
;^{F9}  ^F9 toggle all video tracks ;NOTE - NEED TO REASSIGN. USED FOR APP SWITCHING NOW.
;^!{F9} ^+F9 toggle all audio tracks
;F10::unused
;F11::unused
;F12::unused
;F13 - from macro key G13, "back" in windows mods script.

;Macro key G12 on my K95 keyboard is set to F14.
#IfWinActive ahk_exe winword.exe
~F14::F2
;;all the below code CANNOT work as long as there is ~VK7DSC065:: present. this needs to be done NO with the # thingies. will improve this code later.
; tooltip, wat
; sendinput, {F2} ;set to "go to previous comment" in Word.
; ; IfWinExist, Microsoft Office Word, OK ;checks to see if the annoying "do you want to continue searching from the beginning of the document" dialouge box is present.
	; ; sendinput, {escape}
; return

#IfWinActive ahk_exe Adobe Premiere Pro.exe


;~VK7DSC065:: ;I was having trouble with cross-talk on F14... so writing it this way allowed me to use it. But, this line no longer works in AHK 1.1.27.06... and now using "~F14::" works fine. 
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

;F16 is maybe available?

;macro for moving GOOGLE SHEETS, B-roll matrix information into WORD
#IfWinActive ahk_class MozillaWindowClass
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
;^+]::Send {F2} ;set to "go to previous comment" in Word.
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
;Lwin::
; ~!space::
Rwin::
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





;saving this blank keyboard for future use
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
F12::tooltip, you pressed %A_thishotkey%

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

