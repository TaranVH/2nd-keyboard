# KeyPress-Displayer

THIS IS A SIMPLER ALTERNATIVE TO KEYSTROKE VIZ.AHK. THE TWO SHOULD NOT BE USED AT THE SAME TIME.

Creates an On Screen Display of all the keypresses from the keyboard and mouse buttons

This is an AutoHotKey(.ahk) Script and requires AutoHotkey software to run this script, which can be [obtained for free here](https://autohotkey.com/download/ahk-install.exe) (Size: 2.96 MB)

Challenge is to make a script that,

1. [x] Displays all the keyboard and mouse button presses on the screen - Done
1. [x] The Display should be customizable ie; changes could be made to the *Font, Background Color, Font Color - Done*
1. [ ] The Display should decrease its transparency when the pressed key is released.
1. [x] The Display should disappear after a while if no further keys are pressed. - Done
1. [x] Should display "**234.56**" as a whole group like "**234.56**" and not individual keystrokes like "**2**" then "**3**" then "**4**" then "**.**" then "**5**" then "**6**". Same is applicable to words "**HELLO**" not "**H**" "**E**" "**L**" "**L**" "**O** - Done"
1. [x] Should display "**Numpad0**" as "**0**" "**Numpad1**" as "**1**" etc. - Done
1. [x] Should display "**(**" as "**(**" and not "**Shift+0**" or "**Shift+)**" likewise for all symbols. - Done
1. [x] Multiple keypresses like "**Backspace Backspace Backspace Backspace Backspace**" as "**Backspace(x5)**", the number in the brackets is to increase with the increase in keypresses. - Done
1. [x] Should not treat "**Hello**" as "**Hel(x2)o**" - Done
1. [x] Should refresh the display after a certain number of keypresses are made. - Done
    1. For example, with a breakpoint of 15 characters the typed string "**I went to the zoo yesterday had lots of fun**" should be displayed as,<br>"**I went to the z**" then<br>"**oo yesterday ha**" and finally<br>"**d lots of fun**"
