#NoEnv
;; Lines 4 and 5 (below) have already been run, in the original script (like Q.ahk) which #includes this one.
;;===================================================
;SetWorkingDir %A_ScriptDir%
;#Include %A_ScriptDir%/_REDIRECTOR_RAZER.ahk 
;;===================================================

;; Every single one of those small scripts is exactly the same except for their filename, which is very important, as it will be used in a function in Razer_macro_keyboard.ahk 

;; _REDIRECTOR_RAZER.ahk must always be in the same folder as all the smaller scripts that it is servicing.

;;EXACT LOCATION FOR WHERE TO PUT THIS SCRIPT:
; C:\AHK\2nd-keyboard\Razer\razer_direct_launch
;;(This is MANDATORY. It will not work otherwise.)

StringToSend = %A_Scriptname%
;; The above line is literally just writing the original script's filename to a variable. So, if it was Q.ahk that was launched, %StringToSend will be "Q.ahk"

result := Send_WM_COPYDATA(StringToSend)
;; The above line is what actually calls the Send_WM_COPYDATA function, which is defined below. Yeah. You can define functions even after an "Exitapp" command.

;; At this point, we are hoping to recieve "true" as our result. If it fails, we will recieve "fail".

if (result = 0)
	wasIgnored()

if (result = "fail")
	failtastic(stringtosend,result) ;I want to have as little code in these small scripts as possible. failtastic() is therefore defined inside of the _REDIRECTOR_RAZER.ahk script.

Exitapp
;; We are no longer in the autoexecute section of the script.


Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle := "C:\AHK\2nd-keyboard\Razer\Razer_macro_keyboard.ahk ahk_class AutoHotkey") ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
	VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
	;tooltip, %errorlevel%
    TimeOutTime = 5000  ; Optional. Milliseconds to wait for response from 2nd_keyboard_if_using_Razer.ahk. Default is 5000
    ; Must use SendMessage not PostMessage.
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% ; 0x4a is WM_COPYDATA.
	;tooltip, %errorlevel%
	;msgbox, errorlevel is %errorlevel%
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}

;; This is what happens when calling a function fails to work:
failtastic(stringtosend,result){
SoundBeep, 350, 200

msgbox, Tried to send `n%stringToSend%`nbut the result was:`n`n%result%`n`nIs the receiving script not running?`n`nAlternatively`, perhaps it was already running another script`, so it ignored THIS one`, which is EXACTLY what is supposed to happen. `n`nAlternatively`, perhaps it timed out`, because the script took longer than 5 seconds to execute`,possibly because you were looking at a messagebox.`n`nAlternatively`, something else may have gone wrong that I have not encountered. You'll have to figure it out. Sorry!`n`nOf course`, if you don't like this message box`, you can always just delete it. It is located inside of _REDIRECTOR_RAZER.ahk
}

;; This is what happens if 2nd_keyboard_if_using_Razer.ahk exists, but ignores the request.
wasIgnored(){
tooltip, I think you already have a function running`,`nso I'm not gonna run another one simultaneously!
SoundBeep, 750, 500
tooltip,
ExitApp

}
