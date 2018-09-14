# KeyPress-Displayer
THIS IS A SIMPLER ALTERNATIVE TO KEYSTROKE VIZ.AHK. THE TWO SHOULD NOT BE USED AT THE SAME TIME.

Creates an On Screen Display of all the keypresses from the keyboard and mouse buttons

This is a AutoHotKey(.ahk) Script and requires Autohotkey software to run this script,<br>which can be obtained for free <a href="https://autohotkey.com/download/ahk-install.exe">here</a> (Size: 2.96 MB)


Challenge is to make a script that,
<ol type="a">
<li> <div color:#555555>Displays all the keyboard and mouse button presses on the screen - Done</div>
</li>
<li> The Display should be customisable ie; changes could be made to the <i>Font, Background Color, Font Color - Done</i>
</li>
<li> The Display should decrase its transparency when the pressed key is released.
</li>
<li> The Display should disappear after a while if no further keys are pressed. - Done
</li>
<li>Should display "<b>234.56</b>" as a whole group like "<b>234.56</b>" and not individual keystrokes like "<b>2</b>" then "<b>3</b>" then "<b>4</b>" then "<b>.</b>" then "<b>5</b>" then "<b>6</b>". Same is applicable to words "<b>HELLO</b>" not "<b>H</b>" "<b>E</b>" "<b>L</b>" "<b>L</b>" "<b>O</b> - Done"
</li>
<li> Should display "<b>Numpad0</b>" as "<b>0</b>" "<b>Numpad1</b>" as "<b>1</b>" etc. - Done
</li>
<li> Should display "<b>(</b>" as "<b>(</b>" and not "<b>Shift+0</b>" or "<b>Shift+)</b>" likewise for all symbols. - Done
</li>
<li> Multiple keypresses like "<b>Backspace Backspace Backspace Backspace Backspace</b>" as "<b>Backspace(x5)</b>", the number in the brackets is to increase with the increase in keypresses. - Done
</li>
<li> Should not treat "<b>Hello</b>" as "<b>Hel(x2)o</b>" - Done
</li>
<li> Should refresh the display after a certain number of keypresses are made. - Done<br>
For example, with a breakpoint of 15 characters the typed string "<b>I went to the zoo yesterday had lots of fun</b>" should be displayed as,<br>
"<b>I went to the z</b>" then<br>
"<b>oo yesterday ha</b>" and finally<br>
"<b>d lots of fun</b>" </li>
