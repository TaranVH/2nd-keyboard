; KeypressOSD.ahk - not programmed by Taran heavily modified by Victor Uribe
;THIS IS A SIMPLER ALTERNATIVE TO KEYSTROKE VIZ.AHK. THE TWO SHOULD NOT BE USED AT THE SAME TIME.
;This visualizer does not show associated commands.

#SingleInstance force
#NoEnv
SetBatchLines, -1
ListLines, Off
CoordMode, Mouse, Screen

; Settings
maxOnScreenChars := 60 ; Maximum number of characters that will be displayed
fontCharWidth := 27    ; Depends on resolution needs to be changed if 
textFont = Consolas     ; NOT WORKING Make sure to set fontCharWidth correclty and only use monospace fonts
bgColor = Black        ; background color of the gui
spaceStr := " "     ; This is the string that will appear when pressing the space key
counterPrefix := " x"

transN        := 100    ; 0=transparent, 255=opaque
ShowSingleKey := True  ; dislay A-Z, Enter and other keys pressed without modifier (Ctr, Alt, ...)
DisplayTime   := 500  ; time to fade, in milliseconds
DisplayTime2  := 2500

; Create GUI
Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
Gui, Margin, 0, 0
Gui, Color, bgColor
Gui, Font, cWhite s30 bold, Consolas
Gui, Add, Text, vHotkeyText Left x2
WinSet, Transparent, %transN%
Winset, AlwaysOnTop, On
SetTimer, ShowHotkey, 1

; Create hotkey

;get //
Loop, 95
    Hotkey, % "~*" Chr(A_Index + 31), Display
Loop, 24 ; F1-F24
    Hotkey, % "~*F" A_Index, Display
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1, Display

Otherkeys := "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep|LButton|RButton|MButton|XButton1|XButton2|WheelDown|WheelUp|WheelLeft|WheelRight"

Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField, Display
return

Count(H, N) {
	Pos := 0, Count := 0
	Loop
		If (Pos := InStr(H, N, False, Pos + 1))
			Count++
		else
			break
	return Count
}

CountInString( ByRef Haystack , Needle = "" ,pVal=0) {
  StringReplace, Haystack, Haystack, %Needle%, %Needle%, UseErrorLevel
  Return ErrorLevel+pVal
}

; Display
;
PreviousKeys := ""
counter=1
lastKeyPress := ""

Display:
	actualkey := SubStr(A_ThisHotkey, 3)
	
	if (StrLen(PreviousKeys) > maxOnScreenChars){
		PreviousKeys := " " prefix lastKeyPress
		counter=1
	}
	
    If (A_ThisHotkey = "")
        Return
		
	;declare modifiers
    mods := "Ctrl|Shift|Alt|LWin|RWin"
    
	;declare prefix for mod keys
	prefix := ""
    
	;parse for modifier keys
	Loop, Parse, mods, |
        if GetKeyState(A_LoopField){
            prefix .= A_LoopField "+"
		}
    if (!prefix && !ShowSingleKey)
        return
	
	;check for special keys and mouse buttons (tab, space, medai etc)
	oKey := InStr(Otherkeys, actualkey)
	
	if ((StrLen(prefix)> 0 or oKey > 0 and StrLen(actualkey) > 1) and prefix <> "Shift+"){	
		if (lastKeyPress = actualkey){
			if (counter > 1){
				StringTrimRight, PreviousKeys, key, 4
			}				
			counter+=1
			if (StrLen(prefix) > 0){
				key := PreviousKeys counterPrefix counter " "
			}
			else {
				key := PreviousKeys prefix counterPrefix counter " "
			}
			key := StrReplace(key,"  "," ")
		}
		else{
			counter = 1
			key := PreviousKeys " " prefix actualkey " " 
			key := StrReplace(key,"  "," ")
		}
	}
	else{
		; replace spaces with spaceStr from settings
		hotk := StrReplace(actualkey," ",spaceStr)
		;actual key to display
		key := PreviousKeys prefix hotk
    }
    
	if (prefix = "Shift+")
		key := PreviousKeys actualkey
		
    ;looping with modifiers
	PreviousKeys := key
	lastKeyPress := actualkey
	key := StrReplace(key,"Numpad","")
	key := StrReplace(key,"&","&&")

	LastHotkeyPressedTime := A_TickCount
Return

; Show Gui element with the hotkeys, move with mouse and fade into transparency
ShowHotkey:
    prev_X := -999
    prev_Y := -999
    prev_LastHotkeyPressedTime := "999"
    Gui, +LastFound
    Loop {
        Elapsed := A_TickCount - LastHotkeyPressedTime
        Faded := 1 - Elapsed/DisplayTime
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime) {
            WinSet, Transparent, % transN
        } else if (Faded > 0.1) {
            WinSet, Transparent, % transN * 1
        }
        MouseGetPos, X, Y
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime or (((abs(prev_X - X) > 1 or abs(prev_Y - Y) > 1) or Faded < 0) and PreviousKeys != "")) {
            text_w := StrLen(key) * fontCharWidth + 7
            
			if (Faded < 0.1) {
                adjusted_X := 20
                adjusted_Y := A_ScreenHeight - 100
                WinSet, Transparent, % 50
                PreviousKeys := ""
				lastKeyPress := ""
				counter := 1
            } else {
                adjusted_X := 20
                adjusted_Y := A_ScreenHeight - 100
            }
			
            GuiControl,, HotkeyText, %key%
            GuiControl, Move, HotkeyText, +AlwaysOnTop w%text_w%
            WinSet, Region, 0-0 W%text_w% H60 R10-10
            Gui, Show, NoActivate x%adjusted_X% y%adjusted_Y% w%text_w%
            prev_X := X
            prev_Y := Y
            prev_LastHotkeyPressedTime := LastHotkeyPressedTime
			SetTimer, HideGUI, % -1 * DisplayTime2
        }
        Sleep, 20
    }
Return

HideGUI() {
	Gui, Hide
}
