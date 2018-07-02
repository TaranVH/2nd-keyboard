; NOTE THIS ONLY WORKS WITH AutoHotkey v1.1.26.00 and below

;KeypressOSD.ahk
;Author - Victor Uribe
;This script shows all keypresses on the main screen.
;THIS IS A SIMPLER ALTERNATIVE TO KEYSTROKE VIZ.AHK. THE TWO SHOULD NOT BE USED AT THE SAME TIME.
;This visualizer does not show associated commands.
;Toggle this script using the Pause key.

#SingleInstance force
#NoEnv
SetBatchLines, -1
ListLines, Off

; Settings
	;gui
		guiHeight := 60         ; Changes the height of the text window (max is 500)
		maxOnScreenChars := 60  ; Maximum number of characters that will be displayed
		bgColor = Black         ; background color of the gui, use hexadecimal values (884488) or 'simple' colors defined in AHK
		fontColor = White       ; changes the font color
		guiX = 20               ; the horizontal position of the gui screen px from the left = 0
		guiY = 120              ; the vertical position of the gui screen px from the bottom

	;font
		fontSize := 30			; Size of the fond in the gui, you may need to adjust the size of the gui also
		fontCharWidth := 27     ; (default 27 width of Consolas)Can depend on Resolution/Scale, needs to be changed most of the time
		font := "Consolas"      ; Consolas is the default, use monospace fonts for best results

	;Settings for the gui string
		bufr := " "                 ; String to add before and after each popup
		cntPrefix := " x"           ; prefix for the counter otherwise it is right next to the previous key
		modSpaceKey := "SPACE!"          ; This is the string that will appear when pressing the space key for example '<space>' vs ' '
		modSeperator := "+"         ; This is the string that will be shown to seperate modifiers from single keys
		modKeySeperator := " "      ; This is the seperator between keypresses, will not show between letters
		modNumPrefix := ""          ; This is the prefix to the keys pressed on the numpad (ex: "Numpad+" will display "Numpad+1")
		modShift := "Shift+"              ; This is the prefix for any keys modified with the shift key
		shiftmodSeperator := ""     ; allows you do choose whether you want a space/symbol or nothing bewteen a 'Shifted' key and the next key
		onlyCaps := false             ; Only show UpperCase letters regardless of the Caps Lock or Shift state
		
	;timers
		transN        := 200    ; 0=transparent, 255=opaque
		DisplayTime   := 1000   ; time before fade, in milliseconds
		DisplayTime2  := 3000   ; time before hiding gui

	;functionality
		#MaxHotkeysPerInterval 200              ; This value will set how many hotkeys are allowed to be pressed per 2000 milliseconds; autohotkey default=71
		startCounterAt := 2                     ; Only display counter if key is pressed more than this many times (default;1)
		mods := "Ctrl|Shift|Alt|LWin|RWin"	; Declare modifiers, any key can be a modifier
		showMouseBtnPress := True				;if set to true will show mouse key presses, if false will only show keyboard presses
		showWheelMovement := False             ;if set to true will show the mouse wheel movements
		
;=====================================================================================================================		
;internal vars (do not change anything below this line)
PreviousKeys := ""							; Used to keep track of all keys pressed in this popup
counter = 1									; Used to count the number of times each key is pressed in succession
lastKeyPress := ""							; Used to determine if the last key pressed is the same as the current key (increments counter)

; Create GUI
Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
Gui, Margin, 0, 0
Gui, Color, %bgColor%
Gui, Font, cWhite s%fontSize% bold, %font%
Gui, Add, Text, vHotkeyText Left
WinSet, Transparent, %transN%
Winset, AlwaysOnTop, On
SetTimer, ShowHotkey, 1

; Create hotkeys
Loop, 95 ; letters and symbols
    Hotkey, % "~*" Chr(A_Index + 31), Display
Loop, 24 ; F1 - 
    Hotkey, % "~*F" A_Index, Display
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1, Display

; Create hotkeys for other keyboard buttons
Otherkeys :=  "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|Backspace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep"  ;|Pause

Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField, Display

mouseBtns := "LButton|RButton|MButton|XButton1|XButton2"
mouseWheel := "WheelDown|WheelUp|WheelLeft|WheelRight"

If (showMouseBtnPress){
	Loop, parse, mouseBtns, |
  	Hotkey, % "~*" A_LoopField, Display
}

If (showWheelMovement){
	Loop, parse, mouseWheel, |
  	Hotkey, % "~*" A_LoopField, Display
}
	
;declare special symbols
sym := "!|@|#|$|%|^|&|*|(|)|_|+|<|>|?|:|""|{|}|`|"

Pause::Suspend
Pause,,1
   
return

; Display
Display:	
	actualkey := SubStr(A_ThisHotkey, 3)

	if (StrLen(PreviousKeys) > maxOnScreenChars){
		PreviousKeys := lastKeyPress
		counter = 1
	}
    
	;declare/clear prefix for mod keys
	prefix := ""
	
	;parse for modifier keys 
	Loop, Parse, mods, |
        if GetKeyState(A_LoopField){
			if (A_LoopField = "Shift"){
				prefix .= modShift shiftmodSeperator
			}else{
				prefix .= A_LoopField modSeperator
			}
		}
		
	;parse for symbols keys 
	Loop, Parse, sym, |
        if (actualkey = A_LoopField and GetKeyState("Shift")){
			prefix := ""
		}
    
		
	actualkey := StrReplace(actualkey, "Numpad", modNumPrefix)
	actualkey := StrReplace(actualkey, "&", "&&")                      ;necessary for proper use of '&', limitation of autohotkey gui title bars

	if (lastKeyPress = prefix actualkey and (StrLen(actualkey)>1)){   ; or StrLen(actualkey)>1 for counting backspace and enter ;; StrLen(prefix)>1 or 
		counter += 1
		dprefix := ""
		keyDown := ""
	}else{
		if (prefix = "" and StrLen(actualkey) = 1 and StrLen(lastKeyPress)=1 or PreviousKeys = ""){
			dprefix := prefix
		}else{
			dprefix := modKeySeperator prefix
		}
		
		if (StrLen(actualkey)=1){
			if (onlyCaps or ((GetKeyState("CapsLock","T") and GetKeyState("Shift") <> True) or (GetKeyState("Shift") AND GetKeyState("CapsLock","T") <> True))){
				StringUpper, keyDown, actualkey
			}else{
				StringLower, keyDown, actualkey
			}
		}else{
			keyDown := actualkey
		}		
		counter = 1
	}
	
	if !(keyDown = "Backspace"){
		keyDown := StrReplace(keyDown, "space", modSpaceKey)
	}
	
	if (counter < startCounterAt){
		dcntPrefix := ""
		dcounter := ""
	}else{
		dcntPrefix := cntPrefix
		dcounter := counter
	}
	
	key := bufr PreviousKeys dprefix keyDown dcntPrefix dcounter bufr
	key := StrReplace(key, "   ", " ")
	
	lastKeyPress := prefix actualkey
	PreviousKeys := PreviousKeys dprefix keyDown
	
	LastHotkeyPressedTime := A_TickCount
return

; Show Gui element with the hotkeys, and fade into transparency
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
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime or (((abs(prev_X - X) > 1 or abs(prev_Y - Y) > 1) or Faded < 0) and PreviousKeys != "")) {
            text_w := StrLen(key) * fontCharWidth + 7
            
			if (Faded < 0.1) {
                adjusted_X := guiX
                adjusted_Y := A_ScreenHeight - guiY
                WinSet, Transparent, % 50
                PreviousKeys := ""
				lastKeyPress := ""
				counter := 1
            } else {
                adjusted_X := guiX
                adjusted_Y := A_ScreenHeight - guiY
            }

            GuiControl,, HotkeyText, %key%
            GuiControl, Move, HotkeyText, +Topmost w%text_w%
            WinSet, Region, 0-0 W%text_w% h%guiHeight% R20-20
            Gui, Show, NoActivate x%adjusted_X% y%adjusted_Y% w%text_w% h500
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