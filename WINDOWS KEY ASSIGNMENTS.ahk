#NoEnv
SendMode Input
#SingleInstance force
#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Almost All Windows Functions.ahk
#MaxHotkeysPerInterval 2000
Menu, Tray, Icon, shell32.dll, 16 


;;;;;;temporary tooltip maker;;;;;;




#IfWinActive ahk_class Notepad++
;instant save and reload for this script -- and i guess not the other ones...?
F5::
send ^s
sleep 100
Reload
Return
#IfWinActive

;these two can probably be combined with  && but i dont wanna figure that out now.
#IfWinActive ahk_class MozillaWindowClass
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
#IfWinActive


;RIP Monty Oum https://youtu.be/qSuTnCFqMkw?t=1m21s
#IfWinActive ahk_exe Photoshop.exe
F1::sendinput {alt down}iac{alt up}



#IfWinActive, ahk_group ExplorerGroup
; ctrl L, alt D, or F4 will highlight the address bar. But in different ways..?
^+!d::
sleep 10
Sendinput !d
sleep 10
return

`::
Send !{up} ;This allows you to use the TILDE to go DOWN one folder level in explorer save boxes
Return

+`::Send !{left} ;shift tilde will go "back" in explorer save boxes

#IfWinActive

scrollLock::Sendinput ^+{printscreen} ;assigning 'capture region' straight to scrollLock in ShareX does not work, so i have to remap it here.


; ;use scroll lock's status
; ;to toggle a macro keyboard
; #If GetKeyState("ScrollLock","T")
; a::msgbox, macro 1
; b::msgbox, macro 2
; c::msgbox, macro 3
; d::msgbox, macro 4
; e::msgbox, macro 5
; f::Sendinput, {alt down}iac{alt up}
; g::Send,{LCtrl down}{NumpadAdd}{LCtrl up}
; h::Send, #b{left}{left}{enter}

; #If




F13::back()

^F1::switchToFirefox()
+^F1::switchToOtherFirefoxWindow()
^+!f::winkill, ahk_exe firefox.exe
^+!p::
winkill, ahk_exe Adobe Premiere Pro.exe
msgbox,,,killed premiere,0.5
return
^F2::switchToExplorer()
!^F2::closeAllExplorers()

^F3::switchToPremiere()

^F4::switchToWord()
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

;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
`::
Send !{up}
Return


;this converts F4 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.
#IfWinActive ahk_exe explorer.exe
F4::
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return

;script to resize name field so the entire field is readable
F7::Send,{LCtrl down}{NumpadAdd}{LCtrl up}








;;; these  things below will turn an explorer window into one with this address, unless it is already open - in which case, we switch over to it.
;;; each one is triggered by a pre-programmed techkeys keyboard, so that each is actually just one keystroke to engage.
#IfWinActive
; ^!+1::runexplorer("Z:\Linus\1. Linus Tech Tips\Pending")
^!numpadEnd::
StringToSend = runexplorer() 2nd-keyboard
Send_WM_COPYDATA(StringToSend)
runexplorer("C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard") 

Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field

return
^!numpaddown::
;msgbox, wtf
StringToSend = runexplorer() Project template
Send_WM_COPYDATA(StringToSend)
runexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
return

;!+3::runexplorer("C:\Users\TaranWORK\Videos\Desktop") ;this is labeled "shadowplay."
;^!+numpad3::
^!numpadpgdn::
StringToSend = runexplorer() shadowplay recordings
Send_WM_COPYDATA(StringToSend)
runexplorer("C:\Users\TaranWORK\Videos\Desktop")
sleep 5
;send {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...
return
;C:\Users\TaranWORK\Videos\Base Profile ;for some reason, the recordings sometimes go into this folder now.
;;; done ;;;;


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
return
;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
;http://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg

Joy1::msgbox you hit Joy1
Joy2::msgbox you hit Joy2
Joy3::msgbox you hit Joy3


Media_Next::
msgbox hiiiee. testing stuff.
return



;experimental functions...

; F8::WheelDown

; F9::WheelUp


/*
;so apparently AHK can listen for joystick buttons and axes, but canot CREATE those events itself. that makes me sad. I may need to use http://vjoystick.sourceforge.net/site/
Joy2::msgbox, you pressed joy 2

#IfWinActive ahk_exe notepad++.exe ;logitech gaming software
; #IfWinActive ahk_exe LCore.exe ;logitech gaming software

F1::
tooltip, sending
sleep 555
send {F20}
tooltip,
return

F2::
tooltip, sending
sleep 555
send {SC0E7} ;possibly unassigned scancode. IDK
tooltip,
return

f3::send {joy3}
f4::send joy4
f5::send joy5
f6::send joy6
f7::send joy7
f8::send joy8
f9::send joy9
*/
#ifwinactive
