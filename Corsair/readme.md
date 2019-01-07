So this is how to use the Corsair K55 as a secondary keyboard. If you need context, watch my Hasu USB converer video, linked below.

Before you begin, please check the description of this video in case there are any corrections or updates.

iCue - only 1 Corsair keyboard can be used at a time
Even if they do add that feature, it's likely that multiple K55 keyboards will still act as the same keyboard, unless they also add USB port detection.

There's no point in adding a 2nd keyboard unless you're already familiar with AutoHotKey fundamentals: https://autohotkey.com/docs/Tutorial.htm

OKAY, LET'S GET STARTED

DOWNLOAD AND INSTALL THESE:
https://www.corsair.com/ca/en/icue
https://www.autohotkey.com/download/

<Optional>:
Notepad++
https://notepad-plus-plus.org/download/v7.6.2.html
Syntax highlighting for .ahk scripts:
https://www.autohotkey.com/boards/viewtopic.php?t=50
</Optional>

Create this exact folder structure on your PC
C:\AHK\2nd-keyboard\Corsair

Download CORSAIR files from my github
https://github.com/TaranVH/2nd-keyboard/Corsair

Place the AutoHotkey script, here:
C:\AHK\2nd-keyboard\Corsair\2nd_keyboard_if_using_iCue.ahk

Double click on it to get it running. A blue folder icon should appear in your taskbar.

Open iCue and import K55_wrapped_in_F24.cueprofile
	I do not know if this will work for other Corsair keyboards...
	
Make sure that that profile is active.
Make sure that the .ah script is running.
	
Open a notepad window, and try typing on your Corsair Keyboard. Every single key should result in a tooltip instead. Success!

Now it's up to you, to replace each of those lines with calls to your own scripts and functions. You can find some of mine, here: https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Windows_Functions.ahk




You will want to make this .ahk script tart up automatically when Windows does.
Navigate to C:\AHK\2nd-keyboard\Corsair
Right click on 2nd_keyboard_if_using_iCue.ahk and select "create shortcut."

Navigate to:
C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
(Replace YOUR_USERNAME with your own username)

Or navigate here if you want this script to launch for ALL users:
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

And move the shortcut file into that folder.
I also like to add it to my start menu. (Right click the folder, select "pin to start.")


