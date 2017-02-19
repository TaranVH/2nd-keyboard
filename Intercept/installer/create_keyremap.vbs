'http://stackoverflow.com/questions/23641070/create-a-text-document-from-template-vbscript

Dim objFSO
Set objFSO = CreateObject("Scripting.FileSystemObject")

' IMPORT inireader functions
DIM objShell
Set objShell = wscript.createObject("wscript.shell")
Dim iniReaderPath
iniReaderPath = objFSO.GetAbsolutePathName("installer\iniReader.vbs")
Dim vbsFile
Set vbsFile = objFSO.OpenTextFile(iniReaderPath, 1, False)
Dim functions
functions = vbsFile.ReadAll
vbsFile.Close
Set vbsFile = Nothing
ExecuteGlobal functions
'END import inireader function


Dim args
Set args = Wscript.Arguments

Dim iniPath
iniPath = objFSO.GetAbsolutePathName(args(0))

Dim distPath
distPath = objFSO.GetAbsolutePathName(args(1))

Dim devId
devId = ReadIni(iniPath,iniPath,"device")

Const ForReading = 1
Const ForWriting = 2

Dim templatePath
templatePath = objFSO.GetAbsolutePathName("installer\template.ini")

Dim objTemplateTS
Set objTemplateTS = objFSO.OpenTextFile(templatePath, ForReading, False)

Dim strAllTemplateText
strAllTemplateText = objTemplateTS.ReadAll()
objTemplateTS.Close()
strAllTemplateText = Replace(strAllTemplateText, "<DID_PLACEHOLDER>", devId)


Dim objOutputTS
Set objOutputTS = objFSO.OpenTextFile(distPath, ForWriting, True)

objOutputTS.Write(strAllTemplateText)
objOutputTS.Close()
