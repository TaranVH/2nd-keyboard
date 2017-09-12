#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\point_to_gui.ahk
;#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\filemover.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#WinActivateForce

global savedCLASS = "ahk_class Notepad++"
global savedEXE = "notepad++.exe"


;%A_ScriptDir%\Lib\  ; Local library - requires v1.0.90+.
;%A_MyDocuments%\AutoHotkey\Lib\  ; User library.
;path-to-the-currently-running-AutoHotkey.exe\Lib\  ; Standard library.
;C:\Users\TaranVanHemert\AppData\Local\GitHub\TutorialRepository_a66c3719071da6d865a984bb8d6bfb5bcd775ec8\new-repo\Taran's Windows Mods\WINDOWS MOD - Various functions.ahk\Lib\

Menu, Tray, Icon, shell32.dll, 16 ;this changes the icon into a little laptop thingy. just useful for making it distinct from the others.


GroupAdd, ExplorerGroup, ahk_class #32770 ;This is for all the Explorer-based "save" and "load" boxes, from any program!


;lololol I have to have tippy(), but i can't redefine an existing function, so I either have to put it in another .ahk script and #include it, or I could go the lazy route and just add a "2" to the end of ALL of them in this file, because I am a such a bad spaghetti coder that I don't even know what that means.
Tippy2(tipsHere, wait:=333)
{
ToolTip, %tipsHere% TP,,,8
SetTimer, notip2, %wait% ;--in 1/3 seconds by default, remove the tooltip
}
notip2:
	ToolTip,,,,8
	;removes the tooltip
return


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


;this is where filemover() used to be. I moved it to its own script, since using it would prevent all other scripts from running, until the file was completely moved.

#IfWinActive



saveLocation2(){
f_text = 0
SetTitleMatchMode Slow
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
;;msgbox,,,%f_class%, 1
if f_class in ExploreWClass,CabinetWClass ; if the window class is an Explorer window of either kind.
	{
	; WinGetTitle, Title, ahk_class CabinetWClass
	WinGetTitle, title, ahk_id %f_window_id% ;super lame way to do this, does not always work.
	;msgbox, address is `n%title%

	FileDelete, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	FileAppend, %title% , C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	SavedExplorerAddress = %title%
	msgbox, , , %title%`n`nwas saved as root, 1
	}
else
	msgbox,,, this is not an explorer window you chump,1
}
;for further reading:
;https://autohotkey.com/board/topic/60985-get-paths-of-selected-items-in-an-explorer-window/
;end of savelocation2()




;;;; SCRIPT TO ALWAYS OPEN THE MOST RECENTLY SAVED OR AUTOSAVED FILE OF A GIVEN FILETYPE, IN ANY GIVEN FOLDER (AND ALL SUBFOLDERS.);;;;
;;script partially obtained from https://autohotkey.com/board/topic/57475-open-most-recent-file-date-created-in-a-folder/
openlatestfile(directory, filetype)
{
if directory = 1
	{
	FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
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
runexplorer(foo)
{
send {SC0E8} ;scan code of an unassigned key ;;sending even a single keystroke from the secondary keyboard will prevents the taskbar icon from sometimes flashing pointlessly rather than opening.
sleep 5
Run, % foo
sleep 10
;Send,{LCtrl down}{NumpadAdd}{LCtrl up} ;windows shortcut to resize name feild to fit.
;alt v o down enter will sort by date modified, but it is stupid...

if IsFunc("Keyshower")
	{
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







; #ifwinactive
; F7::
	; Send ^s
	; sleep 200
    ; SoundBeep, 1100, 500
	; Reload  ;The only thing you need here is the Reload
; Return






;BEGIN INSTANT APPLICATION SWITCHER SCRIPTS;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#IfWinActive



windowSaver()
{
WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window
global savedCLASS = "ahk_class "lolclass
global savedEXE = lolexe ;is this the way to do it? IDK.
}

;SHIFT + macro key G14




switchToSavedApp(savedCLASS)
{
;msgbox, savedCLASS is %savedCLASS%
if savedCLASS = ahk_class Notepad++
	{
	;msgbox, is notepad++
	if WinActive("ahk_class Notepad++")
		{
		sleep 5
		Send ^{tab}
		}
	}
;msgbox,,,got to here,0.5
windowSwitcher(savedCLASS, savedEXE)
}




;BEGIN savage-folder-navigation CODE!
;I got MOST of this code from https://autohotkey.com/docs/scripts/FavoriteFolders.htm
;and modified it to work with any given keypress, rather than middle mouse click as it had before.

InstantExplorer(f_path,pleasePrepend := 0)
{
send {SC0E8} ;scan code of an unassigned key. This is needed to prevent the item from merely FLASHING on the task bar, rather than opening the folder. Don't ask me why, but this works.
if pleasePrepend = 1
	{
	FileRead, SavedExplorerAddress, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Taran's Windows Mods\SavedExplorerAddress.txt
	;msgbox, current f_path is %f_path%
	f_path = %SavedExplorerAddress%\%f_path% ;no need to use . to concatenate
	;msgbox, new f_path is %f_path%
	}
;for Keyshower, put code here to find the first / and remove the string before it. otherwise you can't see the final folder name
;Keyshower(f_path,"InstExplor")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(f_path,"InstExplor") 
}
f_path := """" . f_path . """" ;this adds quotation marks around everything so that it works as a string, not a variable.
;msgbox, f_path is now finally %f_path%
;SoundBeep, 900, 400
; These first few variables are set here and used by f_OpenFavorite:
WinGet, f_window_id, ID, A
WinGetClass, f_class, ahk_id %f_window_id%
if f_class in #32770,ExploreWClass,CabinetWClass  ; if the window class is a save/load dialog, or an Explorer window of either kind.
	ControlGetPos, f_Edit1Pos, f_Edit1PosY,,, Edit1, ahk_id %f_window_id%

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

; msgbox, A_ThisMenuItemPos %A_ThisMenuItemPos%
; msgbox, A_ThisMenuItem %A_ThisMenuItem%
; msgbox, A_ThisMenu %A_ThisMenu%

;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
; msgbox, f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; f_OpenFavorite:
;msgbox, BEFORE:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%

; Fetch the array element that corresponds to the selected menu item:
;;StringTrimLeft, f_path, f_path%A_ThisMenuItemPos%, 0
if f_path =
	return
if f_class = #32770    ; It's a dialog.
{
	if f_Edit1Pos <>   ; And it has an Edit1 control.
	{
		; IF window Title is NOT "export settings," with the exe "premiere pro.exe"
			;go to the end or do something else, since you are in Premiere's export media dialouge box... which has the same #23770 classNN for some reason...
		

		ControlFocus, Edit1, ahk_id %f_window_id% ;this is really important.... it doesn't work if you don't do this...
		tippy2("DIALOUGE WITH EDIT1`n`nLE controlfocus of edit1 for f_window_id was just engaged.", 1000)
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
		ControlSetText, Edit1, %f_path%, ahk_id %f_window_id%
		ControlSend, Edit1, {Enter}, ahk_id %f_window_id%
		Sleep, 100  ; It needs extra time on some dialogs or in some cases.
		ControlSetText, Edit1, %f_text%, ahk_id %f_window_id%
		;msgbox, AFTER:`n f_path: %f_path%`n f_class:  %f_class%`n f_Edit1Pos:  %f_Edit1Pos%
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

; Since the above didn't return, one of the following is true:
; 1) It's an unsupported window type but f_AlwaysShowMenu is y (yes).
; 2) It's a supported type but it lacks an Edit1 control to facilitate the custom
;    action, so instead do the default action below.
Tippy2("end was reached.",333)
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
}
;end of instantexplorer()











back(){
if WinActive("ahk_class MozillaWindowClass")
	Send ^+{tab}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_class Notepad++")
	Send ^+{tab}
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	Send {F12} ;F12 is my shortcut in premiere for "go back"(in bins)
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
}

;macro key 16 on my logitech G15 keyboard. It will activate firefox,, and if firefox is already activated, it will go to the next window in firefox.

switchToFirefox(){
send {SC0E8} ;scan code of an unassigned key
IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_exe firefox.exe")
	Send ^{tab}
else
	{
	;WinRestore ahk_exe firefox.exe
	WinActivate ahk_exe firefox.exe
	;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
	;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
	}
}


#IfWinActive
;Press SHIFT and macro key 16, and it'll switch between different WINDOWS of firefox.

switchToOtherFirefoxWindow(){
send {SC0E8} ;scan code of an unassigned key
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
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
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
}


switchToPremiere(){
IfWinNotExist, ahk_class Premiere Pro
	{
	;Run, Adobe Premiere Pro.exe
	;Adobe Premiere Pro CC 2017
	Run, C:\Program Files\Adobe\Adobe Premiere Pro CC 2017\Adobe Premiere Pro.exe
	}
if WinActive("ahk_class Premiere Pro")
	{
	WinActivate ahk_exe notepad++.exe
	;msgbox,,,lol,0.1
	WinActivate ahk_class Premiere Pro
	}
else
	WinActivate ahk_class Premiere Pro
}


switchToWord()
{
Process, Exist, WINWORD.EXE
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		Run, WINWORD.EXE
	else
	{
	GroupAdd, taranwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, taranwords, r
	else
		WinActivate ahk_class OpusApp
	}
}




switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

if WinActive("ahk_exe chrome.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe chrome.exe
}


; #IfWinActive
; ^F6::
; IfWinNotExist, ahk_class Notepad++
	; Run, notepad++.exe
; if WinActive("ahk_class Notepad++")
	; Send ^{tab}
; WinActivate ahk_class Notepad++

; return


#IfWinActive
windowSwitcher(theClass, theEXE)
{
;msgbox,,, switching to `nsavedCLASS = %theClass% `nsavedEXE = %theEXE%, 0.5
IfWinNotExist, %theClass%
	Run, % theEXE
if not WinActive(theClass)
	WinActivate %theClass%
}

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

;---------------------------------------------------------------------------------
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;END OF FUNCTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
