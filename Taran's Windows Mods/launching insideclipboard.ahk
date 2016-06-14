Process, Priority, , High ;----I don't know what this is or what it does or if I need it! lol!
;SetKeyDelay, 0
#SingleInstance force ;--------only one instance of this script may run at a time!


#IfWinActive
; everything below this line can be used in any program


;((((((((((((THREE EXTRA CLIPBOARDS))))))))))));
;COPYING
^!+F1::copy(1)

^!+F2::copy(2)

^!+F3::copy(3)

;PASTING

^!F1::load(1)

^!F2::load(2)

^!F3::load(3)

;These 3 (or more) save/load functions are intended to be launched from a single keystroke, possibly on a second keyboard... just not pressed manually evey time.

;((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

;Exec = "C:\InsideClipboard.exe" ; this code does NOT work. You end up with a blank string.

copy(int) {
	sleep 10
	;ClipWait, 0.25 ; this line might not be needed.
	Send ^c
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 16
}

load(int) {
	loadFromFile("clip" . int . ".clp")
	sleep 20
	loadFromFile("clip" . int . ".clp")
	sleep 20
	;it does this twice because for some reason if you do it only once, it only works like 30% of the time. durrrr.
	;msgbox, "clip" . int . ".clp"
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down} ;this is a more robust way of doing it, rather than using "^v"
	sleep 20
	ClipWait, 0.25
	SendInput, {v Up}{Ctrl Up}
	sleep 10
}

saveToFile(name) {
	;code below does not use any fancy variables. Bare string. Unfortunately, I can't find a way to make the others work.
	RunWait, %comspec% /c C:\InsideClipboard.exe /saveclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	
	;just saving the below lines of code, which didn't work because %pathh% nor %Exec% could not be defined properly. I'm not sure why.
	;RunWait, %comspec% /c %Exec% /saveclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	;RunWait, %comspec% /c %Exec% /saveclp %name%, %pathh%
	
}

loadFromFile(name) {
	RunWait, %comspec% /c C:\InsideClipboard.exe /loadclp %name%, c:\Users\TaranVanHemert\Downloads\Taran extra keyboards\insideclipboard\clipboards\
}

