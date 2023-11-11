@REM this is a simple script you can use if you want your second keyboard to initialize on startup. you'll need autohotkey.exe and luamacros.exe in your PATH environment variable.
@REM also make sure to switch out the paths to where your lua script and ahk scripts are, respectively.
@REM move this to your startup folder (Windows + R, shell:startup)

start /MIN LuaMacros.exe -r D:/Scripts/macrokb1.lua
start /MIN autohotkey.exe D:/Scripts/macrokb1.ahk
