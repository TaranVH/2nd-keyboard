#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Gui, +LastFound

Menu, Tray, Icon , midi.ico

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

#include Midi.ahk

midi := new Midi()
midi.OpenMidiIn(0)
Return

MidiControlChange31: 						;Temparature
	ChangeLumetriScale(3, midi.MidiIn().Value, -100, 100, -5)
	Sleep, 10
Return

MidiControlChange41:						;Temperature Reset
	ChangeLumetriValue(290,0)
Return

MidiControlChange32: 						;Tint
	ChangeLumetriScale(4, midi.MidiIn().Value, -100, 100, -3.9)
	Sleep, 10
Return

MidiControlChange42:						;Tint Reset
	ChangeLumetriValue(315,0)
Return

MidiControlChange33: 						;Exposure
	ChangeLumetriScale(5, midi.MidiIn().Value, -5, 5, -0.3)
	Sleep, 10
Return

MidiControlChange43:						;Exposure Reset
	ChangeLumetriValue(370,0)
Return

MidiControlChange34: 						;Highlights
	ChangeLumetriScale(7, midi.MidiIn().Value, -100, 100, -5.5)
	Sleep, 10
Return

MidiControlChange44:						;Highlights Reset
	ChangeLumetriValue(425, 0)
Return

MidiControlChange35: 						;Shadows
	ChangeLumetriScale(450, midi.MidiIn().Value, -100, 100, -5.5)
	Sleep, 10
Return

MidiControlChange45:						;Shadows Reset
	ChangeLumetriValue(450,0)
Return

MidiControlChange36: 						;Whites
	ChangeLumetriScale(475, midi.MidiIn().Value, -100, 100, -5.5)
	Sleep, 10
Return

MidiControlChange46:						;Whites Reset
	ChangeLumetriValue(475,0)
Return

MidiControlChange37: 						;Blacks
	ChangeLumetriScale(500, midi.MidiIn().Value, -100, 100, -5.5)
	Sleep, 10
Return

MidiControlChange47:						;Blacks Reset
	ChangeLumetriValue(500,0)
Return

MidiControlChange38: 						;Saturation
	ChangeLumetriScale(580, midi.MidiIn().Value, 0, 200, -5.5)
	Sleep, 10
Return

MidiControlChange48:						;Saturation Reset
	ChangeLumetriValue(580,100)
Return

MidiControlChange5:						;Sharpness
	ChangeLumetriScale(584836722, midi.MidiIn().Value, -100, 100, -5.5)
	Sleep, 10
Return

bypass := 0
MidiControlChange61:						;Bypass
	if(bypass = 0){
		Send ^+!F9
		Send ^+!{B down}
		bypass = 1
	} else {
		bypass = 0
		Send ^+!F9
		Send ^+!{B up}
	}
Return

;----------------------------- CLIP POS -----------------------------------

MidiControlChange1:							;X position
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab}
			Sleep, 10
			
			Send % Map(midi.MidiIn().Value, 0, 127, -960, 2880)
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

prevXFine := 0

MidiControlChange11:							;X position Fine-tune
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^!+{F10}
			Sleep, 10
			Send ^!+{F5}
			Send {Tab}
			
			ControlGetText, text, Edit1
			text := StrReplace(text, ",", ".")
			Send % text + Map(midi.MidiIn().Value,0,127,-20,20) - prevXFine
			Sleep, 20
			
			Send {Enter}
			MouseMove, %x1%, %y1%, 0

			prevXFine := Map(midi.MidiIn().Value,0,127,-20,20)
		}
	}
Return

MidiControlChange51:							;X position Reset
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab}
			Sleep, 10
			
			Send 960
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange2:							;Y position
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 2}
			Sleep, 10
			
			Send % Map(midi.MidiIn().Value, 0, 127, -540, 1620)
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

prevYFine := 0

MidiControlChange12:							;Y position Fine-tune
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^!+{F10}
			Sleep, 10
			Send ^!+{F5}
			Send {Tab 2}
			
			Sleep 20
			
			ControlGetText, text, Edit1
			text := StrReplace(text, ",", ".")
			Sleep 5
			Send % text + Map(midi.MidiIn().Value,0,127,-20,20) - prevYFine
			Sleep, 20
			
			Send {Enter}
			MouseMove, %x1%, %y1%, 0

			prevYFine := Map(midi.MidiIn().Value,0,127,-20,20)
		}
	}
Return


MidiControlChange52:							;Y position Reset
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 2}
			Sleep, 10
			
			Send 540
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange4:							;Scale
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 3}
			Sleep, 10
			
			Send % Map(midi.MidiIn().Value, 0, 127, 0, 350)
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange54:							;Scale Reset
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 3}
			Sleep, 10
			
			Send 100
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange3:							;Rotation
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 5}
			Sleep, 10
			
			Send % Map(midi.MidiIn().Value, 0, 127, -190, 190)
			
			Sleep, 5
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

rotationFine := 0

MidiControlChange13:							;Rotation Fine-tune
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^!+{F10}
			Sleep, 10
			Send ^!+{F5}
			Send {Tab 5}
			
			Sleep 90
			
			ControlGetText, text, Edit1
			text := StrReplace(text, ",", ".")
			Sleep 20
			Send % text + Map(midi.MidiIn().Value,0,127,-20,20) - rotationFine
			Sleep, 5
			
			Send {Enter}
			MouseMove, %x1%, %y1%, 0

			rotationFine := Map(midi.MidiIn().Value,0,127,-20,20)
		}
	}
Return


MidiControlChange53:							;Rotation Reset
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send {Tab 5}
			Sleep, 10
			
			Send 0
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange14:							;Opacity
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send +{Tab 3}
			Sleep, 10
			
			Send % Map(midi.MidiIn().Value, 0, 127, 0, 105)
			
			Sleep, 5
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

MidiControlChange55:							;Opacity Reset
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseGetPos, x1, y1
		PixelGetColor, color, 690, 1050
		if(color == 0x1D1D1D) {
			MouseClick, L, 690, 1050, 1, 0
		}
		PixelGetColor, kolor, 500, 1050
		if not(kolor == 0x232323){
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F5}
			Send +{Tab 3}
			Sleep, 10
			
			Send 100
			
			Sleep, 20
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}
Return

;----------------------------- Audio --------------------------------------

MidiControlChange6:
	ChangeAudioTrackVolume(midi.MidiIn().value, 1)
	Sleep 10
Return

MidiControlChange7:
	ChangeAudioTrackVolume(midi.MidiIn().value, 2)
	Sleep 10
Return

MidiControlChange8:
	ChangeAudioTrackVolume(midi.MidiIn().value, 3)
	Sleep 10
Return

;----------------------------- Functions ----------------------------------
global huvavavax1 = 0
global huvavavay1 = 0
global prevTime := %A_Now% + 20
global prevTrack = 1
ChangeAudioTrackVolume(volue, track){
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		SetTimer, EEEndung, Delete
			;MsgBox, %A_Now% = %prevTime%
		if(prevTime = "" OR (%A_Now% - prevTime) > 1000 or not prevTrack == track){
			Blockinput, MouseMove
			MouseGetPos, huvavavax1, huvavavay1
			PixelGetColor, culor, 3645, 813
			if(culor == 0x1D1D1D) {
				MouseClick, L, 3645, 813, 1, 0
				;MsgBox, 1
			}
			PixelGetColor, culor, 3190, 822
			if(kulor == 0x1D1D1D) {
				MouseClick, L, 3190, 822, 1, 0
				;MsgBox, 2
			}
			PixelGetColor, kolor, 3220 + (track-1) * 96, 800
			if not(kolor == 0x212121){
				Send ^+!{F10}
				Sleep 5
				Send ^!+{F6}
				Sleep 5
				MouseMove, 3200 + (track-1) * 96, 787, 0
				Sleep 7
			}
		}
		MouseClick, L
		Sleep, 5
		Send % MapLog(volue)	
		Sleep, 5
		
		Send ^+!{F4}
		SetTimer, EEEndung, On, 1000
		prevTime = %A_Now%
		prevTrack = track
	}
}

EEEndung:
	SetTimer, EEEndung, Delete
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
		MouseMove, %huvavavax1%, %huvavavay1%, 0
		Blockinput, MouseMoveOff
		prevTime = 
		;MsgBox, y
	}
return

ChangeLumetriScale(yLometraka, valu, lim1, lim2, ofset){
	if(yLometraka == 584836722){ ; Sharpnes
		If WinActive("ahk_exe Adobe Premiere Pro.exe"){
			MouseGetPos, x1, y1
			CoordMode, pixel
			
			ImageSearch, 😄, ☺️, 2156, 178, 2226, 206, C:\Users\matya\Desktop\PremiereAHK\LumetriCreative.png ; if the "Creative"  is open - don't mind the emoji varieble names.. :-)
			if (ErrorLevel == 0) {
				goto WhateverPoint ; skip opening it...
				Sleep, 10
			}
			
			ImageSearch, 😄, ☺️, 2260, 252, 2288, 281, C:\Users\matya\Desktop\PremiereAHK\kapatko.png ; if the "basic correction"  is not open - don't mind the emoji varieble names.. :-)
			if ErrorLevel {
				MouseClick, L, 2200, 150, 1, 0 ; open the basic correction (MouseClick, button, x, y, count, speed)
				Sleep, 20
			}
			
			MouseClick, L, 2200, 615, 1, 0 ; open the creative tab (MouseClick, button, x, y, count, speed)
			
			WhateverPoint:
			
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F9}
			Send {Tab 4}
			Sleep 20
			
			Send % Map(valu, 0, 127, lim1, lim2) - ofset
			
			Sleep, 5
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
		
		goto Ebudung
	}
	
	if(yLometraka < 426){ ; it it doesn't make sense to use tabs but it is better to use mouse
		If WinActive("ahk_exe Adobe Premiere Pro.exe"){
			MouseGetPos, x1, y1
			CoordMode, pixel
			
			ImageSearch, 😄, ☺️, 2260, 252, 2288, 281, C:\Users\matya\Desktop\PremiereAHK\kapatko.png ; if the "basic correction"  is not open - don't mind the emoji varieble names.. :-)
			if ErrorLevel {
				MouseClick, L, 2200, 150, 1, 0 ; open the basic correction (MouseClick, button, x, y, count, speed)
				Sleep, 10
			}
			
			Send ^+!{F10}
			Sleep 10
			Send ^!+{F9}
			Send {Tab %yLometraka%}
			Sleep % yLometraka * 10
			
			Send % Map(valu, 0, 127, lim1, lim2) - ofset
			
			Sleep, 5
			Send {Enter}
			MouseMove, %x1%, %y1%, 0
		}
	}else{
		If WinActive("ahk_exe Adobe Premiere Pro.exe"){
			MouseGetPos, x1Trol, y1Lol
			
			PixelGetColor, opn, 2196, 289
			if(opn !== "0180FD") {
				MouseMove, 2100, 150, 0
				MouseClick, L
			}
			MouseMove, 2506, yLometraka, 0
			MouseClick, L
			Sleep, 10
			Send % Map(valu, 0, 127, lim1, lim2) - ofset
			Sleep, 20
			MouseMove, 47, 0, 0, R
			MouseClick, L
			MouseMove, %x1Trol%, %y1Lol%, 0
			Sleep, 40
		}
	}
	Ebudung:
}

ChangeLumetriValue(yBubla, value){
	If WinActive("ahk_exe Adobe Premiere Pro.exe"){
	MouseGetPos, x1bubla, y1bubla
	PixelGetColor, open, 2196, 289
	if(open !== "0180FD") {
		MouseMove, 2100, 150, 0
		MouseClick, L
	}
	MouseMove, 2506, yBubla, 0
	MouseClick, L
	Sleep, 10
	Send % value
	Sleep, 20
	MouseMove, 47, 0, 0, R
	MouseClick, L
	MouseMove, %x1bubla%, %y1bubla%, 0
	Sleep, 40
	}
}

Map(x, x1, x2, y1, y2){
	percent := (x2 - x1) / 100
	percent := (x - x1) / percent
	result := (y2 - y1) / 100 * percent + y1
	result := floor(result * 100) / 100
	return %result%
}

MapLog(inputi){
	if(inputi <= 64) output := 1.41 * inputi - 100 ; linear function for the lower end (lower sensitivity)
	if(inputi > 64) output := 0.26 * inputi - 26.8 ; linear mapping funcion for the top half values (high sensitivity)
	tooltip, %inputi%
	return %output%
}
