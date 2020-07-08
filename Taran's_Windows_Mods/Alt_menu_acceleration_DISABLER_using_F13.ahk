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


;; this script belongs to this video
; https://www.youtube.com/watch?v=vRld4bVFrpU

;; I RECOMMEND THAT YO USE Alt_menu_acceleration_DISABLER.ahk INSTEAD. IT USES SC0E9 AND SC0EA.  HOWEVER, IF THAT SCRIPT ISN'T WORKING FOR YOU, TRY THIS ONE.

;;WHAT FOLLOWS IS THE RATIONALE/CONVERSATION FOR WHY I CREATED THIS ALTERNATIVE SCRIPT.

;;DO NOT USE BOTH OF THEM AT THE SAME TIME! USE ONLY THIS ONE OR THE OTHER ONE.

/*
Elite_ Eight
Elite_ Eight
1 week ago
@Taran Van Hemert i downloaded the .exe file but is not working. I just want to die. Can you confirm isn't working anymore?
Taran Van Hemert
Taran Van Hemert
1 week ago (edited)
@Elite_ Eight hmmmmmmmmmm, I'll make a new one for you tomorrow. Check the github folder then.
Elite_ Eight
Elite_ Eight
1 week ago
@Taran Van Hemert thanks you!!!
Taran Van Hemert
Taran Van Hemert
6 days ago
@Elite_ Eight it's updated now
1
Elite_ Eight
Elite_ Eight
6 days ago
@Taran Van Hemert Thx. I'll try asap!
Elite_ Eight
Elite_ Eight
6 hours ago
​@Taran Van Hemert  i downloaded the script from here https://github.com/TaranVH/2nd-keyboard/raw/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.exe run it and still no effect. When i release alt that fucking menu still pop out
Taran Van Hemert
Taran Van Hemert
6 hours ago
@Elite_ Eight you mean, when you release alt, and then hit another key like F, right?
And did you try manual alt nullification by using F12 like I show you in this video?
Elite_ Eight
Elite_ Eight
6 hours ago (edited)
@Taran Van Hemert no, i mean exactly what i've said. When i release alt the start menu open, and it does open even if i'm inside of full screen application like videogames, bringing me back to windows while i'm playing, so for me alt is just a forbidden key. if i push alt+f open "hub feedback" which i don't even know what is it, and there are many other combination with other letters. I tried to push alt +f12 like you said in the video and nothing happen
Taran Van Hemert
Taran Van Hemert
54 minutes ago
@Elite_ Eight well, I can make you a special one that works with F13.
Elite_ Eight
Elite_ Eight
44 minutes ago
@Taran Van Hemert don't bother man, i just solved. After some try i find out that was a matter of keyboard, cause i tried an old one and the problem wasn't there. So i made some search about my keyboard and discovered that if "gaming mode" isn't enabled those stupid shortcut can be triggered. I'm sorry to have wasted your time 

*/

; *********** IS THE WINDOWS / XBOX GAME BAR GETTING IN YOUR WAY? ************
; ****************** OR MAYBE IT'S THE NVIDIA SHARE OVERLAY! *****************
; ============================================================================
; ************* HERE ARE THE INSTRUCTIONS FOR HOW TO FIX THAT! ***************
; ============================================================================

; You will need to disable Windows Game Bar, or at least change or disable the shortcuts! Just hit the windows key and search for "game bar settings." Click on that and turn it OFF. Here is a picture of that process: https://i.imgur.com/yQlOB38.png or https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/HOW_TO_DISABLE_GAME_BAR.png

;ALSO, IF YOU HAVE AN NVIDIA GPU, AND YOUR "SHARE" OVERLAY IS ENABLED, YOU WILL NEED TO DISABLE THE "Broadcast LIVE" OVERLAY! You do this from the GEFORCE EXPERIENCE application. Then you click the little triangle that says "Open in-game overlay." Click on the gear, then click on "Broadcast LIVE." Then click the little slider to turn that OFF!!

;EXPLANATION: For some reason, any scan code above SC07F, or any unused virtual key, when preceeded with ALT, acts as the shortcut to enable the game bar or Broadcast Live overlay. I have no idea why this is. It's very frustrating. Those shortcuts cannot be disabled or changed. So you have to disable the thing that it triggers, instead. If you want to use the game bar, AND you want to use the ALT nullifier, you're out of luck. I have no way to do it. Let me know if you figure it out!

; =============================================================================


;---------------------------

~LAlt::Sendinput {Blind}{F13}
~RAlt::Sendinput {Blind}{F13}



;;;Shoutouts to Joshua Elek for sending me the above, improved script! I had not really known about {BLIND} before then!

;;;The "BLIND" is quite important. It works without it, but dang it makes it smoother, because now it doens't have to move around other modifiers before and after the SC0E9 scan code is fired off. It's great. Trust me. Use it.



; ;;;UPDATE: Those two lines totally work, but I am now trying a slightly different thing instead:

; ~LAlt::
; Sendinput {Blind}{F13}
; KeyWait, LAlt ; so that it doesn't keep spamming SC0E9 (as seen from an AHK window Key history and script info... window.)
; return

; ~RAlt::
; Sendinput {Blind}{F13}
; KeyWait, RAlt ; so that it doesn't keep spamming SC0E9
; return

