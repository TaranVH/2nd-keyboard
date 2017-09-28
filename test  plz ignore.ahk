#NoEnv
#SingleInstance force
#InstallKeybdHook
;#UseHook On 
; Show information for a specific key.
F9::

key = %A_PriorHotkey%
key = 062
; key = p
;msgbox, %key%`n%lol%`n%hi%
name := GetKeyName(key)
vk   := GetKeyVK(key)
sc   := GetKeySC(key)



MsgBox, % Format("Name:`t{}`nVK:`t{:X}`nSC:`t{:X}", name, vk, sc)

SetFormat, IntegerFast, hex
Var += 0  ; Sets Var (which previously contained 11) to be 0xb.
Var .= ""  ; Necessary due to the "fast" mode.
SetFormat, IntegerFast, d

writeshit := Format("{:X}`,SC0{:X}`,{}", vk, sc, name)


; SetFormat Integer, hex
; Loop 511
; {
  ; Code:= A_Index - 0
  ; StringTrimLeft Code, Code, 2
  ; Code = 00%Code%
  ; StringRight Code, Code, 3
  ; HotKey SC%Code%, Show
; }

; Show:
; MsgBox,,,%A_ThisHotKey%,2
; return


FileDelete, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\list of scans.txt
FileAppend,
(


), C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\list of scans.txt


return

F10::send {SC133}

; ;HERE WE ARE RECIVING SCANCODES
; ;doing some scancode testing here:*********
; ~ESC::tooltip,
; ~SC037::msgbox, numpadmultiply?
; ; ~SC038::tooltip, left alt? yes
; ~SC0E8::tooltip Used by me to negate taskbar flashing??

; ~SC058::msgbox, please work o58 - F12
; ~SC059::msgbox, 59
; ~SC05A::msgbox, helloooo 5a
; ~SC05B::msgbox, scan code 05B
; ~SC05C::
; ~SC05D::
; ~SC05E::
; ~SC05F::tooltip %A_thishotkey% 
; ~SC060::msgbox, cmoooonnn 60

; ; ~SC061::msgbox sc061, right shift
; ; ~SC062::msgbox sc062, L CTRL
; ; ~SC063::msgbox sc063, L WIN
; ; ~SC064::msgbox sc064, L ALT
; ; ~SC065::msgbox sc065, R ALT -- actually F14
; ; ~SC066::msgbox sc066, R WIN
; ; ~SC067::msgbox sc067, R CTRL
; ; ~SC068::msgbox sc068, ???
; ; ~SC069::msgbox sc069, ????

; ;~SC06A::tooltip sc06A F19
; ~SC06B::tooltip sc06B F20?
; ~SC06C::tooltip sc06C f21?
; ~SC06D::tooltip sc06D f22?
; ;~SC06E::tooltip sc06E f23?
; ~SC06F::tooltip sc06F is CTRL?
; ~SC070::tooltip sc070
; ~SC071::tooltip sc071
; ~SC072::tooltip sc072
; ~SC073::tooltip sc073
; ~SC074::tooltip sc074
; ~SC075::tooltip sc075
; ~SC076::tooltip F24
; ~SC07A::tooltip sc07A
; ~SC07B::tooltip sc07B
; ~SC07C::tooltip sc07C
; ~SC07D::tooltip sc07D
; ~SC07E::tooltip sc07E ...this does register.
; ~SC07F::tooltip sc07F is as high as I could go

; ~SC080::tooltip sc080... this does not register.
; ~SC081::tooltip sc081... this does not register.
; ~SC082::tooltip sc082... this does not register.
; ~SC083::tooltip sc083... this does not register.
; ~SC084::tooltip sc084... this does not register.
; ~SC085::tooltip sc085... this does not register.
; ~SC086::tooltip sc086... this does not register.

; ~SC0FB::tooltip sc0FB ...this does not register.
; ~SC0FC::tooltip sc0FC ...this does not register.
; ~SC0FD::tooltip sc0FD ...this does not register.
; SC0FE::tooltip sc0FE ...this does not register.
; SC0FF::tooltip sc0FF ...this does not register.
; SCE001::msgbox, SCE001 i think this super wont work





; SC045::msgbox sc045... num lock but actually pause/break?????





;*/

#ifwinactive ahk_class Notepad++
F7::
send ^s
sleep 10
SoundBeep, 1000, 500
reload
return