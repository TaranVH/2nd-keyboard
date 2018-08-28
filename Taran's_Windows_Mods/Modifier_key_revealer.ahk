;ShowOff.ahk
; Shows pushed down keys and buttons
;Skrommel @2005

Menu, Tray, Icon, shell32.dll, 45 ;yellow key
Menu, Tray, Icon, shell32.dll, 216 ; red thingy

#SingleInstance,Force
CoordMode,Mouse,Screen
#InstallKeybdHook ;this is important... it ensures that only physical keypresses are paid attention to, not virtual ones.


applicationname=Modifier_key_revealer
Gosub,TRAYMENU
Gosub,READINI

setTimer reloadEverything, -2400000 ;sets this to 45-ish minutes, to NOT repeat...


FileRead,inifile,%applicationname%.ini
StringSplit,keyarray,inifile,`n
inifile=


shiftkeys=
keys=
timetoshow=10
downer = 0
fontcolor = 000000
fontsize = 40

backcolor=6259EE
fontcolor=6259F9
fontsize=50
boldness=400
font=Arial
statusheight=80
statuswidth=400
statusy = 1975
statusx = 20
relative=1
transparency=100

fontsize=34
boldness=400


kolor := "white"

Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
;Gui,Color,%backcolor%
Gui,Color,%kolor%
;Gui,Font,C555555
Gui,Font,C%fontcolor% S%fontsize% W%boldness%,%font%
;Gui,Font,CBlue
Gui,Add,Text,Vtext,MMMMMMMM MMMMMMMMMMMMM MMMMMM MMMMMMMMMMMMM MMMMMMMMMMMMMMMMM MMMMMM MMMMMMMMMMMMMMMMMMMMMMM

; statusy = %A_ScreenHeight% - %statusheight% - 10
; statusx = %A_ScreenWidth% - %statuswidth% - 10

; WinSet, Transparent, 150, WinTitle
; WinSet, TransColor, E6E6E6 150, WinTitle ; combine the two functions
; WinSet, TransColor, E6E6E6 255
;WinSet, TransColor, %kolor% 50
;WinSet, TransColor, %backcolor% 100
;Gui, -Caption




;;;;;;;;;;;
Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound ;Turns out you NEED THIS LINE for the transparency to work...????
;Gui, Color, %kolor%
;GuiHwnd := WinExist()
;DetectHiddenWindows, On
;WinSet, Region, % "0-0 W" Size " H" Size, ahk_id %GuiHwnd%
;WinSet, ExStyle, +0x20, ahk_id %GuiHwnd% ; set click through style
;WinSet, Transparent, 0, ahk_id %GuiHwnd% ;didn't work...
;;;;;;;;;;;;;;;;;



Gui,Show, NA X%statusx% Y%statusy% W%statuswidth% H%statusheight% NoActivate,%applicationname%
GuiControl,,text,
;WinSet,Transparent,%transparency%,%applicationname%
;WinSet, TransColor, %backcolor% 50
WinSet, TransColor, %backcolor% 200



;;;;;;
;setTimer STATUSOFF, -1000 ;for some reason, just having this line caused multiple modifier keys to NOT be shown if pressed down. I have no idea why. Negative means it hsould not repeat...
; settimer, STATUSOFF, %timetoshow%
GuiControl,,text, (Modifier keys)
Gui, Color, %backcolor%
;;;;;;



;WinSet, TransColor, 000000 199

Loop
{
sleep 5 ; without a "sleep" of at least 1 millisecond, the script loops so much, it uses 4% of my CPU!
;tooltip, currentline = %currentline% --- keyOnLine = %keyOnLine% --- index = %index% --- position = %position% --- keys=%keys%
  oldkeys=%keys%
  keys=
  Loop,%keyarray0%
  {
    key:=keyarray%A_Index%
	;tooltip, %key%, , 5
    StringTrimRight,key,key,1
    GetKeyState,state,%key%,P
    If state=D
	{
      keys=%keys% %key%
	  downer = 1
	  ;tooltip, KEY IS DOWN and downer = %downer%, , , 5
	}

  }
  StringTrimRight,keys,keys,0
  If keys=%oldkeys%
	{
	;tooltip, skip the rest of the loop and start over, , , 3
    Continue
	}
  else if keys<>%oldkeys%
	{
	downer = 0
	;tooltip, you get to continue, , , 2
	; you have either pressed, or let go of, a key. I dont know if I can tell which.
	}

  ; oldshiftkeys=%shiftkeys%
  ; shiftkeys=
  ; StringReplace,shiftkeys,shiftkeys,LWin
  ; StringReplace,shiftkeys,shiftkeys,RWin
  ; StringReplace,shiftkeys,shiftkeys,LCtrl
  ; StringReplace,shiftkeys,shiftkeys,RCtrl
  ; StringReplace,shiftkeys,shiftkeys,LShift
  ; StringReplace,shiftkeys,shiftkeys,RShift
  ; StringReplace,shiftkeys,shiftkeys,LAlt
  ; StringReplace,shiftkeys,shiftkeys,RAlt
  ; StringReplace,shiftkeys,shiftkeys,AltGr
  ; StringReplace,shiftkeys,shiftkeys,%A_SPACE%,,All  
  ; If shiftkeys=
  ; If oldshiftkeys<>
    ; Continue


  If keys<>
  {
		Gui, Color, %backcolor%
		GuiControl,,text, (%keys%) ;this is where the magic happens
		previouskey = keys
		SetTimer,DIMMER,-1
		;SetTimer,STATUSOFF,-11 ;for some reason i can't go straight to STATUSOFF. I have no idea how this works anymore.
  }
;msgbox, magic has happened

}


DIMMER:
;i dont remember what the point of this timer is, but I need it...
if downer = 1
{
	settimer, DIMMER, -21
	;tooltip, this seems to never happen
	return ;does this even work the way I think it does?? (skipping the next line?)
}
;tooltip, this still happened
settimer, STATUSOFF, %timetoshow%
Return


STATUSOFF:
;tooltip, status off
if downer = 1
{
	settimer, STATUSOFF, -21 ;i think this has to be GREATER than the loop sleep time, since otherwise it might turn off the text when it shoudln't.
	return ;does this even work the way I think it does?? (skipping the next line?)
}
Gui, Color, %backcolor%
GuiControl,,text,
SetTimer,STATUSOFF,Off
Return


reloadEverything:
reload
;SoundBeep, 900, 500
setTimer reloadEverything, -2400000 ;sets this to 45-ish minutes, to NOT repeat...
settimer, STATUSOFF, -1000
Return



READINI:
IfNotExist,%applicationname%.ini
{
  inifile=;%applicationname%.ini
  inifile=%inifile%`n`;[Settings]
  inifile=%inifile%`n`;backcolor    000000-FFFFFF 
  inifile=%inifile%`n`;fontcolor    000000-FFFFFF
  inifile=%inifile%`n`;fontsize
  inifile=%inifile%`n`;boldness     1-1000   `;400=normal 700=bold
  inifile=%inifile%`n`;font
  inifile=%inifile%`n`;statusheight
  inifile=%inifile%`n`;statuswidth
  inifile=%inifile%`n`;statusx
  inifile=%inifile%`n`;statusy
  inifile=%inifile%`n`;relative     0-1       `;relative to 0=screen 1=active window
  inifile=%inifile%`n`;transparency 0-255,Off
  inifile=%inifile%`n`;timetohide             `;time in ms
  inifile=%inifile%`n
  inifile=%inifile%`n[Settings]
  inifile=%inifile%`nbackcolor=E6E6E6
  inifile=%inifile%`nfontcolor=000000
  inifile=%inifile%`nfontsize=40
  inifile=%inifile%`nboldness=400as
  inifile=%inifile%`nfont=Arial
  inifile=%inifile%`nstatusheight=30
  inifile=%inifile%`nstatuswidth=500
  inifile=%inifile%`nstatusx=10
  inifile=%inifile%`nstatusy=10
  inifile=%inifile%`nrelative=1
  inifile=%inifile%`ntransparency=Off
  ;inifile=%inifile%`ntimetoshow=1000
  inifile=%inifile%`n
  inifile=%inifile%`nAppsKey`nWin`nCtrl`nShift`nAlt`nAltGr`nlWin`nrWin
  FileAppend,%inifile%,%applicationname%.ini
}
;"
IniRead,backcolor,%applicationname%.ini,Settings,backcolor
IniRead,fontcolor,%applicationname%.ini,Settings,fontcolor
IniRead,fontsize,%applicationname%.ini,Settings,fontsize
IniRead,boldness,%applicationname%.ini,Settings,boldness
IniRead,font,%applicationname%.ini,Settings,font
IniRead,statusheight,%applicationname%.ini,Settings,statusheight
IniRead,statuswidth,%applicationname%.ini,Settings,statuswidth
IniRead,statusx,%applicationname%.ini,Settings,statusx
IniRead,statusy,%applicationname%.ini,Settings,statusy
IniRead,relative,%applicationname%.ini,Settings,relative
IniRead,transparency,%applicationname%.ini,Settings,transparency
;IniRead,timetoshow,%applicationname%.ini,Settings,timetoshow
FileRead,inifile,%applicationname%.ini
StringSplit,keyarray,inifile,`n
inifile=
Return


TRAYMENU:
;Menu,Tray,NoStandard
Menu,Tray,Add,%applicationname%,SETTINGS
Menu,Tray,Add,
Menu,Tray,Add,&Settings...,SETTINGS
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
;Menu,Tray,Add,&Reload...,reload
Menu,Tray,Default,%applicationname%
Menu,Tray,Tip,%applicationname%
Return


SETTINGS:
Gosub,READINI
Run,%applicationname%.ini
Return


EXIT:
GuiClose:
ExitApp


ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Add,Picture,xm Icon1,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,%applicationname% v1.0
Gui,99:Font
Gui,99:Add,Text,y+10,Shows pushed down keys and buttons
Gui,99:Add,Text,y+5,- To change the look of the status window, edit the %applicationname%.ini
Gui,99:Add,Text,y+0,by rightclicking the tray menu and selecting Settings

Gui,99:Add,Picture,xm y+20 Icon5,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,1 Hour Software by Skrommel
Gui,99:Font
Gui,99:Add,Text,y+10,For more tools, information and donations, please visit 
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 G1HOURSOFTWARE,www.1HourSoftware.com
Gui,99:Font

Gui,99:Add,Picture,xm y+20 Icon7,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,DonationCoder
Gui,99:Font
Gui,99:Add,Text,y+10,Please support the contributors at
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 GDONATIONCODER,www.DonationCoder.com
Gui,99:Font

Gui,99:Add,Picture,xm y+20 Icon6,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,AutoHotkey
Gui,99:Font
Gui,99:Add,Text,y+10,This tool was made using the powerful
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 GAUTOHOTKEY,www.AutoHotkey.com
Gui,99:Font

Gui,99:Show,,%applicationname% About
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE") 
Return

1HOURSOFTWARE:
  Run,http://www.1hoursoftware.com,,UseErrorLevel
Return

DONATIONCODER:
  Run,http://www.donationcoder.com,,UseErrorLevel
Return

AUTOHOTKEY:
  Run,http://www.autohotkey.com,,UseErrorLevel
Return

99GuiClose:
  Gui,99:Destroy
  OnMessage(0x200,"")
  DllCall("DestroyCursor","Uint",hCur)
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static9,Static13,Static17
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return


; F7::
	; Send ^s
	; sleep 200
    ; SoundBeep, 1100, 500
	; Reload  ;The only thing you need here is the Reload
; Return
