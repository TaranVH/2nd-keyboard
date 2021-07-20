#Warn All, MsgBox

^+e::

; for example
PhotoshopExport()
return
; or 
;PhotoshopExport("C:\foo\", "jpeg")

; baseDir: optional path to save the image if the document is unsaved or forcePath is true
; format: psd, png, jpeg or tif. more are available through the api but I'm lazy
; forcePath: force saving the file to baseDir
PhotoshopExport(baseDir := "", format := "jpeg", forcePath := false)
{
	try {
		psApp := ComObjActive("Photoshop.Application")
	}
	catch e {
		MsgBox, % "Unable to connect to running Photoshop instance: " e.message
	}

	if(psApp.Documents.Count < 1)
		throw Exception("There is no open document")

	doc := psApp.activeDocument

	; figure out the directory where the file should be saved
	resultPath := ""
	if(forcePath)
	{
		resultPath := forcePath
	}
	else
	{
		try {
			; will throw an exception if unsaved
			resultPath := doc.path
		}
		catch e {
			if(baseDir != "")
				resultPath := baseDir
			else
				throw Exception("Document is unsaved and no baseDir was provided")
		}
	}
	
	; ensure the directory actually exists
	if(!InStr(FileExist(resultPath),  "D"))
		throw Exception("Unable to export to path " . resultPath)

	; parse the file name and change the extension
	newFileName := ""
	try {
		SplitPath, % doc.fullName, , , , currentBaseFileName
		newFileName := currentBaseFileName . "." . format
	} 
	catch e {
		; if unsaved, name the file ahkexport
		newFileName := "ahkexport." . format
	}

	exportFullPath := resultPath . "\" . newFileName

	formatId := -1
	if(format == "psd")
		formatId := 1
	if(format == "jpeg")
		formatId := 6
	else if(format == "png")
		formatId := 13
	else if(format == "tif")
		formatId := 17
	else
		throw Exception("Invalid file format: " . format)

	; see page 108 for numerous available options: https://www.adobe.com/content/dam/acom/en/devnet/photoshop/pdfs/photoshop-javascript-ref-2020.pdf
	options := ComObjCreate("Photoshop.ExportOptionsSaveForWeb")
	options.Quality := 90
	options.Format := formatId
	options.Optimized := ComObj(0xB, -1)

	try {
		; 2 stands for ExportType SAVEFORWEB
		doc.export(exportFullPath , 2, options)
	}
	catch e {
		MsgBox, % "Error exporting the image: " e.message
	}
	
	ObjRelease(options)
	ObjRelease(psApp)
}
