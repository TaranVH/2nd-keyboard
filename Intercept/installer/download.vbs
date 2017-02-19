Option Explicit
Dim args, http, fileSystem, adoStream, url, target, status

Set args = Wscript.Arguments
Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
url = args(0)
target = args(1)
'WScript.Echo "Getting '" & target & "' from '" & url & "'..."

http.Open "GET", url, False
http.Send
status = http.Status

If status <> 200 Then
	WScript.Echo "FAILED to download: HTTP Status " & status
	WScript.Quit 1
End If

Set adoStream = CreateObject("ADODB.Stream")
adoStream.Open
adoStream.Type = 1
adoStream.Write http.ResponseBody
adoStream.Position = 0

Set fileSystem = CreateObject("Scripting.FileSystemObject")
If fileSystem.FileExists(target) Then fileSystem.DeleteFile target
adoStream.SaveToFile target
adoStream.Close
