
;;;THIS IS A HEAVILY MODIFIED VERSION OF NIFTYWINDOWS.
; NiftyWindows Version 0.9.3.1
; http://www.enovatic.org/products/niftywindows/


#SingleInstance force
#HotkeyInterval 1000
#MaxHotkeysPerInterval 100
#NoTrayIcon

;OKAY SO I HATE THIS WHOLE SCRIPT BUT IT WAS NECESSARY TO USE IT SO THAT I COULD HAVE WINDOW DRAGGING WORKING ACROSS ALL 4 MONITORS, 1 OF WHICH NOW HAS TO BE AT A DIFFERENT UI SCALE, AND THIS FUCKED WITH THE OTHER, FAR SIMPLER SCRIPT. (EasyWindowDrag_(KDE).ahk) SO I GUTTED THIS ONE (WHICH WAS SUPER DIFFICULT BECAUSE IT'S A CLUSTERFUCK OF, IDK, WHAT'S THE VARIABLE EQUIVALENT OF A MAGIC NUMBER? A MAGIC VARIABLE? ANYWAY, BECAUSE OF THEIR GENIUS (THAT'S SARCASM) DECISION TO USE RIGHT CLICK AND THEN ALSO USE ALL THE MODIFIER KEYS IN THE MAIN FUNCTION(S) FOR DOING STUFF, I HAD TO SLOWLY, PAINFULLY FIX IT SO THAT IT'S JUST XBUTTON1 AND XBUTTON 2 NOW.

;LEAVE THE MODIFIER KEYS ALONE. IT'S LIKE POKING A DRAGON.

;OKAY YEAH SO IF NONE OF THIS MAKES SENSE, JUST IGNORE IT. THIS SCRIPT IS HERE MOSTLY JUST FOR ME. YEAH OK GOOD NIGHT.



SYS_ToolTipFeedback := 0

Process, Priority, , HIGH
SetBatchLines, -1
; TODO : a nulled key delay may produce problems for WinAmp control
SetKeyDelay, 0, 0
SetMouseDelay, 0
SetDefaultMouseSpeed, 0
SetWinDelay, 0
SetControlDelay, 0

; Gosub, SYS_ParseCommandLine
; Gosub, CFG_LoadSettings
; Gosub, CFG_ApplySettings

MIR_MirandaFullPath = %ProgramFiles%\Miranda\Miranda32.exe
SplitPath, MIR_MirandaFullPath, , MIR_MirandaDir

if ( !A_IsCompiled )
	SetTimer, REL_ScriptReload, 1000

OnExit, SYS_ExitHandler

Gosub, TRY_TrayInit
Gosub, SYS_ContextCheck
;;;Gosub, UPD_AutoCheckForUpdate

Return



; [SYS] parses command line parameters

SYS_ParseCommandLine:
	Loop %0%
		If ( (%A_Index% = "/x") or (%A_Index% = "/exit") )
			ExitApp
Return



; [SYS] exit handler

SYS_ExitHandler:
	; Gosub, AOT_ExitHandler
	; Gosub, ROL_ExitHandler
	; Gosub, TRA_ExitHandler
	Gosub, CFG_SaveSettings
ExitApp



; [SYS] context check

SYS_ContextCheck:
	Gosub, SYS_TrayTipBalloonCheck
	If ( !SYS_TrayTipBalloon )
	{
		Gosub, SUS_SuspendSaveState
		Suspend, On
		MsgBox, 4148, Balloon Handler - %SYS_ScriptInfo%, The balloon messages are disabled on your system. These visual messages`nabove the system tray are often used by tools as additional information four`nyour interest.`n`nNiftyWindows uses balloon messages to show you some important operating`ndetails. If you leave the messages disabled NiftyWindows will show some plain`nmessages as tooltips instead (in front of the system tray).`n`nDo you want to enable balloon messages now (highly recommended)?
		Gosub, SUS_SuspendRestoreState
		IfMsgBox, Yes
		{
			SYS_TrayTipBalloon = 1
			RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips, %SYS_TrayTipBalloon%
			RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips, %SYS_TrayTipBalloon%
			SendMessage, 0x001A, , , , ahk_id 0xFFFF ; 0x001A is WM_SETTINGCHANGE ; 0xFFFF is HWND_BROADCAST
			Sleep, 500 ; lets the other windows relax
		}
	}
	
	IfNotExist, %A_ScriptDir%\readme.txt
	{
		TRY_TrayEvent := "Help"
		Gosub, TRY_TrayEvent
		Suspend, On
		Sleep, 10000
		ExitApp, 1
	}

	IfNotExist, %A_ScriptDir%\license.txt
	{
		TRY_TrayEvent := "View License"
		Gosub, TRY_TrayEvent
		Suspend, On
		Sleep, 10000
		ExitApp, 1
	}
	
	TRY_TrayEvent := "About"
	Gosub, TRY_TrayEvent
Return



; [SYS] handles tooltips

SYS_ToolTipShow:
	If ( SYS_ToolTipText )
	{
		If ( !SYS_ToolTipSeconds )
			SYS_ToolTipSeconds = 2
		SYS_ToolTipMillis := SYS_ToolTipSeconds * 1000
		CoordMode, Mouse, Screen
		CoordMode, ToolTip, Screen
		If ( !SYS_ToolTipX or !SYS_ToolTipY )
		{
			MouseGetPos, SYS_ToolTipX, SYS_ToolTipY
			SYS_ToolTipX += 16
			SYS_ToolTipY += 24
		}
		ToolTip, %SYS_ToolTipText%, %SYS_ToolTipX%, %SYS_ToolTipY%
		SetTimer, SYS_ToolTipHandler, %SYS_ToolTipMillis%
	}
	SYS_ToolTipText =
	SYS_ToolTipSeconds =
	SYS_ToolTipX =
	SYS_ToolTipY =
Return

SYS_ToolTipFeedbackShow:
	If ( SYS_ToolTipFeedback )
		Gosub, SYS_ToolTipShow
	SYS_ToolTipText =
	SYS_ToolTipSeconds =
	SYS_ToolTipX =
	SYS_ToolTipY =
Return

SYS_ToolTipHandler:
	SetTimer, SYS_ToolTipHandler, Off
	ToolTip
Return



; [SYS] handles balloon messages

SYS_TrayTipShow:
	If ( SYS_TrayTipText )
	{
		If ( !SYS_TrayTipTitle )
			SYS_TrayTipTitle = %SYS_ScriptInfo%
		If ( !SYS_TrayTipSeconds )
			SYS_TrayTipSeconds = 10
		If ( !SYS_TrayTipOptions )
			SYS_TrayTipOptions = 17
		SYS_TrayTipMillis := SYS_TrayTipSeconds * 1000
		Gosub, SYS_TrayTipBalloonCheck
		If ( SYS_TrayTipBalloon and !A_IconHidden )
		{
			TrayTip, %SYS_TrayTipTitle%, %SYS_TrayTipText%, %SYS_TrayTipSeconds%, %SYS_TrayTipOptions%
			SetTimer, SYS_TrayTipHandler, %SYS_TrayTipMillis%
		}
		Else
		{
			TrayTip
			SYS_ToolTipText = %SYS_TrayTipTitle%:`n`n%SYS_TrayTipText%
			SYS_ToolTipSeconds = %SYS_TrayTipSeconds%
			SysGet, SYS_TrayTipDisplay, Monitor
			SYS_ToolTipX = %SYS_TrayTipDisplayRight%
			SYS_ToolTipY = %SYS_TrayTipDisplayBottom%
			Gosub, SYS_ToolTipShow
		}
	}
	SYS_TrayTipTitle =
	SYS_TrayTipText =
	SYS_TrayTipSeconds =
	SYS_TrayTipOptions =
Return

SYS_TrayTipHandler:
	SetTimer, SYS_TrayTipHandler, Off
	TrayTip
Return

SYS_TrayTipBalloonCheck:
	RegRead, SYS_TrayTipBalloonCU, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips
	SYS_TrayTipBalloonCU := ErrorLevel or SYS_TrayTipBalloonCU
	RegRead, SYS_TrayTipBalloonLM, HKEY_LOCAL_MACHINE, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, EnableBalloonTips
	SYS_TrayTipBalloonLM := ErrorLevel or SYS_TrayTipBalloonLM
	SYS_TrayTipBalloon := SYS_TrayTipBalloonCU and SYS_TrayTipBalloonLM
Return



; [SUS] provides suspend services

#Esc::
SUS_SuspendToggle:
	Suspend, Permit
	If ( !A_IsSuspended )
	{
		Suspend, On
		SYS_TrayTipText = NiftyWindows is suspended now.`nPress WIN+ESC to resume it again.
		SYS_TrayTipOptions = 2
	}
	Else
	{
		Suspend, Off
		SYS_TrayTipText = NiftyWindows is resumed now.`nPress WIN+ESC to suspend it again.
	}
	Gosub, SYS_TrayTipShow
	Gosub, TRY_TrayUpdate
Return

SUS_SuspendSaveState:
	SUS_Suspended := A_IsSuspended
Return

SUS_SuspendRestoreState:
	If ( SUS_Suspended )
		Suspend, On
	Else
		Suspend, Off
Return

SUS_SuspendHandler:
	IfWinActive, A
	{
		WinGet, SUS_WinID, ID
		If ( !SUS_WinID )
			Return
		WinGet, SUS_WinMinMax, MinMax, ahk_id %SUS_WinID%
		WinGetPos, SUS_WinX, SUS_WinY, SUS_WinW, SUS_WinH, ahk_id %SUS_WinID%
		
		If ( (SUS_WinMinMax = 0) and (SUS_WinX = 0) and (SUS_WinY = 0) and (SUS_WinW = A_ScreenWidth) and (SUS_WinH = A_ScreenHeight) )
		{
			WinGetClass, SUS_WinClass, ahk_id %SUS_WinID%
			WinGet, SUS_ProcessName, ProcessName, ahk_id %SUS_WinID%
			SplitPath, SUS_ProcessName, , , SUS_ProcessExt
			If ( (SUS_WinClass != "Progman") and (SUS_ProcessExt != "scr") and !SUS_FullScreenSuspend )
			{
				SUS_FullScreenSuspend = 1
				SUS_FullScreenSuspendState := A_IsSuspended
				If ( !A_IsSuspended )
				{
					Suspend, On
					SYS_TrayTipText = A full screen window was activated.`nNiftyWindows is suspended now.`nPress WIN+ESC to resume it again.
					SYS_TrayTipOptions = 2
					Gosub, SYS_TrayTipShow
					Gosub, TRY_TrayUpdate
				}
			}
		}
		Else
		{
			If ( SUS_FullScreenSuspend )
			{
				SUS_FullScreenSuspend = 0
				If ( A_IsSuspended and !SUS_FullScreenSuspendState )
				{
					Suspend, Off
					SYS_TrayTipText = A full screen window was deactivated.`nNiftyWindows is resumed now.`nPress WIN+ESC to suspend it again.
					Gosub, SYS_TrayTipShow
					Gosub, TRY_TrayUpdate
				}
			}
		}
	}
Return



; [SYS] provides reversion of all visual effects

/**
 * This powerful hotkey removes all visual effects (like on exit) that have 
 * been made before by NiftyWindows. You can use this action as a fall-back 
 * solution to quickly revert any always-on-top, rolled windows and 
 * transparency features you've set before.
 */

^#BS::
^!BS::
SYS_RevertVisualEffects:
	; Gosub, AOT_SetAllOff
	; Gosub, ROL_RollDownAll
	; Gosub, TRA_TransparencyAllOff
	SYS_TrayTipText = All visual effects (AOT, Roll, Transparency) were reverted.
	Gosub, SYS_TrayTipShow
Return



; [NWD] nifty window dragging

/**
 * This is the most powerful feature of NiftyWindows. The area of every window 
 * is tiled in a virtual 9-cell grid with three columns and rows. The center 
 * cell is the largest one and you can grab and move a window around by clicking 
 * and holding it with the right mouse button. The other eight corner cells are 
 * used to resize a resizable window in the same manner.
 */

Xbutton2::


	;chosenkey = %A_thishotkey%
	chosenkey = %Xbutton2%
	;tooltip, chosenkey = %chosenkey%
	;GetKeyState, TARAN_X2KeyState, %chosenkey%, P
	GetKeyState, TARAN_X2KeyState, Xbutton2, P
	
	NWD_ResizeGrids = 20
	CoordMode, Mouse, Screen
	MouseGetPos, NWD_MouseStartX, NWD_MouseStartY, NWD_WinID
	If ( !NWD_WinID )
		Return
	WinGetPos, NWD_WinStartX, NWD_WinStartY, NWD_WinStartW, NWD_WinStartH, ahk_id %NWD_WinID%
	WinGet, NWD_WinMinMax, MinMax, ahk_id %NWD_WinID%
	WinGet, NWD_WinStyle, Style, ahk_id %NWD_WinID%
	WinGetClass, NWD_WinClass, ahk_id %NWD_WinID%
	
	;GetKeyState, NWD_CtrlState, Ctrl, P
	
	
	;;;this bullshit here checks if it's one of the windows it doesn't want you to do this in. only necessary because they're using fucking RIGHT CLICK to do this bullshit.
	
	; ; ; the and'ed condition checks for popup window:
	; ; ; (WS_POPUP) and !(WS_DLGFRAME | WS_SYSMENU | WS_THICKFRAME)
	; If ( (NWD_WinClass = "Progman") or ((NWD_CtrlState = "U") and (((NWD_WinStyle & 0x80000000) and !(NWD_WinStyle & 0x4C0000)) or (NWD_WinClass = "ExploreWClass") or (NWD_WinClass = "CabinetWClass") or (NWD_WinClass = "IEFrame") or (NWD_WinClass = "MozillaWindowClass") or (NWD_WinClass = "OpWindow") or (NWD_WinClass = "ATL:ExplorerFrame") or (NWD_WinClass = "ATL:ScrapFrame"))) )
	; {
		; NWD_ImmediateDownRequest = 1
		; NWD_ImmediateDown = 0
		; NWD_PermitClick = 1
	; }
	; Else
	; {
		; NWD_ImmediateDownRequest = 0
		; NWD_ImmediateDown = 0
		; NWD_PermitClick = 1
	; }
	
	NWD_ImmediateDownRequest = 0
	NWD_ImmediateDown = 0
	NWD_PermitClick = 1
	
	
	;;;taran note, this too is somehow, horribly, necessary. fuck i hate this code. without it, nothing happens at all... just a normal right click.
	NWD_Dragging := (NWD_WinClass != "Progman") and ((NWD_CtrlState = "D") or ((NWD_WinMinMax != 1) and !NWD_ImmediateDownRequest))
	
	
	
	
	; ;;;;taran note, this is needed to make the edge resizing actually work. without it, you only have window MOVEMENT, which is fine by me, frankly.
	
	; ; "checks whether the window has a sizing border (WS_THICKFRAME)"
	; If ( (NWD_CtrlState = "D") or (NWD_WinStyle & 0x40000) )
	; {
		; If ( (NWD_MouseStartX >= NWD_WinStartX + NWD_WinStartW / NWD_ResizeGrids) and (NWD_MouseStartX <= NWD_WinStartX + (NWD_ResizeGrids - 1) * NWD_WinStartW / NWD_ResizeGrids) )
			; NWD_ResizeX = 0
		; Else
			; If ( NWD_MouseStartX > NWD_WinStartX + NWD_WinStartW / 2 )
				; NWD_ResizeX := 1
			; Else
				; NWD_ResizeX := -1

		; If ( (NWD_MouseStartY >= NWD_WinStartY + NWD_WinStartH / NWD_ResizeGrids) and (NWD_MouseStartY <= NWD_WinStartY + (NWD_ResizeGrids - 1) * NWD_WinStartH / NWD_ResizeGrids) )
			; NWD_ResizeY = 0
		; Else
			; If ( NWD_MouseStartY > NWD_WinStartY + NWD_WinStartH / 2 )
				; NWD_ResizeY := 1
			; Else
				; NWD_ResizeY := -1
	; }
	; Else
	; {
		; NWD_ResizeX = 0
		; NWD_ResizeY = 0
	; }
	
	NWD_ResizeX = 0
	NWD_ResizeY = 0
	
	SetTimer, NWD_WindowHandlerX2, 10
Return

NWD_SetDraggingOff:
	NWD_Dragging = 0
Return

NWD_SetClickOff:
	NWD_PermitClick = 0
	NWD_ImmediateDownRequest = 0
Return

NWD_SetAllOff:
	Gosub, NWD_SetDraggingOff
	Gosub, NWD_SetClickOff
Return

NWD_IgnoreKeyHandler:
	; GetKeyState, NWD_RButtonState, RButton, P
	; GetKeyState, NWD_ShiftState, Shift, P
	; GetKeyState, NWD_CtrlState, Ctrl, P
	; GetKeyState, NWD_AltState, Alt, P
	; ; TODO : unlike the other modifiers, Win does not exist 
	; ; as a virtual key (but Ctrl, Alt and Shift do)
	; GetKeyState, NWD_LWinState, LWin, P
	; GetKeyState, NWD_RWinState, RWin, P
	; If ( (NWD_LWinState = "D") or (NWD_RWinState = "D") )
		; NWD_WinState = D
	; Else
		; NWD_WinState = U
	
	; If ( (NWD_RButtonState = "U") and (NWD_ShiftState = "U") and (NWD_CtrlState = "U") and (NWD_AltState = "U") and (NWD_WinState = "U") )
	; {
		; SetTimer, NWD_IgnoreKeyHandler, Off
		; ; Hotkey, Shift, Off
		; ; Hotkey, Ctrl, Off
		; ; Hotkey, Alt, Off
		; ; Hotkey, LWin, Off
		; ; Hotkey, RWin, Off
	; }
Return




NWD_WindowHandlerX2:
	SetWinDelay, -1
	CoordMode, Mouse, Screen
	MouseGetPos, NWD_MouseX, NWD_MouseY
	WinGetPos, NWD_WinX, NWD_WinY, NWD_WinW, NWD_WinH, ahk_id %NWD_WinID%
	; GetKeyState, NWD_RButtonState, RButton, P
	
	
	GetKeyState, TARAN_X2KeyState, xbutton2, P
	
	;tooltip, TARAN_X2KeyState = %TARAN_X2KeyState%

	
	; GetKeyState, NWD_ShiftState, Shift, P
	; GetKeyState, NWD_AltState, Alt, P
	; ; TODO : unlike the other modifiers, Win does not exist 
	; ; as a virtual key (but Ctrl, Alt and Shift do)
	; GetKeyState, NWD_LWinState, LWin, P
	; GetKeyState, NWD_RWinState, RWin, P
	; If ( (NWD_LWinState = "D") or (NWD_RWinState = "D") )
		; NWD_WinState = D
	; Else
		; NWD_WinState = U
	
	
	If ( TARAN_X2KeyState = "U" )
	{
		SetTimer, NWD_WindowHandlerX2, Off
		
		; If ( NWD_ImmediateDown )
			; msgbox, the immediate down thing happened. that is bad. ;MouseClick, RIGHT, %NWD_MouseX%, %NWD_MouseY%, , , U
		; Else
			; msgbox, and here some other bullshit happens
			; ; If ( NWD_PermitClick and (!NWD_Dragging or ((NWD_MouseStartX = NWD_MouseX) and (NWD_MouseStartY = NWD_MouseY))) )
			; ; {
				; ; MouseClick, RIGHT, %NWD_MouseStartX%, %NWD_MouseStartY%, , , D
				; ; MouseClick, RIGHT, %NWD_MouseX%, %NWD_MouseY%, , , U
			; ; }

		Gosub, NWD_SetAllOff
		NWD_ImmediateDown = 0
	}
	Else
	{
		NWD_MouseDeltaX := NWD_MouseX - NWD_MouseStartX
		NWD_MouseDeltaY := NWD_MouseY - NWD_MouseStartY

		If ( NWD_MouseDeltaX or NWD_MouseDeltaY )
		{
			; If ( NWD_ImmediateDownRequest and !NWD_ImmediateDown )
			; {
				; MouseClick, RIGHT, %NWD_MouseStartX%, %NWD_MouseStartY%, , , D
				; MouseMove, %NWD_MouseX%, %NWD_MouseY%
				; NWD_ImmediateDown = 1
				; NWD_PermitClick = 0
			; }

			If ( NWD_Dragging ) ;i know that 0 means that it's off, but i think this is asking if it's a "1."
			{
				If ( !NWD_ResizeX and !NWD_ResizeY )
				{
					NWD_WinNewX := NWD_WinStartX + NWD_MouseDeltaX
					NWD_WinNewY := NWD_WinStartY + NWD_MouseDeltaY
					NWD_WinNewW := NWD_WinStartW
					NWD_WinNewH := NWD_WinStartH
				}
				Else
				{
					NWD_WinDeltaW = 0
					NWD_WinDeltaH = 0
					If ( NWD_ResizeX )
						NWD_WinDeltaW := NWD_ResizeX * NWD_MouseDeltaX
					If ( NWD_ResizeY )
						NWD_WinDeltaH := NWD_ResizeY * NWD_MouseDeltaY
					; If ( NWD_WinState = "D" )
					; {
						; If ( NWD_ResizeX )
							; NWD_WinDeltaW *= 2
						; If ( NWD_ResizeY )
							; NWD_WinDeltaH *= 2
					; }
					NWD_WinNewW := NWD_WinStartW + NWD_WinDeltaW
					NWD_WinNewH := NWD_WinStartH + NWD_WinDeltaH
					; If ( NWD_WinNewW < 0 )
						; If ( NWD_WinState = "D" )
							; NWD_WinNewW *= -1
						; Else
							; NWD_WinNewW := 0
					; If ( NWD_WinNewH < 0 )
						; If ( NWD_WinState = "D" )
							; NWD_WinNewH *= -1
						; Else
							; NWD_WinNewH := 0
					; If ( (NWD_AltState = "D") and NWD_WinStartAR )
					; {
						; NWD_WinNewARW := NWD_WinNewH * NWD_WinStartAR
						; NWD_WinNewARH := NWD_WinNewW / NWD_WinStartAR
						; If ( NWD_WinNewW < NWD_WinNewARW )
							; NWD_WinNewW := NWD_WinNewARW
						; If ( NWD_WinNewH < NWD_WinNewARH )
							; NWD_WinNewH := NWD_WinNewARH
					; }
					NWD_WinDeltaX = 0
					NWD_WinDeltaY = 0
					; If ( NWD_WinState = "D" )
					; {
						; NWD_WinDeltaX := NWD_WinStartW / 2 - NWD_WinNewW / 2
						; NWD_WinDeltaY := NWD_WinStartH / 2 - NWD_WinNewH / 2
					; }
					; Else
					; {
					
					
					;;;;;;;;;;this is definitely needed if you are RESIZING the window. for moving, it is not needed at all AFAIK.
					
					If ( NWD_ResizeX = -1 )
						NWD_WinDeltaX := NWD_WinStartW - NWD_WinNewW
					If ( NWD_ResizeY = -1 )
						NWD_WinDeltaY := NWD_WinStartH - NWD_WinNewH
						
							
							
							
					; }
					NWD_WinNewX := NWD_WinStartX + NWD_WinDeltaX
					NWD_WinNewY := NWD_WinStartY + NWD_WinDeltaY
				}
				
				; If ( NWD_ShiftState = "D" )
					; NWD_WinNewRound = -1
				; Else
					; NWD_WinNewRound = 0
				
				; Transform, NWD_WinNewX, Round, %NWD_WinNewX%, %NWD_WinNewRound%
				; Transform, NWD_WinNewY, Round, %NWD_WinNewY%, %NWD_WinNewRound%
				; Transform, NWD_WinNewW, Round, %NWD_WinNewW%, %NWD_WinNewRound%
				; Transform, NWD_WinNewH, Round, %NWD_WinNewH%, %NWD_WinNewRound%
				
				If ( (NWD_WinNewX != NWD_WinX) or (NWD_WinNewY != NWD_WinY) or (NWD_WinNewW != NWD_WinW) or (NWD_WinNewH != NWD_WinH) )
				{
					WinMove, ahk_id %NWD_WinID%, , %NWD_WinNewX%, %NWD_WinNewY%, %NWD_WinNewW%, %NWD_WinNewH%
					
					If ( SYS_ToolTipFeedback )
					{
						WinGetPos, NWD_ToolTipWinX, NWD_ToolTipWinY, NWD_ToolTipWinW, NWD_ToolTipWinH, ahk_id %NWD_WinID%
						SYS_ToolTipText = Window Drag: (X:%NWD_ToolTipWinX%, Y:%NWD_ToolTipWinY%, W:%NWD_ToolTipWinW%, H:%NWD_ToolTipWinH%)
						Gosub, SYS_ToolTipFeedbackShow
					}
				}
			}
		}
	}
Return



;window RESIZING
Xbutton1::

	chosenkey = %Xbutton1%

	GetKeyState, TARAN_X1KeyState, Xbutton1, P
	
	NWD_ResizeGrids = 2 ;;;;;;;;;;THIS HERE IS ESSENTIALLY THE ONLY DIFFERENCE, JESUS H CHRIST
	CoordMode, Mouse, Screen
	MouseGetPos, NWD_MouseStartX, NWD_MouseStartY, NWD_WinID
	If ( !NWD_WinID )
		Return
	WinGetPos, NWD_WinStartX, NWD_WinStartY, NWD_WinStartW, NWD_WinStartH, ahk_id %NWD_WinID%
	WinGet, NWD_WinMinMax, MinMax, ahk_id %NWD_WinID%
	WinGet, NWD_WinStyle, Style, ahk_id %NWD_WinID%
	WinGetClass, NWD_WinClass, ahk_id %NWD_WinID%
	
	NWD_ImmediateDownRequest = 0
	NWD_ImmediateDown = 0
	NWD_PermitClick = 1
	
	
	;;;taran note, this too is somehow, horribly, necessary. fuck i hate this code. without it, nothing happens at all... just a normal right click.
	NWD_Dragging := (NWD_WinClass != "Progman") and ((NWD_CtrlState = "D") or ((NWD_WinMinMax != 1) and !NWD_ImmediateDownRequest))
	
	
	
	
	;;;;taran note, this is needed to make the edge resizing actually work. without it, you only have window MOVEMENT, which is fine by me, frankly.
	
	; "checks whether the window has a sizing border (WS_THICKFRAME)"
	If ( (NWD_CtrlState = "D") or (NWD_WinStyle & 0x40000) )
	{
		If ( (NWD_MouseStartX >= NWD_WinStartX + NWD_WinStartW / NWD_ResizeGrids) and (NWD_MouseStartX <= NWD_WinStartX + (NWD_ResizeGrids - 1) * NWD_WinStartW / NWD_ResizeGrids) )
			NWD_ResizeX = 0
		Else
			If ( NWD_MouseStartX > NWD_WinStartX + NWD_WinStartW / 2 )
				NWD_ResizeX := 1
			Else
				NWD_ResizeX := -1

		If ( (NWD_MouseStartY >= NWD_WinStartY + NWD_WinStartH / NWD_ResizeGrids) and (NWD_MouseStartY <= NWD_WinStartY + (NWD_ResizeGrids - 1) * NWD_WinStartH / NWD_ResizeGrids) )
			NWD_ResizeY = 0
		Else
			If ( NWD_MouseStartY > NWD_WinStartY + NWD_WinStartH / 2 )
				NWD_ResizeY := 1
			Else
				NWD_ResizeY := -1
	}
	Else
	{
		NWD_ResizeX = 0
		NWD_ResizeY = 0
	}

	SetTimer, NWD_WindowHandlerX1, 10
Return



NWD_WindowHandlerX1:
	SetWinDelay, -1
	CoordMode, Mouse, Screen
	MouseGetPos, NWD_MouseX, NWD_MouseY
	WinGetPos, NWD_WinX, NWD_WinY, NWD_WinW, NWD_WinH, ahk_id %NWD_WinID%
	; GetKeyState, NWD_RButtonState, RButton, P
	
	
	GetKeyState, TARAN_X1KeyState, xbutton1, P
	
	;tooltip, TARAN_X1KeyState = %TARAN_X1KeyState%

	
	; GetKeyState, NWD_ShiftState, Shift, P
	; GetKeyState, NWD_AltState, Alt, P
	; ; TODO : unlike the other modifiers, Win does not exist 
	; ; as a virtual key (but Ctrl, Alt and Shift do)
	; GetKeyState, NWD_LWinState, LWin, P
	; GetKeyState, NWD_RWinState, RWin, P
	; If ( (NWD_LWinState = "D") or (NWD_RWinState = "D") )
		; NWD_WinState = D
	; Else
		; NWD_WinState = U
	
	
	If ( TARAN_X1KeyState = "U" )
	{
		SetTimer, NWD_WindowHandlerX1, Off
		
		; If ( NWD_ImmediateDown )
			; msgbox, the immediate down thing happened. that is bad. ;MouseClick, RIGHT, %NWD_MouseX%, %NWD_MouseY%, , , U
		; Else
			; msgbox, and here some other bullshit happens
			; ; If ( NWD_PermitClick and (!NWD_Dragging or ((NWD_MouseStartX = NWD_MouseX) and (NWD_MouseStartY = NWD_MouseY))) )
			; ; {
				; ; MouseClick, RIGHT, %NWD_MouseStartX%, %NWD_MouseStartY%, , , D
				; ; MouseClick, RIGHT, %NWD_MouseX%, %NWD_MouseY%, , , U
			; ; }

		Gosub, NWD_SetAllOff
		NWD_ImmediateDown = 0
	}
	Else
	{
		NWD_MouseDeltaX := NWD_MouseX - NWD_MouseStartX
		NWD_MouseDeltaY := NWD_MouseY - NWD_MouseStartY

		If ( NWD_MouseDeltaX or NWD_MouseDeltaY )
		{
			; If ( NWD_ImmediateDownRequest and !NWD_ImmediateDown )
			; {
				; MouseClick, RIGHT, %NWD_MouseStartX%, %NWD_MouseStartY%, , , D
				; MouseMove, %NWD_MouseX%, %NWD_MouseY%
				; NWD_ImmediateDown = 1
				; NWD_PermitClick = 0
			; }

			If ( NWD_Dragging ) ;i know that 0 means that it's off, but i think this is asking if it's a "1."
			{
				If ( !NWD_ResizeX and !NWD_ResizeY )
				{
					;so if we're NOT resizing anything, use this...?
					NWD_WinNewX := NWD_WinStartX + NWD_MouseDeltaX
					NWD_WinNewY := NWD_WinStartY + NWD_MouseDeltaY
					NWD_WinNewW := NWD_WinStartW
					NWD_WinNewH := NWD_WinStartH
				}
				Else
				{
					NWD_WinDeltaW = 0
					NWD_WinDeltaH = 0
					If ( NWD_ResizeX )
						NWD_WinDeltaW := NWD_ResizeX * NWD_MouseDeltaX
					If ( NWD_ResizeY )
						NWD_WinDeltaH := NWD_ResizeY * NWD_MouseDeltaY
					; If ( NWD_WinState = "D" )
					; {
						; If ( NWD_ResizeX )
							; NWD_WinDeltaW *= 2
						; If ( NWD_ResizeY )
							; NWD_WinDeltaH *= 2
					; }
					NWD_WinNewW := NWD_WinStartW + NWD_WinDeltaW
					NWD_WinNewH := NWD_WinStartH + NWD_WinDeltaH
					; If ( NWD_WinNewW < 0 )
						; If ( NWD_WinState = "D" )
							; NWD_WinNewW *= -1
						; Else
							; NWD_WinNewW := 0
					; If ( NWD_WinNewH < 0 )
						; If ( NWD_WinState = "D" )
							; NWD_WinNewH *= -1
						; Else
							; NWD_WinNewH := 0
					; If ( (NWD_AltState = "D") and NWD_WinStartAR )
					; {
						; NWD_WinNewARW := NWD_WinNewH * NWD_WinStartAR
						; NWD_WinNewARH := NWD_WinNewW / NWD_WinStartAR
						; If ( NWD_WinNewW < NWD_WinNewARW )
							; NWD_WinNewW := NWD_WinNewARW
						; If ( NWD_WinNewH < NWD_WinNewARH )
							; NWD_WinNewH := NWD_WinNewARH
					; }
					NWD_WinDeltaX = 0
					NWD_WinDeltaY = 0
					; If ( NWD_WinState = "D" )
					; {
						; NWD_WinDeltaX := NWD_WinStartW / 2 - NWD_WinNewW / 2
						; NWD_WinDeltaY := NWD_WinStartH / 2 - NWD_WinNewH / 2
					; }
					; Else
					; {
					
					
					;;;;;;;;;;this is definitely needed if you are RESIZING the window. for moving, it is not needed at all AFAIK.
					
					If ( NWD_ResizeX = -1 )
						NWD_WinDeltaX := NWD_WinStartW - NWD_WinNewW
					If ( NWD_ResizeY = -1 )
						NWD_WinDeltaY := NWD_WinStartH - NWD_WinNewH
						
							
							
							
					; }
					NWD_WinNewX := NWD_WinStartX + NWD_WinDeltaX
					NWD_WinNewY := NWD_WinStartY + NWD_WinDeltaY
				}
				
				; If ( NWD_ShiftState = "D" )
					; NWD_WinNewRound = -1
				; Else
					; NWD_WinNewRound = 0
				
				; Transform, NWD_WinNewX, Round, %NWD_WinNewX%, %NWD_WinNewRound%
				; Transform, NWD_WinNewY, Round, %NWD_WinNewY%, %NWD_WinNewRound%
				; Transform, NWD_WinNewW, Round, %NWD_WinNewW%, %NWD_WinNewRound%
				; Transform, NWD_WinNewH, Round, %NWD_WinNewH%, %NWD_WinNewRound%
				
				If ( (NWD_WinNewX != NWD_WinX) or (NWD_WinNewY != NWD_WinY) or (NWD_WinNewW != NWD_WinW) or (NWD_WinNewH != NWD_WinH) )
				{
					WinMove, ahk_id %NWD_WinID%, , %NWD_WinNewX%, %NWD_WinNewY%, %NWD_WinNewW%, %NWD_WinNewH%
					
					If ( SYS_ToolTipFeedback )
					{
						WinGetPos, NWD_ToolTipWinX, NWD_ToolTipWinY, NWD_ToolTipWinW, NWD_ToolTipWinH, ahk_id %NWD_WinID%
						SYS_ToolTipText = Window Drag: (X:%NWD_ToolTipWinX%, Y:%NWD_ToolTipWinY%, W:%NWD_ToolTipWinW%, H:%NWD_ToolTipWinH%)
						Gosub, SYS_ToolTipFeedbackShow
					}
				}
			}
		}
	}
Return



; TSW_WheelHandler:
	; GetKeyState, TSW_RButtonState, RButton, P
	; If ( TSW_RButtonState = "U" )
	; {
		; SetTimer, TSW_WheelHandler, Off
		; GetKeyState, TSW_LAltState, LAlt
		; If ( TSW_LAltState = "D" )
			; Send, {LAlt up}
	; }
; Return



; TRA_ExitHandler:
; tooltip,
	; ; Gosub, TRA_TransparencyAllOff
; Return






; [TRY] handles the tray icon/menu

TRY_TrayInit:
	Menu, TRAY, NoStandard
	Menu, TRAY, Tip, %SYS_ScriptInfo%

	If ( !A_IsCompiled )
	{
		Menu, AutoHotkey, Standard
		Menu, TRAY, Add, AutoHotkey, :AutoHotkey
		Menu, TRAY, Add
	}

	Menu, TRAY, Add, Help, TRY_TrayEvent
	Menu, TRAY, Default, Help
	Menu, TRAY, Add
	Menu, TRAY, Add, About, TRY_TrayEvent
	Menu, TRAY, Add
	Menu, TRAY, Add, Mail Author, TRY_TrayEvent
	Menu, TRAY, Add, View License, TRY_TrayEvent
	Menu, TRAY, Add, Visit Website, TRY_TrayEvent
	Menu, TRAY, Add, Check For Update, TRY_TrayEvent
	Menu, TRAY, Add

	Menu, MouseHooks, Add, Left Mouse Button, TRY_TrayEvent
	Menu, MouseHooks, Add, Middle Mouse Button, TRY_TrayEvent
	Menu, MouseHooks, Add, Right Mouse Button, TRY_TrayEvent
	Menu, MouseHooks, Add, Fourth Mouse Button, TRY_TrayEvent
	Menu, MouseHooks, Add, Fifth Mouse Button, TRY_TrayEvent
	Menu, TRAY, Add, Mouse Hooks, :MouseHooks

	Menu, TRAY, Add, ToolTip Feedback, TRY_TrayEvent
	Menu, TRAY, Add, Auto Suspend, TRY_TrayEvent
	Menu, TRAY, Add, Focus Follows Mouse, TRY_TrayEvent
	Menu, TRAY, Add, Suspend All Hooks, TRY_TrayEvent
	Menu, TRAY, Add, Revert Visual Effects, TRY_TrayEvent
	Menu, TRAY, Add, Hide Tray Icon, TRY_TrayEvent
	Menu, TRAY, Add
	Menu, TRAY, Add, Exit, TRY_TrayEvent
	
	Gosub, TRY_TrayUpdate

	If ( A_IconHidden )
		Menu, TRAY, Icon
Return

TRY_TrayUpdate:
	If ( CFG_LeftMouseButtonHook )
		Menu, MouseHooks, Check, Left Mouse Button
	Else
		Menu, MouseHooks, UnCheck, Left Mouse Button
	If ( CFG_MiddleMouseButtonHook )
		Menu, MouseHooks, Check, Middle Mouse Button
	Else
		Menu, MouseHooks, UnCheck, Middle Mouse Button
	If ( CFG_RightMouseButtonHook )
		Menu, MouseHooks, Check, Right Mouse Button
	Else
		Menu, MouseHooks, UnCheck, Right Mouse Button
	If ( CFG_FourthMouseButtonHook )
		Menu, MouseHooks, Check, Fourth Mouse Button
	Else
		Menu, MouseHooks, UnCheck, Fourth Mouse Button
	If ( CFG_FifthMouseButtonHook )
		Menu, MouseHooks, Check, Fifth Mouse Button
	Else
		Menu, MouseHooks, UnCheck, Fifth Mouse Button
	If ( SYS_ToolTipFeedback )
		Menu, TRAY, Check, ToolTip Feedback
	Else
		Menu, TRAY, UnCheck, ToolTip Feedback
	If ( SUS_AutoSuspend )
		Menu, TRAY, Check, Auto Suspend
	Else
		Menu, TRAY, UnCheck, Auto Suspend
	If ( XWN_FocusFollowsMouse )
		Menu, TRAY, Check, Focus Follows Mouse
	Else
		Menu, TRAY, UnCheck, Focus Follows Mouse
	If ( A_IsSuspended )
		Menu, TRAY, Check, Suspend All Hooks
	Else
		Menu, TRAY, UnCheck, Suspend All Hooks
Return

TRY_TrayEvent:
	If ( !TRY_TrayEvent )
		TRY_TrayEvent = %A_ThisMenuItem%
	
	If ( TRY_TrayEvent = "Help" )
		IfExist, %A_ScriptDir%\readme.txt
			Run, "%A_ScriptDir%\readme.txt"
		Else
		{
			SYS_TrayTipText = File couldn't be accessed:`n%A_ScriptDir%\readme.txt
			SYS_TrayTipOptions = 3
			Gosub, SYS_TrayTipShow
		}

	If ( TRY_TrayEvent = "About" )
	{
		SYS_TrayTipText = Copyright (c) 2004-2005 by Enovatic-Solutions.`nAll rights reserved. Use is subject to license terms.`n`nCompany:`tEnovatic-Solutions (IT Service Provider)`nAuthor:`t`tOliver Pfeiffer`, Bremen (GERMANY)`nEmail:`t`tniftywindows@enovatic.org
		Gosub, SYS_TrayTipShow
	}

	If ( TRY_TrayEvent = "Mail Author" )
		Run, mailto:niftywindows@enovatic.org?subject=%SYS_ScriptInfo% (build %SYS_ScriptBuild%)

	If ( TRY_TrayEvent = "View License" )
		IfExist, %A_ScriptDir%\license.txt
			Run, "%A_ScriptDir%\license.txt"
		Else
		{
			SYS_TrayTipText = File couldn't be accessed:`n%A_ScriptDir%\license.txt
			SYS_TrayTipOptions = 3
			Gosub, SYS_TrayTipShow
		}

	If ( TRY_TrayEvent = "Visit Website" )
		Run, http://www.enovatic.org/products/niftywindows/

	If ( TRY_TrayEvent = "Check For Update" )
		Gosub, UPD_CheckForUpdate

	If ( TRY_TrayEvent = "ToolTip Feedback" )
		SYS_ToolTipFeedback := !SYS_ToolTipFeedback

	If ( TRY_TrayEvent = "Auto Suspend" )
	{
		SUS_AutoSuspend := !SUS_AutoSuspend
		Gosub, CFG_ApplySettings
	}

	If ( TRY_TrayEvent = "Focus Follows Mouse" )
	{
		XWN_FocusFollowsMouse := !XWN_FocusFollowsMouse
		Gosub, CFG_ApplySettings
	}

	If ( TRY_TrayEvent = "Suspend All Hooks" )
		Gosub, SUS_SuspendToggle
	
	If ( TRY_TrayEvent = "Revert Visual Effects" )
		Gosub, SYS_RevertVisualEffects

	If ( TRY_TrayEvent = "Hide Tray Icon" )
	{
		SYS_TrayTipText = Tray icon will be hidden now.`nPress WIN+X to show it again.
		SYS_TrayTipOptions = 2
		SYS_TrayTipSeconds = 5
		Gosub, SYS_TrayTipShow
		SetTimer, TRY_TrayHide, 5000
	}

	If ( TRY_TrayEvent = "Exit" )
		ExitApp

	If ( TRY_TrayEvent = "Left Mouse Button" )
	{
		CFG_LeftMouseButtonHook := !CFG_LeftMouseButtonHook
		Gosub, CFG_ApplySettings
	}
	
	If ( TRY_TrayEvent = "Middle Mouse Button" )
	{
		CFG_MiddleMouseButtonHook := !CFG_MiddleMouseButtonHook
		Gosub, CFG_ApplySettings
	}
	
	If ( TRY_TrayEvent = "Right Mouse Button" )
	{
		CFG_RightMouseButtonHook := !CFG_RightMouseButtonHook
		Gosub, CFG_ApplySettings
	}
	
	If ( TRY_TrayEvent = "Fourth Mouse Button" )
	{
		CFG_FourthMouseButtonHook := !CFG_FourthMouseButtonHook
		Gosub, CFG_ApplySettings
	}
	
	If ( TRY_TrayEvent = "Fifth Mouse Button" )
	{
		CFG_FifthMouseButtonHook := !CFG_FifthMouseButtonHook
		Gosub, CFG_ApplySettings
	}

	Gosub, TRY_TrayUpdate
	TRY_TrayEvent =
Return

TRY_TrayHide:
	SetTimer, TRY_TrayHide, Off
	Menu, TRAY, NoIcon
Return



; ; [EDT] edits this script in notepad

; ^#!F9::
	; If ( A_IsCompiled )
		; Return
	
	; Gosub, SUS_SuspendSaveState
	; Suspend, On
	; MsgBox, 4129, Edit Handler - %SYS_ScriptInfo%, You pressed the hotkey for editing this script:`n`n%A_ScriptFullPath%`n`nDo you really want to edit?
	; Gosub, SUS_SuspendRestoreState
	; IfMsgBox, OK
		; Run, notepad.exe %A_ScriptFullPath%
; Return



; [REL] reloads this script on change

REL_ScriptReload:
	If ( A_IsCompiled )
		Return

	FileGetAttrib, REL_Attribs, %A_ScriptFullPath%
	IfInString, REL_Attribs, A
	{
		FileSetAttrib, -A, %A_ScriptFullPath%
		If ( REL_InitDone )
		{
			Gosub, SUS_SuspendSaveState
			Suspend, On
			MsgBox, 4145, Update Handler - %SYS_ScriptInfo%, The following script has changed:`n`n%A_ScriptFullPath%`n`nReload and activate this script?
			Gosub, SUS_SuspendRestoreState
			IfMsgBox, OK
				Reload
		}
	}
	REL_InitDone = 1
Return



; ; [EXT] exits this script

; #x::
	; If ( A_IconHidden )
	; {
		; Menu, TRAY, Icon
		; SYS_TrayTipText = Tray icon is shown now.`nPress WIN+X again to exit NiftyWindows.
		; SYS_TrayTipSeconds = 5
		; Gosub, SYS_TrayTipShow
		; Return
	; }

	; If ( A_IsCompiled )
	; {
		; SYS_TrayTipText = NiftyWindows will exit now.`nYou can find it here (to start it again):`n%A_ScriptFullPath%
		; SYS_TrayTipOptions = 2
		; SYS_TrayTipSeconds = 5
		; Gosub, SYS_TrayTipShow
		; Suspend, On
		; Sleep, 5000
		; ExitApp
	; }

	; Gosub, SUS_SuspendSaveState
	; Suspend, On
	; MsgBox, 4145, Exit Handler - %SYS_ScriptInfo%, You pressed the hotkey for exiting this script:`n`n%A_ScriptFullPath%`n`nDo you really want to exit?
	; Gosub, SUS_SuspendRestoreState
	; IfMsgBox, OK
		; ExitApp
; Return



; [CFG] handles the persistent configuration

CFG_LoadSettings:
	CFG_IniFile = %A_ScriptDir%\%SYS_ScriptNameNoExt%.ini
	IniRead, SUS_AutoSuspend, %CFG_IniFile%, Main, AutoSuspend, 1
	IniRead, XWN_FocusFollowsMouse, %CFG_IniFile%, WindowHandling, FocusFollowsMouse, 0
	IniRead, SYS_ToolTipFeedback, %CFG_IniFile%, Visual, ToolTipFeedback, 1
	IniRead, UPD_LastUpdateCheck, %CFG_IniFile%, UpdateCheck, LastUpdateCheck, %A_MM%
	IniRead, CFG_LeftMouseButtonHook, %CFG_IniFile%, MouseHooks, LeftMouseButton, 1
	IniRead, CFG_MiddleMouseButtonHook, %CFG_IniFile%, MouseHooks, MiddleMouseButton, 1
	IniRead, CFG_RightMouseButtonHook, %CFG_IniFile%, MouseHooks, RightMouseButton, 1
	IniRead, CFG_FourthMouseButtonHook, %CFG_IniFile%, MouseHooks, FourthMouseButton, 1
	IniRead, CFG_FifthMouseButtonHook, %CFG_IniFile%, MouseHooks, FifthMouseButton, 1
Return

CFG_SaveSettings:
	CFG_IniFile = %A_ScriptDir%\%SYS_ScriptNameNoExt%.ini
	IniWrite, %SUS_AutoSuspend%, %CFG_IniFile%, Main, AutoSuspend
	IniWrite, %XWN_FocusFollowsMouse%, %CFG_IniFile%, WindowHandling, FocusFollowsMouse
	IniWrite, %SYS_ToolTipFeedback%, %CFG_IniFile%, Visual, ToolTipFeedback
	IniWrite, %UPD_LastUpdateCheck%, %CFG_IniFile%, UpdateCheck, LastUpdateCheck
	IniWrite, %CFG_LeftMouseButtonHook%, %CFG_IniFile%, MouseHooks, LeftMouseButton
	IniWrite, %CFG_MiddleMouseButtonHook%, %CFG_IniFile%, MouseHooks, MiddleMouseButton
	IniWrite, %CFG_RightMouseButtonHook%, %CFG_IniFile%, MouseHooks, RightMouseButton
	IniWrite, %CFG_FourthMouseButtonHook%, %CFG_IniFile%, MouseHooks, FourthMouseButton
	IniWrite, %CFG_FifthMouseButtonHook%, %CFG_IniFile%, MouseHooks, FifthMouseButton
Return

CFG_ApplySettings:
	If ( SUS_AutoSuspend )
		SetTimer, SUS_SuspendHandler, 1000
	Else
		SetTimer, SUS_SuspendHandler, Off
		
	; If ( XWN_FocusFollowsMouse )
		; SetTimer, XWN_FocusHandler, 100
	; Else
		; SetTimer, XWN_FocusHandler, Off
		
	If ( CFG_LeftMouseButtonHook )
		CFG_LeftMouseButtonHookStr = On
	Else
		CFG_LeftMouseButtonHookStr = Off

	If ( CFG_MiddleMouseButtonHook )
		CFG_MiddleMouseButtonHookStr = On
	Else
		CFG_MiddleMouseButtonHookStr = Off

	If ( CFG_RightMouseButtonHook )
		CFG_RightMouseButtonHookStr = On
	Else
		CFG_RightMouseButtonHookStr = Off

	If ( CFG_FourthMouseButtonHook )
		CFG_FourthMouseButtonHookStr = On
	Else
		CFG_FourthMouseButtonHookStr = Off

	If ( CFG_FifthMouseButtonHook )
		CFG_FifthMouseButtonHookStr = On
	Else
		CFG_FifthMouseButtonHookStr = Off
	
	; Hotkey, $LButton, %CFG_LeftMouseButtonHookStr%
	; Hotkey, $^LButton, %CFG_LeftMouseButtonHookStr%
	; Hotkey, #LButton, %CFG_LeftMouseButtonHookStr%
	; Hotkey, #^LButton, %CFG_LeftMouseButtonHookStr%
	
	; Hotkey, #MButton, %CFG_MiddleMouseButtonHookStr%
	; Hotkey, #^MButton, %CFG_MiddleMouseButtonHookStr%
	; Hotkey, $MButton, %CFG_MiddleMouseButtonHookStr%
	; Hotkey, $^MButton, %CFG_MiddleMouseButtonHookStr%
	
	Hotkey, $RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+!RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+^RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+!^RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+!#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+^#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $+!^#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $!RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $!^RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $!#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $!^#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $^RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $^#RButton, %CFG_RightMouseButtonHookStr%
	Hotkey, $#RButton, %CFG_RightMouseButtonHookStr%
	
	Hotkey, $XButton1, %CFG_FourthMouseButtonHookStr%
	Hotkey, $^XButton1, %CFG_FourthMouseButtonHookStr%
	
	Hotkey, $XButton2, %CFG_FifthMouseButtonHookStr%
	Hotkey, $^XButton2, %CFG_FifthMouseButtonHookStr%
Return



; ;;[UPD] checks for a new build

UPD_CheckForUpdate:
	UPD_CheckSuccess =
	Random, UPD_Random
	If ( TEMP )
		UPD_BuildFile = %TEMP%\%SYS_ScriptNameNoExt%.%UPD_Random%.tmp
	Else
		UPD_BuildFile = %SYS_ScriptDir%\%SYS_ScriptNameNoExt%.%UPD_Random%.tmp
	Gosub, SUS_SuspendSaveState
	Suspend, On
	URLDownloadToFile, http://www.enovatic.org/products/niftywindows/files/build.txt?random=%UPD_Random%, %UPD_BuildFile%
	Gosub, SUS_SuspendRestoreState
	If ( !ErrorLevel )
	{
		FileReadLine, UPD_Build, %UPD_BuildFile%, 1
		If ( !ErrorLevel )
			If UPD_Build is digit
			{
				UPD_CheckSuccess = 1
				UPD_LastUpdateCheck = %A_MM%
				If ( UPD_Build > SYS_ScriptBuild )
				{
					SYS_TrayTipText = There is a new version available. Please check website.
					SYS_TrayTipOptions = 1
					Run, http://www.enovatic.org/products/niftywindows/
				}
				Else
					SYS_TrayTipText = There is no new version available.
			}
			Else
				SYS_TrayTipText = wrong build pattern in downloaded build file
		Else
			SYS_TrayTipText = downloaded build file couldn't be read
	}
	Else
		SYS_TrayTipText = build file couldn't be downloaded
	FileDelete, %UPD_BuildFile%
	If ( !UPD_CheckSuccess )
	{
		SYS_TrayTipText = Check for update failed:`n%SYS_TrayTipText%
		SYS_TrayTipOptions = 3
	}
	Gosub, SYS_TrayTipShow
Return



; ^#!b::
	; If ( !A_IsCompiled )
	; {
		; UPD_VersionFile = %SYS_ScriptDir%\version.txt
		; IfExist, %UPD_VersionFile%
		; {
			; FileDelete, %UPD_VersionFile%
			; If ( ErrorLevel )
				; Return
		; }
		; FileAppend, %SYS_ScriptVersion%, %UPD_VersionFile%
		; If ( ErrorLevel )
			; Return
			
		; UPD_BuildFile = %SYS_ScriptDir%\build.txt
		; IfExist, %UPD_BuildFile%
		; {
			; FileDelete, %UPD_BuildFile%
			; If ( ErrorLevel )
				; Return
		; }
		; FileAppend, %A_NowUTC%, %UPD_BuildFile%
		; If ( ErrorLevel )
			; Return
		
		; SYS_TrayTipText = Version and build files were written successfully:`n%UPD_VersionFile%`n%UPD_BuildFile%
		; SYS_TrayTipOptions = 2
		; SYS_TrayTipSeconds = 5
		; Gosub, SYS_TrayTipShow
	; }
; Return
