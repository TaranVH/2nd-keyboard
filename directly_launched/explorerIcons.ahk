StringToSend = explorer > icons
Send_WM_COPYDATA(StringToSend)
If (exphWnd := WinActive("ahk_class CabinetWClass"))
	ExplorerViewChange_ICONS(exphWnd)
;derp, i had a Return here, and obviously the next line was never reached...
Exitapp

SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk

; numpad3::sortExplorerByName()

; numpad6::sortExplorerByDate()

; numpad5::
; If (exphWnd := WinActive("ahk_class CabinetWClass"))
	; ExplorerViewChange_ICONS(exphWnd)
; return

; numpad4::
; If (exphWnd := WinActive("ahk_class CabinetWClass"))
	; ExplorerViewChange_Window(exphWnd)
; return