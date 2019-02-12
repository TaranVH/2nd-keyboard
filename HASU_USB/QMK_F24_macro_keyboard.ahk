SetWorkingDir, C:\AHK\2nd-keyboard\
;Menu, Tray, Icon, shell32.dll, 283 ;if commented in, this line will turn the H icon into a little grey keyboard-looking thing.
;SetKeyDelay, 0 ;IDK exactly what this does.


;;WHAT'S THIS ALL ABOUT??

;;THE SHORT VERSION:
;; https://www.youtube.com/watch?v=kTXK8kZaZ8c

;;THE LONG VERSION:
;; https://www.youtube.com/playlist?list=PLH1gH0v9E3ruYrNyRbHhDe6XDfw4sZdZr

;;LOCATION FOR WHERE TO PUT THIS SCRIPT:
; C:\AHK\2nd-keyboard\HASU_USB\
;;(It's not mandatory for this one, but if you use any of my other scripts, it'll make things easier later.)

;;Location for where to put a shortcut to the script, such that it will start when Windows starts:
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








;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;
;;+++++++++++++++++ BEGIN SECOND KEYBOARD F24 ASSIGNMENTS +++++++++++++++++++++;;
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++;;

;; You should DEFINITELY not be trying to add a 2nd keyboard unless you're already
;; familiar with how AutoHotkey works. I recommend that you at least take this tutorial:
;; https://autohotkey.com/docs/Tutorial.htm

;; You should probably use something better than Notepad for your scripting. (Do NOT use Word.)
;; I use Notepad++. "Real" programmers recoil from it, but it's fine for my purposes.
;; https://notepad-plus-plus.org/
;; You'll probably want the syntax highlighting:  https://stackoverflow.com/questions/45466733/autohotkey-syntax-highlighting-in-notepad

;;COOL BONUS BECAUSE YOU'RE USING QMK:
;;The up and down keystrokes are registered seperately.
;;Therefore, your macro can do half of its action on the down stroke,
;;And the other half on the up stroke. (using "keywait,")
;;This can be very handy in specific situations.
;;The Corsair K55 keyboard fires the up and down keystrokes instantly.

#if (getKeyState("F24", "P")) ;<--Everything after this line will only happen on the secondary keyboard that uses F24.
F24::return ;this line is mandatory for proper functionality

escape::tooltip, "[F24] You might wish to not give a command to escape. Could cause problems. IDK."
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
;;Again, these are fundamentals that you should have learned from the tutorial.


;;===================== MODIFIERS =========================;;

;Lshift::tooltip, Even if you used the "F22_with_modifiers" hex file, these woudn't be wrapped unless you were already holding down some OTHER key. hmm.
;If you DID use F24.hex, then these won't get pressed in the first place.
;Lctrl::tooltip, do not use
;Lwin::tooltip, do not use
;Lalt::tooltip, do not use

;Ralt::tooltip, do not use
;Rwin::tooltip, do not use
;appskey::tooltip, This is not a modifier, but I replaced it with INTERNATIONAL4 (SC079) anyway, because it was able to misbehave.
;Rctrl::tooltip, do not use
;Rshift::tooltip, do not use


;;If you leave the modifier keys alone, it allows for lines like the ones below:
;+z::tooltip, you pressed SHIFT Z on the F24 keyboard.
;^z::tooltip, you pressed CTRL Z on the F24 keyboard.
;!z::tooltip, you pressed ALT Z on the F24 keyboard. I don't recommend this... ALT is dangerous because of menu acceleration, even if you try to disable it like I have
;^!z::tooltip, you pressed CTRL SHIFT Z on the F24 keyboard.
;;Etc.
;;However, I use few to no modifiers on my secondary keyboards... I prefer tap dance instead. The decision is up to you.
;;If you're super confused by all this, don't be. Just use F24.hex and don't worry about the modifiers at all.
;;Also, I have to do some more testing to see if the stuff I said above is actually true, hmmmmmm.


;;================= MODIFIERS REMAPPED ======================;;

;; When you replace these with your own functions, I recommend that you do NOT delete the tooltips. Just comment them out. That way, you always know what was changed to what. It gets very confusing very quickly otherwise.
;; Here is the full list of scan code substitutions that I made:
;; https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=824607963

SC070::tooltip, [F24] Lshift -to-> SC070-International 2

;; The following 3 assignments MUST use the UP stroke - the down stroke doesn't appear for some reason.
SC071 up::tooltip, [F24] LCtrl -to-> SC071-Language 2
SC072 up::tooltip, [F24] LWin -to-> SC072-Language 1
SC073 up::tooltip, [F24] LAlt -to-> SC073-International 1
; The above 3 assignments MUST up the UP stroke

SC077::tooltip, [F24] RAlt -to-> SC077-Language 4
SC078::tooltip, [F24] RWin -to-> SC078-Language 3
SC079::tooltip, [F24] AppsKey -to-> SC079-International 4
SC07B::tooltip, [F24] RCtrl -to-> SC07B-International 5
SC07D::tooltip, [F24] RShift -to-> SC07D-International 3

;;================= LOCKING KEYS ======================;;

F20::tooltip, [F24] CapsLock -to-> SC06B-F20
SC05C::tooltip, [F24] NumLock -to-> SC05C-International 6
;Numlock is an AWFUL key. I prefer to leave it permanently on.
;It's been changed to International 6, so you can use it with no fear that it'll mess up your numpad.
;;ScrollLock is in the next section.

;;================= NEXT SECTION ======================;;

PrintScreen::tooltip, [F24] %A_thishotKey%
ScrollLock::tooltip, [F24] %A_thishotKey% ;ScrollLock is not so troublesome. I left it alone.
SC07E::tooltip, [F24] Pause -to-> SC07E-Brazillian comma

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
numpad9::tooltip,[F24] %A_thishotKey%

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

;;====== NUMPAD KEYS THAT DON'T CARE ABOUT NUMLOCK =====;;
;;NumLock::tooltip, DO NOT USE THE NUMLOCK KEY IN YOUR 2ND KEYBOARD! I have replaced it with SC05C-International 6
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::
numpadDot::tooltip, [F24] %A_thishotKey%

;;================== JUST IN CASE ======================;;
; I tested a CoolerMaster keyboard that had P1 P2 P3 and P4 keys on it,
; which corresponded to some of the super function keys. (F13-F24)
; So I've put those below too, just in case you have the same thing.
; You don't have the option to NOT wrap them, unless you make your own hex file.

F13::
F14::
F15::
F16::
F17::
F18::
F19::tooltip, [F24] %A_thishotKey%
;;;F20:: already used by CapsLock
;;F21::meh
;;F24::might be used by some other keyboard
;;F23::might be used by some other keyboard
;;F24::do not use

;;== MEDIA KEYS CANNOT BE WRAPPED IN F24 WITH THE USB CONVERTER ==;;
;;; otherwise they would be here :(

;;============== END OF ALL KEYBOARD KEYS ===============;;

#if ;this line will end the F24 secondary keyboard assignments.


;;;---------------IMPORTANT: HOW TO USE #IF THINGIES-------------------

;;You can use more than one #if thingy at a time, but it must be done like so:
#if (getKeyState("F24", "P")) and if WinActive("ahk_exe Adobe Premiere Pro.exe")
F1::msgbox, You pressed F1 on your secondary keyboard while inside of Premiere Pro

;; HOWEVER, You still would still need to block F1 using #if (getKeyState("F24", "P"))
;; If you don't, it'll pass through normally, any time Premiere is NOT active.
;; Does that make sense? I sure hope so. Experiment with it if you don't understand.

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

;; Here is a discussion about all this:
;; https://github.com/TaranVH/2nd-keyboard/issues/65

;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;+++++++++++++++++ END OF SECOND KEYBOARD F24 ASSIGNMENTS ++++++++++++++++++++++
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;Note that this whole script was written for North American keyboard layouts.
;;IDK what you foreign language peoples are gonna have to do!
;;At the very least, you'll have some duplicate keys.

#if

;;*******************************************************************************
;;*************DEFINE YOUR NORMAL KEY ASSIGNMENTS BELOW THIS LINE****************
;;*******************************************************************************

;;If you assign them BEFORE the second keyboard, they'll overrule it. You don't want that.
#ifwinactive ahk_exe ahk_exe Adobe Premiere Pro.exe
F2::msgbox, You pressed F2 on your normal keyboard while inside of Premiere Pro. `nThis is an autohotkey script by the way - in case you forgot.`nCheck your taskbar to find it.
;; You can of course delete the above line.
#ifwinactive
;;~~~~~~~~~~~~~~~~~DEFINE YOUR FUNCTIONS BELOW THIS LINE~~~~~~~~~~~~~~~~~~~~~~~~~


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

