@echo off

echo When a new window pops up, follow the instructions.
echo After the keyboard detection is done, this dialog will continue.
pause

if not exist "installer\getdeviceid.exe" (
    echo run installer before running this program
    pause
    goto exit
)

start /WAIT installer/getdeviceid.exe

cscript //Nologo installer/create_keyremap.vbs deviceid.ini keyremap.ini

:exit
del deviceid.ini
