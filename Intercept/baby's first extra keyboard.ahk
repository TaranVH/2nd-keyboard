#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

#if (getKeyState("F12", "P"))
F12::return


q::msgbox, you pressed Q on the extra keyboard
w::msgbox, you pressed %A_thishotkey% on the extra keyboard
e::tooltip, you pressed %A_thishotkey% on the extra keyboard
r::SoundBeep, 1000, 500

#if