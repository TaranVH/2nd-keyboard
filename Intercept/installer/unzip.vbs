Option Explicit
Dim args, src, dist, fso, zip, files, objShell,FilesInZip

Set args = Wscript.Arguments
Set fso = CreateObject("Scripting.FileSystemObject")

'The location of the zip file.
src = fso.GetAbsolutePathName(args(0))
'The folder the contents should be extracted to.
dist= fso.GetAbsolutePathName(args(1))

'WScript.Echo "Unzipping '" & src & "' to '" & dist & "'..."

'If the extraction location does not exist create it.
If NOT fso.FolderExists(dist) Then
   fso.CreateFolder(dist)
End If

'Extract the contants of the zip file.
set objShell = CreateObject("Shell.Application")
set zip=objShell.NameSpace(src)

if (not zip is nothing) then
    set files=zip.items

    objShell.NameSpace(dist).CopyHere(files)
    Set fso = Nothing
    Set objShell = Nothing
else
    WScript.Echo "Could not find zip file '" + src + "'"
end if
