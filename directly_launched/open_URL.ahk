StringToSend = openlatestFLAT(1, .url)
Send_WM_COPYDATA(StringToSend)
openlatestFLAT(1, .url)
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk


; openlatestFLAT(directory, filetype)
; {
; if directory = 1
	; {
	; FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; ;msgbox, current directory is`n%directory%
	; directory = %SavedExplorerAddress%
	; ;msgbox, new directory is`n%directory%
	; }
; ;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
; StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.

; ;Keyshower(directory,"openlatestfile")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(directory,"openlatestfile") 
; }

; ;I need some method of excluding ~$ files, since those clutter everything up (MS Word .docx ...)

; ;msgbox, directory is %directory%`n and filetype is %filetype%
; Loop, Files,%directory%\*%filetype%, F
; {

; If (A_LoopFileTimeModified>Rec)
  ; {
  ; IfNotInString, A_LoopFileFullPath, ~$
	; FPath=%A_LoopFileFullPath%
  ; Rec=%A_LoopFileTimeModified%
  ; }
; }

; Run %Fpath%


; ; ; USING THE SCRIPT
; ; !n::
; ; examplePath = "Z:\Linus\6. Channel Super Fun\Flicking football"
; ; openlatestfile(examplePath, ".prproj") ;<--- notice how i INCLUDE the period in the parameters. IDK if it might be better to add the period later.
; ; return
; }
; ; end of openlatestFLAT()
