#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; now the script directory is in the variable %A_WorkingDir%

; https://www.autohotkey.com/docs/commands/SetKeyDelay.htm
SetKeyDelay, -1 ;INSTANT

;;;OKAY so it works but it's kinda slow because it requires 8 actual .txt files. i hope there is a better way? probably a persistant script that stays in RAM. anyway, I'm done for today.

;;SO THE POINT OF THE PASTE .AHK SCRIPTS IS THAT THEY ARE ALL EXACTLY THE SAME EXCEPT FOR THE FILENAMES. THAT MEANS I CAN CHANGE ONLY THIS SCRIPT AND THEN ALL OF THEM WILL CHANGE. CLEVER HUH?


multiClipboardCopy(target)
{ 

ClipSaved := ClipboardAll ;Save the clipboard
Clipboard = ;Empty the clipboard
SendInput, ^c
ClipWait, 1
if ErrorLevel
	{
	;; MsgBox % "Failed attempt to copy text to clipboard."
	MsgBox,,,"Failed attempt to copy text to clipboard.",0.7
	return
	}
NewClipboard := Trim(Clipboard)
; StringReplace, NewClipboard, NewClipBoard, `r`n, `n, All ;comment this in to remove whitespace automaticaly
Clipboard := ClipSaved ;Restore the clipboard
ClipSaved = ;Free the memory in case the clipboard was very large.

file := FileOpen(target, "w")
file.write(NewClipboard)
file.close()

return NewClipboard
	}
	SetKeyDelay, -1 ;INSTANT
	multiClipboardPaste(target)
	; i have absolutely no clue where or how the multiClipboardPaste() function is defined. I can't find it. This makes no sense... and I wrote the damn thing!!
	{

;msgbox, target is %target%
;;contentsClipboard := "hello test"
;target will be an exact folder with filename
file := FileOpen(target, "r")
contentsClipboard := file.read()

file.close()

;i can do this HERE, or i can do it in the script that called this one. I'm gonna do it here.

;SendInput {Raw}%contentsClipboard%
SendInput %contentsClipboard%

;I don't know if I need {RAW} or not...

;msgbox, contentsClipboard is %contentsClipboard%

return contentsClipboard
}






/*
SetWorkingDir %A_ScriptDir%\clipboards  ; Ensures a consistent starting directory.

; now the script directory is in the variable %A_WorkingDir%
msgbox, A_WorkingDir is %A_WorkingDir%






ClipBoard_1 := GetFromClipboard()

GetFromClipboard()
{ 
  ClipSaved := ClipboardAll ;Save the clipboard
  Clipboard = ;Empty the clipboard
  SendInput, ^c
  ClipWait, 2
  if ErrorLevel
  {
    ;; MsgBox % "Failed attempt to copy text to clipboard."
    MsgBox,,,"Failed attempt to copy text to clipboard.",0.7
    return
  }
  NewClipboard := Trim(Clipboard)
  ; StringReplace, NewClipboard, NewClipBoard, `r`n, `n, All ;comment this in to remove whitespace automaticaly
  Clipboard := ClipSaved ;Restore the clipboard
  ClipSaved = ;Free the memory in case the clipboard was very large.
  return NewClipboard
}

;to paste it
SC16D::SendInput {Raw}%ClipBoard_1%	


*/
