StringToSend = fakeFunction("from E",0)
;; The above line is the only thing you should change. Write out the function you wish to call in exactly the same way you would with any function! Otherwise it won't work!! Note that it must have two parameters. (Unless you modify the code yourself.) If you don't want to use the 2nd parameters, just put a 0.

result := Send_WM_COPYDATA(StringToSend)
;The above line is what actaully calls the Send_WM_COPYDATA function, which is defined in the REDIRECTOR_RAZER.ahk script, which has been #include-d below. Yeah. You can define functions even below an "Exitapp" command.

;At this point, we are hoping to recieve "true" as our result. If it fails, we will recieve "fail".

if (result = 0)
	wasIgnored()

if (result = "fail"){
	failtastic(stringtosend,result) ;I want to have as little code in these small scripts as possible. failtastic(,) is therefore defined inside of the REDIRECTOR_RAZER.ahk script.
	}

Exitapp


SetWorkingDir %A_ScriptDir% ;<--This is superior to the alternative on the following line:
;SetWorkingDir C:\AHK\2nd-keyboard\Razer\razer_direct_launch
;Because even though they both achieve the same result, the way I've done it means that you can move the entire folder wherever you want. The downside is that you'd still have to redefine all the script locations inside of razer synapse. yikes!
#Include %A_ScriptDir%/REDIRECTOR_RAZER.ahk ;<-- REDIRECTOR_RAZER.ahk must always be in the same folder as all the smaller scripts (like this one) that it is servicing.
