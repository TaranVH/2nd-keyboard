; #WinActivateForce
;need code to first check if the locaiton is even available... in case the server crashes like is has before...


;Filemover("Z:\Linus\6. Channel Super Fun\CSF Transcode\CSF match source") ;<-- this does NOT work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\CSF WHY WHY") ;<-- this does NOT work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\ma") ;<-- this does NOT work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\match source") ;<-- this does not work
Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\CSF match source") ;<-- this does not work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\CSF 1920 x 1080") ;<-- this does work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF_Transcode\CSF Delivery") ;<-this does work
;Filemover("Z:\Linus\6. Channel Super Fun\CSF Transcode") ;<-- this does work
;Filemover("Z:\Linus\6. Channel Super Fun") ;<-- this does work

sleep 10
Exitapp

;SetWorkingDir %A_ScriptDir%
;#Include %A_ScriptDir%/REDIRECTOR Windows.ahk
#Include C:\AHK\2nd-keyboard\Taran's_Windows_Mods\filemover.ahk