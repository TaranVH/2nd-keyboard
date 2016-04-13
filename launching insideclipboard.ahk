Process, Priority, , High ;----I don't know what this is or what it does or if I need it! lol!
;SetKeyDelay, 0


#SingleInstance force ;--------only one instance of this script may run at a time!

#IfWinActive ahk_exe Adobe Premiere Pro.exe

#IfWinActive ahk_exe explorer.exe

`::
Send !{up}
Return


#IfWinActive
; everything below this line can now be used outside of premiere


;((((((((((((THREE EXTRA CLIPBOARDS))))))))))))))))))));
;COPYING
^!+F1::
copy(1)
Return

^!+F2::
copy(2)
Return

^!+F3::
copy(3)
Return


;PASTING;;;;;;;;;;;;;;;;;;;;;;;;;;;

^!F1::
load(1)
Return

^!F2::
load(2)
Return

^!F3::
load(3)
Return

;I have assigned all three of these shortcuts to one of my 3-key techkeys keyboards.
;Those are expensive though, considering you only get 3 more keys. (I got mine for free.)
;If you don't have macro buttons on your keyboard, you can use the function keys instead!

;((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


copy(int) {
	sleep 10
	ClipWait, 0.25
	Send ^c
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 16
}

load(int) {
	loadFromFile("clip" . int . ".clp")
	sleep 20
	loadFromFile("clip" . int . ".clp")
	sleep 20 ;it does this twice because for some reason if you do it only once, it only works like 30% of the time. durrrr.
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	sleep 20
	ClipWait, 0.25
	SendInput, {v Up}{Ctrl Up}
	sleep 10
}

saveToFile(name) {
	RunWait, %comspec% /c C:\InsideClipboard.exe /saveclp name, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
}

loadFromFile(name) {
	RunWait, %comspec% /c C:\InsideClipboard.exe /loadclp name, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
}


;control alt shift T -- click on the address bar for any youtube video, and this will link you to the thumbnail!
;^!+T::
;Send {end}{left 11}{backspace 40}https://i.ytimg.com/vi/{right 11}/sddefault.jpg{enter}
;return
;;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
