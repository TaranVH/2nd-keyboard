#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
detecthiddenwindows, on

;;--------------------------------------------------------------------
;;;;;;SCRIPT THAT RECIEVES MESSAGES AND TURNS THEM INTO FUNCTIONS:;;;;
;;--------------------------------------------------------------------

;;Discussion:https://autohotkey.com/board/topic/18361-anyway-to-pass-params-to-script-while-running/

;;Where I got the script from:
; https://autohotkey.com/docs/commands/OnMessage.htm

#ifwinactive
OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA
return

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.

    ;msgbox, %A_ScriptName%`nReceived the following string:`n`n%CopyOfData%
	
	; So at this point, %CopyOfData% contains the following string:
	; coolFunction("from Q",0)
	
	; If only there was an easy way to use that string in such a way that the function is called... I believe this is known as dynamic code execution: https://www.autohotkey.com/docs/Functions.htm#dynamic or   https://autohotkey.com/board/topic/51532-execute-string-in-ahk/
	; But IDK how to get that working.	
	
	;#(%CopyOfData%) ;<--this doesn't work, but i guess it would if I used a mile of code from that thread I linked to. That ain't happening.
	
	;callIt := CopyOfData ;<--unfortunately, this also doesn't work, even if we start off with `%coolFunction`%("from Q",0) ... which means that I need to do it the hard way, which you will see below.
	;callIt = %CopyOfData% ;<- this don't work neither, dang it.
	
	;/*
	string = %CopyOfData%
	theFunctionName := SubStr(String, 1, InStr(string, "(") - 1) ;<-- This assumes that your function name is to the left of a "(" and I think that's a pretty fair assumption.
	
	parameter1 := SubStr(String, InStr(string, "(") + 1)
	parameter1 := SubStr(parameter1, 1, InStr(parameter1, ",") - 1) ;this and the preceeding line will extract the parameters, assuming you properly put them inside of ( ) parentheses!
	
	
	;Func.Call()
	
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

;;DEFINE YOUR FUNCTIONS BELOW HERE

coolFunction(param1,param2 := 2) ;<--Just in case you forgot a 2nd parameter, this means that it'll be a 2.
{
	msgbox, congrats! you made it to coolFunction`, with the parameters`n%param1%`nand`n%param2%
	bueno = "bueno"
	return bueno
}

anotherFunction(yeah,whatever)
{
msgbox, %yeah%`n%whatever%
sleep 10

}

^+s::
send ^s
reload

return

; Keyshower(f_path,"InstExplor")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(f_path,"InstExplor") 
; }




























