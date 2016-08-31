Process, Priority, , High ;----I don't know what this is or what it does or if I need it! lol!
;SetKeyDelay, 0
#SingleInstance force ;--------only one instance of this script may run at a time!

;THIS SCRIPT is now obsolete. do not load it or use it at all. it has been merged into the SECOND KEYBOARD script, so that i can call its functions directly!!!

Menu, Tray, Icon, shell32.dll, 1

#IfWinActive
; everything below this line can be used in any program


;((((((((((((THREE EXTRA CLIPBOARDS))))))))))));
;COPYING ;----please keep in mind that you have to RESTART your computer after saving these clipboards, or they don't load properly in Premiere. I have no idea why.
^!+F1::copy(1)

^!+F2::copy(2)

^!+F3::copy(3)

;PASTING

^!F1::load(1)

^!F2::load(2)

^!F3::load(3)


/*

F7::load(1)
F8::load(2)
F9::load(3)
;F10::clipboard = 

*/





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
	WinActivate, Adobe Premiere Pro
	tooltip, now loading random text into the clipboard. ;I should try it with BLANK text... This is very necessary. Must be done twice to make sure it takes.
	
	loadFromFile("clipTEXT.clp")
	sleep 15
	loadFromFile("clipTEXT.clp")
	sleep 15
	clipboard = 
	sleep 10
	
	tooltip, now pasting NOTHING into premiere.
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down} ;this is a more robust way of doing it, rather than using "^v"
	sleep 20
	ClipWait, 0.25
	SendInput, {v Up}{Ctrl Up}
	
	sleep 20
	;loadFromFile("clipTEXT.clp")
	Send ^v
	sleep 30
	;tooltip, "clip" . %int% . ".clp" ;this doesn't work

	loadFromFile("clip" . int . ".clp")
	sleep 15
	loadFromFile("clip" . int . ".clp")
	sleep 15
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down} ;this is a more robust way of doing it, rather than using "^v"
	sleep 50
	ClipWait, 0.25
	SendInput, {v Up}{Ctrl Up}
	sleep 10
	tooltip,
	
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

