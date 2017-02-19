@echo off
cls
echo "Starting interception installer..."

echo %cd%
echo "----------------------------------------------"

REM Going back to our main directory
cd ..

if exist "Interception\command line installer\install-interception.exe" (
    "Interception\command line installer\install-interception.exe" /install
) else (
    echo "aww"
)


exit
