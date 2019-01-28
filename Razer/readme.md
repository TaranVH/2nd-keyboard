# Using Razer Synapse to create a secondary macro keyboard

If you need context, watch my Hasu USB converer video, linked here: https://youtu.be/GZEoss4XIgc

This readme file has an associated video, available here: https://youtu.be/GttedCcyxa4

[If there are updates / corrections, they will be in this paragraph]

----

Razer Synapse can detect multiple Razer keyboards at once!

That said, it's possible that it would treat two Cyonosa Chromas as the same keyboard. So you'd need a different model if you wanted to add a 3rd keyboard. [Note, if someone can send me proof one way or another, I'd appreciate it.]

Don't bother adding a 2nd keyboard unless you're already familiar with AutoHotKey fundamentals: https://autohotkey.com/docs/Tutorial.htm

Don't buy a Razer Cyonosa Chroma until you test these scripts to see how long the delay is!

### **OKAY, LET'S DO THIS**

Download and install the following:

- https://www.razer.com/synapse-3
- https://www.autohotkey.com/download/
- Optional: Notepad++  https://notepad-plus-plus.org/download/v7.6.2.html
- Optional: Syntax highlighting for .ahk scripts: https://www.autohotkey.com/boards/viewtopic.php?t=50

- Create this EXACT folder structure on your PC:

 ```C:\AHK\2nd-keyboard\Razer```

- Use <kbd>CTRL</kbd> <kbd>S</kbd> to download this file. Delete the ```.txt``` if it appears:  https://raw.githubusercontent.com/TaranVH/2nd-keyboard/master/Razer/Razer_macro_keyboard.ahk
- Place it here, exactly: (Otherwise, none of the direct launch scripts will work!)

```C:\AHK\2nd-keyboard\Razer\2nd_keyboard_if_using_Razer.ahk```

- In Explorer, double click on the .ahk file to get it running. A green tree icon should appear in your taskbar.

- Download ALL 106 scripts in this folder:
https://github.com/TaranVH/2nd-keyboard/tree/master/Razer/razer_direct_launch

(Github doesn't have a way to do this, so here is a direct link:)
https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/TaranVH/2nd-keyboard/tree/master/Razer/razer_direct_launch

- Unzip that file and make sure that all the scripts go exactly here:

```C:\AHK\2nd-keyboard\Razer\razer_direct_launch\``` (scripts go here)

- Now, you can double click on any of them to test how long the delay is before you get a messagebox. It should be very minimal. If the delay is too long, this method might not be the best one for you.

- Download this file: 
https://github.com/TaranVH/2nd-keyboard/blob/master/Razer/Cyonosa_macro_Keyboard.synapse3

- Open Razer Synapse and import ```Cyonosa_2nd_Keyboard.synapse3```

- Make sure that the Razer profile is active on your Cyonosa Chroma keyboard.

- Make sure that the .ahk script is running.

- Hit a key on your Razer keyboard. A message box should appear that includes the word **"Horray."** Success!

If you don't dismiss the message box within 5 seconds, an error message will appear. Also, if you try to launch any other script while the box is up, you will get a tooltip instead, informing you that you already have a script running.

This gets a bit complicated, but basically, we had to do it in this special way, to avoid cross-talk, making sure that only one script is running at a time. Otherwise, you'd have multiple competing threads, if you accidentally hit more than one key at a time.

Simply using #include to get your functions into the first .ahk script is not good enough; that still results in cross-talk.

But if you like, you can use Razer Synapse to directly launch an autohotkey script of your own design, which is independent from all the other ones. The sky's the limit!

- Now it's up to you, to replace each of those lines in Razer_macro_keyboard.ahk with calls to your own functions. It's all just normal AHK scripting from this point on. You can find some of my functions, here: https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Windows_Functions.ahk


### Auto-launching

- You will want to make this .ahk script start up automatically when Windows does.
- Navigate to C:\AHK\2nd-keyboard\Razer
- Right click on ```Razer_macro_keyboard.ahk``` and select "create shortcut."

- Navigate to: ```C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup```

(Replace YOUR_USERNAME with your own username)

- Or navigate here if you want this script to launch for ALL users: ```C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp```

- ...And move the shortcut file into that folder.

I also like to add it to my start menu. (Right click the folder, select "pin to start.")


