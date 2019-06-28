SetWorkingDir, C:\AHK\2nd-keyboard\support_files

#NoEnv
;Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input 
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm
Menu, Tray, Icon, imageres.dll, 251 ;makes the icon into two blue window thingies. would prefer a PS icon if only i knew how to make custom icons.

;Menu, Tray, Icon, C:\My Icon.ico
;https://superuser.com/questions/1102307/change-the-picture-from-the-icon-tray



;-------------------------------------------------------------------------
; HELLO PEOPLES!
; IF YOU ARE NEW TO AUTOHOTKEY, YOU MUST AT LEAST TAKE THE FOLLOWING TUTORIAL:
; https://autohotkey.com/docs/Tutorial.htm
;
; You will need to know some basic scripting to custom tailor most
; of these scripts to your own machine, if you want to use them!
; VERY IMPORTANT NOTE:
; This file works in tandem with ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; All the functions from HERE are actually CALLED from keyboard shortcuts
; in THAT script. I had to do it this way because of the Stream Deck(s)...
; But you can put your key bindings and functions in the same script if
; you want.
;------------------------------------------------------------------------

;update, just kidding. this script somehow, and very weirdly, interfered with ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk -—so i just moced all of this crap over there.

#IfWinActive ahk_exe Photoshop.exe

;fix stupid requirement to hold CTRL for photoshop zooming...
; -::
; send, ^- ;zoom out
; sleep 5
; send, {ctrl up} ;I've had issues with modifier keys getting stuck
; return

; =::
; send, ^= ;zoom in
; sleep 5
; send, {ctrl up} ;I've had issues with modifier keys getting stuck
; return

; F9::
; send, ^-
; sleep 5
; send, {ctrl up} ;I've had issues with modifier keys getting stuck
; return

; F10::
; send, ^=
; sleep 5
; send, {ctrl up} ;I've had issues with modifier keys getting stuck
; return
