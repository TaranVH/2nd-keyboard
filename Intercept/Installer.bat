@echo off
setlocal EnableDelayedExpansion

echo Press enter to confirm the installation...
pause > NUL

If NOT exist "tmp" (
    mkdir tmp
)

:download_interception
REM @TODO: We should only download and install interception if it's not already avalible on the system

If exist "tmp/interception.zip" (
    echo Interception already downloaded. Skipping....
    GOTO unzip_interception
)

REM Using a static link to version 1.0 meaning we wont get updates.
REM We could write some more complicated logic that checks for new
REM versions but im not gonna do that now
set interception_url="https://github.com/oblitum/Interception/releases/download/1.0.0/Interception.zip"

REM Since batch cant download files directly we have to use a vbs file.
REM We're just gonna tell it to download the latest release of Interception
REM from github and save it as interception.zip
echo Downloading Interception...
cscript //Nologo installer/download.vbs %interception_url% tmp/interception.zip

:unzip_interception
REM Just exiting if we where not able to download the program
If not exist "tmp/interception.zip" (
    echo Oh noes. We where not able to download interception. Aborting program...
    pause
    goto exit
)

REM If the zip file is not extracted we then do it...
if not exist "Interception" (
    :: Since batch cant extract zip files either, we're gonna use a VBscript here again.
    echo Extracting Interception...
    cscript //Nologo installer/unzip.vbs tmp/interception.zip ./
) else (
    echo Interception already extracted. Skipping....
)

:install_interception
echo.
echo.
ECHO **************************************
ECHO               ATTENTION
ECHO **************************************
echo We're now gonna install 'Interception' for you. This requires administrator rights. Press yes on the popup for the installation to continue.
pause

start /B /WAIT installer\elevated.bat install_interception.bat

echo Press enter when the interception install is done AND you've closed the secondary window.
pause>nul


:download_intercept
echo Downloading Intercept.exe...

set intercept_url="http://octopup.org/img/code/interception/intercept.zip"

REM Since batch cant download files directly we have to use a vbs file.
REM We're just gonna tell it to download the latest release of Interception
REM from github and save it as interception.zip
cscript //Nologo installer/download.vbs %intercept_url% tmp/intercept.zip

:unzip_intercept
REM Just exiting if we where not able to download the program
If not exist "tmp/intercept.zip" (
    echo Oh noes. We where not able to download intercept. Aborting program...
    pause
    goto exit
)

REM If the zip file is not extracted we then do it...
if not exist "intercept" (
    :: Since batch cant extract zip files either, we're gonna use a VBscript here again.
    echo Extracting Intercept.exe...
    cscript //Nologo installer/unzip.vbs tmp/intercept.zip ./
) else (
    echo Intercept.exe already extracted. Skipping....
)


:download_other_dependencies
echo Downloading other dependencies...

REM Using a static link to version 1.0 meaning we wont get updates.
REM We could write some more complicated logic that checks for new
REM versions but im not gonna do that now
set getdeviceid_url="https://github.com/jlndk/getdeviceid/releases/download/v1.0/getdeviceid.zip"

REM Since batch cant download files directly we have to use a vbs file.
REM We're just gonna tell it to download the latest release of Interception
REM from github and save it as interception.zip
cscript //Nologo installer/download.vbs %getdeviceid_url% tmp/getdeviceid.zip

:unzip_intercept
REM Just exiting if we where not able to download the program
If not exist "tmp/getdeviceid.zip" (
    echo Oh noes. We where not able to download getdeviceid. Aborting program...
    pause
    goto exit
)

REM If the zip file is not extracted we then do it...
if not exist "installer/getdeviceid.exe" (
    :: Since batch cant extract zip files either, we're gonna use a VBscript here again.
    echo Extracting Dependencies...
    cscript //Nologo installer/unzip.vbs tmp/getdeviceid.zip installer
)

echo Installation successfull. Now reboot your computer and run 'keymap.bat'


:exit
REM cleaning up a bit before we exit
rmdir /s /q tmp
