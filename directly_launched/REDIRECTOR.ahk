#include C:\AHK\2nd-keyboard\Almost_All_Premiere_Functions.ahk

#include C:\AHK\2nd-keyboard\point_to_gui.ahk

;rather than pointing ALL the individual scripts directly to Almost_All_Premiere_Functions.ahk, I'm pointing them all to THIS redirect file, which in turn points to Almost_All_Premiere_Functions.ahk.

;In this way, as long as you have REDIRECTOR.ahk in the same folder as the other scripts, you only have to change this one single address.

;Also, the point_to_gui.ahk script is there for ALL scripts to be able to use that special function fo launch the GUI at any time.
;specifically, I think, keyshower()