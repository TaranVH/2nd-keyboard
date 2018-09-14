;msgbox, this is the original place I tested the Send_WM_COPYDATA function.

StringToSend = preset("blur with edges")
result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)

preset("blur with edges")

return



SetWorkingDir %A_ScriptDir%
#Include %A_ScriptDir%/REDIRECTOR.ahk

;filetype := """" . filetype . """" ;this ADDS quotation marks around a string in case you need that.
;StringReplace, directory,directory,", , All ;" ; this REMOVES the quotation marks around the a string if they are present.