#NoEnv
SendMode Input
;SetWorkingDir %A_ScriptDir%

;;the following script is from:
;If this code makes no sense, don't worry about it, and don't use it.
;This code is here for devices like the Stream Deck, that still need to communicate with my GUI, but without being tied down to any specific script or keyboard shortcut. (I have the stream deck configured with System:Open App/File, rather than using keyboard shortcuts to launch functions, because I am legitimately out of shortcuts to use. https://twitter.com/TaranVH/status/872869823864127488 )


;;https://www.autohotkey.com/docs/commands/OnMessage.htm
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle := "C:\AHK\2nd-keyboard\gui.ahk ahk_class AutoHotkey") ;ByRef saves a little memory in this case.
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
    TimeOutTime = 6000  ; Optional. Milliseconds to wait for response from receiver.ahk. Default is 5000
    ; Must use SendMessage not PostMessage.
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% ; 0x4a is WM_COPYDATA.
    tooltip, %errorlevel%
	DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}
