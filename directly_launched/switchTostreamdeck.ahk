StringToSend = open Stream Deck app
Send_WM_COPYDATA(StringToSend)
;result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
;windowSwitcher(theClass, theEXE)
;windowSwitcher(ahk_class Qt5QWindowIcon, StreamDeck.exe)
windowSwitcher("ahk_exe StreamDeck.exe","C:\Program Files\Elgato\StreamDeck\StreamDeck.exe")


Exitapp


SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk

;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
;StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.