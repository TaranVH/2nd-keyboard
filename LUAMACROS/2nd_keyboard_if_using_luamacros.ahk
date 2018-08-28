#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On
Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; HELLO, poeple who want info about making a second keyboard, using luamacros!

; Here's my LTT video about how I use the 2nd keyboard with Luamacros: https://www.youtube.com/watch?v=Arn8ExQ2Gjg

; And Tom's video, which unfortunately does not have info on how to actually DO it: https://youtu.be/lIFE7h3m40U?t=16m9s

; If you have never used AutoHotKey, you must take this tutorial before proceeding!
; https://autohotkey.com/docs/Tutorial.htm

; So you will need luamacros, of course.
; Luamacros: http://www.hidmacros.eu/forum/viewtopic.php?f=10&t=241#p794
; AutohotKey: https://autohotkey.com/

; However, I no longer use luamacros, because I believe interecept.exe is even better! My current code is available in "ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk"

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;-------------2ND KEYBOARD USING LUAMACROS-----------------

#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO. But you can change this to anything you like. You can use Window Spy to determine the ahk_exe of any program, so that your macros will only work when and where you want them to.

;There is no code here. T'was just an example.

#IfWinActive ;---- This will allow for everything below this line to work in ANY application.

~F24::
FileRead, key, C:\AHK\2nd-keyboard\support_files\keypressed.txt
tippy(key) ;<--- this function will just launch a quick tooltip that shows you what key you pressed. OPTIONAL.
If (key = "o")
preset("flip horizontal") 
else if(key = "p")
preset("flip vertical")
else if(key = "i")
	{
	preset("multiply")
	;note that if you want to have multiple lines, you must use { } thingies.
	}
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


else if(key = "r")
copy(1)
else if(key = "f")
copy(2)
else if(key = "v")
copy(3)

else if(key = "t")
paste(1)
else if(key = "g")
paste(2)
else if(key = "b")
paste(3)

else if(key = "up") ;impact push transitions - fun fact, you can SAVE TRANSITION PRESETS if they are cross dissolve or from a 3rd party. In the effect controls triple line menu.
preset("push up")
else if(key = "left")
preset("push left")
else if(key = "down")
preset("push down")
else if(key = "right")
preset("push right")

else if(key = "enter")
Send ^!e ;in premiere, set this (CTRL ALT E) to "remove effects"

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


;;;ALL THE CODE BELOW CAN BE THE ACTUAL FUNCTIONS THAT YOU WANT TO CALL;;;


;;;;;;temporary tooltip maker;;;;;;
Tippy(tipsHere, wait:=333)
{
ToolTip, %tipsHere% TP,,,8
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
noTip:
	ToolTip,,,,8
	;removes the tooltip
return
;;;;;;/temporary tooltip maker;;;;;;


insertSFX(parameter){
msgbox, you launched insertSFX with the parameter %parameter%
msgbox, obviously you can now put any function you like in here.

}


audiomonomaker(parameter){
msgbox, you launched audiomonomaker with the parameter %parameter%
msgbox, you can grab the real function from Almost_All_Premiere_Functions.ahk

}


preset(parameter){
msgbox, you launched PRESET with the parameter %parameter%

}


recallTransition(parameter){
msgbox, you launched recallTransition with the parameter %parameter%
}


copy(bar){
msgbox, you launched COPY with the parameter %bar%

}

paste(foo){
msgbox, you launched PASTE with the parameter %foo%

}