;msgbox, this is the original place I tested the Send_WM_COPYDATA function.

StringToSend = Premiere direct
result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)

switchToPremiere()

Exitapp


SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR Windows.ahk

;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
;StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.