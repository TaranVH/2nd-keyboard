#NoEnv
SendMode Input
#SingleInstance force

; THIS SCRIPT HAS BEEN CLEANED UP AND WILL NOW BE MERGED WITH:
; ALL MUTIPLE KEYBOARD ASSIGNMENS.AHK

SetNumLockState, on ;you won't be able to cahnge the state of numlock when this is used. I think I need admin for this though.
SetScrollLockState, off


; Menu, Tray, Icon, shell32.dll, 16 
;when you get to #include, it means the END of the autoexecute section. So that stuff must go before this line.
#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Almost All Windows Functions.ahk

#MaxHotkeysPerInterval 2000
;Menu, Tray, Icon, shell32.dll, 16 ;for wind key assignemnts



;;;~~~~~~~~~~~~~~~~~~FUNCTION KEYS IN VARIOUS PROGRAMS~~~~~~~~~~~~~~~~~~~~

#IfWinActive ahk_class MozillaWindowClass ;or ahk_class Chrome_WidgetWin_1
!F1::send ^+{pgup}
!F2::send ^+{pgdn}
; F2 & f20::send ^+{pgdn}
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

#IfWinActive ahk_exe notepad++.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 

#IfWinActive ahk_exe Photoshop.exe
F1::send ^+{tab} ;control shift tab, which goes to the next tab
F2::send ^{tab} ;control tab, which goes to the previous tab
F3::send ^w 

;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


; ;RIP Monty Oum https://youtu.be/qSuTnCFqMkw?t=1m21s
; #IfWinActive ahk_exe Photoshop.exe
; F1::sendinput {alt down}iac{alt up}


#IfWinActive, ahk_group ExplorerGroup
; ctrl L, alt D, or F4 will highlight the address bar. But in different ways..?
;IDK if I need this script at all anymore.
^+!d::
sleep 10
Sendinput !d
sleep 10
return


#IfWinActive, ahk_class CabinetWClass
`::Send !{up} ;This allows you to use the TILDE to go DOWN one folder level in explorer save boxes
+`::Send !{left} ;shift tilde will go "back" in explorer save boxes


#IfWinActive ahk_exe explorer.exe ;IDK if there is any meaningful difference for using the ahk_exe rather than the ahk_CLASS

F4::
;this converts F4 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return

`::Send !{up} ;This optional script allows you to use the TILDE to go DOWN one folder level in explorer

F7::Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;script to resize name field so the entire field is readable


#IfWinActive

;;shortcut to CLOSE FIREFOX with no bullshit or fanfare or annoying dialouge boxes that try to argue with you. Just completely nuke it from orbit so we can start over
^!+f::Run, %comspec% /c "taskkill.exe /F /IM firefox.exe",, hide


;shortcut to forcefully CLOSE PREMIERE, WITH NO BULLSHIT. BULLDOZE IT FLAT, BURN IT, SALT THE EATH, NUKE IT FROM ORBIT. JUST FUCKING DIE!!!
^!+p::
Run, %comspec% /c "taskkill.exe /IM /Adobe Premiere Pro.exe /T /F" ;,, hide
sleep 100
;Run, %comspec% /c "taskkill.exe /F /PID 72536",, hide
tooltip, killed premiere
sleep 100
tooltip,
return


#IfWinActive

F13::back()

^F1::switchToFirefox()
+^F1::switchToOtherFirefoxWindow()
^F2::switchToExplorer()
!^F2::closeAllExplorers()

^F3::switchToPremiere()

^F4::switchToWord()
+^F4::switchWordWindow()
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

^F9::windowSwitcher("ahk_exe AfterFX.exe","C:\Program Files\Adobe\Adobe After Effects CC 2017\Support Files\AfterFX.exe") ;NOTE: was used for toggle all video tracks in premiere.
^F10::windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")

; ^F11 is taken by filemover.ahk
; ^F12 is also taken by filemover.ahk
;NOTE: ^F12 (ctrl F12) is forbidden by Premiere, since it opens the Premiere CONSOLE. interesting.









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

;EXAMPLE: https://i.ytimg.com/vi/L-zDtBINvzk/hqdefault.jpg
;http://img.youtube.com/vi/<insert-youtube-video-id-here>/maxresdefault.jpg
return



#IfWinActive
Joy1::msgbox you hit Joy1
Joy2::msgbox you hit Joy2
Joy3::msgbox you hit Joy3

Media_Next::
msgbox hiiiee. testing stuff.
return



#ifwinactive



;damn it, i still can't find ANY script that works to reload a script when you save it....

; GroupAdd, ThisScript, %A_ScriptName%        ; Add any window containing this script's name to the group ThisScript
; ;;;https://www.reddit.com/r/AutoHotkey/comments/39gjam/what_are_your_favorite_ahk_tricks/
; ; ---------------------------------
; ; Auto-reload on save
; ; ---------------------------------
; ; Reloads script if active window is the script editor
; ; Reloads on Ctrl-S in the editor window


; WinGetTitle, Title, A
; MsgBox, The active window is "%Title%".
; MsgBox, The group is %ThisScript%
; MsgBox, The name is %A_ScriptName%

; #IfWinActive ahk_group ThisScript  ; Only run if met. ; Otherwise, ignore hotkey
; #IfWinActive A_ScriptName  ; Only run if met. ; Otherwise, ignore hotkey
; ~^s::
	; msgbox,,, reloading meoww. ,0.3
    ; TrayTip, Reloading updated script, %A_ScriptName%
    ; ;SetTimer, RemoveTrayTip, 2000
    ; ;Sleep, 2000
	; sleep 100
    ; Reload
; return


;------------------------------------

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