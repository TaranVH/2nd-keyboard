StringToSend = runexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
Send_WM_COPYDATA(StringToSend)
runexplorer("Z:\Linus\1. Linus Tech Tips\1. Template File Structure\Project")
Exitapp
SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk