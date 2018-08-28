


InsideClipboard v1.12
Copyright (c) 2007 - 2011 Nir Sofer
Web site: http://www.nirsoft.net



Description
===========

Each time that you copy something into the clipboard for pasting it into
another application, the copied data is saved into multiple formats. The
main clipboard application of Windows only display the basic clipboard
formats, like text and bitmaps, but doesn't display the list of all
formats that are stored in the clipboard.
InsideClipboard is a small utility that displays the binary content of
all formats that are currently stored in the clipboard, and allow you to
save the content of specific format into a binary file.



System Requirements
===================

This utility works on any version of Windows, from Windows 98 to Windows
Vista.



Versions History
================


* Version 1.12:
  o Added horizontal scrollbar to the lower pane.

* Version 1.11:
  o Added Index column, which displays the order of the clipboard
    formats.

* Version 1.10:
  o Added support for saving and loading as Windows .clp file. You
    can use it from the user interface or from command-line

* Version 1.06:
  o Fixed bug: The main window lost the focus when the user switched
    to another application and then returned back to InsideClipboard.

* Version 1.05:
  o New option: Save As Image File. (Works only in Windows
    XP/2003/Vista, or in other systems that GDI+ is installed)

* Version 1.04:
  o New option: Clear All Clipboard Data

* Version 1.03:
  o New option: Refresh On Clipboard Change.

* Version 1.02:
  o Fixed bug: CF_LOCALE format displayed as CF_DIBV5.

* Version 1.01:
  o Fixed bug: InsideClipboard displayed wrong data.
  o Added support for displaying stream data.

* Version 1.00 - First release.



Using InsideClipboard
=====================

InsideClipboard doesn't require any installation process or additional
dll files. In order to start using it, simply run the executable file
(InsideClipboard.exe)
The main window of InsideClipboard has 2 panes. The top pane display the
list of all formats that are currently stored in the clipboard. When
selecting a single item in the top pane, the bottom pane displays the
content of the selected clipboard format. You can view the content as
Ascii (for text-based formats, like RTF or HTML) or as hex dump.



Command-Line Options
====================



/stext <Filename>
Save the clipboard items list into a regular text file.

/stab <Filename>
Save the clipboard items list into a tab-delimited text file.

/stabular <Filename>
Save the clipboard items list into a tabular text file.

/shtml <Filename>
Save the clipboard items list into HTML file (Horizontal).

/sverhtml <Filename>
Save the clipboard items list into HTML file (Vertical).

/sxml <Filename>
Save the clipboard items list to XML file.

/saveclp <.clp Filename>
Save the current clipboard data to .clp file.

/loadclp <.clp Filename>
Load .clp file into the clipboard.



Translating InsideClipboard to other languages
==============================================

In order to translate InsideClipboard to other language, follow the
instructions below:
1. Run InsideClipboard with /savelangfile parameter:
   InsideClipboard.exe /savelangfile
   A file named InsideClipboard_lng.ini will be created in the folder of
   InsideClipboard utility.
2. Open the created language file in Notepad or in any other text
   editor.
3. Translate all string entries to the desired language. Optionally,
   you can also add your name and/or a link to your Web site.
   (TranslatorName and TranslatorURL values) If you add this information,
   it'll be used in the 'About' window.
4. After you finish the translation, Run InsideClipboard, and all
   translated strings will be loaded from the language file.
   If you want to run InsideClipboard without the translation, simply
   rename the language file, or move it to another folder.



License
=======

This utility is released as freeware. You are allowed to freely
distribute this utility via floppy disk, CD-ROM, Internet, or in any
other way, as long as you don't charge anything for this. If you
distribute this utility, you must include all files in the distribution
package, without any modification !



Disclaimer
==========

The software is provided "AS IS" without any warranty, either expressed
or implied, including, but not limited to, the implied warranties of
merchantability and fitness for a particular purpose. The author will not
be liable for any special, incidental, consequential or indirect damages
due to loss of data or any other reason.



Feedback
========

If you have any problem, suggestion, comment, or you found a bug in my
utility, you can send a message to nirsofer@yahoo.com
