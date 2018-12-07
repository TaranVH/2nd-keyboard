# 2nd-keyboard

NOTE: CURRENTLY UNTESTED, wil do that soon ish

A quickstart guide for using a second keyboard purely for macros on Windows.

---

## Getting started

[Watch the video](https://youtu.be/Arn8ExQ2Gjg?t=362) first, then take a look at the instructions below.

1. Ensure that both your keyboards are plugged in.
2. Download and install [LuaMacros](http://www.hidmacros.eu/forum/viewtopic.php?f=10&t=241#p794) and [AuthoHotkey](https://autohotkey.com/).
3. Download `2nd_keyboard_if_using_luamacros.ahk`,  `SECOND_KEYBOARD_script_for_LUA_MACROS.lua`, and `keypressed.txt` from this github repository, by clicking on the RAW button for each, and then selecting FILE > SAVE AS. Save them all into the same folder. I STRONGLY recommend that you use `C:\AHK\2nd-keyboard\LUAMACROS`. That way, you won't have to change any file paths at all! The only downside is that ALL users will have access to those scripts.
4. Open `SECOND_KEYBOARD_script_for_LUA_MACROS.lua` using LuaMacros.exe, which will allow you to view and modify the code. You'll need to change the file path of keypressed.txt at least.
5. Click on the "play" arrow button. An identification window should pop up. Press any key on your 2nd keyboard, and luamacros will identify that device as your 2nd keyboard.
6. Typing on your 2nd keyboard should no longer work, since LuaMacros is now intercepting and blocking those keystrokes.
7. Press the spacebar on your second keyboard, then check keypressed.txt to see if it now contains the string "spacebar". If so, you got it working!
8. Right-click on `Almost_All_Premiere_Functions.ahk` and open it in a text editor like notepad++.
9. Scroll down and find and change the filepath `C:\AHK\2nd-keyboard\LUAMACROS\keypressed.txt` to the correct location of keypressed.txt on your own computer. (If it is different.)
10. `2nd_keyboard_if_using_luamacros.ahk` only has bare functions for proof of concept. You can write your own functions, or copy/paste some from from `Almost_All_Premiere_Functions.ahk`, but you'll probably need to modify them to fit your own system, by changing coordinates, windowClasses, colors, shortcuts, and so on.


### Don't Panic!

---

## References

* [DIY 87-Key Macro Keyboard](https://www.youtube.com/watch?v=Arn8ExQ2Gjg) by Taran of LinusTechTips

* [The Art of the Bodge](https://www.youtube.com/watch?v=lIFE7h3m40U) by Tom Scott

* [LuaMacros](https://github.com/stevedonovan/LuaMacro)

* [AuthoHotkey](https://github.com/AutoHotkey/AutoHotkey)
