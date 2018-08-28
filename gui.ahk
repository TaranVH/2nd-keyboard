#NoEnv
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetWorkingDir C:\AHK\2nd-keyboard\2nd_keyboard_support_files
; the above is what the variable %A_WorkingDir% refers to.

;Menu, Tray, Icon, shell32.dll, 284
#SingleInstance force
SendMode Input ;needed for script that #includes this one
#MaxHotkeysPerInterval 2000 ;needed for script that #includes this one

;defining some variables below:
; Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
Menu, Tray, Icon, shell32.dll, 285 ; this changes the tray icon to a piece of paper

applicationname=SecondKeyboard
statusy = 1850
; statusy = 1700
statusx = 30
statusheight = 80
statusheight2 = 110
statuswidth=500
statuswidth2=700
font=Arial








;++++++++++++++++++++++++++++++++++++++++++++++
; GUI FOR KEYBOARD 1 COMMANDS
Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
Gui,Color,191919
Gui,Font,C00FFFF S27 W200 Q5, Arial
Gui,Add,Text,Vtextt,KEY GOES HERE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWW WWWWWWWWWWW
Gui,Font,c44FF55 S20 W990 norm, Arial
Gui,Add,Text,Vnamee,THE TYPE OF FUNCTIONand the SELECTION WWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWW WWWWWWWWWWW
Gui,Font,cEE6622 S20 W300 norm, Arial
Gui,Add,Text,Vkeyb,1st KEYBOARD IT BE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW WWWWWWWWWW WWWWWWWWWW

Winset, ExStyle, +0x20, %applicationname%
Gui +E0x20 +LastFound +ToolWindow +disabled

Gui,Show,X%statusx% Y%statusy% W%statuswidth% H%statusheight% noactivate ,%applicationname%

GuiControl,,textt, testing visualizer

;WinSet, Transparent, N ; SecondKeyboard
WinSet, Transparent, 255
WinSet, ExStyle, +0x00000020, ahk_id %hwnd%
WinSet, TransColor, 101010


;+++++++++++++++++++++++++++++++++++++++++++++++
; GUI FOR KEYBOARD 2 COMMANDS
Gui KB2: New
Gui KB2: +Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui KB2: Margin,0,0
Gui KB2: Color,000000
Gui KB2: Font,CFF0000 S15 W500 Q5, Franklin Gothic
Gui KB2: Add,Text,Vline1,gui 2 is HEEEERRRREEE WWWWWWWWWWWWWWWWWWWWWWW WWWWWW WWWW
Gui KB2: Font,CFFFF00 S20 W200 Q5, Arial
Gui KB2: Add,Text,Vline2,gui 2 line twwwwoooooo WWWWWWWWWWWWWW WWWWWWW WWWWWWWWWWW
Gui KB2: Font,CFF00FF S20 W200 Q5, Arial
Gui KB2: Add,Text,Vline3,gui 2 line 33333333333333333333 - WWWWWWWWW WWWWW WWWWWWW

Gui KB2: Show,X%statusx% Y%statusy% W%statuswidth2% H%statusheight2% noactivate ,%applicationname%

GuiControl,,line1, 2ND KEYBOARD
GuiControl,,line2, line 2 on gui 2
GuiControl,,line3, line 3 on gui 2

SetTimer,revealtimer,-2500
SetTimer,revealtimer2,-2500

; ; ; ;https://autohotkey.com/board/topic/18361-anyway-to-pass-params-to-script-while-running/page-2#entry534166
; ; ; ;
; ; ; gui, add, edit, w50 h20 vedit1_var gedit1_sub ;lines 1 and 2 create a hidden gui with an edit control.
; ; ; gui, show, hide, scriptcomwin_1
; ; ; return



#ifwinactive
; Save the following script as "Receiver.ahk" then launch it:
OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA
return

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
	
    ;ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
	Keyshower(CopyOfData,,2,-1500)
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}






Keyshower(parameter, functionused := "", alwaysshow := 0,howLong := -2000) ;very badass function that shows key presses and associated commands, both from the primary and secondary keyboards (keyboard 2 must be configured using intercept.exe!)
{
;msgbox,,, now in Keyshower so plz do`n%functionused% ---- %parameter%,1.51
;the "NA" is extremely important to allow this window to be VISIBLE but not interfere with anything.
;msgbox, %A_priorhotkey% %A_thishotkey%


if (A_priorhotkey = "F23" || A_priorhotkey = "~numpadleft" || A_priorhotkey = "~numpadright") ;please pretend that numpad left and right are not here....
	{
	;msgbox, this should be from the 2nd keyboard
	;this was sent from the 2nd keyboard, using interceptor. Interceptor presses F23, then the key, then releases the key, then releases F23. Very simple, but very effective.
	Gui, hide
	Gui, kb2: show, NA 
	
	;msgbox,,,what is hapening,1
	GuiControl kb2:,line1, %A_space%FROM 2ND KEYBOARD
	GuiControl kb2:,line2, %A_space%%A_thishotkey%
	GuiControl kb2:,line3, %A_space%%functionused%(`"%parameter%`")
	SetTimer,revealtimer2,%howLong%
	;msgbox, , , testing now, 1
	}
else if (A_priorhotkey = "F22")
	{
		Gui, kb2: show, NA 
		Gui, hide
		;msgbox,,,what is hapening,1
		GuiControl kb2:,line1, %A_space%FROM THIRD KEYBOARD
		GuiControl kb2:,line2, %A_space%%A_thishotkey%
		GuiControl kb2:,line3, %A_space%%functionused%(`"%parameter%`")
		SetTimer,revealtimer2,%howLong%
	}
else if (alwaysshow = 1)
	{
	
	;This space can be used for any keys that the normal visualizer does not notice. please ignore for now...
	Gui, show, NA 
	Gui, kb2: hide
	StringReplace, fixedHotkey, A_thishotkey, ^, ctrl%A_space%, All
	StringReplace, fixedHotkey, fixedHotkey, +, shift%A_space%, All
	StringReplace, fixedHotkey, fixedHotkey, !, alt%A_space%, All
	GuiControl,,textt, %A_space%%fixedHotkey% ;%A_priorhotkey%
	GuiControl,,namee, %functionused%(`"%parameter%`")
	GuiControl,,keyb, 
	;msgbox, it now should have happened using`n%functionused% --- %parameter%
	SetTimer,revealtimer,%howLong%
	}
else if (alwaysshow = 2)
	{
	
	;a "2" means that this was sent from the stream deck.
	Gui, show, NA 
	Gui, kb2: hide
	;StringReplace, parameter,parameter,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.
	GuiControl,,textt, Direct Launch
	GuiControl,,namee, %parameter%
	GuiControl,,keyb, 
	;msgbox,,,it now should have happened using`n%parameter%,1
	SetTimer,revealtimer,%howLong%
	}
else
	{
	;there is no "modifier" key or anything else associated. Therefore, this was a single keypress sent from the primary keyboard.
	;do nothing. This visualization is taken care of by keystroke viz.ahk
	}
}

revealtimer:
Gui, hide
return

revealtimer2:
Gui, kb2: hide
Return

#if

;++++++++++++++++++++++++GUI stuff end.+++++++++++++++++++++++++++++



#ifwinactive
; ; ; ;https://autohotkey.com/board/topic/18361-anyway-to-pass-params-to-script-while-running/page-2#entry534166
; ; ; ;
; ; ; edit1_sub: ;whenever the text in the edit control is changed this subroutine is launched.
 ; ; ; {
   ; ; ; gui, submit
   ; ; ; msgbox,,, i am about to implement %edit1_var%,1
   
   ; ; ; Keyshower(edit1_var,"hihi",1)
   ; ; ; ;loltaran(edit1_var)
   
   ; ; ; ;gosub, whatever
   ; ; ; ;gosub, Keyshower(%edit1_var%) ;this gosub launches a subroutine based on the number entered into the edit control.
   
   ; ; ; ;Func := Func("Keyshower")
	; ; ; ;	RetVal := Func.Call(%edit1_var%)
   
   ; ; ; ;gosub, %edit1_var%
 ; ; ; }
; ; ; return

; ; ; loltaran(lolvar){
; ; ; ;lolvar := """" . lolvar . """"
; ; ; msgbox, WTF made it to loltaran with %lolvar%


; ; ; }