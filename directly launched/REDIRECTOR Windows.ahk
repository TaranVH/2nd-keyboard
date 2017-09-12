#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\Almost All Windows Functions.ahk

#include C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\point_to_gui.ahk ;this is alreayd in almost all windows functions.ahk,,,, i dont know if you can double include something or not....

#WinActivateForce ;this may prevent taskbar flashing, and force a window to open instead, as it should.

;rather than pointing ALL the scripts directly to this file, I'm pointing them all to this redirect file, which in turn points to the final desintation. In this way, as long as you have REDIRECTOR.ahk in the same folder as the other scripts, you only have to change this one single address.

;Also, the point_to_gui.ahk script is there for ALL scripts to be able to use that special function fo launch the GUI at any time.

