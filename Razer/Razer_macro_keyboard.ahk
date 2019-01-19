#NoEnv
SendMode Input
#InstallKeybdHook
;#InstallMouseHook
#UseHook On

;;EXACT LOCATION FOR WHERE TO PUT THIS SCRIPT:
; C:\AHK\2nd-keyboard\Razer\
;;(This is MANDATORY)

;;Location for where to put a shortcut to this script, so that it will start with Windows:
;;  Here for just yourself:
;;  C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
;;  Or here for all users:
;;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
detecthiddenwindows, on
Menu, Tray, Icon, shell32.dll, 42 ;turns the tray icon into a dumb green tree. If you don't like it, choose another: https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/system32-shell32_dll.png
;;#NoTrayIcon ;If you don't want a tray icon, comment this in. Not recommmended! You won't know if it's running or not.

;________________________________________________________________________________________
;                                                                                        
;		  2ND KEYBOARD USING Razer Synapse (and the Cyonosa Chroma, specifially)		 
;________________________________________________________________________________________
;																						 
;     Please watch [link not yet available] for a comprehensive tutorial. 		 		 
;________________________________________________________________________________________

;; You should DEFINITELY not be trying to add a 2nd keyboard unless you're already
;; familiar with how AutoHotkey works. I recommend that you at least take this tutorial:
;; https://autohotkey.com/docs/Tutorial.htm

;; You should probably use something better than Notepad for your scripting. I use Notepad++. 


;;----------------------------------------------------------------------------
;;;;;;Receive_WM_COPYDATA RECIEVES MESSAGES AND TURNS THEM INTO FUNCTIONS:;;;;
;;----------------------------------------------------------------------------
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

Var = %CopyOfData%
StringTrimRight, Var, Var, 4  ;Removes .ahk from the string
;;OutputVar := SubStr(String, 1, InStr(string, ".") - 1) ;<-- This grabs whatever text is to the left of a period. This is just an alternative way of removing ".ahk" ...Whatever.

;AHK does not have a SWITCH case. So this is what we do instead:
; https://jacksautohotkeyblog.wordpress.com/2018/11/02/use-the-ternary-operator-to-create-conditional-case-statements-or-switches-autohotkey-tip/#more-40047
DoSomething := Var = "ESC" ? function("Escape!")
	: Var = "F1" ?			function("F1")
	: Var = "F2" ?			function("F2")
	: Var = "F3" ?			function("F3")
	: Var = "F4" ?			function("F4")
	: Var = "F5" ?			function("F5")
	: Var = "F6" ?			function("F6")
	: Var = "F7" ?			function("F7")
	: Var = "F8" ?			function("F8")
	: Var = "F9" ?			function("F9")
	: Var = "F10" ?			function("F10")
	: Var = "F11" ?			function("F11")
	: Var = "F12" ?			function("F12")
	: Var = "tilde" ? 		function("tilde or whatever")
	: Var = "1" ? 			function("1")
	: Var = "2" ? 			function("2")
	: Var = "3" ? 			function("3")
	: Var = "4" ?			function("4")
	: Var = "5" ? 			function("5")
	: Var = "6" ? 			function("6")
	: Var = "7" ? 			function("7")
	: Var = "8" ? 			function("8")
	: Var = "9" ? 			function("9")
	: Var = "0" ? 			function("0")
	: Var = "minus" ? 		function("_-")
	: Var = "plus" ? 		function("+=")
	: Var = "backspace" ? 	function("backspaaaaace")
	: Var = "tab" ? 		function("2")
	: Var = "q" ?			function("q")
	: Var = "w" ? 			function("w")
	: Var = "e" ? 			function("e")
	: Var = "r" ?			function("r")
	: Var = "t" ?			function("t")
	: Var = "y" ?			function("y")
	: Var = "u" ?			function("u")
	: Var = "i" ?			function("i")
	: Var = "o" ?			function("o")
	: Var = "p" ?			function("p")
	: Var = "leftbracket" ? function("]")
	: Var = "rightbracket" ?function("[")
	: Var = "backslash" ?	function("backslash")
	: Var = "capslock" ?	function("caps")
	: Var = "a" ?			function("aaaay")
	: Var = "s" ?			function("s")
	: Var = "d" ?			function("d")
	: Var = "f" ?			function("f")
	: Var = "g" ?			function("g")
	: Var = "h" ?			function("h")
	: Var = "j" ?			function("j")

;;Our expression gets too long if we continue.
;; https://autohotkey.com/board/topic/70201-ahk-110200-u32-error-expression-too-long/
;;So I had to divide this into two blocks. Lol.
DoSomethingElse := Var = "k" ? function("k")
	: Var = "l" ?			function("l")
	: Var = "semicolon" ?	function(";")
	: Var = "singlequote" ?	function("'")
	: Var = "enter" ?		function("enter")
	: Var = "LShift" ?		function("Left Shift")
	: Var = "z" ?			function("z")
	: Var = "x" ?			function("x")
	: Var = "c" ?			function("c")
	: Var = "v" ?			function("v")
	: Var = "b" ?			function("b")
	: Var = "n" ?			function("n")
	: Var = "m" ?			function("m")
	: Var = "comma" ?		function(",")
	: Var = "period" ?		function(".")
	: Var = "forwardslash" ?function("/")
	: Var = "RShift" ?		function("RShift")
	: Var = "RCtrl" ?		function("Rctrl")
	: Var = "RWin" ?		function("Rwin") ;this key does not exist on a razer keyboard
	: Var = "RAlt" ?		function("Ralt")
	: Var = "space" ?		function("le space")
	: Var = "Lalt" ?		function("LAlt")
	: Var = "LWin" ?		function("LWin") ;This key can't be remapped in Razer Synapse
	: Var = "appskey" ?		function("appskey can be annoying")
	: Var = "RCtrl" ?		function("RCtrl")
	: Var = "printscreen" ?	function("PrtScn")
	: Var = "scrollLock" ?	function("more like LOL lock")
	: Var = "pauseBreak" ?	function("the worst key")
	: Var = "insert" ?		function("insert")
	: Var = "delete" ?		function("delete")
	: Var = "home" ?		function("home")
	: Var = "end" ?			function("end")
	: Var = "pageup" ?		function("pgup")
	: Var = "pagedown" ?	function("pgdn")
	: Var = "up" ?			function("up")
	: Var = "down" ?		function("down")
	: Var = "left" ?		function("port")
	: Var = "right" ?		function("starboard")
	: Var = "NumLock" ?		function("Numlock is awful")
	: Var = "numpaddDiv" ?	function("numpadDiv")
	: Var = "numpadMult" ?	function("numpadMult")
	: Var = "numpadMinus" ?	function("numpad-")
	: Var = "numpadAdd" ?	function("numpad+")
	: Var = "numpadEnter" ?	function("numpadEnter")
	: Var = "numpadDot" ?	function("numpad dot or delete or whatever")
	: Var = "numpad0" ?		function("numpad0")
	: Var = "numpad1" ?		function("numpad1")
	: Var = "numpad2" ?		function("numpad2")
	: Var = "numpad3" ?		function("numpad3")
	: Var = "numpad4" ?		function("numpad4")
	: Var = "numpad5" ?		function("numpad5")
	: Var = "numpad6" ?		function("numpad6")
	: Var = "numpad7" ?		function("numpad7")
	: Var = "numpad8" ?		function("numpad8")
	: Var = "numpad9" ?		whateverrr("this happens when you press numpad9","and this too")
	;;: Else nope(Var) ;This won't work properly now that it's split in half.
	
	
;Now we are at the end.
return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}


;;#############################################################################
;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;~~~~~~~~~~~~~~~~~DEFINE YOUR FUNCTIONS BELOW THIS LINE~~~~~~~~~~~~~~~~~~~~~~~
;;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;#############################################################################



function(par){
if WinActive("ahk_exe Adobe Premiere Pro.exe")
	msgbox, You pressed %par% on your Razer keyboard while inside of Premiere Pro! ;Because of how we had to call our functions, this must be done instead of the traditional #ifwinactive
else
	{
	msgbox, Horray, you pressed`n%par%`n on your Razer keyboard!
	
	}
}

whateverrr(stuff, things){

msgbox, %stuff%`nand`n%things%

}

nope(var)
{
msgbox, you have not assigned `n%var%`nto anything
}


; ^+s::
; send ^s
; reload
; return





























