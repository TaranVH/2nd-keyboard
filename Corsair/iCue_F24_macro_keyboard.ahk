#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetWorkingDir, C:\AHK\2nd-keyboard\ ;Or you could put the directory here. Whatevs.
;Menu, Tray, Icon, shell32.dll, 319 ;if commented in, this line changes the taskbar icon to a blue star. Beware that if you don't have shell32.dll, it'll be a blank icon!
;SetKeyDelay, 0 ;IDK exactly what this does.

;;EXACT LOCATION FOR WHERE TO PUT THIS SCRIPT:
; C:\AHK\2nd-keyboard\Corsair\
;;(It's not mandatory for this one, but if you use any of my other scripts, it'll make things way easier later.)

;;Location for where to put a shortcut to this script, so that it will start with Windows:
;;  Here for just yourself:
;;  C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;;  Or here for all users:
;;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

#NoEnv
SendMode Input
#InstallKeybdHook
;#InstallMouseHook ;<--You'll want to use this if you have scripts that use the mouse.
#UseHook On
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000

;;The lines below are optional. Delete them if you need to.
#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
#KeyHistory 200 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
#MenuMaskKey vk07 ;https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;prevent taskbar flashing.
;;The lines above are optional. Delete them if you need to.

;________________________________________________________________________________________
;                                                                                        
;		  2ND KEYBOARD USING iCue (and the K55, though it'll work with any of them.)     
;  
;________________________________________________________________________________________
;																						 
;     Please watch [link not yet available] for a comprehensive tutorial. 		 		 
;________________________________________________________________________________________

; https://www.corsair.com/us/en/Categories/Products/Gaming-Keyboards/Standard-Gaming-Keyboards/K55-RGB-Gaming-Keyboard/p/CH-9206015-NA

; I personally use the Hasu USB to USB keyboard converter instead of this.
; https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/

; IMPORTANT NOTE: (As of Jan 2019)
; Corsair's iCue CANNOT distinguish between different keyboards.
; That is, every Corsair keyboard you plug in will always behave the same as the others
; Meaning, you only get to use ONE Corsair keyboard at a time. You cannot have a Corsair macro
; keyboard AND a "normal" Corsair keyboard at the same time. For more info, watch this:
; https://www.youtube.com/watch?v=BuLyxcyhbLQ

;;..............................................................................;;
;;............... BEGIN SECOND KEYBOARD iCue F24 ASSIGNMENTS ...................;;
;;..............................................................................;;

;; You should DEFINITELY not be trying to add a 2nd keyboard unless you're already
;; familiar with how AutoHotkey works. I recommend that you at least take this tutorial:
;; https://autohotkey.com/docs/Tutorial.htm

;; You should probably use something better than Notepad for your scripting. (Do NOT use Word.)
;; I use Notepad++. "Real" programmers recoil from it, but it's fine for my purposes.
;; https://notepad-plus-plus.org/
;; You'll probably want the syntax highlighting: https://www.autohotkey.com/boards/viewtopic.php?t=50


;;;WARNING - THIS IS KINDA UNTESTED SINCE I HAVE STOPPED USING IT. LET ME KNOW IF YOU HAVE ANY ISSUES, BY LEAVING A GITHUB... ISSUE.  https://github.com/TaranVH/2nd-keyboard/issues


#if (getKeyState("F24", "P")) ;<--Everything after this line will only happen on the secondary keyboard that uses F24.
F24::return ;this line is mandatory for proper functionality

escape::tooltip, "[F24] You might wish to not give a command to escape. Could cause problems. IDK."
;escape::return ;<--to disable a key, just use a "return", like so.

F1::coolFunction("Hello World. From F1") ;<--This is just serving as an example of how you would assign functions to these keys
F2::coolFunction("Hello World. From F2")
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::tooltip, you pressed the function key %A_thishotkey% on the [F24] keyboard
;;Note that the assignment on the above line will apply to ALL prior lines ending in "::"
;;...which you should know from the AHK tutorial I linked you to.

;;------------------------NEXT ROW--------------------------;;

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
backspace::tooltip, [F24]  %A_thishotKey%

;;------------------------NEXT ROW--------------------------;;

tab::
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
\::tooltip, [F24]  %A_thisHotKey%
;;capslock::tooltip, [F24] capslock - this should have been remapped to F20. Keep this line commented out.

;;------------------------NEXT ROW--------------------------;;

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
;for the above line, (semicolon) note that the ` is necessary as an escape character -- and that the syntax highlighting might get it wrong.
'::
enter::tooltip, [F24]  %A_thisHotKey%

;;------------------------NEXT ROW--------------------------;;

z::
x::
c::
v::
b::
n::
m::
,::
.::
/::tooltip, [F24]  %A_thishotKey%

space::
tooltip, [F24] SPACEBAR. This will now clear remaining tooltips.
sleep 500
tooltip,
return
;;And THAT^^ is how you do multi-line instructions in AutoHotkey.
;;Notice that the very first line, "space::" cannot have anything else on it.
;;Also notice the mandatory RETURN at the very end.
;;Again, these are fundamentals that you should have learned from the tutorial.


;;===================== MODIFIERS =========================;;

;;Keep these commented out, as they are!
;Lshift::tooltip, do not use
;Lctrl::tooltip, do not use
;Lwin::tooltip, do not use
;Lalt::tooltip, do not use

;Ralt::tooltip, do not use
;Rwin::tooltip, do not use
;appskey::tooltip, This is not a modifier, but I replaced it with INTERNATIONAL4 (SC079) anyway, because it was able to misbehave.
;Rctrl::tooltip, do not use
;Rshift::tooltip, do not use


;;If you delete a modifier's key assignment in iCue, it'll act like a normal modifier.
;;that means you can use it in conjuction with the other keys, to achieve a different result, like so:
;+z::tooltip, you pressed SHIFT Z on the F24 keyboard.
;^z::tooltip, you pressed CTRL Z on the F24 keyboard.
;!z::tooltip, you pressed ALT Z on the F24 keyboard. I don't recommend this... ALT is dangerous because of menu acceleration, even if you try to disable it like I have
;^!z::tooltip, you pressed CTRL SHIFT Z on the F24 keyboard.
;;Etc.
;;However, I use few to no modifiers on my secondary keyboards... I prefer tap dance instead. The decision is up to you.
;;Note that any keys that do NOT have a modifier assignment, WILL behave normally. It's a trade off.
;;If none of that made sense, well look, you're just gonna have to experiment with it, ok?


;;================= MODIFIERS REMAPPED ======================;;

;; When you replace these with your own functions, I recommend that you do NOT delete the tooltips. Just comment them out. That way, you always know what was changed to what. It gets very confusing very quickly otherwise.
;; Here is the full list of scan code substitutions that I made:
;; https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=824607963

SC070::tooltip, [F24] LShift -to-> SC070:International 2
;the following MUST use the UP stroke - the down stroke doesn't work.
SC071 up::tooltip, [F24] LCtrl -to-> SC071:Language 2
SC072 up::tooltip, [F24] LWin -to-> SC072:Language 1
SC073 up::tooltip, [F24] LAlt -to-> SC073:International 1
;the above MUST up the UP stroke

SC077::tooltip, [F24] RAlt -to-> SC077:Language 4
SC078::tooltip, [F24] RWin -to-> SC078:Language 3
SC079::tooltip, [F24] AppsKey -to-> SC079:International 4
SC07B::tooltip, [F24] RCtrl -to-> SC07B:International 5
SC07D::tooltip, [F24] RShift -to-> SC07D:International 3

;;================= LOCKING KEYS ======================;;

F20::tooltip, [F24] CapsLock -to-> SC06B:F20
SC05C::tooltip, [F24] NumLock -to-> SC05C:International 6
;Numlock is an AWFUL key. I prefer to leave it permanently on.
;It's been changed to International 6, so you can use it with no fear that it'll mess up your numpad.
;; ScrollLock is in the next section. iCue has no more extra keys that I could have used to swap it out with.

;;================= NEXT SECTION ======================;;

PrintScreen::tooltip, [F24] %A_thishotKey%
ScrollLock::tooltip, [F24] ScrollLock - this is wrapped normally
SC07E::tooltip, [F24] Pause -to-> SC07E:Brazillian comma

;;Don't use the 3 keys below for your 2nd keyboard!
;Pause::msgbox, The Pause/Break key is a huge PITA. That's why I remapped it to SC07E
;Break::msgbox, Or is it THIS key? WHO KNOWS!
;CtrlBreak::msgbox, I have no idea what Ctrlbreak is. But it shows up sometimes.
;;Don't use the 3 keys above for your 2nd keyboard! Just don't!!

insert::
delete::tooltip, [F24] %A_thishotKey%

home::
end::tooltip, [F24] %A_thishotKey%

pgup::
pgdn::tooltip, [F24] %A_thishotKey%

;;================= NEXT SECTION ======================;;

up::
down::
left::
right::tooltip,[F24] %A_thishotKey%

;;=========== THE NUMPAD WITH NUMLOCK ON ==============;;
;;; -- (I never turn numlock off, FYI.) -- ;;
;;Please note that SHIFT will make numlock act like it's off...
;;or is it the other way around? AGH! Just don't use shift with the numpad!
numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::tooltip,[F24] %A_thishotKey% Because numlock is ON`, which is how I like it.

;;============ THE NUMPAD WITH NUMLOCK OFF ============;;
numpadins::
numpadend::
numpaddown::
numpadpgdn::
numpadleft::
numpadclear::
numpadright::
numpadhome::
numpadup::
numpadpgup::tooltip,[F24] %A_thishotKey% Because numlock is off

;;If you want a function to be called no matter what the status of numlock, do it like so:
;numpad0::
;numpadins::coolFunction("hello")

;;====== NUMPAD KEYS THAT DON'T CARE ABOUT NUMLOCK =====;;
;;NumLock::tooltip, DO NOT USE THE NUMLOCK KEY IN YOUR 2ND KEYBOARD! I have replaced it with SC05C-International 6
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::
numpadDot::tooltip, [F24] %A_thishotKey%

#if ;this line will end the F24 secondary keyboard assignments.


;;================= NEXT SECTION ======================;;
;; The K55 has 6 macro keys. I assigned them to F13-F18.
;; These keys are NOT WRAPPED. But you can do it that way (in iCue) if you like. 

F13::tooltip, G1 mapped to %A_thishotKey%
F14::tooltip, G2 mapped to %A_thishotKey%
F15::tooltip, G3 mapped to %A_thishotKey%
F16::tooltip, G4 mapped to %A_thishotKey%
F17::tooltip, G5 mapped to %A_thishotKey%
F18::tooltip, G6 mapped to %A_thishotKey%


;;====== MEDIA KEYS CANNOT BE USED IN AN iCUE MACRO =====;;
;;==== BUT WE CAN REMAP THEM TO THE SUPER FUNCTION KEYS==;;

F19::tooltip, media_stop mapped to %A_thishotKey%
;;F20 was already used as capslock
F21::tooltip, media_prev mapped to %A_thishotKey%
F22::tooltip, media_play_pause mapped to %A_thishotKey%
F23::tooltip, media_next mapped to %A_thishotKey%
;;F24 is already used as this keyboard's wrapping key.


;; move the #if to here if you want to use wrapped F13-F23 keys

;;;--------------------IMPORTANT: HOW TO USE #IF THINGIES----------------------
;;;---------------(I don't know what they are actually called.)----------------

;;You can use more than one #if thingy at a time, but it must be done like so:
#if (getKeyState("F24", "P")) and if WinActive("ahk_exe Adobe Premiere Pro.exe")
F1::msgbox, You pressed F1 on your secondary keyboard while inside of Premiere Pro

;; HOWEVER, You still would still need to block F1 using #if (getKeyState("F24", "P"))
;; If you don't, it'll pass through normally, any time Premiere is NOT active.
;; Does that make sense? I sure hope so.

;; Alternatively, you can use the following: (Comment it in, and comment out other instances of F1::)
; #if (getKeyState("F24", "P"))
; F1::
; if WinActive("ahk_exe Adobe Premiere Pro.exe")
; {
	; msgbox, You pressed F1 on your secondary keyboard while inside of Premiere Pro
	; msgbox, And you did it by using if WinActive()
; }
; else
	; msgbox, You pressed F1 on your secondary keyboard while NOT inside of Premiere Pro
;;This is easier to understand, but it's not as clean of a solution.

;; #if (getKeyState("F24", "P")) && (uselayer = 0) ;;you can also use a varibable like so, but I don't.

;; Here is a discussion about all this:
;; https://github.com/TaranVH/2nd-keyboard/issues/65

;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;+|||||||||+ END OF INTERCEPTION SECOND KEYBOARD F24 ASSIGNMENTS +|||||||||||||+
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;Note that this whole script was written for North American keyboard layouts.
;;IDK what you foreign language peoples are gonna have to do!
;;At the very least, you'll have some duplicate keys.

#if





;;*******************************************************************************
;;*******************************************************************************
;;~~~~~~~~~~~~~DEFINE YOUR NORMAL KEY ASSIGNMENTS BELOW THIS LINE~~~~~~~~~~~~~~~~
;;If you assign them BEFORE the second keyboard, they'll overrule it. That's bad!
;;*******************************************************************************
;;*******************************************************************************


#ifwinactive ahk_exe ahk_exe Adobe Premiere Pro.exe ;Code beneath this line will ONLY run in Premiere
F2::msgbox, You pressed F2 on your normal keyboard while inside of Premiere Pro. `nThis is an autohotkey script by the way - in case you forgot.`nCheck your taskbar to find it.
;; You can of course delete the above line.

;;more premiere key assignments here


#ifwinactive

;;Use Window Spy (google it) to figure out the ahk_exe of the programs you use.

;;more key assignments here

;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;~~~~~~~~~~~~~~~~~DEFINE YOUR FUNCTIONS BELOW THIS LINE~~~~~~~~~~~~~~~~~~~~~~~
;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

coolFunction(stuff)
{
msgbox, You called a function with the following parameter:`n`n%stuff%`n`nCongrats!
msgbox, You can put whatever you like in here. `nI've provided links to the functions I use.
; https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Premiere_Functions.ahk
; https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Windows_Functions.ahk
; NOTE that I use #include, rather than writing them out in the same .ahk file.
; https://autohotkey.com/docs/commands/_Include.htm
; This allows me to do fancy stuff, like direct launching scripts from my Stream Deck.
; But you don't need to do that at all. Just write out your functions in the same script.
}

anotherFunction(yeah)
{
msgbox, yup %yeah%
;Just delete this function, lol
}

