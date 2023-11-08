# Creating a secondary, macro keyboard with Corsair iCue

If you need context, watch my Hasu USB converter video: https://youtu.be/GZEoss4XIgc
And here is the associated tutorial that goes with this readme: https://youtu.be/I9HYN6qA5CY

[Before you begin, please check the description of the video in case there are any corrections or updates.]

NOTE: In iCue, only 1 Corsair keyboard can be used at a time. More info: https://www.youtube.com/watch?v=BuLyxcyhbLQ

Even if they do add that feature, it's likely that multiple K55 keyboards will still act as the same keyboard, unless they also add USB port detection.

Don't bother adding a 2nd keyboard unless you're already familiar with AutoHotKey fundamentals: https://autohotkey.com/docs/Tutorial.htm

### **OKAY, LET'S DO THIS**

Download and install the following:

- https://www.corsair.com/ca/en/s/downloads
- https://www.autohotkey.com/download/
- Optional: Notepad++  https://notepad-plus-plus.org/download/v7.6.2.html
- Optional: Syntax highlighting for .ahk scripts: https://www.autohotkey.com/boards/viewtopic.php?t=50
- Optional: AutoHotkey Plus Plus (V1 and V2 language support for VSCode): https://marketplace.visualstudio.com/items?itemName=mark-wiemer.vscode-autohotkey-plus-plus

- Create this exact folder structure on your PC:

```C:\AHK\2nd-keyboard\Corsair```

- Download ```iCue_F24_macro_keyboard.ahk``` and ```K55_wrapped_in_F24.cueprofile```

https://github.com/TaranVH/2nd-keyboard/tree/6757b95b3ab5fe898f2b7216f008359963baa8a8/Corsair

- Place the AutoHotkey script here:

```C:\AHK\2nd-keyboard\Corsair\iCue_F24_macro_keyboard.ahk```

- In an Explorer window, double-click on the .ahk script to get it running. An "H" icon should appear in your taskbar. You can hover over it to view the script name or right-click it for a little menu.
  
- Open iCue and import ```K55_wrapped_in_F24.cueprofile```
  (I do not know if this will work for other Corsair keyboards...)
  
- Make sure that that profile is active.
  
- Make sure that the .ahk script is running.
  
- Open a notepad window, and try typing on your Corsair Keyboard. Every single key should result in a tooltip instead. Success!

- NOTE: If you mash keys too rapidly, some unwrapped keystrokes might get through. But, you shouldn't ever need to do that, since this is a macro keyboard, intended for only an occasional, single key press.
  
- Now it's up to you, to replace each of those lines with calls to your own scripts and functions. It's all just normal AHK scripting from this point on. You can find some of my functions, here: https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Windows_Functions.ahk



### Auto-launch

- You will want to make this .ahk script start up automatically when Windows does.

- Navigate to ```C:\AHK\2nd-keyboard\Corsair```

- Right click on ```iCue_F24_macro_keyboard.ahk``` and select "create shortcut."

- Navigate to: ```%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup```

- Or navigate here if you want this script to launch for ALL users: ```C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp```

- ...And move the shortcut file into that folder.

I also like to add it to my start menu. (Right-click the folder, and select "pin to start.")
