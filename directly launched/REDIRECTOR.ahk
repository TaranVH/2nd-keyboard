#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\All Premiere Functions.ahk

;rather than pointing ALL the scripts directly to this file, I'm pointing them all to this redirect file, which in turn points to the final desintation. In this way, as long as you have REDIRECTOR.ahk in the same folder as the other scripts, you only have to change this one single address.



;;the following script is from:
;;https://www.autohotkey.com/docs/commands/OnMessage.htm
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle := "C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\gui.ahk ahk_class AutoHotkey") ;ByRef saves a little memory in this case.
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
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}

