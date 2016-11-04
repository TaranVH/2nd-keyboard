;ShowOff.ahk
; Shows pushed down keys and buttons
;Skrommel @2005

Menu, Tray, Icon, shell32.dll, 190
; Menu, Tray, Icon, shell32.dll, 209 ; sideways star
; Menu, Tray, Icon, shell32.dll, 216 ; red thingy

#SingleInstance,Force
CoordMode,Mouse,Screen

applicationname=KEYSTROKE VIZ

Gosub,TRAYMENU
Gosub,READINI


backcolor=121212
fontcolor=ffffff
fontsize=24
boldness=400
font=Arial
statusheight=75
statuswidth=1000
statusx=10
statusy=10
relative=1
transparency=Off
					
					
SUPERDIM = 0

;;;SetTimer downershower, 30
shiftkeys=
keys=
timetoshow=1500
downer = 0


Gui,+Owner +AlwaysOnTop -Resize -SysMenu -MinimizeBox -MaximizeBox -Disabled -Caption -Border -ToolWindow
Gui,Margin,0,0
Gui,Color,%backcolor%
;Gui,Font,C555555
Gui,Font,C%fontcolor% S%fontsize% W%boldness% Q5 underline,%font%
Gui,Add,Text,Vtext,KEY GOES HERE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
Gui,Font,cFFCCCC S20 W990 norm,%font%
Gui,Add,Text,Vname,FUNCTION GOES HERE WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

; statusy = %A_ScreenHeight% - %statusheight% - 10
; statusx = %A_ScreenWidth% - %statuswidth% - 10

statusy = 1850
statusx = 30

Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound ;Turns out you NEED THIS LINE for the transparency to work...????
;Gui -Caption +ToolWindow

Gui,Show,X%statusx% Y%statusy% W%statuswidth% H%statusheight% NoActivate,%applicationname%

;GuiControl,,text, ;If you turn this one off, you will see all the MMMMMMs.
;WinSet,Transparent,%transparency%,%applicationname%

;WinSet, TransColor, 129573 ;255
WinSet, TransColor, %backcolor% , KEYSTROKE VIZ;100
;WinSet, TransColor, FEFEFE ;100

;WinSet, TransColor, 0000FF 150
;WinSet,Transparent,%transparency%,%applicationname% ;IS THIS NEEDED? IT IS UNKNOWN.
;WinSet, TransColor, DD6644 70

Loop
{

; if superdim = 0
	; {
	; ;TOOLTIP, make bright, , , 5
	; WinSet, TransColor, FEFEFE 254
	; }

if superdim = 1
	{
	;TOOLTIP, make it dimmer, , , 4
		;Gui, Color, FF0000
		;Gui Font, cBlue
		; Gui,Font,C0000FF S%fontsize% W%boldness% underline,%font%
		; GuiControl,,text,fook ;The magic happens HERE!
		; GuiControl,,name,%activity%
		; Guicontrol,,Font, fook2
	WinSet, TransColor, %backcolor% 180, KEYSTROKE VIZ
	}


;sleep 30
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


  ;;;;; below is where the magic happens!
  If keys<>
  {
	Loop, read, premiere keys sept 2016 FOR VISUALIZER.txt
	{
		index = %A_Index% ;this is the lin'es NUMBER you are currently looking at.
		currentline = %A_LoopReadLine% ;this is the exact string of the line
		Position := InStr(currentline, "&")

		StringTrimLeft,rightside,currentline, %position%

		if rightside = %keys%
		{
			keyOnLine = %A_Index%
			;linenumber = %A_Index%
			;msgbox, %rightside%
			lenny := % Strlen(currentline)
			lols := lenny - Position + 1
			
			StringTrimRight,activity,currentline, %lols%
			break
		}
		if rightside <> %keys%
		{
			;keyOnLine = 0
			activity = 
			;msgbox, fail
		}
		; if activity =
			; break
	}



	skip = 0
	if (keys = "ctrl" || keys = "shift" || keys = "alt"  || keys = "alt lwin"  || keys = "shift lwin" || keys = "ctrl shift" || keys = "ctrl alt" || keys = "shift alt" || keys = "ctrl shift alt" || keys = "ctrl  alt shift" || keys = "shift alt ctrl" || keys = "Lbutton" || keys = "Rbutton" || keys = "lwin" || keys = "ctrl lwin" || keys = "ctrl shift lwin" || keys = "ctrl shift alt lwin")
	  {
		;tooltip, found one
		; Gui, Color, EEEEEE
		; GuiControl,,text, %keys%
		; previouskey = keys
		; SetTimer,DIMMER,-100
		skip = 1
	  }
	


	if skip <> 1
	{
		;Gui, Color, %backcolor%
		;Gui Font, cBlue
		Gui,Font,CFFFFFF S%fontsize% W%boldness% Q5 underline,%font%
		GuiControl,,text,%keys% ;The magic happens HERE!
		if WinActive("ahk_exe Adobe Premiere Pro.exe")
			GuiControl,,name,%activity% ;The magic on line 2 happens HERE!
		else
			GuiControl,,name, ;Premiere is not open, so empty line 2.
		Guicontrol Font, %keys% ; I dont know if this line is needed!!
		WinSet, TransColor, %backcolor% 255, KEYSTROKE VIZ
		;WinSet, TransColor, Blue 50
		;Gui -Caption +ToolWindow
		;WinSet, TransColor, FFFFFF 1
		;WinSet, TransColor, 0000FF 99
		;Gui -Caption +ToolWindow
		previouskey = %keys%
		stillholding = 1
		;SetTimer,STATUSOFF,%timetoshow%
		superdim = 0
		SetTimer,DIMMER,-100 ;It'll dim the display if you let go of the key!! But it won't vanish yet!
		;tooltip,
		skip = 0
	}
	
  }
;msgbox, magic has happened

;this is code to move the window around with the mouse. probably. Also, probably no longer needed.
  GetKeyState,mstate,LButton,P
  If mstate=D
  {
    MouseGetPos,mx1,my1,mid
    WinGetTitle,stitle,ahk_id %mid%
    If stitle=%applicationname%
    {
      Loop
      {
        MouseGetPos,mx2,my2
        WinGetPos,sx,sy,,,ahk_id %mid%
        sx:=sx-mx1+mx2
        sy:=sy-my1+my2
        WinMove,ahk_id %mid%,,%sx%,%sy%      
        mx1:=mx2
        my1:=my2
        GetKeyState,mstate,LButton,P
        If mstate=U
          Break
      } 
    }
  }


  
}

downershower:
;;;;tooltip, downer = %downer%, , , 9
; SetTimer downershower, 30 ; it is already set to repeat
return


DIMMER:
;TOOLTIP, SUPERDIM = %SUPERDIM%, , , 15
if downer = 1
{
	settimer, DIMMER, -50
	return
}
;TOOLTIP, NOT RETURNED NOW DOWNER IS NOT 1

;Gui, Color, dd6644
;WinSet, TransColor, DDDDDD 50
;WinSet, TransColor, DD6644 50
;WinSet, TransColor, FEFEFE 100
;WinSet, TransColor, FEFEFE 
;WinSet, TransColor, dd6644            ; NONE OF THESE WORK!

;for some reason, it is impossible to tell the GUI to dim using a timer. I can, however, change a variable, and then inside the big loop, I can have a GUI dimming command which is only triggered if that variable is 1, and THEN the display can dim. Doesn't make sense to me but there it is.
superdim = 1
settimer, STATUSOFF, %timetoshow%
Return





STATUSOFF:
if downer = 1
{
	settimer, STATUSOFF, -100
	return
}
GuiControl,,text,
GuiControl,,name,
SetTimer,STATUSOFF,Off
superdim = 0
;Gui,Font,C%fontcolor% 
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
  inifile=%inifile%`nfontsize=20
  inifile=%inifile%`nboldness=400
  inifile=%inifile%`nfont=Arial
  inifile=%inifile%`nstatusheight=30
  inifile=%inifile%`nstatuswidth=500
  inifile=%inifile%`nstatusx=10
  inifile=%inifile%`nstatusy=10
  inifile=%inifile%`nrelative=1
  inifile=%inifile%`ntransparency=Off
  ;inifile=%inifile%`ntimetoshow=1000
  inifile=%inifile%`n
  inifile=%inifile%`nAppsKey`nWin`nrWin`nlWin`nCtrl`nShift`nAlt`nAltGr
  inifile=%inifile%`nPrintScreen`nCtrlBreak`nPause`nBreak`nHelp`nBrowser_Back`nBrowser_Forward`nBrowser_Refresh`nBrowser_Stop`nBrowser_Search`nBrowser_Favorites`nBrowser_Home`nVolume_Mute`nVolume_Down`nVolume_Up`nMedia_Next`nMedia_Prev`nMedia_Stop`nMedia_Play_Pause`nLaunch_Mail`nLaunch_Media`nLaunch_App1`nLaunch_App2
  inifile=%inifile%`nF1`nF2`nF3`nF4`nF5`nF6`nF7`nF8`nF9`nF10`nF11`nF12`nF13`nF14`nF15`nF16`nF17`nF18`nF19`nF20`nF21`nF22`nF23`nF24
  inifile=%inifile%`nJoy1`nJoy2`nJoy3`nJoy4`nJoy5`nJoy6`nJoy7`nJoy8`nJoy9`nJoy10`nJoy11`nJoy12`nJoy13`nJoy14`nJoy15`nJoy16`nJoy17`nJoy18`nJoy19`nJoy20`nJoy21`nJoy22`nJoy23`nJoy24`nJoy25`nJoy26`nJoy27`nJoy28`nJoy29`nJoy30`nJoy31`nJoy32`nJoyX`nJoyY`nJoyZ`nJoyR`nJoyU`nJoyV`nJoyPOV
  inifile=%inifile%`nSpace`nTab`nEnter`nEscape`nBackspace`nDelete`nInsert`nHome`nEnd`nPgUp`nPgDn`nUp`nDown`nLeft`nRight`nScrollLock`nCapsLock
  inifile=%inifile%`nNumLock`nNumpadDiv`nNumpadMult`nNumpadAdd`nNumpadSub`n`n`n`nNumpadClear`nNumpadDot`nNumpad0`nNumpad1`nNumpad2`nNumpad3`nNumpad4`nNumpad5`nNumpad6`nNumpad7`nNumpad8`nNumpad9
  inifile=%inifile%`nA`nB`nC`nD`nE`nF`nG`nH`nI`nJ`nK`nL`nM`nN`nO`nP`nQ`nR`nS`nT`nU`nV`nW`nX`nY`nZ`nÆ`nØ`nÅ`n1`n2`n3`n4`n5`n6`n7`n8`n9`n0`n```n`,`n`n+`n-`n`n\`n/`n[`n]`n`n`n`n`n`n`n`n`n`n`n`n`n´`n'`n¨`n~`n;`n`n.`n`n`n`n`n`nµ
  inifile=%inifile%`nLButton`nRButton`n`nWheelDown`nWheelUp`nXButton1`nXButton2`n
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






