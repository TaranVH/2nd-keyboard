SetWorkingDir, C:\AHK\2nd-keyboard\support_files
;the above will supposedly set A_WorkingDir. It MUST be done in the autoexecute area, BEFORE the code below.
;SetWorkingDir, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files

#NoEnv
Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

;-------------------------------------------------------------------------
; HELLO PEOPLES!
; IF YOU ARE NEW TO AUTOHOTKEY, YOU MUST AT LEAST TAKE THE FOLLOWING TUTORIAL:
; https://autohotkey.com/docs/Tutorial.htm
;
; You will need to know some basic scripting to custom tailor most
; of these scripts to your own machine, if you want to use them!
;
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
;
; VERY IMPORTANT NOTE:
; This file works in tandem with ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; That script has this one 
; All the functions from HERE are actually CALLED from keyboard shortcuts
; in THAT script. I had to do it this way because of the Stream Deck(s)...
; But you can put your key bindings and functions in the same script if
; you want.
;
; You also need to read from around line 90 of ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; to see which keybaord shortcut assignements are necessary to make these scripts work.
;
; I recommend that you only copy the functions that you need.
; Add one at a time or it will be overwhelming!
;
; All the code in my github repo is free for you to use and change as you please.
; Just don't try to sell it, and we cool.
;------------------------------------------------------------------------


;the variable below POSSIBLY exists for the purpose of communicaiton with gui.ahk if a script is launched from the Stream Deck.
TargetScriptTitle = "C:\AHK\2nd-keyboard\gui.ahk ahk_class AutoHotkey"
;but apparently I do not know for sure...

recallTransition(foo) ;this was a part of the luamacros scripts.
{
;Do nothing.
msgbox, the recallTransition function was deleted cause it never worked very well. %foo%
}

;;;;;;non luamacros stuff begins now.;;;;;

;;;;;;temporary tooltip maker;;;;;;
Tippy(tipsHere, wait:=-333)
{
ToolTip, %tipsHere% TIP,,,8
SetTimer, noTip, %wait% ;--in 1/3 seconds by default, remove the tooltip
;return
}

;um I am trying this because i think the tooltip was being deleted like every bazillionth of a second?
noTip:
ToolTip,,,,8 ;removes the tooltip
SetTimer, noTip, Off
;I REALLY need to figure out how subroutines work...
return ;hoey sit, i didn't have a return here for a long time

;;;;;;/temporary tooltip maker;;;;;;


#IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! (until canceled with a lone "#IfWinActive")
;however, that only applies to stuff like hotkey definitions. I'm pretty sure that functions can be defined anywhere.


monitorKeys(whichMonitor,shortcut,useSpace := 1)
{
;this function has proven to be shockingly robust.
keywait, %A_priorhotkey% ;hopefully that doesn't break it.
;msgbox,,, useSpace is %useSpace%,1
if WinActive("ahk_exe Adobe Premiere Pro.exe") ;AHA, it is better to use the EXE, because if you are in a secondary monitor window, then the CLASS is not active even though the EXE still is, mildly interesssstting.
{

;IDK if I need to set a coordmode here?
; coordmode, pixel, Window
; coordmode, mouse, Window
; coordmode, Caret, Window

if (whichMonitor = "source")
	{
	x := "1800"
	y := "500"
	;;tooltip, source here
	;coordinates that are very likely to be within my Source Monitor's usual area
	}
else
	{
	x := "3300"
	y := "500"
	;;tooltip, program here
	whichMonitor = "program" ;just in case it was not defined properly, it becomes "program" by default.
	;coordinates that are very likely to be within my Program Monitor's usual area
	}
; tooltip, x y is %x% %y%
; sleep, 500



;testing some sheeit
x := "1800"
y := "500"

ActiveHwnd := WinExist("A")
windowWidth := CoordGetControl(x,y, ActiveHwnd)

; tooltip, ActiveHwnd is %ActiveHwnd%
; sleep, 500
; tooltip, windowWidth is %windowWidth%
; sleep, 500


if (windowWidth < 2000) ;this means that the monitor is NOT maximized
	{
	;tooltip, windowwidth is less than 2000
	; sleep 500
	if (whichMonitor = "source"){
		prFocus("source") ;keep in mind, this FIRST brings focus to the Effects panel
		;tooltip, u in SOURCE LAND
		; sleep 500
		}
	else
		{
		prFocus("program") ;keep in mind, this FIRST brings focus to the Effects panel
		;tooltip, u in program LAND
		}
	sleep 20
	}

sleep 30 ;sometimes these shortcuts don't "take" without a bit of delay.
sendinput, %shortcut%
;so, the above would be translated to   sendinput, ^+2   or something like that.

; if (shortcut = "^{numpad3}") or if (shortcut = "^+1")
; {
; sleep 30
; sendinput, %shortcut%
; ;Premiere 12.0.1 is SLOOOWWW to react to these shortcuts in particular. (Source monitor resolution to 1/4) and (program monitor res to 1/1) So I gotta WAIT AROUND and send this TWICE.
; }

; if (shortcut = "^{numpad2}")
	; {
	; send, {CTRL UP}
	; sleep 10
	; send, {CTRL DOWN}
	; sleep 10
	; send, {CTRL UP}
	; sleep 10
	; }



;THE CODE BELOW IS SUPER OPTIONAL
if (windowWidth > 2000) ;if the monitor in question IS maximized...
{
;tooltip, %shortcut% boy
;Then it's not obvious which monitor it is, and it's possible that I misremembered, and pressed the wrong button. Therefore, I will ALSO send the shortcut that corresponds to the alternative monitor.

;Also, it's possible that the window is not in focus. I want to send a middle click to it without moving the mouse, since coordinates arent well supported on other monitors. For this, controlfocus or controlclick MIGHT work...

;ControlClick , x1800 y500, WinTitle, WinText, MIDDLE, 1, Pos

if (shortcut = "^{numpad1}")
	{
	;sleep 30
	sendinput, ^+1
	}
if (shortcut = "^{numpad2}")
	{
	sendinput, ^+2
	}
if (shortcut = "^{numpad5}")
	{
	;sleep 30
	;tooltip, yeah ctrl numpad 5
	sendinput, ^+2
	}
if (shortcut = "^{numpad3}")
	sendinput, ^+3

if (shortcut = "^+1")
	{
	;tooltip, taran whyyy
	sendinput, ^{numpad1}
	}
if (shortcut = "^+2")
	{
	;sleep 30
	sendinput, ^{numpad2}
	}
if (shortcut = "^+3")
	{
	;sleep 30
	sendinput, ^{numpad3}
	}
;and now for the safe margins
if (shortcut = "^!+[")
	sendinput, ^!+]
if (shortcut = "^!+]")
	sendinput, ^!+[

}
;THE CODE ABOVE IS SUPER OPTIONAL


;i might have to comment this back in vvvvv
if (windowWidth < 2000) ;again, if the monitor in question is NOT already maximized...
	if not (whichMonitor = "source") ;stay on the source (program?) monitor if it is active
		{
		prFocus("timeline")
		;tooltip, this is why
		}
;;; that ^^^^^

;if (useSpace = "0")
	;tooltip, we are NOT NOT NOT spacing
;;optional:
if (useSpace = "1")
	{
	;tooltip, we are spacing
	sendinput, {space} ;if playing/paused, pause/play the video.
	sleep 50
	sendinput, {space} ;if playing/paused, pause/play the video.
	;;this allows the new playback resolution to take effect.
	}
}
;if you are not in Premiere Pro, the function is skipped

; if not WinActive("ahk_exe Adobe Premiere Pro.exe")
	; msgbox,,, pr is not active,1
	; ; ;if you use the ahk_class, even if you have an active Premiere window on another monitor, unless it is the MAIN monitor, it doesn't count.
}
;end of monitorKeys() 




effectsPanelFindBox()
{
prFocus(effects)
sendinput, ^b ;select find box
}



effectsPanelType(item := "lol")
{
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips, unlike preset()

;MODSL() ;this is probably no longer needed, but IDK for sure.

;prFocus("effects") ;reliably brings focus to the effects panel. This is an alternative to the next line.
Sendinput, ^+!7 ;CTRL SHIFT ALT 7 -- set in premiere to "effects" panel
sleep 20
Sendinput, ^b ;CTRL B --set in premiere to "select find box." Makes a windows noise if you do it again.
;sleep 20
Sendinput, +{backspace} ;shift backspace deletes any text that may be present. It is much less dangerous than sending "delete" or "backspace" alone.
Sleep, 10
Sendinput, %item%
;now this next part re-selects the field in case you want to type anything different
;sleep 10
Sendinput, ^!b ;ctrl alt B is ALSO select find box, but doesn't have the annoying windows sound. I may wish to change this to something else, as ALT is inherently dangerous if it becomes stuck.
}



#if

MODSL()
{
;UNSTICK LEFT MODIFIERS. I don't really use this anymore.
sendinput, {blind}{SC0E2} ;scan code of an unassigned key. Used for debugging. Warning: may activate windows Game Bar if you didn't disable it.
sleep, 1 ;okay soooooooooo apparently this is always at LEAST 10 to 15 milliseconds no matter what i do. uuuuugh.
; ; https://www.autohotkey.com/docs/commands/Sleep.htm
sendinput,{blind}{LCtrl up}{LAlt up}{LShift up}
;sendinput, {blind}{SC0E3} ;scan code of an unassigned key. Used for debugging. Warning: may activate windows Game Bar if you didn't disable it.
}


MODSR()
{
;UNSTICK RIGHT MODIFIERS. I don't use this anymore.
sendinput, {blind}{SC0E3} ;scan code of an unassigned key. Used for debugging. Warning: may activate windows Game Bar if you didn't disable it.
sleep 1
sendinput, {blind}{RCtrl up}{RAlt up}{RShift up}
sendinput, {blind}{SC0E4} ;scan code of an unassigned key. Used for debugging. Warning: may activate windows Game Bar if you didn't disable it.
}




preset(item)
{
;******FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!******
; preset() is my most used, and most useful AHK function for Premiere Pro!

;===================================================================================
; NEW TO AHK? READ ALL THE BELOW INSTRUCTIONS BEFORE YOU TRY TO USE THIS.
; THIS WILL NOT WORK UNLESS YOU DO SOME SETUP FIRST!
; Fortunately,
; THERE IS A FULL VIDEO TUTORIAL THAT TEACHES YOU HOW TO USE THIS, STEP BY STEP.
; [[[[[LINK TBD, IT'S NOT FINISHED JUST YET.]]]]]
;
; Even if Adobe does one day add this feature to Premiere, this video tutorial will
; still be very useful to anyone who is learning how to use AHK with Premiere,
; especially if you're trying to use any of the other functions that I've created.
; 
; To call the function, use something like
; F4::preset("crop 50")
; Where "crop 50" is the exact, unique name of the preset you wish to apply.
; 
; For this function to work, you MUST go into Premiere's Keyboard Shortcuts panel,
; find the following commands, and add these keyboard shortcut assignments to them:
; 
; Select Find Box ------- CTRL B
; Shuttle Stop ---------- CTRL ALT SHIFT K
; Window > Effects  ----- CTRL ALT SHIFT 7
;
; (You can use different shortcuts if you like, as long
; as those are the ones you send with your AHK script.)
; 
;====================================================================================

;Keep in mind, I use 100% UI scaling on my primary monitor, so if you use 125% or 150% or anything else, your pixel distances for commands like Mousemove WILL be different. Therefore, you'll need to "comment in" the message boxes, change some numbers, and keep saving and refreshing and retrying the script until you've got it working!
;To find out what UI scaling your screen uses, hit the windows key, type in "display," hit Enter, and then scroll down to "Scale and layout." Under "Change the size of text, apps, and other items," there will be a selection menu thing. Mine is set to "100%." I have NOT done anything in the "Advanced scaling settings" blue link just below that.

;To use this script yourself, carefully go through  testing the script and changing the values, ensuring that the script works, one line at a time. use message boxes to check on variables and see where the cursor is. remove those message boxes later when you have it all working!

;NOTE: I built this under the assumption that your Effects Panel will be on the same monitor as your timeline. I can't guarantee that it'll work if the Effects Panel is on another monitor.

;NOTE: You also need to get the PrFocus() function.

;NOTE: To use the preset() function, your cursor must first be hovering over the clip that you wish to apply your preset to. It also works to select multiple clips, again, as long as your cursor is hovering over one of the selected clips.


keywait, %A_PriorHotKey% ;keywait is quite important.
;Let's pretend that you called this function using the following line:
;F4::preset("crop 50")
;In that case, F4 is the prior hotkey, and the script will WAIT until F4 has been physically RELEASED (up) before it will continue. 
;https://www.autohotkey.com/docs/commands/KeyWait.htm
;Using keywait is probably WAY cleaner than allowing the physical key UP event to just happen WHENEVER during the following function, which can disrupt commands like sendinput, and cause cross-talk with modifier keys.


;;---------You do not need the stuff BELOW this line.--------------

sendinput, {blind}{SC0EC} ;for debugging. YOU DO NOT NEED THIS.
;Keyshower(item,"preset") ;YOU DO NOT NEED THIS. -- it simply displays keystrokes on the screen for the sake of tutorials...
; if IsFunc("Keyshower")
	; {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(item,"preset") 
	; }
ifWinNotActive ahk_exe Adobe Premiere Pro.exe ;the exe is more reliable than the class, since it will work even if you're not on the primary Premiere window.
	{
	goto theEnding ;and this line is here just in case the function is called while not inside premiere. In my case, this is because of my secondary keyboards, which aren't usually using #ifwinactive in addition to #if getKeyState(whatever). Don't worry about it.
	}
;;---------You do not need the stuff ABOVE this line.--------------


;Setting the coordinate mode is really important. This ensures that pixel distances are consistant for everything, everywhere.
; https://www.autohotkey.com/docs/commands/CoordMode.htm
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window

;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On
;The mouse will be unfrozen at the end of this function. Note that if you do get stuck while debugging this or any other function, CTRL SHIFT ESC will allow you to regain control of the mouse. You can then end the AHK script from the Task Manager.

SetKeyDelay, 0 ;NO DELAY BETWEEN STUFF sent using the "send"command! I thought it might actually be best to put this at "1," but using "0" seems to work perfectly fine.
; https://www.autohotkey.com/docs/commands/SetKeyDelay.htm


Sendinput, ^!+k ;in Premiere's shortcuts panel, ASSIGN "shuttle stop" to CTRL ALT SHIFT K.
sleep 10
Sendinput, ^!+k ; another shortcut for Shuttle Stop. Sometimes, just one is not enough.
;so if the video is playing, this will stop it. Othewise, it can mess up the script.
sleep 5

;msgbox, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;;This was my debugging to check if there are lingering variables from last time the script was run. You do not need that line.

MouseGetPos, xposP, yposP ;------------------stores the cursor's current coordinates at X%xposP% Y%yposP%
;KEEP IN MIND that this function should only be called when your cursor is hovering over a clip, or a group of selected clips, on the timeline. That's because the cursor will be returned to that exact location, carrying the desired preset, which it will drop there. MEANING, that this function won't work if you select clips, but don't have the cursor hovering over them.

sendinput, {mButton} ;this will MIDDLE CLICK to bring focus to the panel underneath the cursor (which must be the timeline). I forget exactly why, but if you create a nest, and immediately try to apply a preset to it, it doesn't work, because the timeline wasn't in focus...? Or something. IDK.
sleep 5

prFocus("effects") ;Brings focus to the effects panel. You must find, then copy/paste the prFocus() function definition into your own .ahk script as well. ALTERNATIVELY, if you don't want to do that, you can delete this line, and "comment in" the 3 lines below:

;Sendinput, ^+!7 ;CTRL SHIFT ALT 7 --- In Premiere's Keyboard Shortcuts panel, you nust find the "Effects" panel and assign the shortcut CTRL SHIFT ALT 7 to it. (The default shortcut is SHIFT 7. Because Premiere does allow multiple shortcuts per command, you can keep SHIFT 7 as well, or you can delete it. I have deleted it.)
;sleep 12
;Sendinput, ^!+7 ;you must send this shortcut again, because there are some edge cases where it may not have worked the first time.

sendinput, {blind}{SC0ED} ;for debugging. YOU DO NOT NEED THIS LINE.

sleep 15 ;"sleep" means the script will wait for 15 milliseconds before the next command. This is done to give Premiere some time to load its own things.

Sendinput, ^b ;CTRL B ------- set in premiere's shortcuts panel to "select find box"
sleep 5
;Alternatively, it also works to click on the magnifying glass if you wish to select the find box... but this is unnecessary and sloppy.

;The Effects panel's find box should now be activated.
;If there is text contained inside, it has now been highlighted. There is also a blinking vertical line at the end of any text, which is called the "text insertion point", or "caret".

if (A_CaretX = "")
{
;No Caret (blinking vertical line) can be found.

;The following loop is waiting until it sees the caret. THIS IS SUPER IMPORTANT, because Premiere is sometimes quite slow to actually select the find box, and if the function tries to proceed before that has happened, it will fail. This would happen to me about 10% of the time.
;Using the loop is also way better than just ALWAYS waiting 60 milliseconds like I was before. With the loop, this function can continue as soon as Premiere is ready.

;sleep 60 ;<—Use this line if you don't want to use the loop below. But the loop should work perfectly fine as-is, without any modification from you.

waiting2 = 0
loop
	{
	waiting2 ++
	sleep 33
	tooltip, counter = (%waiting2% * 33)`nCaret = %A_CaretX%
	if (A_CaretX <> "")
		{
		tooltip, CARET WAS FOUND
		break
		}
	if (waiting2 > 40)
		{
		tooltip, FAIL - no caret found. `nIf your cursor will not move`, hit the button to call the preset() function again.`nTo remove this tooltip`, refresh the script using its icon in the taskbar.`n`nIt's possible Premiere tried to AUTOSAVE at just the wrong moment!
		;Note to self, need much better way to debug this than screwing the user. As it stands, that tooltip will stay there forever.
		;USER: Running the function again, or reloading the script, will remove that tooltip.
		;sleep 200
		;tooltip,
		sleep 20
		GOTO theEnding
		}
	}
sleep 1
tooltip,
}
;The loop has now ended.
;yeah, I've seen this go all the way up to "8," which is 264 milliseconds

MouseMove, %A_CaretX%, %A_CaretY%, 0 ;this moves the cursor, instantly, to the position of the caret.
sleep 5 ;waiting while Windows does this. Just in case it takes longer than 0 milliseconds.
;;;and fortunately, AHK knows the exact X and Y position of this caret. So therefore, we can find the effects panel find box, no matter what monitor it is on, with 100% consistency!

;tooltip, 1 - mouse should be on the caret X= %A_CaretX% Y= %A_CaretY% now ;;this debugging line was super helpful in me solving this one! Connent this line in if you want to use it, but comment it out after you've gotten the whole function working.

;;;msgbox, caret X Y is %A_CaretX%, %A_CaretY%

MouseGetPos, , , Window, classNN
WinGetClass, class, ahk_id %Window%

;tooltip, 2 - ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%

;;;note to self, I think ControlGetPos is not affected by coordmode??  Or at least, it gave me the wrong coordinates if premiere is not fullscreened... IDK. https://autohotkey.com/docs/commands/ControlGetPos.htm

ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow 

;note to self, I tried to exclude subwindows but I don't think it works...?
;;my results:  59, 1229, 252, 21,     Edit1,     ahk_class Premiere Pro
;tooltip, classNN = %classNN%

;;Now we have found a lot of useful information about this find box. Turns out, we don't need most of it...
;;we just need the X and Y coordinates of the "upper left" corner...

;;Comment in the following line to get a message box of your current variable values. The script will not advance until you dismiss a message box. (Use the enter key.)
;MsgBox, xx=%XX% yy=%YY%

;; https://www.autohotkey.com/docs/commands/MouseMove.htm

;MouseMove, XX-25, YY+10, 0 ;--------------------for 150% UI scaling, this moves the cursor onto the magnifying glass
MouseMove, XX-15, YY+10, 0 ;--------------------for 100% UI scaling, this moves the cursor onto the magnifying glass

;msgbox, should be in the center of the magnifying glass now. ;;<--comment this in for help with debugging.

sleep 5

Sendinput, %item%
;This types in the text you wanted to search for, like "crop 50". We can do this because the entire find box (and any included text) was already selected.
;Premiere will now display your preset at the top of the list. There is no need to press "enter" to search.


sleep 5

;MouseMove, 62, 95, 0, R ;----------------------(for 150% UI.)
MouseMove, 41, 63, 0, R ;----------------------(for 100% UI)
;;relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the preset's icon.

;;In my case, all of my presets are contained inside of folders, which themselves are inside the "presets" folder. Your preset's written name should be completely unique so that it is the first and only item.

;msgbox, The cursor should be directly on top of the preset's icon. `n If not, the script needs modification.

sleep 5


;;At this point in the function, I used to use the line "MouseClickDrag, Left, , , %xposP%, %yposP%, 0" to drag the preset back onto the clip on the timeline. HOWEVER, because of a Premiere bug (which may or may not still exist) involving the duplicated displaying of single presets (in the wrong positions) I have to click on the Effects panel AGAIN, which will "fix" it, bringing it back to normal.
;+++++++ If this bug is ever resolved, then the lines BELOW are no longer necessary.+++++
MouseGetPos, iconX, iconY, Window, classNN ;---now we have to figure out the ahk_class of the current panel we are on. It might be "DroverLord - Window Class14", but the number changes anytime you move panels around... so i must always obtain the information anew.
sleep 5
WinGetClass, class, ahk_id %Window% ;----------"ahk_id %Window%" is important for SOME REASON. if you delete it, this doesn't work.
;tooltip, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;sleep 50
ControlGetPos, xxx, yyy, www, hhh, %classNN%, ahk_class %class%, SubWindow, SubWindow ;;-I tried to exclude subwindows but I don't think it works...?
MouseMove, www/4, hhh/2, 0, R ;-----------------moves to roughly the CENTER of the Effects panel. Clicking here will clear the displayed presets from any duplication errors. VERY important. Without this, the script fails 20% of the time. This is also where the script can go wrong, by trying to do this on the timeline, meaning it didn't get the Effects panel window information as it should have.
sleep 5
MouseClick, left, , , 1 ;-----------------------the actual click
sleep 5
MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the preset's icon
;tooltip, should be back on the preset's icon
sleep 5
;;+++++If this bug is ever resolved, then the lines ABOVE are no longer necessary.++++++


MouseClickDrag, Left, , , %xposP%, %yposP%, 0 ;---clicks the left button down, drags this effect to the cursor's pervious coordinates and releases the left mouse button, which should be above a clip, on the TIMELINE panel.
sleep 5
MouseClick, middle, , , 1 ;this returns focus to the panel the cursor is hovering above, WITHOUT selecting anything. great! And now timeline shortcuts like JKL will work.

blockinput, MouseMoveOff ;returning mouse movement ability
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL ALT DELETE will still work if you get stuck!! Cool.

;;----remove the code below if it makes no sense to you.----
IfInString, item, CROP
	{
	if IsFunc("cropClick") ;This checks to see if you have a function named "cropClick"
		{
		Func := Func("cropClick")
		sleep 320 ;because it might take awhile to appear in Premiere,  and I'm not gonna do another loop think liek I did above...
		RetVal := Func.Call() 
		}
	;;If you don't have cropClick, then nothing happens. That's good!
	
	;;This code below is what I had used before, but it will complain that you haven't defined the function "cropClick", whereas, the code above will NOT!
	;sleep 320
	;cropClick()
	;;msgbox, that had "CROP" in it.
	}
;;----remove the code above if it makes no sense to you----

;The line below is where all those GOTOs are going to.
theEnding:
}
;END of preset(). The two lines above this one are super important.



; https://github.com/Drakeyn/AdobeMacros/blob/master/Premiere%20Pro/Functions/ApplyPreset.ahk
; this is a sort of preset2() I am testing.
DrakeynPreset(item)
{

SendMode Event

;Waits to make sure any previous hotkeys have been released
;keywait, %A_PriorHotKey%

;Just in case we're not in Premiere Pro
if(WinActive("ahk_exe Adobe Premiere Pro.exe") = 0)
	goto apEnd

;Sets up the coord modes, making sure our pixel distances are consistent
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window

;Disables mouse and keyboard input to make sure the function runs properly
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On

;Sets the keypress delay for Send/Sendinput commands to be zero.
SetKeyDelay, 0

;Gets the current position of the mouse and stores it in ox and oy (Original X and Original Y)
MouseGetPos, oX, oY 

; ;Selects the Effects Panel -> Find Box
; SendInput, %kbSelectEffectsPanel%
; SendInput,%kbSelectFindBox%
effectsPanelFindBox()

;Types the preset we're looking for into the find box
Send %item%

;this is where we'd usually need to wait for premiere to update the presets list.
;If, however, it's pre-opened like mine (and reset to be pre-opened at the end of this function)
;then premiere will update the list instantly
;however, if not, or we want it to be reliable no matter what the current state is, we need to delay
;70 ms seems to be about right for my system, you may want to increase/decrease for your own
sleep 70

;get effects panel position
ControlGetPos, cX, cY, cW, cH, %wdEffectsPanel%, ahk_class Premiere Pro
msgbox, %cX%, %cY%, %cW%, %cH%
;find top preset icon
;ImageSearch, iX, iY, cX, cY, cX + cW, cY + cH, %A_WorkingDir%\preset.png
ImageSearch, iX, iY, cX, cY, cX + cW, cY + cH, C:\AHK\2nd-keyboard\support_files\preset.png
msgbox, %ErrorLevel%
if(ErrorLevel == 1)
	goto apEnd
if(ErrorLevel == 2)
	goto apEnd

;move mouse to preset
MouseMove, iX, iY + 5, 0

;drag preset back
MouseClickDrag, Left, , , oX, oY, 0

apEnd:

;Resets and pre-opens the presets list for easier editing - this is just for how [Draken] works
;SendInput, %kbSelectEffectsPanel%
prFocus(effects)

;SendInput, %kbSelectFindBox%
sendinput, ^b ;select find box

;;could use effectsPanelType() but it's not really the same thing because it deletes whatever is in there.
;;could use
;effectsPanelFindBox()
;;and i might later.

Send AAA Taran

;Puts the mouse back where it started
MouseMove oX, oY, 0

;Re-selects the timeline panel
MouseClick, middle, , , 1 

;Re-enables input
BlockInput, MouseMoveOff 
BlockInput, off 
}




prFocus(panel)
{
;READ ALL THE COMMENTS BELOW OR SUFFER THE CONSEQUENCES.

;PrFocus() allows you to have ONE place where you define your personal shortcuts to "focus" panels in Premiere. It also ensures that panels actually get into focus, and don't rotate through the sequences or anything like that.

; THERE IS A FULL VIDEO TUTORIAL THAT TEACHES YOU HOW TO USE THIS, STEP BY STEP.
; [[[[[LINK TBD, IT'S NOT FINISHED JUST YET.]]]]]

;For this function to work, you MUST Go to Premiere's Keyboard Shortcuts panel, and add the following keyboard shortcuts to the following commands:

; KEYBOARD SHORTCUT     PREMIERE COMMAND
; ctrl alt shift 3 .....Application > Window > Timeline (The default is shift 3)
; ctrl alt shift 1 .....Application > Window > Project  (Sets the focus onto a BIN.) (the default is SHIFT 1)
; ctrl alt shift 4 .....Application > Window > Program Monitor (Default is SHIFT 4)
; ctrl alt shift 5 .....Application > Window > Effect Controls (Default is SHIFT 5)
; ctrl alt shift 7 .....Application > Window > Effects  (NOT the Effect Controls panel!) (Default is SHIFT 7)

;(Note that ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk has the FULL list of keyboard shortcuts that you need to assign in order for my other functions to work.)


;EXPLANATION: In Premiere, panel focus is very important. Many shortucts will only work if a specific panel is in focus. That is why those panels must be put into focus FIRST, which is what I built PrFocus() to do. (It's not always as simple as sending just the one keyboard shortcut to activate that panel.)

;Right now, we do NOT know which panel is in focus, (or "active.") and AHK has no way to tell (that I know of.)
;If a panel is ALREADY in focus, and you send the shortcut to bring it into focus again, that panel might then switch to a different sequence in the case of the timeline or program monitor,, or a different item in the case of the Source panel. IT's a nightmare!

;Therefore, we must start with a clean slate. For that, I chose the EFFECTS panel. Sending its focus shortcut multiple times, has no ill effects.

Sendinput, ^!+7 ;bring focus to the effects panel... OR, if any panel had been maximized (using the `~ key by default) this will unmaximize that panel, but sadly, that panel will still be the one in focus.
;Note that if the effects panel is ALREADY maximized, then sending the shortcut to switch to it will NOT un-maximize it. This is OK, though, because I never maximize the Effects Panel. If you do, then you might want to switch to the Effect Controls panel first, and THEN the Effects panel after this line.
;note that sometimes I use ^+! instead... it makes no difference compared to ^!+

sleep 12 ;waiting for Premiere to actaully do the above.

Sendinput, ^!+7 ;Bring focus to the effects panel AGAIN. Just in case some panel somewhere was maximized, THIS will now guarantee that the Effects panel is ACTAULLY in focus.

sleep 5 ;waiting for Premiere to actaully do the above.

sendinput, {blind}{SC0EC} ;scan code of an unassigned key. Used for debugging. You do not need this.

if (panel = "effects")
	goto theEnd ;do nothing. The shortcut has already been sent.
else if (panel = "timeline")
	Sendinput, ^!+3 ;if focus had already been on the timeline, this would have switched to the "next" sequence (in some unpredictable order.)
else if (panel = "program") ;program monitor. If focus had already been here, this would have switched to the "next" sequence.
	Sendinput, ^!+4
else if (panel = "source") ;source monitor. If focus had already been here, this would have switched to the next loaded item.
{
	Sendinput, ^!+2
	;tippy("send ^!+2") ;tippy() was something I used for debugging. you don't need it.
}
else if (panel = "project") ;AKA a "bin" or "folder"
	Sendinput, ^!+1
else if (panel = "effect controls")
	Sendinput, ^!+5

theEnd:
sendinput, {blind}{SC0EB} ;more debugging - you don't need this.
}
;end of prFocus()




;;;Personal notes below:
;panel := """" . panel . """" ;This adds quotation marks around the parameter so that it works as a string, not a variable.
; ; ; if (panel = "effect controls")
; ; ; {
	; ; ; Send ^!+5
	; ; ; return
; ; ; }
;;;Personal notes above^^




;;you do NOT need the following function. Even I don't use it anymore.
savepreset(presetname){
SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
sleep 20
SendInput, {c up}{Ctrl up}
sleep 20
msgbox, text in clipboard = %clipboard%
presetname = %clipboard%
msgbox, presetname = %presetname%
return presetname
}



insertSFX(leSound)
{
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto sfxEnding
	
;keyShower(leSound, "insertSFX") ;the following is used instead of this line.
if IsFunc("Keyshower") ;checks to see if you have the Keyshower function defined.
	{
	Func := Func("Keyshower")
	RetVal := Func.Call(leSound, "insertSFX") 
	}

CoordMode, mouse, Screen
CoordMode, pixel, Screen
coordmode, Caret, screen

BlockInput, mouse
blockinput, MouseMove
BlockInput, On

SetKeyDelay, 0 ;for instant writing of text

MouseGetPos, xpos, ypos
send ^+x ;ctrl shift x -- shortcut in premiere for "remove in/out points.
sleep 10
send ^+9 ;ctrl shift 6 - source assignment preset 4. (sets it to A3.)
sleep 10
; Send ^!+1 ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?
send ^!+1 ;CTRL ALT SHIFT 1 -- ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
;msgbox, waiting for premiere to select that bin....
sleep 20
;msgbox how about naow?
; 
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box." Make sure there are NO OTHER conflicting shortcuts on this key, like "create new bin," which would stop it from working.
; send +{backspace} ;to delete anything that might be written in the bin, so that the caret coordinates are always accurate.

; msgbox, okay now what
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
send ^+9 ;source assignment preset 4, again.
sleep 400 ;we are waiting for the search to complete....
;sleep 400 ;we are still waiting for the search to complete....

MouseMove, -6000, 250, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.
;msgbox, wheres de mouse?
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
tooltip, CLICK!!!
sleep 10
send ^+9 ;source assignment preset 4, again.
sleep 5
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box."
sleep 10
Send +{backspace} ;deletes the search text so that the bin returns to normal view with all SFX visible.
sleep 10
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.

sleep 20
tooltip, so did that work?
;msgbox, clicked, mouse should be back at original coordinates.

;send ^!+4 ;select program monitor
sleep 10
;send ^!+3 ;select timeline
sleep 10
send ^+9 ;my shortcut for "assign source assignment preset 4" in Premiere. The preset has V3 and A4 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
sleep 50
Send ^/ ;CTRL FORWARD SLASH -- SET TO "OVERWRITE" in premiere. Premiere's default shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
sleep 30
; Send mbutton ;this will MIDDLE CLICK to reselect whatever panel your cursor was hovering over before you engaged this function.
send ^!+7 ;highlight effects panel
sleep 30
send ^!+3 ;this is set in premiere to highlight/switch to the timeline. important so that you aren't still stuck in the bin. If this is used more than once, it will unfortunately cycle thorugh all available sequences...
tooltip,
BlockInput, off
BlockInput, MouseMoveOff
sfxEnding:
}
;;end of insertSFX()


;you can select something inside of premiere (like a group of clips, or a transition) and then, with this code, you can COPY it and SAVE that clipboard state. I use this in conjunction with my secondary keyboard.
;You need to have insideclipboard.exe installed, and all the file paths properly comfigured.
;Keep in mind that you must RESTART your computer before the clipboard states become usable. IDK why.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
saveClipboard(int) {
	StringReplace, int, int, +, , All ;replace + with nothing. This is just in case A_thishotkey contains + if shift was used!
	StringReplace, int, int, !, , All ;replace ! with nothing. This is just in case A_thishotkey contains ! if alt was used!
	StringReplace, int, int, ^, , All ;replace ^ with nothing. This is just in case A_thishotkey contains ^ if ctrl was used!
	;msgbox, , , saving as %int%, 0.6
	tooltip, saving as`n"clip" . %int% . ".clp"
	sleep 10
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
	sleep 20
	ClipWait, 0.25 ; this line might not be needed.
	SendInput, {c up}{Ctrl up}
	sleep 20
	saveToFile("clip" . int . ".clp")
	sleep 1000
	saveToFile("clip" . int . ".clp")
	tooltip,
}

;This is the real magic. With this script, you can PASTE those previously saved clipboard states, at any time.
#ifwinactive ahk_exe Adobe Premiere Pro.exe
recallClipboard(int, transition := 0) {
	;deactivate keyboard and mouse
	;keyShower(int, "recallClipboard")
	if IsFunc("Keyshower") {
		Func := Func("Keyshower")
		RetVal := Func.Call(int, "recallClipboard") 
	}
	WinActivate, Adobe Premiere Pro
	prFocus("timeline")
	;Send ^!d ;this is to deselect any clips that might be selected in the timeline.
	;tooltip, "now loading random text into the clipboard."
	loadFromFile("clipTEXT.clp") ;to create this file, just highlight some plain text, copy it, and use insideclipboard.exe to save it as clipTEXT.clp. The clipboard MUST have some text inside; it CANNOT be completely empty. This has the effect of DELETING all the aspects of the clipboard, EXCEPT for text.
	sleep 15
	; ; WinActivate, Adobe Premiere Pro ;IDK if this is needed here.
	; ; loadFromFile("clipTEXT.clp") ;The clipboard must be loaded twice, or it won't work about 70% of the time! I don't know why...
	; ; sleep 15
	;Autohotkey can now delete that string of text, so that no text is accidentlaly pasted into premiere. It doesn't seem to be able to delete EVERYTHING, so the above code is definitely necessary!
	clipboard = 
	;The clipboard is now completely empty.
	sleep 10
	
	;tooltip, now pasting NOTHING into premiere....
	WinActivate, Adobe Premiere Pro ;extremely important to ensure you are still active/focused on Premiere
	SendInput, {Shift Down}{Shift Up}
	sleep 10
	SendInput, {Ctrl Down}{v Down} ;this is a MUCH more robust way of using the keyboard shortcuts to PASTE, rather than just using "Send ^v"
	sleep 5
	SendInput, {v Up}{Ctrl Up}
	sleep 20
	
	;It is necessary to PASTE this COMPLETELY BLANK clipboard into premiere, or Premiere won't "know" that the clipboard has been completely emptied.
	;If you don't do this, Premiere will just use whatever thing you had previously copied inside of Premiere.
	clipboard = 
	;the above line is another method for clearing the clipboard that must also be done to ensure a totally empty clipboard
	sleep 30
	;tooltip, "clip" . %int% . ".clp" ;this code doesn't work
	;tooltip, now preparing to paste %int%
	;msgbox, %int%
	WinActivate, Adobe Premiere Pro 
	loadFromFile("clip" . int . ".clp") ;now we are loading the previously saved clipboard file!
	sleep 15
	; ; loadFromFile("clip" . int . ".clp") ;This must be done twice, or it doesn't work! I don't know why!! :D ;ADENDUM - i tried it with only 1 load and NOW it IS working??? IDK why
	; ; sleep 15
	WinActivate, Adobe Premiere Pro ;this is extremely important.... otherwise, it will try to paste into the command prompt or something. You must ensure the correct program is pasted into.
	
	; ; ; if (transition = 0)
	; ; ; {
		; ; ; target("v1", "off", "all", 5) ;this will disable all video layers, and enable only layer 5.
		; ; ; tooltip, only layer 5 was turned on should be
		; ; ; sleep 150
		
	; ; ; }
	tooltip, now PASTING into premiere...
	WinActivate, Adobe Premiere Pro
	SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	sleep 5
	SendInput, {v Up}{Ctrl Up}
	sleep 10
	
	;the below code doesn't work very well.
	; sleep 100
	;If (transition = 1){
	; ;now if we want an accurate label colorwe have to DELETE what we just did, since none of the label colors will be correct due to a premiere bug.
	; ;tooltip,,,gonna delete now,1
	; tooltip,gonna delete now
	; WinActivate, Adobe Premiere Pro
	; prFocus("timeline")
	; WinActivate, Adobe Premiere Pro
	; SendInput, +{delete} ;ripple delete
	; sleep 100
	
	; ;now to paste again, now that the label colors have been loaded.
	; ;REDO might also work. must test that.
	; WinActivate, Adobe Premiere Pro
	; prFocus("timeline")
	; sleep 30
	; SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
	; ClipWait, 0.50
	; SendInput, {v Up}{Ctrl Up}
	; sleep 10
	;}
	
	
	if (transition = 0)
		target("v1", "on", "all")
	sleep 10
	; send ^{F9} ;toggle video tracks (hopefully off)
	; send ^+{F9} ;toggle audio tracks (hopefully off)
	tooltip,
	Send, ^!{F11} ;this is to deselect any clips that might be selected in the timeline. WAS ctrl alt D. might be unreliable.
	
} ;end of recall Clipboard()

#ifwinactive ;everything below this line can happen in any application!



;;target() is a script to TARGET or UNTARGET any arbitrary track.
;it doesn't work well, and I don't really use it.
Target(v1orA1, onOff, allNoneSolo := 0, numberr := 0)
{
;tooltip, now in TARGET function
; BlockInput, on
; BlockInput, MouseMove
; MouseGetPos xPosCursor, yPosCursor
prFocus("timeline") ;brings focus to the timeline.
wrenchMarkerX := 400
wrenchMarkerY := 800 ;the upper left corner for where to begin searching for the timeline WRENCH and MARKER icons -- the only unique and reliable visual i can use for coordinates.
targetdistance := 98 ;Distance from the edge of the marker Wrench to the left edge of the track targeting graphics
CoordMode Pixel ;, screen  ; IDK why, but it only works like this...
CoordMode Mouse, screen

;tooltip, starting
ImageSearch, xTime, yTime, wrenchMarkerX, wrenchMarkerY, wrenchMarkerX+600, wrenchMarkerY+1000, %A_WorkingDir%\timelineUniqueLocator2.png
if ErrorLevel = 0
	{
	;MouseMove, xTime, yTime, 0
	;tooltip, where u at son. y %ytime% and x %xtime%
	;do nothing. continue on.
	xTime := xTime - targetdistance
	;MouseMove, xTime, yTime, 0
	}
else
	{
	tooltip, image search failed
	goto resetTrackTargeter
	}
;tooltip, continuing...

ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_targeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_targeted_alone.png
if ErrorLevel = 2
	{
	tippy("TARGETED v1 not found")
	goto trackIsUntargeted
	}
if ErrorLevel = 3
	{
	tippy("Could not conduct the TARGETED v1 search!")
	goto resetTrackTargeter
	}
if ErrorLevel = 0
	{
	;MouseMove, FoundX, FoundY, 0
	;tooltip, where is the cursor naow 1,,,2
	;tippy("a TARGETED track 1 was found.")
	if (v1orA1 = "v1")
		{
		send +9 ;command in premiere to "toggle ALL video track targeting."
		sleep 10
		if (onOff = "on")
			{
			;tippy("turning ON")
			send +9 ; do it again to TARGET everything.
			}
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	else if (v1orA1 = "a1")
		{
		send !9 ;command in premiere to "toggle ALL audio track targeting."
		sleep 10
		if (onOff = "on")
			send !9 ; do it again to TARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
	goto resetTrackTargeter
	}

trackIsUntargeted:
;tooltip, track is untargeted,,,2
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_locked_untargeted_alone.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xTime, yTime, xTime+100, yTime+1000, %A_WorkingDir%\%v1orA1%_unlocked_untargeted_alone.png
if ErrorLevel = 0
	{
	;MouseMove, FoundX, FoundY, 0
	;tippy("an UNTARGETED track 1 was found.")
	;tooltip, where is the cursor naow,,,2
	
	if (v1orA1 = "v1")
		{
		send ^{F9};send +9 ;command in premiere to "toggle ALL video track targets." This should TARGET everything.
		sleep 10
		if (onOff = "off")
			send +9 ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send +%numberr%
		}
	if (v1orA1 = "a1")
		{
		send ^+{F9} ;command in premiere to "toggle ALL audio track targets." This should TARGET everything. ;also ALT f9 but it's dangerous.
		sleep 10
		if (onOff = "off")
			send !9 ; do it again to UNTARGET everything.
		sleep 10
		if (numberr > 0)
			Send !%numberr%
		}
	goto resetTrackTargeter
	}

resetTrackTargeter:
; MouseMove, xPosCursor, yPosCursor, 0
; blockinput, off
; blockinput, MouseMoveOff
;sleep 1000
tooltip,
tooltip,,,,2
sleep 10
}
;END of Target()



#ifwinactive


saveToFile(name) {
	;code below does not use any fancy variables. It's a bare string. Unfortunately, I can't find a way to make it work better...
	;change this path ----|                  																 and this one --------|    to your own folder locations.
	;    	              |																										  |
	;                     v																									  	  v
	RunWait, %comspec% /c C:\AHK\2nd-keyboard\insideclipboard\InsideClipboard.exe /saveclp %name%, C:\AHK\2nd-keyboard\insideclipboard\clipboards\
	
	
	;just saving the below lines of code, which didn't work because %pathh% nor %Exec% variables could not be defined properly. Or something... IDK....
	;RunWait, %comspec% /c %Exec% /saveclp %name%, c:\Users\TaranWORK\Downloads\Taran extra keyboards\insideclipboard\clipboards\
	;RunWait, %comspec% /c %Exec% /saveclp %name%, %pathh%
	
}

loadFromFile(name) {
	; You'll need to change these paths too!
	RunWait, %comspec% /c C:\AHK\2nd-keyboard\insideclipboard\InsideClipboard.exe /loadclp %name%, C:\AHK\2nd-keyboard\insideclipboard\clipboards\
}

;i think the line below is probably useless buti am afraid to delete it
#IfWinActive ahk_exe Adobe Premiere Pro.exe



;audioMonoMaker() will open the Audio Channels box, and use the cursor to put both tracks on [left/right], turning stereo sound into mono (with the [right/right] track as the source.
audioMonoMaker(track)
{
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto monoEnding
sleep 3
;msgbox,,, what the hell,0.6
CoordMode,Mouse,Screen
CoordMode,pixel,Screen
;SetTitleMatchMode, 2
;DetectHiddenWindows, On

BlockInput, SendAndMouse
BlockInput, On
BlockInput, MouseMove ;prevents mouse from moving

;Keyshower(track,"audioMonoMaker") ;you can delete this line, you don't need it.
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(track,"audioMonoMaker") 
}
global tToggle = 1
;msgbox, track is %track%
if (track = "right")
{
	;msgbox, this is for the RIGHT audio track. As usual, your number will be smaller, since I have 150% UI scaling enabled.
	addPixels = 36
}
else if (track = "left")
{
	addPixels = 0
	;msgbox, this is for the LEFT audio track
}
;Send ^!+a ;control alt shift a --- ; audio channels shortcut, asigned in premiere - dont use this key combo anywhere else. UPDATE: seems unreliable to send shortcuts that use modifier keys, inside a funciton that was triggered using modifier keys. switched to F3.
sendinput, {F3} ;also the audio channels shortcut.
; sleep 15
; sendinput, {F3} ;again cause sometimes it fails?
;WARNING - this was cross-talking with !+a, causing a preset("blur with edges") macro to be executed. I dont know how to avoid. maybe change order...??
;WARNING - still cross talks with RENDER AUDIO, which is CTRL SHIFT A, or CTRL ALT A.
; fun fact, if you send this keystroke AGAIN, it does NOT close the panel, which is great... that means you can press the button anytime, and it will always result in an open panel.
sleep 15

MouseGetPos, xPosAudio, yPosAudio

MouseMove, 2222, 1625, 0 ;moved the mouse onto the expected location of the "okay" box, which has a distinct white color when the cursor is over it, which will let us know the panel has appeared.

; msgbox where am i, cursor says
MouseGetPos, MouseX, MouseY

waiting = 0
;the following loop is waiting until it sees a specific color from the panel, which means that it has loaded and can then be affected.
loop
	{
	waiting ++
	sleep 50
	tooltip, waiting = %waiting%`npixel color = %thecolor%
	MouseGetPos, MouseX, MouseY
	PixelGetColor, thecolor, MouseX, MouseY, RGB
	if (thecolor = "0xE8E8E8")
		{
		tooltip, COLOR WAS FOUND
		;msgbox, COLOR WAS FOUND 
		break
		}
		
	if (waiting > 10)
		{
		tooltip, no color found, go to ending
		goto, ending
		}
	}
	
;*/
CoordMode, Mouse, Client
CoordMode, Pixel, Client

MouseMove, 165 + addPixels, 295, 0 ;this is relative to the audio channels window itself. Again, you should reduce these numbers by like 33%...?, since i use 150% UI scaling.
;msgbox, now we should be on the first check box
sleep 50

MouseGetPos, Xkolor, Ykolor
sleep 50
PixelGetColor, kolor, %Xkolor%, %Ykolor%
;msgbox, % kolor
; INFORMATION:
; 2b2b2b or 464646 = color of empty box
; cdcdcd = color when cursor is over the box
; 9a9a9a = color when cursor NOT over the box
; note that these colors will be different depending on your UI brightness set in premiere.
; For me, the default brightness of all panels is 313131 and/or 2B2B2B

;msgbox, kolor = %kolor%
If (kolor = "0x1d1d1d" || kolor = "0x333333") ; This is the color of an EMPTY checkbox. The coordinates hsould NOT lead to a position where the grey of the checkmark would be. Also, "kolor" is the variable name rather than "color" because "color" might be already used for something else in AHK.
{
	;msgbox, box is empty
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
}
else if (kolor = "0xb9b9b9") ;We are now looking for CHECK MARKS. This coordinate, should be directly on top of the box, but NOT directly on top of the GRAY checkmark itself. You need to detect telltale WHITE color that means the box has been checked.
{
	; Do nothing. There was a checkmark in this box already.
}
sleep 5
MouseMove, 165 + addPixels, 329, 0
sleep 30
MouseGetPos, Xkolor2, Ykolor2
sleep 10
PixelGetColor, k2, %Xkolor2%, %Ykolor2%
sleep 30
;msgbox, k2 = %k2%
If (k2 = "0x1d1d1d" || k2 = "0x333333") ;both of these are potential dark grey background panel colors
{
	;msgbox, box is empty. i should click
	; click left
	;sendinput, LButton
	MouseClick, left, , , 1
	sleep 10
	;msgbox, did clicking happen?
}
else if (k2 = "0xb9b9b9")
{
	; Do nothing. There was a checkmark in this box already
}
;msgbox, k2 color was %k2%
sleep 5
Send {enter}
ending:
CoordMode, Mouse, screen
CoordMode, Pixel, screen
MouseMove, xPosAudio, yPosAudio, 0
BlockInput, off
BlockInput, MouseMoveOff ;return mouse control to the user.
tooltip,
monoEnding:
} ; monomaker!!!!!!!!!!!!


#ifwinactive







;;;CLICK ON THE 'CROP' TRANSFORM BUTTON IN ORDER TO SELECT THE CROP ITSELF.
;;;THIS WAY, YOU INSTANTLY GET HANDLES ON TEH PROGRAM MONITOR, IT'S SO MUCH NICER.
cropClick()
{
;need something that wil toggle ^p if effect controls are not open.
CoordMode Pixel ;, screen
CoordMode Mouse, screen

BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor


effectControlsX = 10
effectControlsY = 200 ;the coordinates of roughly where my Effect Controls usually are located on the screen


; coordmode, pixel, Window
; coordmode, mouse, Window
; coordmode, Caret, Window

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are(were) done with default UI brightness, plus 150% UI scaling in Windows.

;ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_button_D2019.png ;

ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+200, effectControlsY+800, %A_WorkingDir%\CROP_transform_2020.png
if ErrorLevel = 2
	{
	;msgbox,,, TaranDir is `n%TaranDir%,0.7
	; ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_button_D2019.png
	ImageSearch, FoundX, FoundY, effectControlsX, effectControlsY, effectControlsX+400, effectControlsY+1200, %A_workingDir%\CROP_transform_2020.png
	}
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2
    tippy("NO CROP WAS FOUND")
	;YOU DO NOT NEED TIPPY() ... JUST DELETE IT FROM YOUR SCRIPT.
	;IT'S A DEBUGGING THING, DON'T WORRY ABOUT IT, LOL.
	goto resetcropper
	}
if ErrorLevel = 2
	{
    tippy("Could not conduct the crop search!")
	goto resetcropper
	}
if ErrorLevel = 0
	{
	MouseMove, FoundX+10, FoundY+10, 0 ;this moves the cursor onto the little square thingy.
	;msgbox, is the cursor in position?
	sleep 5
	click left
	}

resetcropper:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10

;msgbox, u are in cropland
return
}
;end of CROP CLICK


reselect()
{
;Premiere isn't as buggy with selections anymore, so I don't use this function anymore.
;Needs a thing here for chekcing to see what application is open!
;alt k??
Send ^!+k ; another shortcut for Shuttle Stop
sleep 5
Send ^!+7 ; shortcut for select Effects panel
sleep 5
Send ^!+3 ; shortcut for select timeline
sleep 5
send ^!d ;deselect
sleep 10
send ^p
sleep 1
send ^p ;toggles selection follows playhead

}
;end of reselect()

addGain(amount := 7)
{
send {F2}
sleep 5
send %amount%
sleep 5
send {enter}
}
;end of addGain()



;#if GetKeyState("F9") && GetKeyState("F23") ;experimental stuff, just ignore it.
;VK27  SC04D  == numpad right (shift numpad6)
;VK66  SC04D  == numpad 6
;VK25  SC04B  == numpad left
;VK64  SC04B  == numpad 4
;#if
#if GetKeyState("F9") && winactive("ahk_exe notepad++.exe")
;p::msgbox lolhi



;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#ifwinactive

marker(){
sendinput, ^!+K ;Premiere shortcut for SHUTTLE STOP
sleep 5
send ^{SC027} ;this is the scan code for a semicolon. CTRL SEMICOLON is one of my shortcuts to create a marker.  ^;  You have to set that up in Premiere of course.

}



;keyboard shortcut assigned to "keyboard shrtcuts panel."
;the trouble with CC2017 is that the find box is not automatically selected.
;and it is not even possible to use a shortcut to select it, either.
;so this script will do that.
;If i launch it with CTRL K, it will NOT select the find box.
;(I use shift K primarily, simply for the fact that the shift key is physically larger, and closer to K.)
kbShortcutsFindBox()
{
coordmode, mouse, screen
coordmode, pixel, screen

MouseGetPos, xpos, ypos ;-----------------------stores the cursor's current coordinates at X%xpos% Y%ypos%

winwait, Keyboard Shortcuts, ,0.5

IfWinExist, Keyboard Shortcuts ;if you are just typing a capital K, while NOT in the keyboard shortcuts panel, the script won't do anything.
	{
	coordmode, mouse, window
	coordmode, pixel, window
	BlockInput, On
	ControlGetPos, X, Y, Width, Height, Edit1, Keyboard Shortcuts ;find box of the keyboard shortcuts panel.
	; ControlClick, x10 y10, edit1, Keyboard Shortcuts ;dunno why... but i can never get controlclick to work.
	MouseMove, X-20, Y+10, 0
	sleep 1
	MouseClick, left, , , 1 ;------------------------clicks on magnifying glass. It is clickable even when the panel has not fully become visible!
	sleep 20
	coordmode, mouse, screen
	coordmode, pixel, screen
	MouseMove, xpos, ypos, 0 ;------------------------returns cursor to previous coordinates
	BlockInput, Off
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;shortcut to close the titler with ctrl w, which only closes panels otherwise...
closeTitler()
{

;Marker @


coordmode, mouse, screen
coordmode, pixel, screen
MouseGetPos, xpos, ypos ;--------stores the cursor's current coordinates at X%xpos% Y%ypos%
coordmode, mouse, client
coordmode, pixel, client
WinGetActiveStats, Title, Width, Height, X, Y

;msgbox, % Title

Title := """" . Title . """"

; if (Title = "Marker @"){
IfInString, Title, "Marker @"
	{
	msgbox, you made it
	Tippy("USE SHIFT TAB ENTER", -1200)
	; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_targeted.png
	send, +{tab}
	sleep 10
	send {enter}
	}
else
	{
	Tippy("Close titler (ctrl w )", -1200)
	MouseMove, Width-35, -15, 0 ;-----moves the mouse onto the "x" at the top right of the titler window

	tooltip, closing titler now!
	Click left
	sleep 50 ;-----------------------wait 1/20th of a second to ensure everything is done

	coordmode, mouse, screen
	coordmode, pixel, screen
	MouseMove, %xpos%, %ypos%, 0 ;---moves the cursor back
	tooltip, 
	}
}



;EFFECT CONTROLS PANEL ---TRANSFORM ICON CLICKER ;F5::
clickTransformIcon2()
{

;This function actually does everything that "Activate Direct Manipulation in Program Monitor" SHOULD do.



;Tippy("transform icon - F5") ;optional. Used to aid debugging. Delete this if it causes problems.

;result := untwirl()
;it will return either "reset" or "untwirled"
;either way, I think I'll ignore the output, lel.

;msgbox,,, %result%,0.7

; ; ;the code below serves to save a lot of time in determining if a clip is selected or not.
; ; ;prFocus("Effect Controls")
; ; sendinput, {F10} ;highlights the effect controls
; ; sleep 10

; ; Send {tab}
; ; ;msgbox,,, its after the tab,0.7
; ; if (A_CaretX = "")
; ; {
	; ; ;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	; ; ;therefore, we will select the top clip at playhead using the code below:
	
	; ; ;Send ^p ;"selection follows playhead," but this causes a windows mild error sound most of the time, wtf? So I'm gonna use another shortcut.
	; ; Sendinput ^{F8} ;"selection follows playhead," alternative mapping for macros to use. (CTRL F8)
	; ; sleep 15
	; ; ;Send ^p
	; ; Sendinput ^{F8}
; ; }




;msgbox,,, about to hit F5?,0.5
sendinput, {F5} ;this is set to "activate Direct Manipulation in Program Monitor" in premiere. this is just in case you've got a mogart selected or something.

sleep 5


BlockInput, On ;blocks keyboard and mouse input... I think.
BlockInput, MouseMove
SetKeyDelay, 0

;sendinput ^!+5 ;highlights the effect controls. This seems to result in ALT not being properly released, or otherwise occuring at the end of the macro when it triggers menu acceleration. That is unacceptable.

; sendinput {F10} ;highlights the effect controls. F10 can be used to avoid the stuck modifiers bug. But It's best to put it on a higher function key that isn't actaully present on the keyboard. at the time of writing, F16 and F22 are still available.

sendinput, {F22} ;In premiere's shortcuts, F22 is assigned to Application > Window > Effect Controls. This will bring focus to the Effect Controls panel, which is the same as clicking or middle clicking on it.

sleep 20
MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window ;This is the Effect controls panel. Info gotten from Window Spy. Your might be different. Be sure to check!!

;X := X+85 ;150% ui. change these variables to match the icon's position on your screen
;Y := Y+100 ;150% ui. change these variables to match the icon's position on your screen

X := X+56 ;100% ui
Y := Y+66 ;100% ui

MouseMove, X, Y, 0
MouseClick, left
MouseMove, %xpos%, %ypos%, 0
BlockInput, Off
BlockInput, MouseMoveOff

sleep 20
sendinput, {F16} ;highlights the timeline, alternative key assignement. Note that this gets messed up if you have more than one timeline window!!
;sendinput, ^!+3 ;highlights the timeline. Danger, this can sometimes change the sequence IF the effect controls were somehow not yet highlighted, or if some other script highlighted the timeline iguess?
;sendinput, 9 ;highlights the timeline
sleep 10
sendinput, {F5} ;this is set to "show direct clip manipulation" or whatever in premiere. but it doens't work too well so this is just in case you've got a mogart sleected or something.
;the above line might not be needed and in fact is useless isnce the shortcut only works while on the timeline....
sleep 10
;sendinput ^!+5 ;highlights the effect controls. This is so that if you hit COPY, it'll copy the motion effect, NOT a selected clip on the timeline.
sendinput {F22} ;highlights the effect controls

}





masterClipSelect() ; i never use this one
{
Tippy("masterClipSelect()")
BlockInput, On
SetKeyDelay, 0
sendinput ^!+5 ;highlights the effect controls
sleep 20

;NEEDED - code that can tell if a clip is already selected or not. instantVFX uses that.
;untwirl()
Send {tab}
if (A_CaretX = "")
{
	;tooltip, No Caret (blinking vertical line) can be found. Therefore`, no clip is selected.
	;Therefore, we try to select the TOP clip at the playhead, using the code below.
	Send ^p ;"selection follows playhead,"
	sleep 10
	Send ^p
}

MouseGetPos, xpos, ypos
ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window
X := X+85
Y := Y+44
MouseMove, X, Y, 0
;MSGBOX, trying to select masterclip
MouseClick, left
;MouseMove, %xpos%, %ypos%, 0 ;moves back to original coordinates
MouseMove, 250, 670, 0, R ;moves down and to the right to be inthe middle of the master clip controls.
BlockInput, Off
}




; ;EFFECT CONTROLS PANEL --- MOTION EFFECT TRIANGLE UNFURL CLICKER;
; ;it's not intelligent though. it will only toggle.
; ;need to somehow combine this with the intelligent functionality below.
; ;watch the associated video for more information!
; ;   
; ~F4::
; Tippy("triangle unfurl - F4")
; BlockInput, on
; BlockInput, MouseMove
; SetKeyDelay, 0
; MouseGetPos, xpos, ypos
; ControlGetPos, X, Y, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro, DroverLord - TabPanel Window
; MouseMove, X+20, Y+94, 0
; MouseClick
; ;MouseMove, %xpos%, %ypos%, 0
; BlockInput, off
; BlockInput, MouseMoveOff
; Return


;obsolete.
;i should delete or merge this but i think it is used SOMEWHERE....
;better not touch it.
clickTransformIcon()
{
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.

; Xcorner := Xcorner+83 ;150% ui
; Ycorner := Ycorner+98 ;150% ui
Xcorner := Xcorner+56 ;100% ui
Ycorner := Ycorner+66 ;100% ui

MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
sleep 10 ; just to make sure it gets there, this is done twice.
MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
;msgbox, the cursor should now be positioned directly over the transform icon. `n Xcorner = %Xcorner% `n Ycorner = %Ycorner%
MouseClick, left
}


;script to lock video and audio layers V1 and A1.
;I don't recommend that anyone else use this. It's really finnicky to set up. Requires a ton of very carefully taken screenshots in order to work...
tracklocker()
{
;sleep 15 ;modifiers?
BlockInput, on
BlockInput, MouseMove
MouseGetPos xPosCursor, yPosCursor

xPos = 400
yPos = 1050 ;the coordinates of roughly where my timeline usually is located on the screen (a 4k screen.)
CoordMode Pixel ;, screen  ; IDK why, but it works like this...
CoordMode Mouse, screen
; CoordMode, mouse, window
; CoordMode, pixel, window
; coordmode, Caret, window
;you might need to take your own screenshot (look at mine to see what is needed) and save as .png. Mine are done with default UI brightness, plus 150% UI scaling in Wondows.
;msgbox, workingDir is %A_WorkingDir%
ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_targeted_2019_ui100.png
if ErrorLevel = 1
	ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_targeted_2019_ui100.png
; if ErrorLevel = 1
	; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_unlocked_untargeted_2018.png
; if ErrorLevel = 1
	; ImageSearch, FoundX, FoundY, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_unlocked_untargeted_2018.png
if ErrorLevel = 1
	{
	;msgbox, we made it to try 2
    tippy("NO UNLOCK WAS FOUND")
	goto try2
	}
if ErrorLevel = 2
	{
    tippy("Could not conduct the search!")
	goto resetlocker
	}
if ErrorLevel = 0
	{
	;tooltip, The icon was found at %FoundX%x%FoundY%.
	;msgbox, The icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX+10, FoundY+10, 0
	sleep 5
	click left
	MouseMove, FoundX+10, FoundY+60, 0 ;moves downwards and onto where A1 should be...
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
	
try2:
tippy("we are now on try 2")
; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *2 %A_WorkingDir%\v1_ALT_locked_targeted_2018.1.png

	
if ErrorLevel = 1
	{
    tippy("try 2 part 1")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\v1_ALT_locked_targeted_2019_ui100.png
	}
if ErrorLevel = 1
	{
    tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, *5 %A_WorkingDir%\IDK_2.png
	}
; if ErrorLevel = 1
	; {
    ; tippy("ALT LOCKED TARGETED V1 could not be found on the screen")
	; ImageSearch, FoundX_LOCK, FoundY_LOCK, xPos, yPos, xPos+600, yPos+1000, %A_WorkingDir%\v1_ALT_locked_untargeted.png
	; }
if ErrorLevel = 2
	{
    tippy("Could not conduct search #2")
	goto resetlocker
	}
	
if ErrorLevel = 0
	{
	;tippy("found a locked lock")
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+10, 0
	sleep 5
	click left ;clicks on Video track 1
	MouseMove, FoundX_LOCK+10, FoundY_LOCK+60, 0
	click left ;clicks on Audio track 1 as well.
	sleep 10
	goto resetlocker
	}
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resetlocker:
MouseMove, xPosCursor, yPosCursor, 0
blockinput, off
blockinput, MouseMoveOff
sleep 10
}
;End of trackLocker()



untwirl()
{
tooltip, untwirl is starting now
dontrestart = 0

;the code below serves to save a lot of time in determining if a clip is selected or not.
prFocus("Effect Controls")
Send {tab}
if (A_CaretX = "")
{
	;No Caret (blinking vertical line) can be found. Therefore, no clip is selected.
	;therefore, we will select the top clip at playhead using the code below:
	Send ^p ;"selection follows playhead,"
	sleep 10
	Send ^p
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint2
		}
	;otherwise,
	Return "reset"
}



restartPoint2:
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;This is the ClassNN of the effect controls panel. Use Window Spy to figure it out.
;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
; YY := Ycorner+99 ;ui 150%
; XX := Xcorner+19 ;ui 150%
YY := Ycorner+66 ;ui 100%
XX := Xcorner+13 ;ui 100%
MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

; if (colorr = "0x353535") ;for 150% ui
if (colorr = "0x222222") ;for 100% ui
{
	tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
}
;else if (colorr = "0x757575") ;for 150% ui. again, this values could be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed. it also cannot be the same as a normal panel color (1d1d1d or 232323)
else if (colorr = "0x7A7A7A") ;for 100% ui
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	;untwirled = 1
	
	Return "untwirled"
	;clickTransformIcon()
	;findVFX(foobar)
	
}
else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{
	;tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
		
	;resetFromAutoVFX()
	;play noise
	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint2 ;this is stupid but it works. Feel free to improve any of my code.
		}
	;otherwise,
	Return "reset"
	}
else
	{
	tooltip, %colorr% not expected
	;play noise
	
	Return "reset"
	;resetFromAutoVFX()
	}
tooltip,
} ;end of untwirl()






;how to use instantVFX: https://www.youtube.com/watch?v=Bi3zBqO74ms
;NOTE: DO NOT CHANGE YOUR WINDOWS CLEARTYPE SETTINGS, OR THE TEXT WILL BE SLIGHTLY DIFFERENT, AND IMAGESEARCH WILL NO LONGER WORK!

;UPDATE:
;I had overwritten the high DPI scaling behaviour of Premiere, by following THESE instructions: https://forums.adobe.com/message/10081059#10081059 , which changes the look of text and other elements of Premiere.
;Doing this totally BROKE the functionality of instantVFX() because now the pixel colors were different, and the images to be searched for would have had to have been updated.
;THEREFORE, I switched back to Premiere's built-in UI scaling, and will just have to wait for adobe to fix the issues that come with it.
;UPDATE 2: now that i have a 43" 4k monitor, I am back to 100% UI and it is wonderful. Will NEVER go back. 150% UI is just such a PITA to deal with.


instantVFX(foobar)
{
dontrestart = 0
restartPoint:
blockinput, sendandMouse
blockinput, MouseMove
blockinput, on

;fortunately, this whole thing is fast enough that i don't NEED to buffer keypresses. I can just fully block them while we wait. But here's a thread about that:
;https://autohotkey.com/board/topic/59606-input-buffer-during-blockinput/

;-Sendinput ^!+5

;clickTransformIcon()

prFocus("effect controls") ;essentially just hits CTRL ALT SHIFT 5 to highlight the effect controls panel.
sleep 10


; Send {tab}
; if (A_CaretX = "")
; {
	; tooltip, No Caret (blinking vertical line) can be found. Therefore`, no clip is selected.
	; ;Therefore, we try to select the TOP clip at the playhead, using the code below.
	; Send ^p ;"selection follows playhead,"
	; sleep 10
	; Send ^p
; }




;ToolTip, A, , , 2
MouseGetPos Xbeginlol, Ybeginlol
global Xbegin = Xbeginlol
global Ybegin = Ybeginlol
; MsgBox, "please verify that the mouse cannot move"
; sleep 2000
ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;This is HOPEFULLY the ClassNN of the effect controls panel. Use Window Spy to figure it out.
;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
; YY := Ycorner+99 ;ui 150%
; XX := Xcorner+19 ;ui 150%
YY := Ycorner+66 ;ui 100%
XX := Xcorner+13 ;ui 100%

MouseMove, XX, YY, 0
sleep 10

PixelGetColor, colorr, XX, YY

; if (colorr = "0x353535") ;for 150% ui
if (colorr = "0x222222") ;for 100% ui
{
	tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
	blockinput, Mouse
	Click XX, YY
	sleep 5
	clickTransformIcon()
	findVFX(foobar)
	Return
}
;else if (colorr = "0x757575") ;for 150% ui. again, this values could be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed. it also cannot be the same as a normal panel color (1d1d1d or 232323)
else if (colorr = "0x7A7A7A") ;for 100% ui
{
	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
	blockinput, Mouse
	sleep 5
	clickTransformIcon()
	findVFX(foobar)
	;untwirled = 1
	Return, untwirled
}
else if (colorr = "0x1D1D1D" || colorr = "0x232323")
	{
	;tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
	;I should experiement with putting a "deselect all clips on the timeline" shortcut here...
	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
	sleep 10
	Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
	resetFromAutoVFX()
	;play noise
	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
	If (dontrestart = 0)
		{
		dontrestart = 1
		goto, restartPoint ;this is stupid but it works. Feel free to improve any of my code.
		}
	Return reset
	}
else
	{
	tooltip, %colorr% not expected
	;play noise
	resetFromAutoVFX()
	Return reset
	}
}
Return ;from autoscaler part 1




findVFX(foobar) ; searches for text inside of the Motion effect. requires an actual image.
{
;tooltip, WTF
;msgbox, now we are in findVFX
sleep 5
MouseGetPos xPos, yPos
;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.

/*
if foobar = "scale"
	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\scale_D2017.png
else if foobar = "anchor_point"
	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
*/

;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2018.png

;something was wrong with using %A_WorkingDir% here. now fixed.

;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019.png
ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019_ui100.png
;within 0 shades of variation (this is much faster)
;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above.
;Again, your UI brightness might be different from mine! I now use the DEFAULT brightness.
; if ErrorLevel = 0
	; msgbox, error 0
if ErrorLevel = 1
	{
	;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
	;msgbox, whwhwuhuat
	ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019_ui100.png
	}
if ErrorLevel = 2
	{
    msgbox,,, ERROR LEVEL 2`nCould not conduct the search,1
	resetFromAutoVFX()
	Return
	}
if ErrorLevel = 1
	{
	;msgbox, , , error level 1, .7
    msgbox,,, ERROR LEVEL 1`n%foobar% could not be found on the screeen,1
	resetFromAutoVFX()
	Return
	}
else
	{
	;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
	;msgbox, The %foobar% icon was found at %FoundX%x%FoundY%.
	MouseMove, FoundX, FoundY, 0
	;msgbox,,,moved to located text,1
	sleep 5
	findHotText(foobar)
	Return
	}
}


;2d8ceb
findHotText(foobar)
{
tooltip, ; removes any tooltips that might be in the way of the searcher.
; https://www.autohotkey.com/docs/commands/PixelSearch.htm
;CoordMode Pixel
MouseGetPos, xxx, yyy

;msgbox, foobar is %foobar%
if (foobar = "scale" ||  foobar = "anchor_point" || foobar = "rotation")
{
	;msgbox,,,scale or the other 3,1
	;PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x3398EE, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
	PixelSearch, Px, Py, xxx+50, yyy, xxx+250, yyy+11, 0x2d8ceb, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI. TEchnically, I could check to see the size of the Effect controls panel FIRST, and then allow the number that is currently 250 to be less than half that, but I haven't run into too much trouble so far...
}
else if (foobar = "anchor_point_vertical")
{
	tooltip, 0.00? ;(looking for that now)
	;msgbox,,, looking for 0.00,0.5
	;ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019.png ;because i never change the value of the anti-flicker filter, (0.00) and it is always the same distance from the actual hot text that i WANT, it is a reliable landmark. So this is a screenshot of THAT.
	ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_ui100.png ;for a user interface at 100%...
	;the *3 allows some minor variation in the searched image.
	if ErrorLevel = 1
		ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_2.png
}

; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anti-flicker-filter_000.png


if ErrorLevel
	{
    ;tooltip, blue not Found
	sleep 100
	resetFromAutoVFX()
	return ;i am not sure if this is needed.
	}
else
	{
	;tooltip, A color within 30 shades of variation was found at X%Px% Y%Py%
	;sleep 1000
    ;MsgBox, A color within 30 shades of variation was found at X%Px% Y%Py%.
	if (foobar <> "anchor_point_vertical")
	{
		
		MouseMove, Px+10, Py+5, 0 ;moves the cursor onto the scrubbable hot text
		;msgbox, anything but anchor point vertical
		;sleep 1000
	}
	else if (foobar = "anchor_point_vertical")
	{
		;msgbox,,,, about to move,0.5
		MouseMove, Px+80, Py-20, 0 ;relative to the unrelated 0.00 text (which I've never changed,) this moves the cursor onto the SECOND variable for the anchor point... the VERTICAL number, rather than horizontal.
		;tooltip, where am I?
		;sleep 2000
	}
	Click down left
	
	GetKeyState, stateFirstCheck, %VFXkey%, P
		
	if stateFirstCheck = U
		{
			;tooltip, you have already released the key.
			;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
			;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
			Click up left
			Sleep 10
			;I am removing the clode below, which acts to set specific values automatically, which can be used to "reset" those values. Instead of that, I'm able to type in my own custom value.
			
			; if (foobar = "scale")
			; {
				; Send, 100
				; sleep 50
				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
				; sleep 20
			; }
			; if (foobar = "rotation")
			; {
				; Send, 0
				; sleep 50
				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
				; sleep 20
			; }
			resetFromAutoVFX(0) ;zero means, DO NOT click on the timeline to put the focus there.
			return ;this return has to be here, or the function will continue on to the next loop! Agh, I didn't realize that for a long time, dumb!
		}
	;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
	Loop
		{
		blockinput, off
		blockinput, MouseMoveOff
		;tooltip, %VFXkey% Instant %foobar% mod
		tooltip, ;removes any tooltips that might exist.
		sleep 15
		GetKeyState, state, %VFXkey%, P ;since this relies on the PHYSICAL state of the key on the attached keyboard, this and other functions do NOT work if you're using Parsec, Teamviewer, or other remote access software.
		
		;NOW is when the user moves their mouse around to change the value of the hot text. You can also use SHIFT or CTRL to make it change faster or slower. Then release the VFX key to return to normal.
		
		if state = U
			{
			Click up left
			;tooltip, "%VFXkey% is now physically UP so we are exiting now"
			sleep 15
			resetFromAutoVFX(1) ;1 means, DO send a middle click to put focus onto the timeline (or wherever the cursor was.)
			; MouseMove, Xbegin, Ybegin, 0
			; tooltip,
			; ToolTip, , , , 2
			; blockinput, off
			; blockinput, MouseMoveOff
			Return
			}
		}
	}
}

;;;--------------------------------------------------------------------------------------------

resetFromAutoVFX(clicky := 0)
{
	;tooltip, you're in RESET land
	;msgbox,,, is resetting working?,1
	global Xbegin
	global Ybegin
	MouseMove, Xbegin, Ybegin, 0
	;MouseMove, global Xbegin, global Ybegin, 0
	;MouseMove, Xbeginlol, Ybeginlol, 0
	
	if clicky = 1
		{
		;tooltip, WHY
		send, {mbutton} ;sends middle click. This will bring the panel you were hovering over, back into focus. Alternatively, i could do this with a keyboard shortcut that highlights the timeline panel, but that is probably less reliable, for... reasons.
		clicky = 0
		}
	;sleep 10
	blockinput, off
	blockinput, MouseMoveOff
	ToolTip, , , , 2
	SetTimer, noTip, 333
}



;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;46664444444613
;end of scripts from INSTANT RESCALE BUTTON script


SendKey(theKEY, fun := "", sometext := ""){
tooltip,sendkey has recieved: `n%theKEY%`n%sometext%`n%fun%,,12
;keyShower(sometext, fun)
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(sometext, fun) 
	}
Sendinput {%theKEY%}
sleep 100
tooltip,,,12
}
;end of sendkey()


;;;;note to self: this highlights the find box of the bin it highlights, i have no idea why. must fix
;other not to self -- i don't know what that sentance is referring to.




;macro key G3, when NOT in Premiere.
;macro sends CTRL SHIFT L, though CTRL ALT L might be better. ideally, it should not use any modifier keys at all... maybe just send a wrapped super function key.
;play/pause premiere even when not in focus
stopPlaying()
{
keywait, %A_priorhotkey% ;avoid stuck modifiers
send {blind}{SC081} ; this is for debugging. it does nothing but show up in the Key History and Script info.

;sendevent, {blind}{lshift up}{lctrl up}{rshift up}{rctrl up}{ralt up}{lalt up} ;i have no idea if this will work.

;send {blind}{SC082}

if WinActive("ahk_exe Adobe Premiere Pro.exe")
	{
	sendinput, {space}
	goto, stopPlayEND
	}
;then it will skip this next part and go to the end.
if !WinActive("ahk_exe Adobe Premiere Pro.exe")
{
;Below is some code to pause/play the timeline in Premiere, when the application is NOT the active window (on top.) This means that I can be reading through the script, WHILE the video is playing, and play/pause as needed without having to switch back to premiere every single time.



;WinGet, lolexe, ProcessName, A
WinGetClass, lolclass, A ; "A" refers to the currently active window

;Keyshower("[WC1] pause/play Premiere when not active",,1,-400)
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call("[WC1] pause/play Premiere when not active",,1,-400) 
}

;Trying to bring focus to the TIMELINE itself is really dangerous and unpredictable, since its Class# is always changing, based upon how many sequences, and other panels, that might be open.

;ControlFocus, DroverLord - Window Class3,ahk_exe Adobe Premiere Pro.exe ;the problem wiht this is that a project panel on the 2nd monitor also can qualify
ControlFocus, DroverLord - Window Class3,Adobe Premiere Pro 2021 ;this works because "Adobe Premiere Pro 2021" is found on the MAIN premiere window, but not the one on the 2nd or 3rd monitors.

; Window Class14 is the Program monitor, at least on my machine.
; well, now it's Window Class13. it really does change around a lot.
; Window Class3 seems to fairly consistently be the Effect Controls panel.
sleep 30
;ControlFocus, DroverLord - Window Class14,ahk_exe Adobe Premiere Pro.exe
;If we don't use ControlFocus first, ControlSend experiences bizzare and erratic behaviour, only able to work when the video is PLAYING, but not otherwise, but also SOMETIMES working perfectly, in unknown circumstances. Huge thanks to Frank Drebin for figuring this one out; it had been driving me absolutely mad. https://www.youtube.com/watch?v=sC2SeGCTX4U

;I tried windowclass3, (the effect controls) but that does not work, possibly due to stuff in the bins, which would play instead sometimes.

;sleep 10
;ControlSend,DroverLord - Window Class3,^!+5,ahk_exe Adobe Premiere Pro.exe
;that is my shortcut for the Effect Controls.
;sleep 10
;ControlSend,DroverLord - Window Class3,^!+3,ahk_exe Adobe Premiere Pro.exe

;that is my shortcut for the Timeline.
;this is to ensure that it doesn't start playing something in the source monitor, or a bin somewhere.

; ; ; sleep 10
; ; ; ControlSend,DroverLord - Window Class14,{ctrl up}{shift up}{space down},ahk_exe Adobe Premiere Pro.exe
; ; ; sleep 30
; ; ; ControlSend,DroverLord - Window Class14,{space up},ahk_exe Adobe Premiere Pro.exe

;now that we have a panel highlighted, we can send keystokes to premiere. But the panel itself is sometimes random. so it's best to use this to FORCE a specific panel that won't screw stuff up.

;NOTE: the "5" keystroke is sent to Premiere, but it will NOT show up in the keyhistory. I'm not sure why... i guess it has to do with ControlSend. Just FYI for debugging.
;ControlSend,DroverLord - Window Class3, ^+!5,ahk_exe Adobe Premiere Pro.exe ;this shortcut will highlight the EFFECT CONTROLS, which will NOT also stop playback of the source monitor, if it is already playing.
ControlSend,DroverLord - Window Class3, ^+!5,Adobe Premiere Pro 2021 ;this shortcut will highlight the EFFECT CONTROLS, which will NOT also stop playback of the source monitor, if it is already playing.
sleep 40
;msgbox,,, srsly wtf,0.5
;msgbox,srsly wtf
;ControlSend,DroverLord - Window Class3, ^+!5,ahk_exe Adobe Premiere Pro.exe
ControlSend,DroverLord - Window Class3, ^+!5,Adobe Premiere Pro 2021
sleep 10 ;this asn't here at all for a long time. dunno if i really need it.

;FYI, {space} also doesn't show up in the keyhistory.
ControlSend,,{space}, ahk_exe Adobe Premiere Pro.exe
;;;use either the ABOVE line, or the line BELOW. Can't say right now which is better...
;ControlSend,DroverLord - Window Class1,{space},ahk_exe Adobe Premiere Pro.exe
;even though we are sending the "SPACE" to a windowclass that (often) doesn't exist, because we already highlighted the effect controls, the "space" will go to the effect controls panel. USUALLY. Sometimes it still ends up playing some file in some bin.




;in case premiere was accidentally switched to, this will switch the user back to the original window.
if not WinActive(lolClass)
	WinActivate, %lolclass%
}

;end of Premiere play/pause when not in focus.
send {blind}{SC083} ; used as a sort of a debugging flag thingy. Always wise to use BLIND on these. ;also probably terrible if you have windows game bar still enabled, lol.
stopPlayEND:
}



CoordGetControl(xCoord, yCoord, _hWin) ; _hWin should be the ID of the active window
{

	;this overly complicated function will get information about a window without having to move the cursor to those coordinates first. the AHK people really should have a command for this already....
	;Keep in mind, Premiere has LOTS of small windows within it. Open window Spy and move your cursor around Premiere, to see what i mean.

	;script originally from Coco
	; https://autohotkey.com/board/topic/84144-find-classnn-of-control-by-posxy-without-moving-mouse/
	
	
	CtrlArray := Object() 
	WinGet, ControlList, ControlList, ahk_id %_hWin%
	Loop, Parse, ControlList, `n
	{
		Control := A_LoopField
		ControlGetPos, left, top, right, bottom, %Control%, ahk_id %_hWin%
      right += left, bottom += top
		if (xCoord >= left && xCoord <= right && yCoord >= top && yCoord <= bottom)
			MatchList .= Control "|"
	}
	StringTrimRight, MatchList, MatchList, 1
	Loop, Parse, MatchList, |
	{
		ControlGetPos,,, w, h, %A_LoopField%, ahk_id %_hWin%
		Area := w * h
		CtrlArray[Area] := A_LoopField
	}
	for Area, Ctrl in CtrlArray
	{
		Control := Ctrl
		if A_Index = 1
			break
	}
	return w
}




;this is assigned to Macro key G2,
;which was once CTRL numpad0.
;It is currently F21 & F2::
easeInAndOut(){
;NEW method in 2020 is below.
;;sleep 11 isn't needed because it was done already....?
sendevent, {blind}{lshift up}{lctrl up}{rshift up}{rctrl up}{ralt up}{lalt up} ;i have no idea if this will work. This is to try to prevent any stuck modifier keys

sendinput, {blind}{SC0EB} ;this might send a tooltip. ; edit: nope.

send, {blind}^+{f10} ;shortcut is set in premiere to "ease in"
sleep 10
sendinput, {blind}{SC0EB} ;this might send a tooltip.
sleep 5
send, {blind}+{F10} ;shortcut is set in premiere to "ease out"
sleep 5

;sooo, that CTRL SHIFT F10 event has resulted in CTRL being stuck DOWN on more than one occasion. I'm not sure... how... or why...
; https://autohotkey.com/board/topic/94091-sometimes-modifyer-keys-always-down/

; https://www.autohotkey.com/boards/viewtopic.php?f=5&t=26760
; ;--- PREVENT KEYS STICKING ---;
	; KeyList := "Shift|Win|CTRL|alt|Escape|ScrollLock|CapsLock|NumLock|Tab"
	; Loop, Parse, KeyList, |
	; {
		; If GetKeystate(A_Loopfield, "P")
			; Send % "{" A_Loopfield " Up}"
	; }
	; reload
; ;--- /PREVENT KEYS STICKING ---;

;https://www.autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm


sendevent, {blind}{lshift up}{lctrl up}{rshift up}{rctrl up}{ralt up}{lalt up} ;i have no idea if this will work.

sendinput, {blind}{SC0E8} ;scan code of an unassigned key


; ;OLD EASE IN AND EASE OUT before the shortcuts were added for real in 2020
; ;This will click on the necessary menu items for you
; ;all you have to do is hover the cursor over a keyframe (or selected keyframes) in the Effect Controls panel, and hit the button.
; tooltip, ease in and out
; ; blockinput, sendandMouse
; blockinput, MouseMove
; ; blockinput, on
; click right
; send T
; sleep 10
; send E
; send E
; sleep 10
; send {enter}
; sleep 10
; tooltip, 
; ; click right
; click middle
; sendinput {click right}
; send T
; sleep 10
; send E
; sleep 10
; send {enter}
; blockinput, off
; blockinput, MouseMoveOff
; ;sleep 100
; tooltip,
}
;end of easeinandeaseout()

;!+.::msgbox, A_workingDir should be %A_WorkingDir%


;;0000000000 obsolete premiere functions 0000000000000000000

; #IfWinActive ahk_exe Adobe Premiere Pro.exe
; ;TITLE BAR REMOVER
; ;;ctrl backslash is a nice shortcut in MACINTOSH Premiere for hiding the title bar. There is no Windows equivalent... unless you use autohotKey!
; ;;WARNING THOUGH - i think this script makes premiere less stable. I hardly use it...
; ;;https://jacKsautohotKeyblog.wordpress.com/2016/05/27/autohotKey-toggles-and-the-ternary-operator-beginning-hotKeys-part-18/
; ^\::
  ; If (toggle := !toggle)
    ; WinSet, Style, -0xC00000, A
  ; else
    ; WinSet, Style, +0xC00000, A
; Return
;UPDATE:
;Premiere in Windows now HAS this feature by default!! But there is no visible shortcut for it in the shortcuts mapper, strangely enough. Anyway, that makes my script obsolete. yay!

;;;the below function is no longer needed. Premiere now has this feature by default.
;~+K::KbShortcutsFindBox() ;this one DOES need the ~ so that capital Ks will work in the titler, and so that the keyboard shortcuts panel will actually launch when it is pressed.

;;no longer used:
; control g = make 200% speed
;^g::
;Send ^r200{Enter}
;return
;;no longer used:
; control h = make 50% speed
;^h::
;Send ^r50{Enter}
;return

;;00000000000 END of obsolete premiere functions 00000000000000