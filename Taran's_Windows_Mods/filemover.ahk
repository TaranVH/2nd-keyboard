#NoEnv 
Menu, Tray, Icon, shell32.dll, 156
;SetWorkingDir %A_ScriptDir%
#SingleInstance force ;only one instance of this script may run at a time!

#IfWinActive ahk_exe explorer.exe
^F10::Filemover("Z:\Linus\2. Tech Linked\5. Transcode\TL Match Source")
^F11::Filemover("Z:\Linus\5. Fast As Possible\_FAP Transcoding\FAP Match Source")
^F12::Filemover("Z:\Linus\1. Linus Tech Tips\Transcode\LTT Match Source")

; ^+F11::Filemover("Z:\Linus\5. Fast As Possible\_FAP Transcoding\FAP 1920 x 1080")
; ^+F12::Filemover("Z:\Linus\5. Fast As Possible\_FAP Transcoding\FAP Match Source")
; ^!+F11::Filemover("Z:\Linus\2. Tech Linked\5. Transcode\TL 1920 x 1080")
; ^!+F12::Filemover("Z:\Linus\2. Tech Linked\5. Transcode\TL Match Source")

; ^F10::
; tooltip, nimdamover activated
; sleep 300
; tooltip,
; nimdaMOVER("Z:\Linus\1. Linus Tech Tips\")
; return
; #IfWinActive

; need to add this to it https://autohotkey.com/docs/commands/FileExist.htm


;;trying to copy a file from one location to another, using the Windows progress bar.
;;holy crap, look at all these bullshit responses to such a simple request: https://autohotkey.com/board/topic/93904-copy-and-paste-large-files/
;All of them wrong, or misunderstanding the question.
;But I look all over for better answers, and it turns out, you just need one stupid line. Thank you, Nimda!
;; //autohotkey.com/board/topic/78604-real-progress-indication-of-files-copy/?p=499248
nimdaMOVER(publishLOC) {
filetomovePATH := Explorer_GetSelection()
return ComObjCreate("Shell.Application").Namespace(publishLOC).CopyHere(filetomovePATH)
;return ComObjCreate("Shell.Application").Namespace(publishLOC).CopyHere(filetomovePATH "\*") ;I don't know what the "\*" is for...
;This is just a test function, I don;t actually use it.
}

;;;;FILE MOVER TO TRANSCODE FOLDERS
; YTpublish = "Z:\Linus\1. Linus Tech Tips\Transcode\YT Publish 4K\"
; VESpublish = "Z:\Linus\1. Linus Tech Tips\Transcode\Vessel Final 4K\"

;I did not write the code below, I forget where I got it from. Will look into it.
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
	;msgbox, %ToReturn% is ToReturn
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
FileMover(publishLOC){
;msgbox,,,filemover,1


;https://www.autohotkey.com/docs/misc/Threads.htm
;IDK how this realy works, but i want this to be able to run in the backgrond while I use the rest of the script normally.
;More ideal would be to have it totally on its own...
;someone mentioned this...? https://www.google.ca/search?q=use+the+AutoHotkey.dll+to+run+a+separate+thread&ie=utf-8&oe=utf-8&gws_rd=cr&ei=I2VyWfj4Neqd0gLR2pOQBA



;filetomovePATH := Explorer_GetSelection() ;NOTE: does not work from the desktop for some stupid reason...
;;msgbox, you want to move this file to`n%publishLOC%
;tooltip, Filemover Activated, , , 3
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

;msgbox, file2move = `n%file2move% `n`nfiletomovePATH =`n%filetomovePATH%

;https://www.autohotkey.com/docs/commands/LoopFile.htm the following code does work to list files in a given directory!
FileList =  ; Initialize to be blank.
Loop, Files, %publishLOC%\*.*, DFR
    FileList = %FileList%%A_LoopFileName%`n
Loop, Files, %publishLOC%\*.*, DFR
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
            Goto, theEnd_FM
        }
        IfMsgBox, Cancel
            Goto, theEnd_FM
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
	msgbox, 3 , ,%filetomovePATH%`nIS NOT PRESENT AT OR ABOVE `n%publishLOC%`n...would you like to move it there?
	IfMsgBox, Yes
	{
		;return 
		ComObjCreate("Shell.Application").Namespace(publishLOC).CopyHere(filetomovePATH)
		;FileCopy,%filetomovePATH%,%publishLOC% ;;this was the old code that does NOT give you a nice windows GUI thingy telling you the status.
		
		;Run %COMSPEC% /c explorer.exe /select`, "%publishLOC%%file2move%",, Hide
		;;Msgbox, did that work?
		FileNotPresent = 0
	}
}
Goto, theEnd_FM
theEnd_FM:

;SetTimer, tooltipper, off
sleep 10
; tooltip, , , , 9
tooltip, , , , 3
; tooltip,
;;msgbox, you are at the VERY end
}
;end of file mover.