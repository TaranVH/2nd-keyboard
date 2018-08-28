I tried HidMacros/LuaMacros but I found that it didn’t do a good job of keeping track of my USB keyboards when I unplugged them and plugged them back in again.

Instead I ended up using Interception (http://www.oblita.com/interception.html) and this command-line interface for it posted by user kamaz on Orbiter Forum (http://orbiter-forum.com/showthread.php?t=30829).

Install steps:
•	Run the interception installer in the https://github.com/oblitum/Interception/releases/download/1.0.0/Interception.zip file from GitHub (https://github.com/oblitum/Interception/releases/tag/1.0.0) and reboot. Do not run the old installer linked by kamaz in the Orbiter Forum post.
•	Download kamaz’s intercept.exe tool posted on Orbiter Forum (http://octopup.org/img/code/interception/intercept.zip). You can use this intercept.exe command-line tool to configure your keyboard remappings, or directly edit the keyremap.ini file it uses. Try making a few remappings and save them to understand the keyremap.ini file format.
•	Optional: Use my start-intercept.vbs (http://octopup.org/img/code/interception/start-intercept.zip) tool to automatically configure intercept.exe to run when you start Windows, without requiring a command prompt window to be left lying around. I placed a shortcut to start-intercept.vbs in my Windows Startup Programs folder.

You can download my copies of everything from here if you like: http://octopup.org/img/code/interception/interception.zip

