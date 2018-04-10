#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000

;This small script was inspired by this post: https://adobe-video.uservoice.com/forums/911233-premiere-pro/suggestions/33839743-give-momentary-keypress-functionality-to-hand-and#comments
;I realized that wacom users would still benefit from scroll wheel functionality...



;This next line makes it so that anything below it can only happen if Premiere is the active window.
#IfWinActive ahk_exe Adobe Premiere Pro.exe

;;i found the code here https://stackoverflow.com/questions/24001634/how-can-i-bind-my-mouse-wheel-to-scroll-down-with-a-key-and-this-key-is-ahk
F11::
While GetKeyState("F11", "p")
{
    SendInput, {Wheelup}
    Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
}
return

F12::
;msgbox,,,you pressed F9,0.6
While GetKeyState("F12", "p")
{
    SendInput, {WheelDown}
    Sleep, 10 ; Add a delay if you want to increase the interval between keystokes.
}
return

;super boring script that is dumb
;because of the delay after the initial keypress
;and the slowness of the subsequent keypresses:
; F11::wheelup
; F12::wheeldown
