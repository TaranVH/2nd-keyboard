--------------------------------------------------------------------
# TaranVH's install steps for interception, intercept, and AutoHotKey:
--------------------------------------------------------------------
### VIDEO TUTORIAL THAT EXPLAINS ALL THIS IN GREATER DETAIL:
https://www.youtube.com/watch?v=y3e_ri-vOIo

### DOWNLOADING INTERCEPTION:
- Navigate to this page:
- https://github.com/oblitum/Interception
- Click on "download the latest release."
- Click on Interception.zip to download it.
- Unzip the file to some location on your computer.


### INSTALLING INTERCEPTION (tricky):
- Navigate to the folder location of "install-interception.exe" in Windows File Explorer.
- Copy the address from the address bar.
- Open the start menu, and type in <kbd>C</kbd><kbd>M</kbd><kbd>D</kbd>. DO NOT hit "ENTER."
- Instead, <kbd>right click</kbd> on the command prompt item that appeared in your start menu, and <kbd>click</kbd> on "Run as administrator"
- Now inside the admin command prompt, type in "<kbd>c</kbd><kbd>d</kbd><kbd>[spacebar]</kbd>" and hit <kbd>CTRL</kbd> <kbd>V</kbd> to paste the explorer address. For me, I had to type in the following:
```cmd
cd C:\Users\Taran Baron\Downloads\Interception\command line installer
```
- Hit <kbd>ENTER</kbd>
- Now, type in the following line of text exactly as shown:
```
install-interception.exe /install
```
- ...and hit <kbd>ENTER</kbd>
- Once the program installs sucessfully, you still must restart your computer in order to complete the installation.

- (If you ever want to UNinstall interception, watch this): https://www.youtube.com/watch?v=Hn18vv--sFY

### USING INTERCEPT.EXE -- (This is different from intercepTION!)
- Download Kamaz's intercept.exe zip from here:
- http://octopup.org/img/code/interception/intercept.zip
	(If it's no longer available from that location, I've already rehosted it in this folder.)
- Unzip intercept.zip to some location on your computer.
- Plug in your second keyboard and ensure that it is working normally.
- Double click on intercept.exe. It will open a command prompt thingy.
  (Note: If you get "System Error" messages about missing .dll files or an "Application Error" reading "The application was unable to start correctly (0xc000007b).", you need to download the files msvcr100.dll and msvcp100.dll (hosted in this directory) and put them into the same folder as intercept.exe. See the next section for details.)
- Type <kbd>a</kbd> to add a key.
- On the SECONDARY keyboard, press the <kbd>Q</kbd> key once.
- You will be prompted with "Enter combo for this trigger, end with ESC."
- Carefully execute the following keystrokes (it doesn't matter which keyboard):

<kbd>F12 down</kbd>
<kbd>Q down</kbd>
<kbd>Q up</kbd>
<kbd>F12 up</kbd>
<kbd>ESC</kbd>

- Now press <kbd>Q</kbd> again to label the script
- Press <kbd>ENTER</kbd> to accept this label.
- Press <kbd>S</kbd> to save the filter, or <kbd>C</kbd> to cancel if you made a mistake.
- This has the effect of basically "wrapping" the keystroke inside of another keystroke.
- Now repeat the above steps, but using the keys <kbd>W</kbd>, <kbd>E</kbd>, and <kbd>R</kbd>.
- If you make a mistake, you can always just open the .ini file in a text editor and delete any bad entries.

### DLLs NEEDED TO RUN INTERCEPT.EXE -- (You don't need this if intercept.exe works for you already.)

The version of intercept.exe hosted here needs the **32-bit** versions of the following DLLs to run successfully:

- msvcr100.dll
- msvcp100.dll

These 32-bit versions may be missing on newer 64-bit Windows systems. Confusingly, your system might have
**64-bit** versions of these files installed in `C:\Windows\System32` (sic!). In
this case, intercept.exe will either complain that it cannot find these files
or it will stop with an "Application Error" reading "The application was unable
to start correctly (0xc000007b)."

The correct 32-bit versions of these DLLs must be in the same folder as intercept.exe (or somewhere in the system's search
path for DLLs) in order to run intercept.exe. The two DLLs are part of Microsoft's "Visual C++ Redistributable" package
for "Visual Studio 2010 (VC++ 10.0) SP1".

For your convenience, the two DLLs are hosted in this directory. Just download them and put them next to `intercept.exe`
in the same folder. Do NOT replace the existing DLLs in `C:\Windows\System32` with the downloaded files! (Other programs
may need these 64-bit versions to work correctly.)

If you prefer to get the DLLs directly from Microsoft, instead, proceed as follows:

- Go to https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170
 (If this link should become bad, search the Microsoft site for "Visual C++ Redistributable Downloads".)
- Find the downloads for "Visual Studio 2010 (VC++ 10.0) SP1".
- Download the file `vcredist_x86.exe`.
- Do NOT run this file (unless you really want to install these very old components system-wide).
- Instead, use 7-Zip to open `vcredist_x86.exe` as an archive! (This may or may not work with other archiver tools, but I only have 7-Zip to test.)
- Within the archive, find the file `vc_red.cab`. It is in the top-level directory of the archive but
  for some strange reason, you may have to open the `.` (dot) folder in the archive several times until you see it.
- Still in 7-Zip, double-click `vc_red.cab` to open it as an archive.
- You should now see a list of files including `F_CENTRAL_msvcr100_x86` and `F_CENTRAL_msvcp100_x86`.
- Extract these two files to the same folder as `intercept.exe` and rename them to `msvcr100.dll` and `msvcp100.dll`, respectively.
- Now, double-clicking `intercept.exe` should successfully start the program.

### CREATING THE AUTOHOTKEY SCRIPT
- Download and install autohotkey if you don't have it:
- https://autohotkey.com/
- Right click on the desktop and select "New" > "AutoHotKey Script"
- Name the file "baby's first extra keyboard.ahk"
- Right click on the file and choose "Open with" > "Notepad". (Or, use your text editor of choice. Do not use Word.)
- In that file, there will already be a few lines of code. Beneath them, insert the following lines of code, up to the #if:
```
#SingleInstance force
#if (getKeyState("F12", "P"))
F12::return
q::msgbox, you pressed Q on the extra keyboard
w::msgbox, you pressed %A_thishotkey% on the extra keyboard
e::tooltip, you pressed %A_thishotkey% on the extra keyboard
r::SoundBeep, 1000, 500
#if
;Done with F12
```
- Now save the file. ("baby's first extra keyboard.ahk")
- Double click on the file to get it running.


### PUTTING IT ALL TOGETHER:

- Make sure that Intercept.exe is running, with the filters applied. (press Y to apply them. Do not close the window.)
- Open a blank text file and type "QWERTY" using your primary keyboard in it to ensure that it works.
- Now, type Q, W, E, or R on your secondary keyboard. Instead of text, you should recieve message boxes, tooltips, or a beep.
- Now that you have that working, you can restart intercept.exe, and (A)dd all the remaining keys, using the method described above.
- HOWEVER, that will be very slow. So instead, you can download and use Taran's files, "keyremap.ini" and "FULL_extra_keyboard.ahk" and customize them to your own computer.


- If you use Taran's keyremap.ini, be sure to "find and replace" all instances of this line:
```
device=HID\VID_046D&PID_C31C&REV_6400&MI_00
```
...with the device ID of your own secondary keyboard. (Again, you can get this info by (A)dding a filter in intercept.exe.)

- If you create your own keyremap.ini, you should find and replace all instances of `58,0,` (the scan code for F12) with `6E,0,` (the scan code for F23.) This is simply so that you do not make your F12 key unusable.
- Also, ensure that your AutoHotKey script is listening for F23 rather than F12, by modifying the code like so:
```
#if (getKeyState("F23", "P"))
F23::return

;;; put all your keys here ;;;

#if
;Done with F23
```




### ADDITIONAL RECOURCES:
> Kamaz's original post:

> http://orbiter-forum.com/showthread.php?t=30829

> geoffff's follow-up post:

> https://autohotkey.com/boards/viewtopic.php?p=61425&sid=c49c82a1247806ce92836a945aad4b37#p61425



 
