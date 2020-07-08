Menu, Tray, Icon, shell32.dll, 110 ; changes the icon to a 🚫

;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#NoEnv
;#NoTrayIcon ;comment this in if you do not want a tray icon.
#SingleInstance
#MaxHotkeysPerInterval 2000
Process, Priority, , H
SendMode Input
#SingleInstance force

;These next two lines are very important. You have to change the "menu mask key" away from being CTRL, to something that won't result in cross-talk. Read this thread to learn the details: https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#MenuMaskKey vk07  ; vk07 is unassigned. 
#UseHook

;; take this tutorial if you don't know how AHK works. https://www.autohotkey.com/docs/Tutorial.htm


;; If this script isn't working for you, try Alt_menu_acceleration_DISABLER_using_F13.ahk


;;;; THE READ ME IS BELOW. TRUST ME, YOU SHOULD READ IT. BUT FIRST... ;;;;


; *********** IS THE WINDOWS / XBOX GAME BAR GETTING IN YOUR WAY? ************
; ****************** OR MAYBE IT'S THE NVIDIA SHARE OVERLAY! *****************
; ============================================================================
; ************* HERE ARE THE INSTRUCTIONS FOR HOW TO FIX THAT! ***************
; ============================================================================

; You will need to disable Windows Game Bar, or at least change or disable the shortcuts! Just hit the windows key and search for "game bar settings." Click on that and turn it OFF. Here is a picture of that process: https://i.imgur.com/yQlOB38.png or https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/HOW_TO_DISABLE_GAME_BAR.png

;ALSO, IF YOU HAVE AN NVIDIA GPU, AND YOUR "SHARE" OVERLAY IS ENABLED, YOU WILL NEED TO DISABLE THE "Broadcast LIVE" OVERLAY! You do this from the GEFORCE EXPERIENCE application. Then you click the little triangle that says "Open in-game overlay." Click on the gear, then click on "Broadcast LIVE." Then click the little slider to turn that OFF!!

;EXPLANATION: For some reason, any scan code above SC07F, or any unused virtual key, when preceeded with ALT, acts as the shortcut to enable the game bar or Broadcast Live overlay. I have no idea why this is. It's very frustrating. Those shortcuts cannot be disabled or changed. So you have to disable the thing that it triggers, instead. If you want to use the game bar, AND you want to use the ALT nullifier, you're out of luck. I have no way to do it. Let me know if you figure it out!

; =============================================================================


;-------------------------------  READ ME  ------------------------------------

;TO RUN THIS SCRIPT:


;IF YOU DON'T WANT TO INSTALL AUTOHOTKEY

;You merely need to download the .exe from here:  https://github.com/TaranVH/2nd-keyboard/raw/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.exe

;Now double click on that file to run it.



;ALTERNATIVELY, IF YOU DO WANT TO INSTALL AUTOHOTKEY:

;Download and install autohotkey from here: https://www.autohotkey.com/

;You don't need to download the .exe of this script.

; Instead, go to this exact page https://raw.githubusercontent.com/TaranVH/2nd-keyboard/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.ahk

;...and hit CTRL S to save it somewhere. Make sure it is saved as a .ahk file, not a .txt file!

;Double click on the file to run it.




; ===== TO USE THE SCRIPT: ===== (This applies to the .exe and .ahk -- they are exactly the same.)


;Note that the script will add a little red 🚫 to your taskbar, which can be right clicked to be disabled or exited from the menu.

; You can hold down both ALT keys whenever you want to easily toggle this script on and off. This is useful for things like Premiere's keyboard shortcuts menu, which has ALT-nullification of its own.



;TO AUTO-START THIS SCRIPT WHEN WINDOWS STARTS:

; Once you've chosen a good folder location for the script, right click on it and choose "create shortcut." Then drag that shortcut into your startup folder! KEEP IN MIND that there are TWO startup folders - one for your user account, and one for ALL users. you can use either one. Here they are:

;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

;  C:\Users\Taran\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup


;Here's a video about this script: https://www.youtube.com/watch?v=vRld4bVFrpU




;========================== RAMBLINGS ====================================

; THEY ALL SAID IT COULD NOT BE DONE
; THEY ALL HAD SHITTY SOLUTIONS THAT DIDN'T WORK

; https://superuser.com/questions/309005/disable-the-activation-of-the-menu-bar-when-alt-is-pressed-in-windows-7
; https://forums.adobe.com/thread/1863532
; https://twitter.com/TaranVH/status/993918736510763008

; BUT YOUR MAIN MAN TARAN, HE FIGURED THIS SHIT OUT
; NOW HE CAN GET RID OF ALT MENU ACCELERATION ONCE AND FOR ALL
; AND SO CAN YOU, WITH THIS AHK SCRIPT.


; THE SITUATION:
; In just about any Windows application, pressing (and releasing!) the ALT key will highlight the menu bar in a special way, where pressing a letter key immediately after, (Like F) will result in the menu being opened. Further keystrokes will bring you even deeper into the menu. This is called "menu acceleration."
; So, ALT I R will make a new row in excel, and ALT R C will make a new comment in Word... stuff like that. You only have to press one key at a time, and the key combo still works. 

; THE PROBLEM:
; Because this system allows you to completely release the ALT key before pressing the next keystrokes, it means that ALT is not really a modifier key... it's an obligatory STICKY KEY. https://en.wikipedia.org/wiki/Sticky_keys
; So, in applications that treat the ALT key as a modifier, like Premiere, you sometimes end up activating the menus when you don't want to! (And there's no reason to use menu acceleration anyway, since Premiere already allows you to bind those actions to custom shortcuts.)

; THE COMPLAINT:
; I've looked, and there is no way to disable this feature using the registry... because it's an "accessibility" thing.
; Guess what, Microsoft? I don't have a physical diability, and this feature slows me down. Forcing this feature on EVERYONE just because SOME pople need it, is like ripping out all the stairs, and putting wheelchair ramps in instead. There's no reason to force everyone to use the wheelchair ramps.

; THE THOUGHT PROCESS:
; I noticed that the "File" menu only appears to become activated on the key-up event. However, functionally, it actually activates on the key DOWN event. Therefore, attempting to block this using "LAlt up::[insert code here]" will never work.
; I also noticed that if I pressed down left ALT, held it, and then pressed and released F12, that when I released left ALT... NOTHING HAPPENED. And, when I then pressed F, NOTHING CONTINUED TO HAPPEN.
; Brilliant. And it works with any keystroke, not just F12. so, to nullify the menu acceleration, we have to pair ALT with another keystroke... but which key can we sacrifice? IT can't be used for anything else...
; Some people would think to use F13 through F24. Those poeple are wrong. They are not The Macro King.
; "F24" is just the name that we give to the scan code 76, also known as SC076. But the scan codes go much higher than this.
; How high? I have a list. I made it myself, since nobody else on the internet seems to have done so:

; https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0

; There are hundreds of unused ones to choose from. However, although the following scan codes might APPEAR to be unused...:
;SC05A SC05B SC05C SC05D SC05E SC05F SC060 SC061 SC062 SC06F SC070 SC071 SC072 SC073 SC074 SC075 SC077 SC078 SC079 SC07A SC07B SC07C SC07D SC07E SC07F
;You should probably only use scan codes above SC080. This is because diffreent software will treat each code differently. Google docs, for example, changes some of those scan codes into accented characters. Again, see my spreadsheet for the full, gory details.
; Furthermore, after some testing, I determined that we must address each alt key specifically, for both its down and up events.
;You can comment in the tooltips if you want to do any debugging, but this script should run just fine right out of the box.
;ALT still works normally for everything else.
;ALT I R and other key combos stil work, but now you must be holding ALT down the whole time.


; THE SOLUTION IS LITERALLY JUST TWO LINES:


; ~LAlt::Sendinput {Blind}{sc0E9}
; ~RAlt::Sendinput {Blind}{sc0E9}



;;;Shoutouts to Joshua Elek for sending me the above, improved script! I had not really known about {BLIND} before then!

;;;The "BLIND" is quite important. It works without it, but dang it makes it smoother, because now it doens't have to move around other modifiers before and after the SC0E9 scan code is fired off. It's great. Trust me. Use it.



;;;UPDATE: Those two lines totally work, but I am now trying a slightly different thing instead:

~LAlt::
Sendinput {Blind}{sc0E9}
KeyWait, LAlt ; this wasit for the key to be RELEASED. So that it doesn't keep spamming SC0E9 (as seen from an AHK window Key history and script info... window.)
Sendinput {Blind}{sc0EA}
return

~RAlt::
Sendinput {Blind}{sc0E9}
KeyWait, RAlt ; so that it doesn't keep spamming SC0E9
Sendinput {Blind}{sc0EA}
return

;this was VK07, but i want to be able to distinguish between this, and menu masking, seperately, in my debugging.



;;BELOW IS MY OLD SOLUTION THAT IS PRETTY GOOD, BUT DOESN'T WORK IF YOU HOLD DOWN ALT FOR MORE THAN A SECOND, because Windows actaully fires ALT DOWN over and over again, hah:

/*

~LAlt::
sendinput, {SC0E9 down} ;this is the scan code of an unassigned key. As long as you nor the system never use it for anything else, it can be used in THIS way to cancel the menu acceleration.
KeyWait, LAlt
return

~LAlt up::
sendinput, {SC0E9 up}
return



~RAlt::
;sendinput, {RAlt down}
sendinput, {SC0E9 down}
;;tooltip, Ralt is pressed
KeyWait, RAlt
;;tooltip, Ralt was released
return

~RAlt up::
;sendinput, {RAlt up}
sendinput, {SC0E9 up}
;;tooltip, 
return

*/

;;;;;;;alternatively, it might be as just 2 lines:





Lalt & Ralt::suspend ;hit both ALT keys simultaneously to toggle the functonality of this script. The tray icon will also change visually, so you will always know. You might want to delete this line if it's messing you up!



;;comment in the code below if you wish to reassign alt modifier combinations:



;!f::msgbox,,,To block modifier key use of alt you can do it like this,0.7
;!e::msgbox,,,replace msgbox with whatever code you want,0.7
;!w::msgbox,,,horray for having control of your own computer,0.7
;#ifWinActive ahk_exe Adobe Premiere Pro.exe


; ~!f::f
; !e::e
; !c::c
; !s::s
; !m::m
; !g::g
; !v::v
; !w::w
; !h::h

;or you could just use RETURN to block the key combo completely.

;I have done all this in ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk
;It's on line 1726 at the time of this writring, but that will change.
;To find that, search for: !f::return



;uh ignore this.
;this resulted in the error noise...

; 7B  058	#	d	0.64	F12            	
; 7B  058	 	u	0.08	F12            	
; 7B  058	#	d	0.41	F12            	
; 7B  058	 	u	0.08	F12            	
; A4  038	 	d	0.77	LAlt           	
; 07  000	i	d	0.00	not found      	
; 07  000	i	u	0.00	not found      	
; A4  038	i	u	0.00	LAlt           	
; 00  0E9	i	d	0.00	not found      	
; 07  000	i	d	0.00	not found      	
; A4  038	i	d	0.00	LAlt           	
; 07  000	i	u	0.00	not found      	
; A4  038	 	d	0.50	LAlt           	
; A4  038	 	d	0.03	LAlt           	
; A4  038	 	d	0.03	LAlt           	
; A4  038	 	d	0.03	LAlt           	
; A4  038	 	d	0.03	LAlt           	
; A4  038	 	u	0.03	LAlt           	
; 00  0E9	i	u	0.00	not found      	
; 35  006	#	d	2.48	5              	
; 35  006	 	u	0.06	5              	
; 13  045	h	d	1.72	Pause          	
; 13  045	s	u	0.06	Pause        

; with the new alt killer code that is only 2 lines... it doens't even show up in here...
   	; ;no noise:
; 81  069	h	d	0.08	F18            	
; A4  038	i	d	0.00	LAlt           	
; A0  02A	i	d	0.00	LShift         	
; 35  006	i	d	0.00	5              	
; 35  006	i	u	0.00	5              	
; A4  038	i	u	0.00	LAlt           	
; A0  02A	i	u	0.00	LShift         	
; 1B  001	#	d	0.09	Escape         	
; 81  069	s	u	0.01	F18            	
; 1B  001	 	u	0.06	Escape         	
; 1B  001	#	d	0.06	Escape         	
; 1B  001	 	u	0.08	Escape         	
; 1B  001	#	d	0.06	Escape         

; ;;;and YES a noise:	
; 1B  001	 	u	0.09	Escape         	
; 1B  001	#	d	0.06	Escape         	
; 1B  001	 	u	0.06	Escape         	
; 1B  001	#	d	0.05	Escape         	
; 1B  001	 	u	0.08	Escape         	
; 81  069	h	d	0.09	F18            	
; A4  038	i	d	0.00	LAlt           	
; A0  02A	i	d	0.00	LShift         	
; 35  006	i	d	0.00	5              	
; 35  006	i	u	0.00	5              	
; A4  038	i	u	0.00	LAlt           	
; A0  02A	i	u	0.00	LShift         	
; 81  069	s	u	0.09	F18            	
; 13  045	h	d	1.64	Pause          	
; 13  045	s	u	0.08	Pause          	
; Press [F5] to refresh.

;;biggest differeence is that the firs tone has an escape down event still inside the F18 events. idk why.
;also the 2nd one has more milliseconds on the f18 up event. that's pretty much it.