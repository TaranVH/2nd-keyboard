--------------------------------------------------------------------
TaranVH's install steps for interception, intercept, and AutoHotKey:
--------------------------------------------------------------------

DOWNLOADING INTERCEPTION:
Navigate to this page:
https://github.com/oblitum/Interception
Click on "download the latest release."
Click on Interception.zip to download it.
Unzip the file to some location on your computer.


INSTALLING INTERCEPTION (tricky):
Navigate to the folder location of "install-interception.exe" in Windows File Explorer.
Copy the address from the address bar.
Open the start menu, and type in "CMD". DO NOT hit ENTER.
Instead, right click on the command prompt item that appeared in your start menu, and click on "run as administrator"
Now inside the admin command prompt, type in "cd " and hit CTRL V to paste the explorer address. Then hit ENTER. For me, I had to type in the following:
cd C:\Users\Taran Baron\Downloads\Interception\command line installer
Now, type in the following line of text exactly as shown:
install-interception.exe /install
...and hit ENTER.
Now you need to restart your computer in order to complete the installation.


INSTALLING INTERCEPT.EXE -- (This is different from intercepTION!)
Download Kamaz's intercept.exe zip from here:
http://octopup.org/img/code/interception/intercept.zip
	(Let me know if this file ever goes offline, I'll rehost it.)
Unzip intercept.zip to some location on your computer.
Plug in your second keyboard and ensure that it is working normally.
Double click on intercept.exe. It will open a command prompt thingy.
Type "a" to add a key.
On the SECONDARY keyboard, press the Q key once.
You will be prompted with "Enter combo for this trigger, end with ESC."
Carefully execute the following keystrokes (it doesn't matter which keyboard):
F12 DOWN
Q DOWN
Q UP
F12 UP
ESC
Now press Q again to label the script
Press ENTER to accept this label.
Press S to save the filter, or C to cancel if you made a mistake.
This has the effect of basically "wrapping" the keystroke inside of another keystroke.
Now repeat the above steps, but using the keys W, E, and R.


CREATING THE AUTOHOTKEY SCRIPT
Download and install autohotkey if you don't have it:
https://autohotkey.com/
Right click on the desktop and select "New" > "AutoHotKey Script"
Name the file "baby's first extra keyboard.ahk"
Right click on the file and choose "Open with" > "Notepad". (Or, use your text editor of choice. Do not use Word.)
In that file, there will already be a few lines of code. Beneath them, insert the following lines of code, up to the #if:

#SingleInstance force
#if (getKeyState("F12", "P"))
F12::return
q::msgbox, you pressed Q on the extra keyboard
w::msgbox, you pressed %A_thishotkey% on the extra keyboard
e::tooltip, you pressed %A_thishotkey% on the extra keyboard
r::SoundBeep, 1000, 500
#if

Now save the file. ("baby's first extra keyboard.ahk")
Double click on the file to get it running.


PUTTING IT ALL TOGETHER:

Make sure that Intercept.exe is running, with the filters applied. (press Y to apply them. Do not close the window.)
Open a blank text file and type "QWERTY" using your primary keyboard in it to ensure that it works.
Now, type Q, W, E, or R on your secondary keyboard. Instead of text, you should recieve message boxes, tooltips, or a beep.
Now that you have that working, you can restart intercept.exe, and (A)dd all the remaining keys, using the method described above.
HOWEVER, that will be very slow. So instead, you can download and use Taran's files, "keyremap.ini" and "fancy extra keyboards.ahk" and customize them to your own computer.

If you use Taran's keyremap.ini, be sure to "find and replace" all instances of the following line:
device=HID\VID_046D&PID_C31C&REV_6400&MI_00
with the device ID of your own secondary keyboard. (Again, you can get this info by (A)dding a filter in intercept.exe.)

If you create your own keyremap.ini, you should replace all instances of "58," (the scan code for F12) with "6E," (the scan code for F23.)
This is simply so that you do not make your F12 key unusable.
Also, ensure that your AutoHotKey script is listening for F23 rather than F12.





-----------------------------------------------------------------------------------------------
ADDITIONAL RECOURCES:
Kamaz's original post:
http://orbiter-forum.com/showthread.php?t=30829
geoffff's follow-up post:
https://autohotkey.com/boards/viewtopic.php?p=61425&sid=c49c82a1247806ce92836a945aad4b37#p61425
-----------------------------------------------------------------------------------------------
