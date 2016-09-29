#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;%A_ScriptDir%\Lib\  ; Local library - requires v1.0.90+.
;%A_MyDocuments%\AutoHotkey\Lib\  ; User library.
;path-to-the-currently-running-AutoHotkey.exe\Lib\  ; Standard library.
;C:\Users\TaranVanHemert\AppData\Local\GitHub\TutorialRepository_a66c3719071da6d865a984bb8d6bfb5bcd775ec8\new-repo\Taran's Windows Mods\WINDOWS MOD - Various functions.ahk\Lib\

Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.




/*
MsgBox, % GetAhkStats("lines")
MsgBox, % GetAhkStats("variables")
MsgBox, % GetAhkStats("hotkeys")
Stat1 := GetAhkStats("history")
MsgBox, %Stat1%
Return

a::a
b::b
c::c
d::d

GetAhkStats(xxSection="", xxUseWindow=99, xxDestroyAfter=1)
{
  xxSectionN = Lines|Variables|Hotkeys|History
  If xxSection=
    xxSection = History
  Loop, Parse, xxSectionN, |
    IfInString, A_LoopField, %xxSection% 
      xxSection = %A_Index%
  DetectHiddenWindows, On
  SetTitleMatchMode, 2
  Gui, %xxUseWindow%:Show, Hide
  xxHidWin := WinExist(A_ScriptFullPath " - AutoHotkey v")
  xxOldpar := DllCall("GetParent", "UInt", xxHidWin)
  DllCall("SetParent", "UInt", xxHidWin, "UInt", (GuiGetHWND("", xxUseWindow)))
  WinMenuSelectItem, ahk_id %xxHidWin%,, View, %xxSection%&
  Loop {
    Sleep, 50
    ControlGetText, xxOut1, Edit1, ahk_id %xxHidWin%
    If xxOut1<>
      break
  }
  WinHide, ahk_id %xxHidWin%
  DllCall("SetParent", "UInt", xxHidWin, "UInt", xxOldpar)
  If (xxDestroyAfter)
    Gui, %xxUseWindow%:Destroy
Return, xxOut1
}

GuiGetHWND(xxClassNN="", xxGUI=1)
{
  If (xxGUI)
    Gui, %xxGUI%:+LastFound
  xxGui_hwnd := WinExist()
  If xxClassNN=
    Return, xxGui_hwnd
  ControlGet, xxOutputVar, Hwnd,, %xxClassNN%, ahk_id %xxGui_hwnd%
Return, xxOutputVar
}

*/






;;;;FILE MOVER TO TRANSCODE FOLDERS

; YTpublish = "Z:\Linus\1. Linus Tech Tips\Transcode\YT Publish 4K\"
; VESpublish = "Z:\Linus\1. Linus Tech Tips\Transcode\Vessel Final 4K\"


Explorer_GetSelection(hwnd="") {
	;msgbox, now in getselection
    hwnd := hwnd ? hwnd : WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
        for window in ComObjCreate("Shell.Application").Windows
            if (window.hwnd==hwnd)
    sel := window.Document.SelectedItems
    for item in sel
    ToReturn .= item.path "`n"
	;msgbox, %ToReturn% is toreturn
    return Trim(ToReturn,"`n")
}

filetomovePATH = 
SlashPosition = 0
file2move = 
filetomovePATH =  
FileListLocations =
Fileposition =
counter = 0
nlines = 0

;BEGIN FUNCTION DEFINITION:
FileMover(publishLOC) {

filetomovePATH := Explorer_GetSelection() ;NOTE: does not work from the desktop for some stupid reason...
;;msgbox, you want to move this file to`n%publishLOC%
tooltip, Filemover Activated, , , 3
;Send, ^c


sleep 10
existingfile = 
SlashPosition = 0
file2move = 
filetomovePATH =  ;if you don't refresh these variables, they will retain data from previous run-throughs.
FileListLocations =
Fileposition =
FileNotPresent = 0
filetomovePATH := Explorer_GetSelection()

;msgbox, the current file path is `n%filetomovePATH%
SlashPosition := InStr(filetomovePATH, "\" ,false,-1,1) ;first occurance from the right to the left, supposedly.
StringTrimLeft,file2move,filetomovePATH, %slashposition%
;;msgbox, file2move = `n%file2move% `n`nfiletomovePATH =`n%filetomovePATH%

;https://www.autohotkey.com/docs/commands/LoopFile.htm the following code does work to list files in a given directory!
FileList =  ; Initialize to be blank.
Loop, Files, %publishLOC%*.*, DFR
    FileList = %FileList%%A_LoopFileName%`n
Loop, Files, %publishLOC%*.*, DFR
    FileListLocations = %FileListLocations%%A_LoopFileFullPath%`n ;A_LoopFileDir -or- A_LoopFileFullPath

;;msgbox, FileListLocations = `n%FileListLocations%
;;msgbox, FileList = `n%FileList%

counter = 0
nlines = 0
;settimer debug2, 20
;msgbox, launching debugger

sleep 20
Loop Parse, FileList, `n
  ++nlines
;;MsgBox, total lines here, or nlines: %nlines%

Loop, parse, FileList, `n
{
	; tooltip, counter = %counter%`nnlines = %nlines%, , , 10
    if A_LoopField =  ; Ignore the blank item at the end of the list.
        continue
	;MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    ;IfMsgBox, No
    ;    break
    If A_LoopField = %file2move%
    {
        Fileposition = %A_Index%
        Loop, parse, FileListLocations, `n
            if A_index = %Fileposition%
                existingfile = %A_LoopField% ;I have to confess, I wrote those 4 lines all at once and i have no idea how they work... they just do.
        ;;msgbox, existingfile = %existingfile%
       
        ;A match has been found in this folder system, meaning the file was ALREADY moved over here before!
        msgbox, 1, ,%A_LoopField%`nis already present at`n%existingfile%`n...Want to see?
        IfMsgBox, OK
        {
            ;Run, explore, % filetomovePATH ;<---this will only go to the folder, but WON'T highlight the file - it will just open it instead, unless you use A_LoopFileDir.
            Run %COMSPEC% /c explorer.exe /select`, "%existingfile%",, Hide
            ;Run %COMSPEC% /c explorer.exe /select`, "%FileListLocations%",, Hide
            ;Msgbox, you win! File SHOULD be there already!
            Goto, theEnd
        }
        IfMsgBox, Cancel
            Goto, theEnd
    }
    ;Msgbox, WHERE AM I
    ; MsgBox, 4,, File number %A_Index% is: `n%A_LoopField%`n`n...continue?
    ; IfMsgBox, No
        ; break
    counter ++
    if counter + 1 = nlines
		{
        ;;msgbox, looked at all files, didn't find the one you are looking for. time to break.
		FileNotPresent = 1
		break
		}
    ;tooltip, count: %counter%, , ,5
}
;;msgbox, end of the loop
if FileNotPresent = 1
{
	msgbox, 1 , ,%filetomovePATH%`nis NOT present at or above `n%publishLOC%`n...would you like to move it there?
	IfMsgBox, OK
	{
		FileCopy,%filetomovePATH%,%publishLOC%
		Run %COMSPEC% /c explorer.exe /select`, "%publishLOC%%file2move%",, Hide
		;;Msgbox, did that work?
		FileNotPresent = 0
	}
}
Goto, theEnd
theEnd:

;SetTimer, tooltipper, off
sleep 10
; tooltip, , , , 9
tooltip, , , , 3
; tooltip,
;;msgbox, you are at the VERY end
}
;end of file mover.
#IfWinActive 



#IfWinActive ahk_exe explorer.exe
^F11::Filemover("Z:\Linus\1. Linus Tech Tips\Transcode\Vessel Final 4K\")
^F12::Filemover("Z:\Linus\1. Linus Tech Tips\Transcode\YT Publish 4K\")
#IfWinActive


;;;;;;;;;;THESE ARE ALL STUPID CRAP AND DONT WORK:;;;;;;;;
tooltipper:
;msgbox, who did this
;tooltip, counter = %counter%`nnlines = %nlines%`nfile2move = %file2move% `n filetomovePATH = %filetomovePATH% `n file2move = %file2move% `n , , , 9
Return
nothin:
;msgbox, nothin here
tooltip, nothin , , , 8
Return
debug2:
tooltip, counter = %counter%`nnlines = %nlines%, , , 10
;tooltip, , , , 10
return
;;;;;;;;;;;;;;;;THOSE DIDNT WORK.;;;;;;;;;;;;;;;













;--------THESE FUNCTIONS are for changing the address of an existing exporer window, into a new, given address --- unless you already have a window with that address open - in which case, it just brings that window to the front. This way, you dont have several exporer windows that are all at the exact same address.
;But I only call this function if you are NOT already in explorer, in which case, it also works this way but with much less code. Lol, hope that makes sense.
;sadly they are sometimes really slow - takes liek a second for it to kick in! I need a faster way to do this.
explorerLaunch(foo)
{
Run, % foo
;I'm commenting this code out for now because it hasn't been working lately...
; if WinActive("ahk_exe explorer.exe")
	; {
	; tooltip, explorer is open already, now doing NAVRUN
	; NavRun(foo)
	; }
; Else
	; {
	; tooltip, else was triggered meaning we are not in explorer)
	; Run, % foo
	; }
; Return
}

;-------The below script origninally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/
; ; Hotkeys 1 & 2
; 1::NavRun("C:\")
; 2::NavRun(A_MyDocuments)
; http://msdn.microsoft.com/en-us/library/bb774094
GetActiveExplorer() {
	tooltip, getactiveexplorer code now
    static objShell := ComObjCreate("Shell.Application")
    WinHWND := WinActive("A")    ; Active window
    for Item in objShell.Windows
        if (Item.HWND = WinHWND)
            return Item        ; Return active window object
    return -1    ; No explorer windows match active window
}

NavRun(Path) {
    if (-1 != objIE := GetActiveExplorer())
        objIE.Navigate(Path)
    else
        Run, % Path
}
;--------The above script origninally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/


#IfWinActive ahk_class Notepad++
;instant save and reload for this script -- and i guess not the other ones...?
F5::
send ^s
sleep 100
Reload
Return
#IfWinActive





;ahk_class Notepad++
; ahk_class Premiere Pro
;ahk_class OpusApp ; MS WORD









;macro key 16 on my logitech G15 keyboard. It will activate firefox,, and if firefox is already activated, it will go to the next window in firefox.
^numpad1::
if WinActive("ahk_class MozillaWindowClass")
	Send ^{tab}
else
	WinActivate ahk_class MozillaWindowClass
Return



; This is a script that will always go to the NEXT Explorer window if you hit the same button again.
; CTRL Numpad2 is pressed with a SINGLE button stoke from my logitech G15 keyboard -- Macro key 17.
#IfWinActive 
^numpad2::
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;activates the most recently used explorer window IN THIS CONTEXT, otherwise you have to use WinActivatebottom
Return

#IfWinActive 
^numpad3::WinActivate ahk_class Premiere Pro


;This is a script that will always go to the Word, or the NEXT Word window if you hit the same button again.
#IfWinActive 
^numpad4::
GroupAdd, taranwords, ahk_class OpusApp
if WinActive("ahk_class OpusApp")
	GroupActivate, taranwords, r
else
	WinActivate ahk_class OpusApp
Return

;apparently CRTL NUM5 is some kind of select all shortcut?

#IfWinActive 
^numpad6::WinActivate ahk_class Notepad++













#IfWinActive

;SNIP MAKER - DOES NOT WORK AT THE MOMENT
Break:: ; this refers to the actual pause/break key on a keyboard
;msgbox, hello
sleep 10
send ^!{insert} ;this was set in windows by right clicking on the icon and selecting proprties, of the SNIPPING tool, to open the snipping tool. Snips are nice because they go into the clipboard.
sleep 300
Send !n
sleep 100
Send r ; this script will create a new snip with a single button press.... that's the idea anyway. it doesn't always launch, IDK why.
return




;The optional script below allows you to use the TILDE to go DOWN one folder level in explorer
#IfWinActive ahk_exe explorer.exe
`::
Send !{up}
Return

;this converts F4 into ALT F4, but only for explorer. this is just to save one more keypress, since i close explorer windows in this way quite a lot.
;There is a deliberate delay added, since in SOME situations, ALT would be recognised, but not F4. Adding a delay takes care of that.
#IfWinActive ahk_exe explorer.exe
F4::
Send {alt down}
sleep 10
Send {F4}
sleep 10
Send {alt up}
Return




;;; these  things below will turn an explorer window into one with this address, unless it is already open - in which case, we switch over to it.
;;; each one is triggered by a pre-programmed techkeys keyboard, so that each is actually just one keystroke to engage.
#IfWinActive
^!+1::explorerLaunch("Z:\Linus\1. Linus Tech Tips\Pending") 
^!+2::explorerLaunch("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
^!+3::explorerLaunch("C:\Users\TaranVanHemert\Videos\SHADOWPLAY CAPTURE\Desktop")
;;; done ;;;;


;next techkeys keyboard here maybe?

; ^!+4::
; msgbox ctrl_alt_shift_4
; return

; !1::
; msgbox alt1
; return


#IfWinActive
;opens the CLOCK / CALENDAR. ;http://superuser.com/questions/290068/windows-keyboard-shortcut-to-view-calendar
#c::
Send #b{left}{enter}
Return


;code to locate an invisible cursor
; F7::
; Loop
; {
; tooltip, cursor, , ,3
; sleep 20
; }
;F7 Up::tooltip, , , ,3
;return