#SingleInstance force 
;msgbox, this is the original place I tested the Send_WM_COPYDATA function.

;StringToSend = Word direct launch
;result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)


; Process, Exist, WINWORD.EXE
; If errorLevel = 0
	; Run, WINWORD.EXE
; WinActivate ahk_class OpusApp
	

openApp(theClass, theEXE, theTitle := ""){

IfWinNotExist, %theClass%
	Run, % theEXE
if not WinActive(theClass)
	{
	WinActivate %theClass%
	;WinGetTitle, Title, A
	WinRestore %theTitle%
	}
}

openApp("ahk_class Notepad++", "notepad++.exe")

Exitapp


;SetWorkingDir %A_ScriptDir%
;#Include %A_ScriptDir%/REDIRECTOR Windows.ahk

;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
;StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.