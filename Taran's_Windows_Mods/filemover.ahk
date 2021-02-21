#NoEnv 
Menu, Tray, Icon, shell32.dll, 156
;SetWorkingDir %A_ScriptDir%
#SingleInstance force ;only one instance of this script may run at a time!


;THIS SCRIPT IS REALLY COOL AND USEFUL

/*
Basically, we export to .mov cineform because by doing so, we're able to utilize smart rendering... using cineform previews that were already timeline rendered. This allows us to make one tiny change, then export again instantly, and not have to wait for the whole damn file to re-encode. The time it takes to "render" is just the time it takes to COPY the already existing cineform previews. (that exist as hundreds of smaller .mov files)

However, now that we have our entire video in one .mov file, it's too large to upload to YouTube. (It's 30-100 gigabytes!) That's why we have our server running a virtual machine, running windows, running a copy of media encoder, with several "watch folders" that will transcode any file placed into them, into a .mp4 according to our specifications. This .mp4 is what we upload onto YouTube. It's still huge, but much smaller. (3-10 gigabytes)

But dealing with these watch folders was annoying. I don't want to have to navigate to them every time I want to use them. So I wrote this script. In an Explorer window, if I have a file selected, and I hit one of the four shortcuts you see below, it will send the file to one of the four watch folders.

But! It's not that simple. What if that file had already been transcoded? I've just sent it again. That's more work for the server to do, for no reason. So, I've added coded that will CHECK to see if that file has already been moved over there.

But! It's not that simple either. Becuase Media Encoder will move source files over to a "source" folder, like this: Z:\Linus\1. Linus Tech Tips\Transcode\LTT Match Source\Source\1-4-2021 11-00-43 AM\Eve Spectrum Monitor - FP_1.mov

So I need to do a fancier search that will also check all SUB-directories... that is, it'll check all the folders inside of the folder that I already specified. And if the file is already found, then the script will just tell me about it, and won't send another file.

But! It's still not that simple! Because sometimes, someone has already deleted the .mov source file, as we should, because it takes up a lot of space and is no longer needed. That's fine... it's just that my script would think that the file hasn't been transcoded, because it's looking for a .mov file, and not a .mp4 file with the same name. But! the .mp4 files don't have the same name either! They have "___match 60-75.mp4" on the end, which we do to clarify that the source settings were matched, and it was encoded from 60,000 to 75,000 kbps.

So! Because that was happening more often, I've now modified the script so that it looks for a PARTIAL MATCH. I stripped away the ".mov" text, which also means that the "___match 60-75.mp4" gets ignored too, and the script can search all subdirectories for any file that contains the text "Eve Spectrum Monitor - FP_1" for example. But it WILL still deliberately ignore a file like "Eve Spectrum Monitor - YT_2" because that's not a complete match. I know I just said that it looks for a partial match... but uh, it's doing both? IDK how to explain this. The full string must be found, but it can have anything else before or after it. It's THAT kind of partial match. Yeah.

Anyway, this script was really annoying to write, but it's saved me so much faffing about with folders, and so much double checking to see if I sent a file to transcode or not, that it's absolutely been worth it. It's one of my greatest scripts. And you can use it too! If you can figure out how to modify it to suit your own purposes.
*/





#IfWinActive ahk_exe explorer.exe
^F9::Filemover("Z:\Linus\17. Short Circuit\SC Transcode\SC Match Source")
^F10::Filemover("Z:\Linus\2. Tech Linked\5. Transcode\TL Match Source")
^F11::Filemover("Z:\Linus\5. Fast As Possible\_FAP Transcoding\FAP Match Source")
;^F11::Filemover("Z:\Linus\5. Fast As Possible\_FAP Transcoding")
^F12::Filemover("Z:\Linus\1. Linus Tech Tips\Transcode\LTT Match Source")


;^F8::Filemover("C:\Users\Taran\Documents\move test again")

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


; ;;;;;;;;;;;;TESTING

; #ifwinactive ahk_class Notepad++
; F8::
; tooltip, F8

; leString := "qwertyuiop"

; answer := SubStr(leString, 1, -3)
; msgbox, answer is`n %answer% ;qwertyu

; answer := SubStr(leString, 1, 3)
; msgbox, answer is`n %answer% ;qwe

; answer := SubStr(leString, 0, 6)
; msgbox, answer is`n %answer% ;p

; answer := SubStr(leString, -1, -3)
; msgbox, answer is`n %answer% ;

; ; haystack := "this is a haystack"
; ; needle := "a"
; ; foundpos := InStr(haystack, needle) ;new code
; ; msgbox, foundpos is %foundpos%

; ; yellow := InStr("123abc789","abc")
; ; msgbox, yellow is %yellow%


; return

; #ifwinactive ahk_class Notepad++
; !s::
; tooltip, reload
; send ^s
; sleep 10
; Soundbeep, 900, 400
; reload
; return

; ;;;;;;;;;;;;/TESTING



; need to add this to it https://autohotkey.com/docs/commands/FileExist.htm
;;edit: I have.

;;trying to copy a file from one location to another, using the Windows progress bar.
;;holy crap, look at all these bullshit responses to such a simple request: https://autohotkey.com/board/topic/93904-copy-and-paste-large-files/
;All of them wrong, or misunderstanding the question.
;But I looked all over for better answers, and it turns out, you just need one stupid line. Thank you, Nimda!
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

;msgbox,,,Location is %publishLOC%,2


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

file2move := SubStr(file2move, 1, -4)
;this removes the last 4 characters (".mov) and outputs "smart access memory YT_1" as it should. I do this so that I can search for a partial match instead of a whole match. it would be better to remove all characters at and beyond the last "." but I don't wanna and I don't need to right now. Meow.


;msgbox, file2move = `n%file2move% `n`nfiletomovePATH =`n%filetomovePATH%


;https://www.autohotkey.com/docs/commands/LoopFile.htm the following code does work to list files in a given directory!

;msgbox, Location is `n%publishLOC%

LocationSlashPosition := InStr(publishLOC, "\" ,false,-1,1) ;first occurance from the right to the left.

;msgbox, LocationSlashPosition is `n%LocationSlashPosition%

LocationSlashPosition -- ;you gotta subtract 1 so that it also will trim the "\"

;msgbox, LocationSlashPosition is `n%LocationSlashPosition%

StringLeft, publishLOCshorter, publishLOC, %LocationSlashPosition%

;;;I HATE SUBSTR(), IT'S AWFUL TO USE AND CONFUSING, RAAAH! ;https://www.autohotkey.com/docs/commands/SubStr.htm
;;;publishLOCshorter2 := SubStr(publishLOC, 1, %LocationSlashPosition%)


;msgbox, Shortened location is `n%publishLOCshorter%
;example:
;Z:\Linus\5. Fast As Possible\_FAP Transcoding\

;IMPORTANT NOTE:
;If your target folder is EMPTY, then this script will not work! (?)
;IDK how to fix it. AHG!

FileList =  ; Initialize to be blank.
Loop, Files, %publishLOCshorter%\*.*, DFR
    FileList = %FileList%%A_LoopFileName%`n
Loop, Files, %publishLOCshorter%\*.*, DFR
    FileListLocations = %FileListLocations%%A_LoopFileFullPath%`n ;A_LoopFileDir -or- A_LoopFileFullPath

;if the location does not exist, both of these are blank.
;OR something else bizzare has happened, IDK what or how...

;msgbox, FileListLocations = `n%FileListLocations%
;msgbox, FileList = `n%FileList% ;this list doesn't also include the file paths. file names only.

counter = 0
nlines = 0
;settimer debug2, 20
;msgbox, launching debugger

sleep 20
Loop Parse, FileList, `n
  ++nlines
;;MsgBox, total lines here, or nlines: %nlines%

;msgbox, "file2move" is `n`n %file2move%



Loop, parse, FileList, `n
{
	; tooltip, counter = %counter%`nnlines = %nlines%, , , 10
    if A_LoopField =  ; Ignore the blank item at the end of the list.
        continue
	;MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    ;IfMsgBox, No
    ;    break
	
	;msgbox, "A_LoopField" is %A_LoopField%
	
	;If A_LoopField = %file2move% ;;;this is the old code
    foundpos := InStr(A_LoopField, file2move) ;new code. 
    ;msgbox, "foundpos" is %foundpos%
	if foundpos > 0
	{
        Fileposition = %A_Index%
        Loop, parse, FileListLocations, `n
            if A_index = %Fileposition%
                existingfile = %A_LoopField%
        
		;;msgbox, existingfile = %existingfile%

        ;A match has been found in this folder system, meaning the file was ALREADY moved over here before!
        ;msgbox, 1, ,%A_LoopField%`n`nis already present at`n`n%existingfile%`n`n...Want to see?
        msgbox, 1, ,''%file2move%''`n`nis already present at`n`n%existingfile%`n`n...Want to see?
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


/*
*/


if FileNotPresent = 1
{
	;msgbox, 3 , ,%filetomovePATH%`n`nIS NOT PRESENT AT OR ABOVE `n`n%publishLOC%`n`n...would you like to move it there?
	msgbox, 3 , ,''%file2move%''`n`nIS NOT PRESENT AT OR ABOVE `n`n%publishLOC%`n`n...would you like to move it there?
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