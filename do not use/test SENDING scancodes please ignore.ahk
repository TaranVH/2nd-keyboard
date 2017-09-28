#NoEnv
SendMode Input
#InstallKeybdHook ;danger, this is untested right now
#UseHook On ;danger, also untested.



#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000


;experimenting with scan codes. here is a list of blank ones.
;https://developer.mozilla.org/en/docs/Web/API/KeyboardEvent/code

F10::sendinput, {F11} ;scancode 065 but firefox says 9C - maybe is in hex.
; F11::
; tooltip, yeah 05A
; sleep 500
; sendinput, {SC05A} ;just after F23, but is not F24.
; tooltip,
; return
2::sendinput, {SC058} ;just before F13
3::send, {SC05E}
4::send, {SC05F}
5::
sendinput, {SC060}
tooltip, SC060 was sent
return
6::sendinput, {SC061}
7::sendinput, {SC037} ;numpadmultiply
8::sendinput, {SC038} ;alt left (lol)
9::sendinput, {SC06A}
0::sendinput, {SC06B}

;
;1*
;**************
;
#ifwinactive ahk_class Notepad++
F6::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return