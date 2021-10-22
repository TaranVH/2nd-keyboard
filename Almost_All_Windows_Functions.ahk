; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe" ;BEFORE the #include is apparently the only place these can go.

#include C:\AHK\2nd-keyboard\point_to_gui.ahk

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#WinActivateForce

; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe"

; -------------------------------------------------------------------------
; If this is your first time using AutoHotkey, you must take this tutorial:
; https://autohotkey.com/docs/Tutorial.htm
; -------------------------------------------------------------------------
; Also, please note that some of the code in this script requires that the
; ACC LIBRARY be installed.
; just scroll to the top of this page and follow the instructions.)
;https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114
;alternatively, you can just delete the functions that use it.
; -------------------------------------------------------------------------

Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.




GroupAdd, ExplorerGroup, ahk_class #32770 ;This is for all the Explorer-based "save" and "load" boxes, from any program!


;lololol I have to have tippy(), but i can't redefine an existing function, so I either have to put it in another .ahk script and #include it, or I could go the lazy route and just add a "2" to the end of ALL of them in this file, because I am a such a bad spaghetti coder that I don't even know what that means.
Tippy2(tipsHere, wait:=333)
{
ToolTip, %tipsHere%,,,9
SetTimer, notip2, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
notip2:
ToolTip,,,,9
	;removes the tooltip
return

tooltip, yello

;alt escape does ssomething.

;;;oh heck yes - a case changer.
;;;http://www.computoredge.com/AutoHotkey/Free_AutoHotkey_Scripts_and_Apps_for_Learning_and_Generating_Ideas.html#ChangeCase

;;;aslo i can give myself a ---damn it i forgot it AS i was wriiting it. —a thing to always paste as SIMPLE, unformatted test. YEAH.

;;;clipboard stuff.
;;https://ditto-cp.sourceforge.io/

;;https://cedeq.com/enterpad/en/autohotkey/useful-ahk-scripts/multiple-clipboards
;;https://jacksautohotkeyblog.wordpress.com/2016/06/09/autohotkey-solutions-for-windows-clipboard-limitations-autohotkey-clipboard-tips/






;; I'm seeing some excellent sounding scripts in here which i might wish to take for myself:
;   https://github.com/func-github/AHK-Windows-Enhancement
; oh just kidding, they are in the TO DO section... they don't actually exist...


;this is (was?) my multiple clipboard function.
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


;this is the new way I'm gonna do multiple clipboards:
;  code is from:
;  https://autohotkey.com/board/topic/32265-multiple-clipboards/

; ; Hotkeys
; ^Numpad1::Copy(1)
; ^Numpad4::Paste(1)

Copy(clipboardID)
{
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	
	Clipboard = ; Erase the clipboard first, or else ClipWait does nothing
	Send ^c
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	if ErrorLevel 
	{
		Clipboard := oldClipboard ; Restore old (real) clipboard
		return
	}
	
	ClipboardData%clipboardID% := ClipboardAll
	
	Clipboard := oldClipboard ; Restore old (real) clipboard
}

Cut(clipboardID)
{
	global ; All variables are global by default
	local oldClipboard := ClipboardAll ; Save the (real) clipboard
	
	Clipboard = ; Erase the clipboard first, or else ClipWait does nothing
	Send ^x
	ClipWait, 2, 1 ; Wait 1s until the clipboard contains any kind of data
	if ErrorLevel 
	{
		Clipboard := oldClipboard ; Restore old (real) clipboard
		return
	}
	ClipboardData%clipboardID% := ClipboardAll
	
	Clipboard := oldClipboard ; Restore old (real) clipboard
}

Paste(clipboardID)
{
	global
	local oldClipboard := ClipboardAll ; Save the (real) clipboard

	Clipboard := ClipboardData%clipboardID%
	Send ^v

	Clipboard := oldClipboard ; Restore old (real) clipboard
	oldClipboard = 
}









RemoveDashes()
{ 
  SetKeyDelay, 0
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
  
  NewClipboard := StrReplace(NewClipboard, "-", A_Space)
  NewClipboard := StrReplace(NewClipboard, "_", A_Space)
  
  ;;NewClipboard := SubStr(NewClipboard, 1, -13)
  ; use that if you want to remove the junk at the end. Go from:
  ; hit glass bottle hit bounce solid wood MyGJ8w4u.wav
  ; to
  ; hit glass bottle hit bounce solid wood
  ; and the .wav is automatically put back, fortunately.
  
  ;note to self, add this kinda thing to the AHK dopcumentation
  ; https://www.autohotkey.com/docs/commands/SubStr.htm
  
  ; StringReplace, NewClipboard, NewClipBoard, "-", A_Space, All
  ; StringReplace, NewClipboard, NewClipBoard, "_", A_Space, All
  
  sleep 2
  
  SendInput {Raw}%NewClipboard% ;this does it
  
  Clipboard := ClipSaved ;Restore the clipboard
  ClipSaved = ;Free the memory in case the clipboard was very large.
  
  
  ;return NewClipboard
  return
}




checkFullness()
{
; DriveSpaceFree, OutputVar, Z:\
DriveSpaceFree, OutputVar, \\10.20.0.27\Users
If (OutputVar < 1000000)
	{
	msgbox, Whonnock has only %OutputVar% Megabytes remaining
	
	}

}


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


;=============

;this is where filemover() used to be. I moved it to its own script, since using it would prevent all other scripts from running, until the file was completely moved. lolol.

;=============

;Macro Key G1, probably.
search(){
;sleep 13
keywait, %A_PriorKey% ;waits for the key that called this function to be RELEASED.
; the time to wait is supposed to be 5ms, but WHO KNOWS what iCue might actaully do.
if winactive("ahk_exe Adobe Premiere Pro.exe")
	{
	if IsFunc("effectsPanelType") {
	Func := Func("effectsPanelType")
	RetVal := Func.Call(directory,"")
	;;I'm doing it in this weird way just in case the function is not available -- this means it won't screw anything up.
	}
	;effectsPanelType("") ;set to macro key G1 on my logitech G15 keyboard. 
	
	;This just CLEARS the effects panel search bar and selects it so that you can type something in yourself. Or maybe it merely highlights what it already there -- whatever.
	}
else if winactive("ahk_exe notepad++.exe")
	sendinput ^f
else if winactive("ahk_exe firefox.exe")
	sendinput ^e
else if winactive("ahk_exe chrome.exe")
	sendinput ^e
else if winactive("ahk_class CabinetWClass")
	sendinput ^e
}


;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;This friggin beautiful code is from this thread:
;https://autohotkey.com/board/topic/121208-windows-explorer-get-folder-path/?p=687189
;another version of this function exists in filemover.ahk , but i think it's not used at all, lol.

Explorer_GetSelection(hwnd="") {
	WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	if (process = "explorer.exe")
		if (class ~= "Progman|WorkerW") {
			;;if you're on the desktop
			ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
			Loop, Parse, files, `n, `r
			ToReturn .= A_Desktop "\" A_LoopField "`n"
	} else if (class ~= "(Cabinet|Explore)WClass") {
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				sel := window.Document.SelectedItems
		for item in sel
			ToReturn .= item.path "`n"
	}
return Trim(ToReturn,"`n")
}
; ; ;How to call the above function
; ; F12::
; ; pathAndName := Explorer_GetSelection()
; ; ;SplitPath, pathAndName, fn
; ; SplitPath, pathAndName, nameOnly ,thePath
; ; MsgBox % "FileName :`t" nameOnly "`nPath :`t" thePath "`nFullName :`t" pathAndName 
; ; clipboard = % thePath
; ; SoundBeep, 500, 200
; ; return

;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;This one does not require you to select an item in the folder in order to work! Unfortunately, it does NOT work on Save As dialogs for whatever reason.
;; code was gotten from here https://autohotkey.com/board/topic/121208-windows-explorer-get-folder-path/?p=687189
;; and here https://www.autohotkey.com/boards/viewtopic.php?p=28751#p28751
Explorer_GetPath(hwnd="") {
	WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	if (process = "explorer.exe")
		if (class ~= "Progman|WorkerW") {
			;;if you're on the desktop
			ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
			Loop, Parse, files, `n, `r
			ToReturn .= A_Desktop "\" A_LoopField "`n"
	} else if (class ~= "(Cabinet|Explore)WClass") {
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				lePath := window.Document.Folder.Self.Path
	}
return lePath
}

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#IfWinActive



saveLocation2(){
f_text = 0
SetTitleMatchMode Slow
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
;;msgbox,,,%f_class%, 1
if f_class in ExploreWClass,CabinetWClass ;;,#32770 ; if the window class is an Explorer window of either kind.
	{
	;;; WinGetTitle, Title, ahk_class CabinetWClass
	;WinGetTitle, title, ahk_id %f_window_id% ;super lame way to do this, does not always work. ;;update -- this is now mercifully obsolete!
	
	thePath := Explorer_GetPath()
	title = % thePath
	
	;msgbox, the address is `n`n%title%

	;;; OLD METHOD. The trouble with this is that by deleting the file, github constantly thinks there's a new .txt file and wants to upload it, no matter how many times I say to ignore the file. Because technically it's a new .txt file. IDK how it even knows that. File metadata??
	; ;sorry, I tried to NOT have to refer to these folder paths directly, but it always failed spectacularly:
	; FileDelete, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; FileAppend, %title% , C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	; SavedExplorerAddress = %title%
	; ;checkForFile("Thumbnail","Template.psd")
	;;;;/OLD METHOD
	
	;;;NEW METHOD IS BELOW:
	; Info:
	; https://www.autohotkey.com/boards/viewtopic.php?t=62917
	; https://www.autohotkey.com/boards/viewtopic.php?t=61853
	file := FileOpen("C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt", "w") 
	file.write(title)
	file.close()
	SavedExplorerAddress = %title%
	;;;/NEW METHOD
	
	msgbox, , , %title%`n`nwas saved as root!, 0.3
	}
else
	msgbox,,, this is PROBABLY not an explorer window you chump,0.5
;for some reason, after this script runs, it sometimes activates the last active window. It doesn't make any sense...
}
;for further reading:
;https://autohotkey.com/board/topic/60985-get-paths-of-selected-items-in-an-explorer-window/
;end of savelocation2()


;in progress
checkForFile(subDirectory, filename)
{
FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
;msgbox, current directory is`n%directory%
directory = %SavedExplorerAddress%
msgbox, new directory is`n%directory%

;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.

finalDirectory = %directory% . %subDirectory%

;msgbox, directory is %directory%`n and filetype is %filetype%
Loop, Files,%finalDirectory%, F
{

If (A_LoopFileTimeModified>Rec)
  {
  IfNotInString, A_LoopFileFullPath, ~$
	FPath=%A_LoopFileFullPath%
  Rec=%A_LoopFileTimeModified%
  }
}
MsgBox, 3,, Select YES to open the latest %filetype% at Fpath:`n`n%Fpath%
IfMsgBox, Yes
	{
	Run %Fpath%
	}
}







;;;; SCRIPT TO ALWAYS OPEN THE MOST RECENTLY SAVED OR AUTOSAVED FILE OF A GIVEN FILETYPE, IN ANY GIVEN FOLDER (AND ALL SUBFOLDERS.);;;;
;;script partially obtained from https://autohotkey.com/board/topic/57475-open-most-recent-file-date-created-in-a-folder/
openlatestfile(directory, filetype)
{
if directory = 1
	{
	FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	;msgbox, current directory is`n%directory%
	directory = %SavedExplorerAddress%
	;msgbox, new directory is`n%directory%
	}
;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.

;Keyshower(directory,"openlatestfile")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(directory,"openlatestfile") 
}

;I need some method of excluding ~$ files, since those clutter everything up (MS Word .docx ...)

;msgbox, directory is %directory%`n and filetype is %filetype%
Loop, Files,%directory%\*%filetype%, FR
{

If (A_LoopFileTimeModified>Rec)
  {
  IfNotInString, A_LoopFileFullPath, ~$
	FPath=%A_LoopFileFullPath%
  Rec=%A_LoopFileTimeModified%
  }
}
;try to get this to work with an ENTER press from thne stream deck...
MsgBox, 3,, Select YES to open the latest %filetype% at Fpath:`n`n%Fpath%
IfMsgBox, Yes
	{
	Run %Fpath%
	}

; ; USING THE SCRIPT
; !n::
; examplePath = "Z:\Linus\6. Channel Super Fun\Flicking football"
; openlatestfile(examplePath, ".prproj") ;<--- notice how i INCLUDE the period in the parameters. IDK if it might be better to add the period later.
; return
}
; end of openlatestfile()





openlatestFLAT(directory, filetype)
{
if directory = 1
	{
	FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	;msgbox, current directory is`n%directory%
	directory = %SavedExplorerAddress%
	;msgbox, new directory is`n%directory%
	}
;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.

;Keyshower(directory,"openlatestfile")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(directory,"openlatestfile") 
}

;msgbox, directory is %directory%`n and filetype is %filetype%
Loop, Files,%directory%\*%filetype%, F
{
If (A_LoopFileTimeModified>Rec)
  {
  IfNotInString, A_LoopFileFullPath, ~$
	FPath=%A_LoopFileFullPath%
  Rec=%A_LoopFileTimeModified%
  }
}

;msgbox, %Fpath%

Run %Fpath%
;run, firefox.exe %Fpath% ;;if you use this, it'll open up tons of firefox tabs, each one with a different word from the title. kind of interesting, but not at all what i want, lol.


;unfortunately, since I don't already know the tab NAME, (which is required for JEE_FirefoxFocusTabByName) I can't make it so that it'll merely switch to that tab if it's already open. Instead, it'll always open a new tab with this URL. Unfortunate, but fixing it is beyond my capabilities for now.

; ; USING THE SCRIPT
; !n::
; examplePath = "Z:\Linus\6. Channel Super Fun\Flicking football"
; openlatestfile(examplePath, ".prproj") ;<--- notice how i INCLUDE the period in the parameters. IDK if it might be better to add the period later.
; return
}
; end of openlatestFLAT()




debug2:
tooltip, counter = %counter%`nnlines = %nlines%, , , 10
;tooltip, , , , 10
return
;;;;;;;;;;;;;;;;THOSE DIDNT WORK.;;;;;;;;;;;;;;;



;MOVED FROM PREMIERE SCRIPTS
;function to start, then activate any given application
openApp(theClass, theEXE, theTitle := ""){
;Keyshower(theEXE, "openApp") ;leads to a function that shows the keypresses onscreen
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(theEXE, "openApp") 
}
IfWinNotExist, %theClass%
	Run, % theEXE
if not WinActive(theClass)
	{
	WinActivate %theClass%
	;WinGetTitle, Title, A
	WinRestore %theTitle%
	}
}

;MOVED FROM PREMIERE SCRIPTS
;this should probably all be replaced with instantexplorer, since that will work to change any existing Save as dialogs or whatever.
runexplorer(foo)
{
keywait, %A_PriorHotKey% ;to avoid stuck modifiers as usual
send {SC0E7} ;the scan code of an unassigned key ;;sending even a single keystroke like this, which comes "from" the secondary keyboard, will prevent the taskbar icon from sometimes flashing pointlessly rather than opening.
sleep 5
Run, % foo
sleep 10
;Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;windows shortcut to resize name feild to fit.
;alt v o down enter will sort by date modified, but it is stupid...

if IsFunc("Keyshower")
	{
	;you can ignore or delete this part. It's just for onscreen visualization. Not necessary.
	Func := Func("Keyshower")
	RetVal := Func.Call(foo, "runExplorer") 
	}

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


;-------The below script originally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/
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
;--------The above script originally from: https://autohotkey.com/board/topic/102127-navigating-explorer-directories/







; #ifwinactive
; F7::
	; Send ^s
	; sleep 200
    ; SoundBeep, 1100, 500
	; Reload  ;The only thing you need here is the Reload
; Return








#IfWinActive

;BEGIN savage-folder-navigation CODE!
;I got MOST of this code from https://autohotkey.com/docs/scripts/FavoriteFolders.htm
;and modified it to work with any given keypress, rather than middle mouse click as it had before.

;<<<<< i don't remember what the text below is talking about
;NEED to include this too: file locater modified Explorer window with shitty edit2 control
;Locate File '\\?\Z:\Linus\1. Linus Tech Tips\Pending\Maxine Settings Computer\Delivery\Maxine Settings Computer rc3.mov'
;ahk_class #32770
;ahk_exe Adobe Premiere Pro.exe
; >>>>>>>> idk what that was.


InstantExplorer(f_path,pleasePrepend := 0)
{
;this has been heavily modified from https://autohotkey.com/docs/scripts/FavoriteFolders.htm

;I feel ambivilant about this line. It'll be more stable, but it'll be a bit sloooowerrrr!
keywait, %A_priorhotkey% ;should there be a timeout clause? this still works even when launched with no hotkey, hmm.

sendinput, {blind}{SC0E8} ;scan code of an unassigned key. This is needed to prevent the item from merely FLASHING on the task bar, rather than opening the folder. Don't ask me why, but this works. Also, this is helpful for debugging.

;msgbox, hello

if pleasePrepend = 1 ;this is for the changeable per-project folder shortcuts
	{
	FileRead, SavedExplorerAddress, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SavedExplorerAddress.txt
	;msgbox, current f_path is %f_path%
	if f_path =
		{
		; if f_path is BLANK, then we don't want to add a \ onto the end just by itself, as that will be done later!
		;msgbox, I did not add a blank f_path.
		f_path = %SavedExplorerAddress%
		}
	else
		f_path = %SavedExplorerAddress%\%f_path% ;there is no need to use . to concatenate
		
	;msgbox, new f_path is %f_path%
	;SUPER IMPORTANT NOTE - you must have explorer show the entire path in the title bar, or this doesn't work. I do need a better way to get that information. Something DLL based or whatever.
	}
;NOTE TO FUTURE TARAN: for Keyshower, put code here to find the first \ and remove the string before it. otherwise you can't see the FULL final folder name because it gets cropped off
;Keyshower(f_path,"InstExplor")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(f_path,"InstExplor") 
}

;;;NO LONGER IMPORTANT: YOU NEED TO GO INTO WINDOWS' FOLDER OPTIONS > VIEW > AND CHECK "DISPLAY THE FULL PATH IN THE TITLE BAR" OR THIS WON'T WORK.
;;;UPDATE: THE INSTRUCTION ABOVE ARE OBSOLETE NOW, I'VE FIGURED OUT A BETTER WAY TO DO GET THAT INFO! (It uses the windows API stuff that i have access to through AHK)


instantExplorerTryAgain:

if !FileExist(f_path)
{
	;MsgBox,,, %f_path%`nNo such path exists`, but we will go down in folders until it does.,1.0
	
	if InStr(f_path, "\"){
	
		FoundPos := InStr(f_path, "\", , StartingPos := 0, Occurrence := 1)
		;msgbox % FoundPos
		
		Length := StrLen(f_path)
		
		;StringLeft, OutputVar, InputVar, Count
		
		trimThis := Length - FoundPos
		
		;msgbox % trimThis
		
		NewString := SubStr(f_path, 1, FoundPos-1)
		;msgbox, NewString is %NewString%
		f_path := NewString
		GOTO, instantExplorerTryAgain
		;oh my god this code is so sloppy, it's great. And this is like, one of my best ever functions. I'm not even kidding. I use it like 20x an hour.
	}
	else
	{
		MsgBox,,, %f_path%`n`nNo such path exists.,1.0
		GOTO, instantExplorerEnd
		
	}
}

f_path = %f_path%\ ;;THIS ADDS A \ AT THE VERY END OF THE FILE PATH, FOR THE SAKE OF OLD-STYLE SAVE AS DIALOUGE BOXES WHICH REQUIRE THEM IN ORDER TO UPDATE THE FOLDER PATH WHEN IT IS INSERTED INTO Edit1.

;msgbox, f_path is currently %f_path% ;just debugging as usual

f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable. 

;but also, the old style still dopesn't like the quotation marks, and I'm not sure how to detect it since i know almost nothing about it. ho hum. But it does have ClassNN:	SysListView321 which MAYBE i could use with this code https://autohotkey.com/board/topic/9362-detect-opensave-dialog/ but i dont know. saving this for later.

;msgbox, f_path is now finally %f_path%

;SoundBeep, 900, 400 ;this is dumb because you cant change the volume, or tell it NOT to wait while the sound plays...

; These first few variables are set here and used by f_OpenFavorite:
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
WinGetTitle, f_title, ahk_id %f_window_id% ;to be used later to see if this is the export dialouge window in Premiere...
if f_class in #32770,ExploreWClass,CabinetWClass  ; if the window class is a save/load dialog, or an Explorer window of either kind.
	ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%


	;edit2
/*
if f_AlwaysShowMenu = n  ; The menu should be shown only selectively.
{
	if f_class in #32770,ExploreWClass,CabinetWClass  ; Dialog or Explorer.
	{
		if f_Edit1Pos =  ; The control doesn't exist, so don't display the menu
			return
	}
	else if f_class <> ConsoleWindowClass
		return ; Since it's some other window type, don't display menu.
}
; Otherwise, the menu should be presented for this type of window:
;Menu, Favorites, show
*/

;msgbox, A_ThisMenuItemPos %A_ThisMenuItemPos%
;msgbox, A_ThisMenuItem %A_ThisMenuItem%
;msgbox, A_ThisMenu %A_ThisMenu%

;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; msgbox, f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; f_OpenFavorite:
;msgbox, BEFORE:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; Fetch the array element that corresponds to the selected menu item:
;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
if f_path =
	return

if f_class = EVERYTHING    ; It's Everything search. I want to put the fodler name in quotes in the main field, because that's how you search a subdirectory.
{
ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%
;msgbox, this is Everything search`nf_Edit1Pos = %f_Edit1Pos%

if f_Edit1Pos <>   ; we know it should have an Edit1 control.
	{
	ControlFocus, Edit1, ahk_id %f_window_id%
	
	WinActivate ahk_id %f_window_id%
	
	f_path := f_path . " " ;this adds a space to the end, so i can type the actual thing to search for afterwards.

	ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
	;(it adds a space to the end too.)
	sleep 2
	ControlFocus, DirectUIHWND2, ahk_id %f_window_id% ;to try to get the focus back into the center area, so you can now type letters and have it go to a file or fodler, rather than try to SEARCH or try to change the FILE NAME by default.
	send, {end} ;to get to the end of the search box. best place to search for the actual thing i want to find.
	return
	}

GOTO, instantExplorerEnd 
}



if f_class = #32770    ; It's a dialog.
	{

	if WinActive("ahk_exe waifu2x-caffe.exe")
		{
		tooltip, you are inside of Waifu2x
		
		GOTO, ending2
		;this will open an explorer window rather than trying to change waifu2x's input path as it otherwise would.
		}
	
	if WinActive("ahk_exe Adobe Premiere Pro.exe")
		{
		tooltip, you are inside of premiere
		
		if (f_title = "Export Settings") or if (f_title = "Link Media")
			{
			msgbox,,,you are in Premiere's export window or link media window, but NOT in the "Save as" inside of THAT window. no bueno, 1
			GOTO, instantExplorerEnd 
			;return ;no, I don't want to return because i still want to open an explorer window.
			}
		
		
		If InStr(f_title, "Link Media to") ;Note that you must have "use media browser to locate files" UNCHECKED because it is GARBAGE.
			{
			tooltip, you are inside Premieres relinker.
			; This requires custom code, because the EditX boxes are different:
			; last path   = Edit1
			; filename    = Edit2
			; address bar = Edit3

			ControlFocus, Edit2, ahk_id %f_window_id% 

			tooltip, you are inside the link media thingy
			sleep 1
			
			WinActivate ahk_id %f_window_id%
			sleep 1
			ControlGetText, f_text, Edit2, ahk_id %f_window_id%
			sleep 1
			ControlSetText, Edit2, %f_path%, ahk_id %f_window_id%
			ControlSend, Edit2, +{Enter}, ahk_id %f_window_id%
			Sleep, 100  ; It needs extra time on some dialogs or in some cases.
			ControlSetText, Edit2, %f_text%, ahk_id %f_window_id%
			;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
			
			tooltip,
			return		
			}

		if (f_title = "Save As") or if (f_title = "Save Project")
			{
			;;;ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%
			;ControlFocus, Edit2, ahk_id %f_window_id% ;we know that Edit2 is the address bar in this case. So there's no need to use Edit1 and then swap back in the filename.
			
			ControlFocus, Edit1, ahk_id %f_window_id% 
			;msgbox,,,you are hereee,0.5
			tooltip, you are here
			sleep 1
			;tippy2("DIALOUGE WITH PREMIERE'S Edit1`n`nLE controlfocus of Edit1 for f_window_id was just engaged.", 2000)
			; msgbox, is it in focus?
			; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
			; sleep 10
			; click
			; sleep 10
			; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
			;msgbox, Edit1 has been clicked maybe
			
			; Activate the window so that if the user is middle-clicking
			; outside the dialog, subsequent clicks will also work:
			WinActivate ahk_id %f_window_id%
			; Retrieve any filename that might already be in the field so
			; that it can be restored after the switch to the new folder:
			ControlGetText, f_text, Edit1, ahk_id %f_window_id%
			sleep 1
			ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
			ControlSend, Edit1, +{Enter}, ahk_id %f_window_id%
			Sleep, 100  ; It needs extra time on some dialogs or in some cases.
			ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
			;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
			
			tooltip,
			return
			tooltip, do you make it this far
			tooltip, the answer is no. the RETURN ends it properly
			GOTO, instantExplorerEnd 
			;But i have the GOTO just in case, hahahaha
			}
		}

	; stuff beyond here is NOT in premiere
	if f_Edit1Pos <>   ; And it has an Edit1 control.
		{

		ControlFocus, Edit1, ahk_id %f_window_id% ;this is really important.... it doesn't work if you don't do this...
		;tippy2("DIALOUGE WITH EDIT1`n`nwait really?`n`nLE controlfocus of edit1 for f_window_id was just engaged.", 1000)
		; msgbox, is it in focus?
		; MouseMove, f_Edit1Pos, f_Edit1PosY, 0
		; sleep 10
		; click
		; sleep 10
		; msgbox, how about now? x%f_Edit1Pos% y%f_Edit1PosY%
		;msgbox, edit1 has been clicked maybe
		
		; Activate the window so that if the user is middle-clicking
		; outside the dialog, subsequent clicks will also work:
		WinActivate ahk_id %f_window_id%
		
		; Retrieve any filename that might already be in the field so
		; that it can be restored after the switch to the new folder:
		ControlGetText, f_text, Edit1, ahk_id %f_window_id%
		sleep 2
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		sleep 3
		ControlSend, Edit1, {Enter}, ahk_id %f_window_id%
		Sleep, 100  ; It needs extra time on some dialogs or in some cases.
		
		;now RESTORE the filename in that text field. I don't like doing it this way...
		ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
		;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
		sleep 2
		ControlFocus, DirectUIHWND2, ahk_id %f_window_id% ;to try to get the focus back into the center area, so you can now type letters and have it go to a file or fodler, rather than try to SEARCH or try to change the FILE NAME by default.
		return
		}
	; else fall through to the bottom of the subroutine to take standard action.
	}

;for some reason, the following code just doesn't work well at all.
/*
else if f_class in ExploreWClass,CabinetWClass  ; In Explorer, switch folders.
{
	tooltip, f_class is %f_class% and f_window_ID is %f_window_id%
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		Tippy2("EXPLORER WITH EDIT1 only 2 lines of code here....", 1000)
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		msgbox, ControlSetText happened. `nf_class is %f_class% and f_window_ID is %f_window_id%`nAND f_Edit1Pos is %f_Edit1Pos%
		; Tekl reported the following: "If I want to change to Folder L:\folder
		; then the addressbar shows http://www.L:\folder.com. To solve this,
		; I added a {right} before {Enter}":
		ControlSend, Edit1, {Right}{Enter}, ahk_id %f_window_id%
		return
	}
	; else fall through to the bottom of the subroutine to take standard action.
}
*/

else if f_class = ConsoleWindowClass ; In a console window, CD to that directory
	{
	WinActivate, ahk_id %f_window_id% ; Because sometimes the mclick deactivates it.
	SetKeyDelay, 0  ; This will be in effect only for the duration of this thread.
	IfInString, f_path, :  ; It contains a drive letter
		{
		StringLeft, f_path_drive, f_path, 1
		Send %f_path_drive%:{enter}
		}
	Send, cd %f_path%{Enter}
	return
	}
ending2:
; Since the above didn't return, one of the following is true:
; 1) It's an unsupported window type but f_AlwaysShowMenu is y (yes).
; 2) It's a supported type but it lacks an Edit1 control to facilitate the custom
;    action, so instead do the default action below.
;Tippy2("end was reached.",333)
;SoundBeep, 800, 300 ;this is nice but the whole damn script WAITS for the sound to finish before it continues...
; Run, Explorer %f_path%  ; Might work on more systems without double quotes.

;msgbox, f_path is %f_path%

; SplitPath, f_path, , OutDir, , ,
; var := InStr(FileExist(OutDir), "D")

; if (var = 0)
	; msgbox, directory does not exist
; else if var = 1
	Run, %f_path%  ; I got rid of the "Explorer" part because it caused redundant windows to be opened, rather than just switching to the existing window
;else
;	msgbox,,,Directory does not exist,1

instantExplorerEnd:
tooltip,
}
;end of instantexplorer()


; future development
; 



;BEGIN INSTANT APPLICATION SWITCHER SCRIPTS;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#IfWinActive


windowSaver()
{
WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window
global savedCLASS = "ahk_class "lolclass
global savedEXE = lolexe ;is this the way to do it? IDK.
;msgbox, %savedCLASS%
;msgbox, %savedEXE%
}

;SHIFT + macro key G14

;;;i think i can comment these out,,,, idk.
; global savedCLASS = "ahk_class Notepad++"
; global savedEXE = "notepad++.exe"

; switchToSavedApp(savedCLASS, savedEXE)
; {
; ;msgbox,,, savedCLASS is %savedCLASS%,0.5
; ;msgbox,,, savedexe is %savedEXE%,0.5
; if savedCLASS = ahk_class Notepad++
	; {
	; ;msgbox,,, is notepad++,0.5
	; if WinActive("ahk_class Notepad++")
		; {
		; sleep 5
		; Send ^{tab}
		; }
	; }

; ;msgbox,,,got to here,0.5
; windowSwitcher(savedCLASS, savedEXE)
; }





back()
{
;no need for 11 ms of delay, because this is sent from just F13.
;; if WinActive("ahk_class MozillaWindowClass")
;tooltip, back
;sendinput, {ctrl up}
If GetKeystate(Lctrl, "P")
        Send {Lctrl Up}
If GetKeystate(Rctrl, "P")
        Send {Rctrl Up}

if WinActive("ahk_exe firefox.exe")
	Send ^+{tab}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_class Notepad++")
	Send ^+{tab}
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	Send ^!+b ;ctrl alt shift B  is my shortcut in premiere for "go back"(in bins)(the project panel)
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
if WinActive("ahk_class OpusApp")
	sendinput, {F2} ;"go to previous comment" in Word.
}

;macro key 16 on my logitech G15 keyboard. It will activate firefox,, and if firefox is already activated, it will go to the next window in firefox.

openTightVNC()
{
if WinActive("bm-export-1 - TightVNC Viewer") ;if we are at the "Failed to recv data from socket." dialouge box
	{
	Sendinput, {enter}
	goto tvnEND2 ;LOL ARE YOU TRIGGERED BY THIS!!? DESPAIR!
	}
if WinActive("New TightVNC Connection") ;if we are at the thingy that asks for the server IP (already inputted)
	{
	Sendinput, {enter}
	goto tvnEND2 ;LOL ARE YOU TRIGGERED BY THIS!!? DESPAIR!
	}
if WinActive("Vnc Authentication") ;if we are at the thingy that asks for the PASSWORD!
	{
	FileRead, SECRET_SERVER_PASS, C:\AHK\2nd-keyboard\Taran's_Windows_Mods\SECRET_SERVER_PASS_NOT_ON_GITHUB.txt
	;msgbox, pass is %SECRET_SERVER_PASS%
	Sendinput, %SECRET_SERVER_PASS%
	sleep 10
	Sendinput, {enter}
	goto tvnEND2 ;LOL ARE YOU TRIGGERED BY THIS!!? DESPAIR!
	}
IfWinNotExist, ahk_class TvnWindowClass
	Run, C:\Program Files\TightVNC\tvnviewer.exe
if WinExist("ahk_exe tvnviewer.exe")
	WinActivate ahk_exe tvnviewer.exe
tvnEND2:
;all done
}

switchToFirefox(){
;sleep 12 ;;I need this because I put a 10ms delay before the key UP events in iCue. I had to do THAT because otherwise it would go too fast for AHK to even notice. Without this delay, those up events will happen while the function is running, which can lead to modifier keys that are virtually stuck DOWN, which is super bad and annoying.
; i don't remember why I removed this delay. but i also removed the 5ms of delay in icue, sooooo this might not be necceessary anymore?


sendinput, {blind}{SC0EB} ;scan code of an unassigned key. Do I NEED this?
;hmmm, this can force a sending of RCTRL UP because this thing itself does NOT have any modifier keys assigned to it. which means if we use BLIND instead, then that should not happen, right? hmmm.
;And then it sends rCTRL DOWN just after, because it's trying not to mess stuff up, oh i see what's going on there, okay....

;sleep 100
;;look at the below to diagnose MODS error later. i think it double tapped? bad omen...
/*
01  000	 	d	3.56	LButton        	Loupedeck Configuration
01  000	 	u	0.13	LButton        	Adobe Premiere Pro 2020 - Z:\Linus\5. Fast As Possible\1. Pending\what happened to toslink\Project\
01  000	 	d	2.02	LButton        	
01  000	 	u	0.11	LButton        	N/A
A3  11D	 	d	5.11	RControl       	Loupedeck Configuration <----------i think it happened right here
70  03B	h	d	0.00	F1             	
A3  11D	i	u	0.02	RControl       	
00  0E8	i	d	0.00	not found      	
70  03B	s	u	0.00	F1             	
00  0E8	i	u	0.00	not found      	
A3  11D	i	d	0.00	RControl       	
A3  11D	 	u	0.00	RControl       	
01  000	 	d	0.77	LButton        	Loupedeck Taran - Google Docs - Mozilla Firefox
01  000	 	u	0.11	LButton        	
0D  01C	#	d	0.59	Enter          	
0D  01C	#	u	0.11	Enter          	
49  017	#	d	0.84	i              	
20  039	#	d	0.09	Space          	
49  017	 	u	0.01	i              	
20  039	 	u	0.06	Space          	
57  011	#	d	0.16	w              	
57  011	 	u	0.08	w            

*/


IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_exe firefox.exe")
	{
	WinGetClass, class, A
	if (class = "Mozillawindowclass1")
		msgbox, this is a notification
	}
if WinActive("ahk_exe firefox.exe")
	{
	Sendinput, {blind}^{tab} ;this one seems to be best. If Rctrl is still being held down by iCue, then AHK doesn't bother sending its own CTRL event, nor does it try to undo the effects of an existing modifier key by sending it up and then down again real quickly... all possible because of {blind} !
	;Sendinput, {blind}<^{tab} ; this does not work, it just sends (SHIFT ,) instead.
	;Sendinput, {blind}{rctrl down}{tab}{rctrl up} ;this WILL work to use rCONTROL even if Lcontrol is already being held down. Interesting, but not neccessary in this script.
	}
else
	{
	;WinRestore ahk_exe firefox.exe
	;WinActivate ahk_exe firefox.exe ;was winactivatebottom before...
	;WinActivatebottom ahk_class MozillaWindowClass ;was winactivatebottom before...
	WinActivate ahk_class MozillaWindowClass ;was winactivatebottom before...
	;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
	;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
	}
sleep 2

;now to unstick any potentially stuck modifier keys
; KeyList := "Shift|Rctrl|alt"
; Loop, Parse, KeyList, |
	; {
	; If GetKeystate(A_Loopfield, "P")
		; Send % "{" A_Loopfield " Up}"
	; }

; send, {Rctrl up} ;This SHOULD work, but i think it doesn't because the RCTRL event is still coming from the keyboard itself. I need to make something that will send RCTRL up and double click that shit and then see if it makes any difference at all next time. hmm.
; ;okay, I've created RCTRL UP.AHK to test this. Just doble clicking on it will send a RCTRL UP event. This is important because it's not being done through the keyboard. Will try that next time this shizz happens.
; send, {Lctrl up}

}



#IfWinActive
;Press SHIFT and macro key 16, and it'll switch between different WINDOWS of firefox.

switchToOtherFirefoxWindow(){
;holy shit this code actually works now for some reason, IDK why!!!
;sleep 11 ;this is to avoid the stuck modifiers bug ; just kidding, I just needed {blind}
sendinput, {blind}{SC0E8} ;scan code of an unassigned key
Process, Exist, firefox.exe
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, firefox.exe
	else
	{
	GroupAdd, taranfirefoxes, ahk_class MozillaWindowClass
	if WinActive("ahk_class MozillaWindowClass")
		GroupActivate, taranfirefoxes, r
	else
		WinActivate ahk_class MozillaWindowClass
	}
}



; This is a script that will always go to The last explorer window you had open.
; If explorer is already active, it will go to the NEXT last Explorer window you had open.
; CTRL Numpad2 is pressed with a single button stoke from my logitech G15 keyboard -- Macro key 17. 

switchToExplorer(){
sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.

; ; ;maybe need to unstick modifiers
; ; sleep 2
; ; send, {Rctrl up}
; ; send, {Lctrl up}

}

; ;trying to activate these windows in reverse order from the above. it does not work.
; ^+F2::
; IfWinNotExist, ahk_class CabinetWClass
	; Run, explorer.exe
; GroupAdd, taranexplorers, ahk_class CabinetWClass
; if WinActive("ahk_exe explorer.exe")
	; GroupActivate, taranexplorers ;but NOT most recent.
; else
	; WinActivatebottom ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
; Return

;closes all explorer windows :/
;^!F2 -- for searchability

closeAllExplorers()
{
WinClose,ahk_group taranexplorers
; i want to improve this so that the bottom (most recently active) explorer window does NOT close. IDK how to do that yet though.
; https://stackoverflow.com/questions/39601787/close-windows-explorer-window-with-auto-hotkey
; https://autohotkey.com/board/topic/88648-close-all-explorer-windows/
}


switchToPremiere(){
IfWinNotExist, ahk_class Premiere Pro
	{
	;Run, Adobe Premiere Pro.exe
	;Adobe Premiere Pro CC 2017
	; Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe ;if you have more than one version instlaled, you'll have to specify exactly which one you want to open.
	;Run, Adobe Premiere Pro.exe
	Run, C:\Program Files\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe
	}
if WinActive("ahk_class Premiere Pro")
	{
	;;update: this is no longer needed, they fixed that responsiveness issue AFAIK...
	; ; ; IfWinNotExist, ahk_exe notepad++.exe
		; ; ; {
		; ; ; Run, notepad++.exe
		; ; ; sleep 200
		; ; ; }
	; ; ; WinActivate ahk_exe notepad++.exe ;so I have this here as a workaround to a bug. Sometimes Premeire becomes unresponsive to keyboard input. (especially after timeline scrolling, especially with a playing video.) Switching to any other application and back will solve this problem. So I just hit the premiere button again, in those cases.g
	; ; ; sleep 10
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro

;maybe need to unstick modifiers
sleep 2
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
}


switchToWord()
{
sleep 11 ;this is to try to avoid the stuck modifiers bug
;tooltip, why
Process, Exist, WINWORD.EXE
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	IfWinExist, Microsoft Office Word, OK ;checks to see if the annoying "do you want to continue searching from the beginning of the document" dialouge box is present.
		sendinput, {escape}
	else if WinActive("ahk_class OpusApp")
		sendinput, {F3} ;set to "go to next comment" in Word.
	else
		WinActivate ahk_class OpusApp
	}

;maybe need to unstick modifiers
sleep 2
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
sendinput, {SC0EA} ;scan code of an unassigned key. used for debugging.
}



switchWordWindow()
{
sleep 11 ;this is to avoid the stuck modifiers bug
; Process, Exist, WINWORD.EXE
; ;msgbox errorLevel `n%errorLevel%
	; If errorLevel = 0
		; Run, WINWORD.EXE
	; else
	; {
	GroupAdd, taranwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, taranwords, r
	else
		WinActivate ahk_class OpusApp
	; }
}

switchToTeams()
{
sleep 11 ;this is to avoid the stuck modifiers bug
SetTitleMatchMode, 2
WinActivate, | Microsoft Teams
;ahk_class Chrome_WidgetWin_1
; General (Editors) | Microsoft Teams
; ahk_class Chrome_WidgetWin_1
; ahk_exe Teams.exe
; ahk_pid 11508
; https://www.autohotkey.com/docs/misc/WinTitle.htm

}


switchToEdge()
{
;I use Edge to upload videos for review to an unlisted channel. That's just much easier than always having to deal with switching between youtube accounts on my primary browser.
;sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_exe msedge.exe
	Run, msedge.exe
else
	windowSwitcher("ahk_class Chrome_WidgetWin_1", "msedge.exe")
	
; ahk_class Chrome_WidgetWin_1
; ahk_exe msedge.exe
; ahk_pid 36788

}


switchToChrome()
{
;Even getting rid of the "sleep" commands, there's still a noticable delay when I switch to chrome for the first time. this is... annoying. It makes itself the window on top, but is not actaully ACTIVATED for about 300 milliseconds... meaning my next command or two will not work, until chrome is ACTUALLY active. AGH i might need to talk directly to the AHK forums about this. find out if there really is a difference between on top and active, because I sure as hell am noticing one.

;sleep 11 ;this is to avoid the stuck modifiers bug?
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

if WinActive("ahk_exe chrome.exe")
	{
	;Sendinput {blind}^{tab} ;idk why i had it this way, but it sometimes wouldn't work.
	Sendinput  ^{tab}
	}
else
	WinActivate ahk_exe chrome.exe
	
;maybe need to unstick modifiers
;sleep 2
sendinput {Rctrl up}{Lctrl up}
;idk if it helps or not.
;sendinput, {RAW}{SC0EA} ;scan code of an unassigned key. used for debugging.
}

switchToOtherChromeWindow(){
sendinput, {blind}{SC0E8} ;scan code of an unassigned key

Process, Exist, chrome.exe
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, chrome.exe
	else
	{
	GroupAdd, taranChromes, ahk_exe chrome.exe
	if WinActive("ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe")
		GroupActivate, taranChromes, r
	else
		WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe,, Microsoft Teams ;the last one is explicitly telling it NOT to open Microsoft Teams.
	}
}

switchToWindowSpy()
{
If Not WinExist("ahk_class AU3Reveal")
	openApp("ahk_class AU3Reveal", "C:\Program Files\AutoHotkey\WindowSpy.ahk", "Active Window Info")
; else
	; msgbox, heyyyy ;doesn't work for some raisin.
; if WinExist("ahk_class AU3Reveal")
	; msgbox, heyyo
	; WinClose, Window Spy
}


switchToAudacity()
{
; Audacity
; ahk_class wxWindowNR
; ahk_exe audacity.exe
; ahk_pid 80600
IfWinNotExist, ahk_exe audacity.exe
	{
	Run, C:\Program Files (x86)\Audacity\audacity.exe
	}
else
	{
	WinActivate ahk_exe audacity.exe
	}
}


switchToStreamDeck(){
sleep 11 ;this is to avoid the stuck modifiers bug
IfWinNotExist, ahk_exe StreamDeck.exe
	{
	Run, C:\Program Files\Elgato\StreamDeck\StreamDeck.exe
	}
else
	{
	WinActivate ahk_exe StreamDeck.exe
	}
}


#IfWinActive


windowSwitcher(theClass, theEXE)
{
;to CALL this function with specific parameters:
;windowSwitcher("ahk_class Chrome_WidgetWin_1", "vivaldi.exe")
;;YOU MIGHT WANT TO USE openApp() INSTEAD, lol

sleep 10 ;this is to avoid the stuck modifiers bug
if theEXE = Discord.exe
	{
	;if WinActive("ahk_exe Discord.exe")
	WinActivate, ahk_exe Discord.exe
	
	}


if theClass = ahk_class Notepad++
	{
	;msgbox,,, is notepad++,0.5
	if WinActive("ahk_class Notepad++")
		{
		sleep 5
		Send {blind}^{tab}
		}
	}

; ;if savedCLASS = Chrome_WidgetWin_1
;tons of applications use Chrome_WidgetWin_1 so I have to make exceptions for all of them...
if theCLASS = ahk_class Chrome_WidgetWin_1
	{
	;tooltip, it is a chrome thingy
	;msgbox % theEXE
	if theEXE = vivaldi.exe
		{
		;tooltip, this is the vivaldi browser. i sometimes use for full page screenshots.
		; https://docs.google.com/spreadsheets/d/1dVJb7kI_ZETLavrplfARgn9gL8HUpvkq6A0jCPxqA3w/edit#gid=50892840
		SetTitleMatchMode, 2
		WinActivate, - Vivaldi
		;WinActivate ahk_exe %theEXE%
		}
	if theEXE = Teams.exe
		{
		;tooltip, this is microsoft Teams
		if WinActive("ahk_exe Teams.exe")
			sendinput, ^e ;;CTRL E is the Teams shortcut to go to the SEARCH bar. So, if I hit the key again, it'll do that.
		SetTitleMatchMode, 2
		WinActivate, | Microsoft Teams
		;WinActivate ahk_exe %theEXE%
		}
	if theEXE = msedge.exe 
		{
		;tooltip, this is microsoft Edge. I use it just to upload review copies of videos onto an unlisted channel.
		if WinActive("ahk_exe msedge.exe")
			sendinput, ^{tab}
		;SetTitleMatchMode, 2
		WinActivate, ahk_exe msedge.exe
		;WinActivate ahk_exe %theEXE%
		}
	
	goto, switchEND
	;programmer status: Triggered
	; https://xkcd.com/292/
	}

;msgbox,,, switching to `nsavedCLASS = %theClass% `nsavedEXE = %theEXE%, 0.5
; IfWinNotExist, %theClass%
	; Run, % theEXE
if not WinActive(theClass)
	WinActivate %theClass%
switchEND:
}

;;;EXPLORERSORT.AHK CODE IS BELOW

;https://www.autohotkey.com/boards/viewtopic.php?f=6&t=33129
;every stitch of cool code here is the above posts!  All Credit and Thanks is theirs

#IfWinActive, ahk_exe explorer.exe

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_ExpWinGetObj(hWnd)
{
	for oWin in ComObjCreate("Shell.Application").Windows
		if (oWin.HWND == hWnd)
			break
	return oWin
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

;e.g. JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
;e.g. isp := isb := isv := ifv2 := icm := ""
JEE_ExpGetInterfaces(oWin, ByRef isp="", ByRef isb="", ByRef isv="", ByRef ifv2="", ByRef icm="")
{
	isp := ComObjQuery(oWin, "{6d5140c1-7436-11ce-8034-00aa006009fa}")
	, isb := ComObjQuery(isp, "{4C96BE40-915C-11CF-99D3-00AA004AE837}", "{000214E2-0000-0000-C000-000000000046}")
	if (DllCall(NumGet(NumGet(isb+0)+15*A_PtrSize), Ptr,isb, PtrP,isv) < 0) ;QueryActiveShellView
		return
	ifv2 := ComObjQuery(isv, "{1af3a467-214f-4298-908e-06b03e0b39f9}")
	icm := ComObjQuery(ifv2, "{d8ec27bb-3f3b-4042-b10a-4acfd924d453}")
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

;custom abbreviation to canonical property name
JEE_ExpColAbbrevToName(vList, vDelim="`n")
{
	oArray := {nam:"System.ItemNameDisplay"
	,siz:"System.Size"
	,typ:"System.ItemTypeText"
	,mod:"System.DateModified"
	,cre:"System.DateCreated"
	,acc:"System.DateAccessed"
	,dat:"System.ItemDate"
	,dur:"System.Calendar.Duration"
	,dim:"System.Image.Dimensions"
	,len:"System.Media.Duration"}

	vOutput := ""
	Loop, Parse, vList, % vDelim
		vOutput .= ((A_Index = 1) ? "" : vDelim) oArray[A_LoopField]
	return vOutput
}

;==================================================

;IColumnManager interface (Windows)
;https://msdn.microsoft.com/en-us/library/windows/desktop/bb776149(v=vs.85).aspx
;methods (8): C:\Program Files (x86)\Windows Kits\8.1\Include\um\ShObjIdl.h

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_ICMGetColumnCount(icm, vMode="")
{
	vFlags := InStr(vMode, "a") ? 0x1 : 0x2
	;CM_ENUM_VISIBLE := 0x2 ;CM_ENUM_ALL := 0x1
	DllCall(NumGet(NumGet(icm+0)+5*A_PtrSize), Ptr,icm, UInt,vFlags, UIntP,vCountCol) ;GetColumnCount
	return vCountCol
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

;mode: n (get name), c (get CLSID and property identifier), a (get all)
JEE_ICMGetColumns(icm, vSep="`n", vMode="n")
{
	vFlags := InStr(vMode, "a") ? 0x1 : 0x2
	DllCall(NumGet(NumGet(icm+0)+5*A_PtrSize), Ptr,icm, UInt,vFlags, UIntP,vCountCol) ;GetColumnCount
	vOutput := ""
	VarSetCapacity(vOutput, vCountCol*100*2)
	vOutput := ""
	;CM_ENUM_VISIBLE := 0x2 ;CM_ENUM_ALL := 0x1
	vArrayPROPERTYKEY := ""
	VarSetCapacity(vArrayPROPERTYKEY, vCountCol*20, 0)
	DllCall(NumGet(NumGet(icm+0)+6*A_PtrSize), Ptr,icm, UInt,vFlags, Ptr,&vArrayPROPERTYKEY, UInt,vCountCol) ;GetColumns
	Loop, % vCountCol
	{
		vOffset := (A_Index-1)*20
		if InStr(vMode, "c")
		{
			DllCall("ole32\StringFromCLSID", Ptr,&vArrayPROPERTYKEY+vOffset, PtrP,vAddrCLSID)
			vCLSID := StrGet(vAddrCLSID, "UTF-16")
			vNum := NumGet(vArrayPROPERTYKEY, vOffset+16, "UInt")
			vOutput .= vCLSID " " vNum
		}
		if InStr(vMode, "n")
		{
			if InStr(vMode, "c")
				vOutput .= "`t"
			DllCall("propsys\PSGetNameFromPropertyKey", Ptr,&vArrayPROPERTYKEY+vOffset, PtrP,vAddrName)
			vName := StrGet(vAddrName, "UTF-16")
			vOutput .= vName
		}
		vOutput .= vSep
	}
	vOutput := SubStr(vOutput, 1, -StrLen(vSep))
	return vOutput
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_ICMSetColumns(icm, vList, vSep="`n")
{
	DllCall(NumGet(NumGet(icm+0)+5*A_PtrSize), Ptr,icm, UInt,vFlags, UIntP,vCountCol) ;GetColumnCount
	vList := StrReplace(vList, vSep, vSep, vCountCol)
	vCountCol++
	vArrayPROPERTYKEY := ""
	VarSetCapacity(vArrayPROPERTYKEY, vCountCol*20, 0)
	Loop, Parse, vList, % vSep
	{
		vOffset := (A_Index-1)*20
		DllCall("propsys\PSGetPropertyKeyFromName", Str,A_LoopField, Ptr,&vArrayPROPERTYKEY+vOffset)
	}
	DllCall(NumGet(NumGet(icm+0)+7*A_PtrSize), Ptr,icm, Ptr,&vArrayPROPERTYKEY, UInt,vCountCol) ;SetColumns
	return
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

;not working (error 0x8000FFFF)
;is 'ideal' width, the autosize width?
JEE_ICMGetColumnWidth(icm, vName, ByRef vWidthIdeal="")
{
	VarSetCapacity(PROPERTYKEY, 20, 0)
	DllCall("propsys\PSGetPropertyKeyFromName", Ptr,&vName, Ptr,&PROPERTYKEY)
	VarSetCapacity(CM_COLUMNINFO, 184, 0)
	NumPut(184, CM_COLUMNINFO, 0, "UInt") ;cbSize
	;CM_MASK_WIDTH := 0x1 ;CM_MASK_IDEALWIDTH := 0x4
	NumPut(0x5, CM_COLUMNINFO, 4, "UInt") ;dwMask
	DllCall(NumGet(NumGet(icm+0)+4*A_PtrSize), Ptr,icm, Ptr,&PROPERTYKEY, Ptr,&CM_COLUMNINFO) ;GetColumnInfo
	vWidthIdeal := NumGet(CM_COLUMNINFO, 20, "UInt") ;uIdealWidth
	return NumGet(CM_COLUMNINFO, 12, "UInt") ;uWidth
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_ICMSetColumnWidth(icm, vName, vWidth)
{
	VarSetCapacity(PROPERTYKEY, 20, 0)
	DllCall("propsys\PSGetPropertyKeyFromName", Ptr,&vName, Ptr,&PROPERTYKEY)
	VarSetCapacity(CM_COLUMNINFO, 184, 0)
	NumPut(184, CM_COLUMNINFO, 0, "UInt") ;cbSize
	;CM_MASK_WIDTH := 0x1
	NumPut(0x1, CM_COLUMNINFO, 4, "UInt") ;dwMask
	NumPut(vWidth, CM_COLUMNINFO, 12, "UInt") ;dwMask
	DllCall(NumGet(NumGet(icm+0)+3*A_PtrSize), Ptr,icm, Ptr,&PROPERTYKEY, Ptr,&CM_COLUMNINFO) ;SetColumnInfo
}

;==================================================

;IFolderView2 interface (Windows)
;https://msdn.microsoft.com/en-us/library/windows/desktop/bb775541(v=vs.85).aspx
;methods (42): C:\Program Files (x86)\Windows Kits\8.1\Include\um\ShObjIdl.h

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_IFV2GetSortColumnCount(ifv2)
{
	DllCall(NumGet(NumGet(ifv2+0)+26*A_PtrSize), Ptr,ifv2, IntP,vCountCol) ;GetSortColumnCount
	return vCountCol
}

;========== I, TARAN, DID NOT WRITE THIS CODE, AND POSSIBLY DON'T USE IT ============

JEE_IFV2GetSortColumns(ifv2, vSep="`n", vMode="n")
{
	DllCall(NumGet(NumGet(ifv2+0)+26*A_PtrSize), Ptr,ifv2, IntP,vCountCol) ;GetSortColumnCount
	vOutput := ""
	vArraySORTCOLUMN := ""
	VarSetCapacity(vArraySORTCOLUMN, vCountCol*24, 0)
	DllCall(NumGet(NumGet(ifv2+0)+28*A_PtrSize), Ptr,ifv2, Ptr,&vArraySORTCOLUMN, Int,vCountCol) ;GetSortColumns
	Loop, % vCountCol
	{
		vOffset := (A_Index-1)*24
		if (vMode = "n")
		{
			DllCall("propsys\PSGetNameFromPropertyKey", Ptr,&vArraySORTCOLUMN+vOffset, PtrP,vAddrName)
			vName := StrGet(vAddrName, "UTF-16")
			;SORT_ASCENDING := 1 ;SORT_DESCENDING := -1
			vDirection := NumGet(vArraySORTCOLUMN, vOffset+20, "Int")
			vOutput .= vName " " vDirection vSep
		}
		else if (vMode = "c")
		{
			DllCall("ole32\StringFromCLSID", Ptr,&vArraySORTCOLUMN+vOffset, PtrP,vAddrCLSID)
			vCLSID := StrGet(vAddrCLSID, "UTF-16")
			vNum := NumGet(vArraySORTCOLUMN, vOffset+16, "UInt")
			vDirection := NumGet(vArraySORTCOLUMN, vOffset+20, "Int")
			vOutput .= vCLSID " " vNum " " vDirection vSep
		}
	}
	vOutput := SubStr(vOutput, 1, -StrLen(vSep))
	return vOutput
}

;========== I, TARAN, DID NOT WRITE THIS CODE ============

JEE_IFV2SetSortColumns(ifv2, vList, vSep="`n")
{
	vList := StrReplace(vList, vSep, vSep, vCountCol)
	vCountCol++
	vArraySORTCOLUMN := ""
	VarSetCapacity(vArraySORTCOLUMN, vCountCol*24, 0)
	Loop, Parse, vList, % vSep
	{
		vOffset := (A_Index-1)*24
		vPos := InStr(A_LoopField, " ", 0, -1)
		vName := SubStr(A_LoopField, 1, vPos-1)
		vDirection := SubStr(A_LoopField, vPos+1)
		DllCall("propsys\PSGetPropertyKeyFromName", Str,vName, Ptr,&vArraySORTCOLUMN+vOffset)
		;SORT_ASCENDING := 1 ;SORT_DESCENDING := -1
		NumPut(vDirection, vArraySORTCOLUMN, vOffset+20, "Int")
	}
	DllCall(NumGet(NumGet(ifv2+0)+27*A_PtrSize), Ptr,ifv2, Ptr,&vArraySORTCOLUMN, Int,vCountCol) ;SetSortColumns
}

;========== I, TARAN, DID NOT WRITE THIS CODE ============
	;1: ascending, -1: descending
	;vList := "System.ItemNameDisplay 1" ;Name
	;vList := "System.ItemDate 1" ;Date
	;vList := "System.ItemTypeText 1" ;Type
	;vList := "System.Size 1" ;Size
	;vList := "System.Media.Duration 1" ;Length
	;MsgBox % JEE_IFV2GetSortColumns(ifv2)

;;HOW TO ACTUALLY CALL THESE FUNCTIONS:
;/*

sortByDate()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	;above must load up the complex structures with black magic
	;clipboard:=JEE_IFV2GetSortColumns(ifv2)
	;System.DateModified -1
	;System.DateModified 1
	;;if RegExMatch(JEE_IFV2GetSortColumns(ifv2),"System.DateModified ?:-1")
	;regexesllwork but not straightforward
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	;dont call it twice - maybe you wouldnt need to but im not seeing a superb way to avoid it below
	if InStr(curCol,"System.DateModified")
	{
		;test if it is ascending or descending and let's flip 'em
		If InStr(curCol,"-")
		{
			vList := "System.DateModified 1" 
		}
		;no alternate cases right?
		else {
			vList := "System.DateModified 1" 
		}
	}
	;no alternate cases right?
	else {
		vList := "System.DateModified 1"
	}
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

sortByDateOLD()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	;above must load up the complex structures with black magic
	;clipboard:=JEE_IFV2GetSortColumns(ifv2)
	;System.DateModified -1
	;System.DateModified 1
	;;if RegExMatch(JEE_IFV2GetSortColumns(ifv2),"System.DateModified ?:-1")
	;regexesllwork but not straightforward
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	;dont call it twice - maybe you wouldnt need to but im not seeing a superb way to avoid it below
	if InStr(curCol,"System.DateModified")
	{
		;test if it is ascending or descending and let's flip 'em
		If InStr(curCol,"-")
		{
			vList := "System.DateModified 1" ;Date modified ascending
		}
		;no alternate cases right?
		else {
			vList := "System.DateModified -1" ;Date modified descending
		}
	}
	;no alternate cases right?
	else {
		vList := "System.DateModified -1" ;Date modified descending should be default in my humble
	}
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

sortByDateDescending()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	;above must load up the complex structures with black magic
	;clipboard:=JEE_IFV2GetSortColumns(ifv2)
	;System.DateModified -1
	;System.DateModified 1
	;;if RegExMatch(JEE_IFV2GetSortColumns(ifv2),"System.DateModified ?:-1")
	;regexesllwork but not straightforward
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	;dont call it twice - maybe you wouldnt need to but im not seeing a superb way to avoid it below
	
	vList := "System.DateModified -1" ;Date modified descending 
	
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

sortByType()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	if InStr(curCol,"System.ItemTypeText")
	{
		If InStr(curCol,"-")
		{
			vList := "System.ItemTypeText 1" ;Ascending
		}
		else {
			vList := "System.ItemTypeText -1" ;Descending
		}
	}
	else {
		vList := "System.ItemTypeText -1" ;Ascending default
	}
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

sortBySize()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	if InStr(curCol,"System.Size")
	{
		If InStr(curCol,"-")
		{
			vList := "System.Size 1" ;Ascending
		}
		else {
			vList := "System.Size -1" ;Descending
		}
	}
	else {
		vList := "System.Size -1" ;Ascending default?  i may pick something else here in practice
	}
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

sortByName()
{
	WinGet, hWnd, ID, A
	oWin := JEE_ExpWinGetObj(hWnd)
	JEE_ExpGetInterfaces(oWin, isp, isb, isv, ifv2, icm)
	curCol:=JEE_IFV2GetSortColumns(ifv2)
	if InStr(curCol,"System.Name")
	{
		If InStr(curCol,"-")
		{
			vList := "System.Name 1" ;Ascending
			tooltip, ascending
		}
		else {
			vList := "System.Name -1" ;Descending
			tooltip, descending
		}
	}
	else {
		vList := "System.Name -1" ;Ascending default
		;tooltip, wahatever
	}
	JEE_IFV2SetSortColumns(ifv2, vList)
	isp := isb := isv := ifv2 := icm := ""
}

;========== I, TARAN, DID NOT WRITE THE ABOVE CODE ============

;;#IfWinActive
;*/

;;;EXPLORERSORT.AHK CODE IS ABOVE




;;------------------------------------------------------------------------------

; ;OBSOLETE - THESE NEVER WORKED VERY WELL
; sortExplorerByName(){
; IfWinActive, ahk_class CabinetWClass
	; {
	; ;Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
	; send {alt}vo{enter} ;sort by name
	; ;tippy2("sort Explorer by name")
	; }
; }

; sortExplorerByDate(){
; IfWinActive, ahk_class CabinetWClass
	; {
	; ;Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;expand name field
	; send {alt}vo{down}{enter} ;sort by date modified, but it functions as a toggle...
	; ;tippy2("sort Explorer by date")
	; }
; }
; ;ABOVE IS OBSOLETE - THESE NEVER WORKED VERY WELL


;;-------------------------------------------------------------------------

ExplorerViewChange_Window(explorerHwnd)
{
;https://autohotkey.com/boards/viewtopic.php?t=28304
	if (!explorerHwnd)
		return
	;msgbox,,, % explorerHwnd, 0.5
	Windows := ComObjCreate("Shell.Application").Windows
	for window in Windows
		if (window.hWnd == explorerHwnd)
			sFolder := window.Document
			
	;sFolder.ShellView := 1
	sFolder.CurrentViewMode := 4 ; Details
	;tooltip % sFolder.CurrentViewMode
	;sFolder.SORTCOLUMNS := PKEY_ItemNameDisplay, SORT_DESCENDING, bsssssss
}

; ;;;must look through that thread to find the direct "sort by name, sort by date" thingies.

; ExplorerViewChange_List(explorerHwnd)
; {
	; if (!explorerHwnd)
		; return
	; ;msgbox,,, % explorerHwnd, 0.5
	; Windows := ComObjCreate("Shell.Application").Windows
	; for window in Windows
		; if (window.hWnd == explorerHwnd)
			; sFolder := window.Document
	; if (sFolder.CurrentViewMode == 8)
		; sFolder.CurrentViewMode := 6 ; Tiles
	; else if (sFolder.CurrentViewMode == 6)
		; sFolder.CurrentViewMode := 4 ; Details
	; else if (sFolder.CurrentViewMode == 4)
		; sFolder.CurrentViewMode := 3 ; List
	; else if (sFolder.CurrentViewMode == 3) {
		; sFolder.CurrentViewMode := 2 ; Small icons
		; sFolder.IconSize := 16 ; Actually make the icons small...
	; } else if (sFolder.CurrentViewMode == 2) {
		; sFolder.CurrentViewMode := 1 ; Icons
		; sFolder.IconSize := 48 ; Medium icon size
	; } else if (sFolder.CurrentViewMode == 1) {
		; if (sFolder.IconSize == 256)
			; sFolder.CurrentViewMode := 8 ; Go back to content view
		; else if (sFolder.IconSize == 48)
			; sFolder.IconSize := 96 ; Large icons
		; else
			; sFolder.IconSize := 256 ; Extra large icons
	; }
	; ObjRelease(Windows)
	; tooltip % sFolder.CurrentViewMode
; }

;========== I, TARAN, DID NOT WRITE THIS CODE, but I do use it! ============

ExplorerViewChange_ICONS(explorerHwnd)
{

	if (!explorerHwnd)
	{
		tooltip, exiting.
		sleep 100
		return
	}
	;msgbox,,, % explorerHwnd, 0.5
	Windows := ComObjCreate("Shell.Application").Windows
	for window in Windows
		if (window.hWnd == explorerHwnd)
			sFolder := window.Document
	if (sFolder.CurrentViewMode >= 2) {
		sFolder.CurrentViewMode := 1 ; icons
		sFolder.IconSize := 256 ; make the icons big...
		;tooltip, large 1
	} else if (sFolder.CurrentViewMode == 1) {
		if (sFolder.IconSize == 48){
			sFolder.IconSize := 256
			;tooltip, large
			}
		else if (sFolder.IconSize == 256){
			sFolder.IconSize := 96
			;tooltip, you are now at medium icons
			}
		else if (sFolder.IconSize == 96) {
			sFolder.IconSize := 48 ; smallish icons
			;tooltip, you are now at smallish icons
			}
		else {
			sFolder.CurrentViewMode := 1
			sFolder.IconSize := 256
			;tooltip, reset
		}
	}
	;tooltip % sFolder.IconSize
	;tooltip, %explorerHwnd%
	;sleep 100
	;tooltip, % sFolder.CurrentViewMode
}





; ; ;testing the script here...
; ; #If (exphWnd := WinActive("ahk_class CabinetWClass"))
; ; ^+::
; ; ^=::
; ; tooltip, waaaaaaaaat
; ; ExplorerViewChange_Window(exphWnd)
; ; return
; ; #If



; Script to activate any given firefox tab...
;This requires the ACC library, which you have to install into AutoHotKey (it's pretty easy, just scroll to the top of this page and follow the instructions.)
;https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114
; calling the function looks like this: 
^!+numpad2::JEE_FirefoxFocusTabByName(hWnd, "Linus Media Group Inc. Mail")
;==================================================

; JEE_FirefoxGetTabCount(hWnd)
; {
; oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
; vRet := 0
; for each, oChild in Acc_Children(oAcc)
	; if (oChild.accName(0) == "Browser tabs")
	; {
		; oAcc := Acc_Children(oChild)[1], vRet := 1
		; break
	; }
; if !vRet
; {
	; oAcc := oChild := ""
	; return
; }

; vCount := 0
; for each, oChild in Acc_Children(oAcc)
	; if !(oChild.accName(0) == "")
		; vCount++
; oAcc := oChild := ""
; return vCount
; }

;==================================================

; JEE_FirefoxGetTabNames(hWnd, vSep="`n")
; {
; oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
; vRet := 0
; for each, oChild in Acc_Children(oAcc)
	; if (oChild.accName(0) == "Browser tabs")
	; {
		; oAcc := Acc_Children(oChild)[1], vRet := 1
		; break
	; }
; if !vRet
; {
	; oAcc := oChild := ""
	; return
; }

; vOutput := ""
; for each, oChild in Acc_Children(oAcc)
; {
	; vTabText := oChild.accName(0)
	; if !(vTabText == "")
	; ;&& !(vTabText == "New Tab")
	; ;&& !(vTabText == "Open a new tab")
		; vOutput .= vTabText vSep
; }
; vOutput := SubStr(vOutput, 1, -StrLen(vSep)) ;trim right
; oAcc := oChild := ""
; return vOutput
; }

;==================================================

#ifwinactive
; ^!+F12::
; tooltip, here we goooo
; Title := GetTitle("https://calendar.google.com/calendar/b/0/r")
; Title := GetTitle("https://www.google.com/")
; Title := GetTitle("https://www.autohotkey.com/")
; msgbox, title is %title%

; ;gotofiretab("Calendar - April 2019","https://calendar.google.com/calendar/b/0/r") 
; return


;===

GetTitle(URL) {
    WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WinHttp.Open("GET", URL, false)
    
    WinHttp.Send()
    
    RegexMatch(WinHttp.ResponseText, "<title>\K.*(?=<\/title>)", Title)
    return Title
}


gotofiretab(name,URL,alternativeName := "hgflasdkhsf")
{
;WinActivate ahk_exe firefox.exe ;I think this is unreilable because it only makes sure the applicaiton is RUNNING, not necessarily that it's ACTIVE.
WinActivate ahk_class MozillaWindowClass ;so i use the CLASS instead.
;tooltip, FIRETAB
sleep 15
WinGet, the_current_id, ID, A
vRet := JEE_FirefoxFocusTabByName(the_current_id, name, alternativeName)
;So if the tab's NAME is already open as one of Firefox's tabs, it'll simply switch to that tab. Unfortunately, we can't do this based upon  just the URL, which would be so much easier...
;The alternative name is for Gmail which sometimes flashes "Message from Nick Light" or whatever. It has to be nonsense text so it won't activate any other tab in cases where it's not needed.
;tooltip, vret is %vRet%
if (vRet = 0)
	run, firefox.exe %URL%
sleep 100
tooltip,
}

;
;==================================================



 
JEE_FirefoxFocusTabByName(hWnd, vTitle, vTitle2 := "hasfklskh", vNum:=1)
{
;TARAN NOTE: Using a tab NAME is somewhat unstable. Gmail for example will dynamically change the name to "Message from Nick Light" or whatever else. So really, I need to get the tab URL. will have to poke around ACC viewer to see where that information is...
; for future URL getting: https://autohotkey.com/boards/viewtopic.php?t=3702
; better: https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114


oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
vRet := 0
for each, oChild in Acc_Children(oAcc)
	if (oChild.accName(0) == "Browser tabs")
	{
		oAcc := Acc_Children(oChild)[1], vRet := 1
		break
	}
if !vRet
{
	oAcc := oChild := ""
	return
}

vCount := 0, vRet := 0
for each, oChild in Acc_Children(oAcc)
{
	vTabText := oChild.accName(0)
	; if (vTabText = vTitle)
		; vCount++
	If InStr(vTabText, vTitle) ;TARAN NOTE: I changed this line so that only a PARTIAL tab title match is required.
		vCount++
	If InStr(vTabText, vTitle2)
		vCount++
	if (vCount = vNum)
	{
		oChild.accDoDefaultAction(0), vRet := A_Index
		break
	}
}
oAcc := oChild := ""
return vRet
}
 
;==================================================




; JEE_FirefoxFocusTabByNum(hWnd, vNum)
; {


; oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
; vRet := 0
; for each, oChild in Acc_Children(oAcc)
	; if (oChild.accName(0) == "Browser tabs")
	; {
		; oAcc := Acc_Children(oChild)[1], vRet := 1
		; break
	; }
; if !vRet || !Acc_Children(oAcc)[vNum]
	; vNum := ""
; else
	; Acc_Children(oAcc)[vNum].accDoDefaultAction(0)
; oAcc := oChild := ""
; return vNum
; }


;==================================================
;==================================================
;==================================================
;==================================================
;==================================================








gotoChrometab(name,URL,alternativeName := "cwifhladirhs")
{
;;OKAY SO THIS CODE IS PRETTY GOOD, BUT it will (sometimes?!) return a vRet value of 0 if a tab is currently loading. it's bizzare. idk how to fix it.
;anyway, this code will basically open a tab of a given URL, unless it is already open, in which case, it'll switch to that tab.


;unfortunately, I cannot use the CLASS to activate Chrome, since so many other chrome-based applications use it.... so i am forced to use the .exe, which seems to be less reliable...

;WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe, Google Chrome, Microsoft Teams
;WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe, Google Chrome, Microsoft Teams
; WinActivate, ahk_exe chrome.exe, Google Chrome, Microsoft Teams
WinActivate, ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe,, Microsoft Teams ;the last one is explicitly telling it NOT to open Microsoft Teams.

;TOOLTIP, ARE YOU THERE
; MSGBOX, ARE YOU THERE

;FORTUNATELY, it looks like you can include the exe AND the class in the same line. nice. Not clear from the documentation.
; https://www.autohotkey.com/docs/commands/WinActivate.htm 

;tooltip, FIRETAB
sleep 15
WinGet, the_current_id, ID, A
; MsgBox the_current_id is %the_current_id%
; MsgBox % "The active window's ID is " . WinExist("A")

; vRet := JEE_FirefoxFocusTabByName(the_current_id, name, alternativeName)
vRet := JEE_ChromeFocusTabByName(the_current_id, name, , alternativeName)


;JEE_ChromeFocusTabByNum(hWnd, 3)

;So if the tab's NAME is already open as one of Chrome's tabs, it'll simply switch to that tab. Unfortunately, we can't do this based upon  just the URL, which would be so much easier...
;The "alternative name" is for Gmail's tab, which sometimes flashes "Nick Light says..." or whatever, if you use Hangouts, which I guess we don't anymore. Hmm. Anyway, it has to be nonsense text by default so it won't activate any other tab in cases where it's not needed.

tooltip, vret = %vRet%
;Tippy2(ultimately vret was %vRet%)
sleep 200
if (vRet = 0) ;if the tab you want has not ALREADY been opened,
	run, chrome.exe %URL% ;this is the line to actaully open the given URL.
sleep 100
tooltip,
}




;==================================================
;; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=294316#p294316 ;;


;;;;;;;THIS CODE IS OBSOLETE;;;;;;
; JEE_ChromeFocusTabByName(hWnd, vTitle, vNum:=1)
; {
	; oAcc := Acc_Get("Object", "4.1.2.2.2", 0, "ahk_id " hWnd)
	; vCount := 0, vRet := 0
	; for _, oChild in Acc_Children(oAcc)
	; {
		; vTabText := oChild.accName(0)
		; if (vTabText = vTitle)
			; vCount++
		; if (vCount = vNum)
		; {
			; oChild.accDoDefaultAction(0), vRet := A_Index
			; break
		; }
	; }
	; oAcc := oChild := ""
	; return vRet
; }
;;;;;;;THE ABOVE CODE IS OBSOLETE;;;;;;

JEE_ChromeFocusTabByName(hWnd:="", vTitle:="", vNum:="", vTitle2:="")
{

	local
	
	; tooltip, you are inside JEE_ChromeFocusTabByName
	; sleep 500
	
	
	static vAccPath := JEE_ChromeAccInit("T")
	if (hWnd = "")
		hWnd := WinExist("A")
	if (vNum = "")
		vNum := 1 ;this means, use the very first match you find.
	oAcc := Acc_Get("Object", vAccPath, 0, "ahk_id " hWnd)
	
	vCount := 0, vRet := 0
	for _, oChild in Acc_Children(oAcc)
	{
		vTabText := oChild.accName(0)
		;;; if (vTabText = vTitle)
			;;; vCount++
		If InStr(vTabText, vTitle) ;TARAN NOTE: I changed the above line so that only a PARTIAL tab title match is required.
			vCount++
		If InStr(vTabText, vTitle2) ;also i added the option for an alternative title
			vCount++
		;msgbox, vTabText is %vTabText% and vCount is %vCount%
		if (vCount = vNum)
		{
			oChild.accDoDefaultAction(0), vRet := A_Index
			break
		}
	}
	oAcc := oChild := ""
	
	; tooltip, hWnd = %hWnd%
	; sleep 1000
	; tooltip, vTitle = %vTitle%
	; sleep 1000
	; tooltip, vNum = %vNum%
	; sleep 1000
	
	return vRet
}

;=====THE CODE BELOW IS SUPPORT FOR THE CODE ABOVE==========

;note: these Acc paths often change:
;Acc paths determined via:
;[JEE_AccGetTextAll function]
;Acc: get text from all window/control elements - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=6&t=40615

JEE_ChromeAccInit(vValue)
{
	if (vValue = "U1")
		return "4.1.2.1.2.5.2" ;address bar
	if (vValue = "U2")
		return "4.1.2.2.2.5.2" ;address bar
	if (vValue = "T")
		return "4.1.2.1.1.1" ;tabs (append '.1' to get the first tab)
}


;==================================================

JEE_ChromeFocusTabByNum(hWnd:="", vNum:="")
{
	local
	static vAccPath := JEE_ChromeAccInit("T")
	if (hWnd = "")
		hWnd := WinExist("A")
	if !vNum
		return
	oAcc := Acc_Get("Object", vAccPath, 0, "ahk_id " hWnd)
	if !Acc_Children(oAcc)[vNum]
		vNum := ""
	else
		Acc_Children(oAcc)[vNum].accDoDefaultAction(0)
	oAcc := ""
	return vNum
}

;==================================================
;==================================================
;==================================================
;==================================================
;==================================================








;;;;;;;scripts from this guy;;;;;;;;;;;;;;;;
;https://github.com/asvas/AsVas_AutoHotkey_Scripts/blob/master/ahk_Scripts.ahk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;not CURRENTLY used anywhere...;;;;


; x::F_Switch("firefox.exe","ahk_class MozillaWindowClass","firefoxgroup","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
; +x::F_Run("firefox.exe","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
; c::F_Switch("chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup")
; +c::F_Run("chrome.exe")
;
; w::F_Switch("WINWORD.EXE","ahk_class OpusApp","wordgroup") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
; +w::F_Run("WINWORD.EXE") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")


;Function for hiding/Showing the intercept.exe window
F_Intercept_visibility()
{
IfWinActive ahk_exe intercept.exe
	WinHide ahk_exe intercept.exe
else
	WinShow ahk_exe intercept.exe
return
}

;---------------------------------------------------------------------------------
;Function for running intercept.exe
F_Intercept_run()
{
Run, intercept.exe
Sleep 250
WinActivate ahk_exe intercept.exe
send y
WinHide ahk_exe intercept.exe
return
}

;---------------------------------------------------------------------------------
;Run Function - Running specific executable
F_Run(Target,TPath = 0)
{
if TPath = 0 
	Run, %Target%
else
	Run, %TPath% ;Command for running target if conditions are satisfied
}

;-----------------------------------------------------------------
;Switch Function - Switching between different instances of the same executable or running it if missing
F_Switch(Target,TClass,TGroup,TPath = 0)
{
IfWinExist, ahk_exe %Target% ;Checking state of existence
	{
	GroupAdd, %TGroup%, %TClass% ;Definition of the group (grouping all instance of this class) (Not the perfect spot as make fo unnecessary reapeats of the command with every cycle, however the only easy option to keep the group up to date with the introduction of new instances)
	ifWinActive %TClass% ;Status check for active window if belong to the same instance of the "Target"
		{
		GroupActivate, %TGroup%, r ;If the condition is met cycle between targets belonging to the group
		}
	else
		WinActivate %TClass% ;you have to use WinActivatebottom if you didn't create a window group.
	}
else
	{
	if TPath = 0 
		Run, %Target%
	else
		Run, %TPath% ;Command for running target if conditions are satisfied
	}
Return
}
;;;;;;scripts from another guy END;;;;;;;;;



message(stuff){

msgbox, %stuff%


}











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;END OF FUNCTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; insert::

; return

;;; https://autohotkey.com/board/topic/34696-explorer-post-message-sort-by-modified-size-name-etc/
; pgup::
; tooltip, sort by name?
; PostMessage, 0x111, 30210,,, ahk_class CabinetWClass ; Name
; return

; pgdn::
; PostMessage, 0x111, 28715,,, ahk_class CabinetWClass ; List
; ;PostMessage, 0x111, 30213,,, ahk_class CabinetWClass ; Date modified
; return
