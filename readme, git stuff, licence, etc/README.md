# 2nd-keyboard

A quickstart guide for using a second keyboard purely for macros on Windows.
It's not super complicated, but you'll need a novice understanding of scripting/programming, and need to know how to effectively debug a script one step at a time (for when you are modifying my code.)

---

## Getting started

[Watch the video](https://youtu.be/Arn8ExQ2Gjg?t=362) first, then take a look at the instructions below.

1. Ensure that both your keyboards are plugged in.
2. Download and install [LuaMacros](http://www.hidmacros.eu/forum/viewtopic.php?f=10&t=241#p794) and [AuthoHotkey](https://autohotkey.com/).
2. Open `SECOND KEYBOARD script for LUA MACROS.lua` using LuaMacros.exe, which will allow you to view and modify the code. You'll need to change the file path of keypressed.txt at least.
4. Click on the "play" arrow button. An identification window should pop up. Press any key on your 2nd keyboard, and luamacros will identify that device as your 2nd keyboard.
5. Typing on your 2nd keyboard should no longer work, since LuaMacros is now intercepting those keystrokes.
6. Press the spacebar on your second keyboard, then check keypressed.txt to see if it now contains the string "spacebar". If so, you got it working!

7. Right-click on `SECOND KEYBOARD - Premiere functions.ahk` and open it in a text editor like notepad++.
8. Scroll down to line 300 and change the filepath `C:\Users\TaranVanHemert\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keypressed.txt` to the correct location of keypressed.txt on your own computer.
9. Scroll down to line 311 and change the filepath `C:\Users\TaranVanHemert\Documents\GitHub\2nd-keyboard\2nd keyboard support files\keyActions.txt` to the correct location of keyActions.txt on your own computer.
10. `keyActions.txt` is basically just a big array. Change it however you like, but pay attention to how the AHK script will read it.
11. `SECOND KEYBOARD Premiere functions in AutoHotKey.ahk` was built for use in Adobe Premiere, but you can delete all the functions and write your own, for whatever application you desire!
12. If you do want to use my AHK Premiere functions, you'll need to modify them to fit your own computer. Common changes that will have to be made are: Coordinates, panel names, colors.


### Don't Panic!

---

## References

* [DIY 87-Key Macro Keyboard](https://www.youtube.com/watch?v=Arn8ExQ2Gjg) by Taran of LinusTechTips

* [The Art of the Bodge](https://www.youtube.com/watch?v=lIFE7h3m40U) by Tom Scott

* [LuaMacros](https://github.com/stevedonovan/LuaMacro)

* [AuthoHotkey](https://github.com/AutoHotkey/AutoHotkey)
