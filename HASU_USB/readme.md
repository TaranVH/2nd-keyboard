# Creating a secondary, macro keyboard with the Hasu USB keyboard converter

Main video is here: https://youtu.be/GZEoss4XIgc

An accompanying video tutorial can be found here: https://youtu.be/kTXK8kZaZ8c

The converter: https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/
The K120: (But any cheap keyboard will work) https://www.logitech.com/en-ca/product/k120

What follows is the alternative to using this incomplete online TMK tool: 
http://www.tmk-kbd.com/tmk_keyboard/editor/unimap/?usb_usb

Oh, there's also a QMK one, but IDK if it has full functionality either:
https://config.qmk.fm/#/converter/usb_usb/hasu/LAYOUT_all

As another alternative, you can just use this .hex file that I already created for you:
 https://github.com/TaranVH/2nd-keyboard/blob/master/HASU_USB/F24/F24.hex

Here are some alternative instructions for how to set up the environment, using MSYS2 rather than Ubuntu in Windows: https://beta.docs.qmk.fm/newbs/newbs_getting_started#set-up-your-environment (I tried it and failed to get it working)

 
## SETTING UP YOUR DEVELOPMENT ENVIRONMENT OR WHATEVER IT'S CALLED (USING UBUNTU INSIDE OF WINDOWS)

- We need to install the Ubuntu subsystem on Windows 10
- Apparently there's a ton of guides on how to do it, (which are probably better than this one!)
- First, check to see if you have Ubuntu installed already, by searching for ```ubuntu``` or ```bash``` in your start menu. If you already have it, skip the steps below.

### TURNING ON UBUNTU IN WINDOWS, OR WHATEVER THIS IS
- Go to your control panel by hitting the WIN key, typing ```control panel```, and hitting ENTER.
- Click “Programs and Features.”
- On the left side, click “Turn Windows features on or off”
- In the window that appears, scroll down until you see “Windows Subsystem for Linux.”
- If the box to the left of “Windows Subsystem for Linux” does NOT have a check mark in it, click on the box to make a check mark appear. ☑
- Click “Okay”
- Exit the control panel; you don’t need it anymore.
- You’ll have to restart your machine now. Hah!

### OK, BACK TO SETTING UP UBUNTU IN WINDOWS
- Hit the Windows key, search for “Microsoft Store,” and hit ENTER
- In the top left of the Microsoft Store window, click on the search box and search for “Ubuntu.” It should be the first result. Click on that and click “Get” to install it, if you don’t already have it.
- Click the "launch" button when it appears, to launch Ubuntu
- Follow whatever prompts you get, to install Ubuntu.
- You may have to create a username and password for your subsystem. Remember your password - it will be used for elevated commands

- After you open a command line shell, type in
- ```sudo apt-get update -y```
- then,
- ```sudo apt-get upgrade -y```

…This will upgrade your Ubuntu to have the most recent updates

(Press ENTER each time you type in a command, of course!)

- Now, install git like by typing this in:
- ```sudo apt-get install git```

- Next, use Windows Explorer to create a directory somewhere. I strongly recommend ```C:\qmk```
- In your Ubuntu window, go to that directory by typing
- ```cd /mnt/c/qmk```
- Once there, type in:
- ```git clone https://github.com/qmk/qmk_firmware.git```
- This should copy the contents to a local directory.
- Then, type in:
- ```cd qmk_firmware```
- This will bring you to /mnt/c/qmk/qmk_firmware/
- Next, type in:
- ```sudo util/wsl_install.sh```
- This will install all the tools needed for qmk.
- Type in ```Y``` for (Y)es as needed during that installation process.
- Now, open a File Explorer window, and go here:
- ```C:\qmk\qmk_firmware\keyboards\converter\usb_usb\keymaps\default``` (or wherever you put your keymap directory)
- Make a copy the “default” folder, and name it whatever you like. I named mine like so:
- ```C:\qmk\qmk_firmware\keyboards\converter\usb_usb\keymaps\my_special_keyboard```
- Inside of that folder, you’ll find a ```keymap.c``` file. You can now change or edit this keymap however you like. Documentation can be found here, under the heading “How to customize:” https://docs.qmk.fm/#/

### NOW WE CAN MAKE A HEX FILE ALREADY

- Now that your ```keymap.c``` and ```config.h``` files are how you want them, you’re ready to turn that into a .hex file.
- Back on the Ubuntu command line, type in the following to go to the qmk base directory:
- ```cd /mnt/c/qmk/qmk_firmware```
- Then, type in:
- ```sudo make converter/usb_usb:my_special_keyboard```
- (“my_special_keyboard” because that’s the directory where the keymap was edited.)
- Now, your hex file can be found in:
- ```C:\qmk\qmk_firmware```

-------------

### FLASHING THE HEX FILE ONTO THE USB KEYBOARD CONVERTER

- (If the instructions below do not work, try this instead: https://github.com/mechmerlin/qmk_setup/blob/master/windows_flashing.md )
- Make sure that your usb converter is NOT plugged in.
- Download, install, and run QMK Toolbox: https://github.com/qmk/qmk_toolbox/releases
- Plug in your USB converter by itself, with no keyboard attached to it. Wait to hear the Windows “hardware found” sound.  (“Beeedlde-BOOP!”)
- On the top of the USB converter, press the small button.
- You should hear the Windows “hardware disconnected” sound, and then “hardware found” sound again.
- In QMK toolbox, click OPEN and locate your hex file in the resulting Explorer window.
- Now, click FLASH.
- Wait for QMK toolbox to do its thing. You should see “```DFU Device disconnected```” in yellow text when it’s done.
- Unplug your USB converter from your computer.

- Now it is fully functional! Just make sure to always plug it in by itself first, and THEN plug a keyboard into the back, or it probably won’t work. Also, try to avoid using USB ports on monitors which might turn off or power down when the computer is not on – you might have to re-plug it in, which gets annoying. Ideally, you’ll plug this in directly to one of the PC’s own USB ports.

- Also, you may wish to use a tiny USB extension cable, if you fear that the converter might get damaged if it is accidentally yanked on from a bad angle.

## YOU ONLY HAVE HALF OF WHAT YOU NEED, SO NEXT IS:

### GETTING THIS TO WORK WITH AUTOHOTKEY

- Download and install Autohotkey... but you should already have it, and be familiar with it: https://www.autohotkey.com/download/
- Download this script:
https://github.com/TaranVH/2nd-keyboard/blob/master/HASU_USB/QMK_F24_macro_keyboard.ahk

- Use an Explorer window to create this folder structure, and save it here.

- ```C:\AHK\2nd-keyboard\HASU_USB\QMK_F24_macro_keyboard.ahk```

- In Explorer, double-click on the AHK script to get it running. A friendly green "H" icon should appear in your taskbar. Boop!

- Now, try typing into a text document. Instead of text, you should be seeing tooltips, no matter which key you press. (Well, F1 and F2 will result in message boxes.)

### NOW YOU FILL UP THAT AHK SCRIPT WITH FUNCTIONS! YAH!

IF YOU ARE NEW TO AUTOHOTKEY, TAKE THIS TUTORIAL:
https://autohotkey.com/docs/Tutorial.htm

You're free to use and modify any of my own scripts: https://github.com/TaranVH/2nd-keyboard/blob/master/Almost_All_Windows_Functions.ahk I recommend that you start with ```instantExplorer()```

### Whatever

- This readme / written guide might be light on detail, or inaccurate,  or I might have gotten names of some things wrong. If you want to improve this readme file, go right ahead. I'll merge your changes, provided that you are not just trolling or whatever.

