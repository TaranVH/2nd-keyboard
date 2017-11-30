;---------------------------------------------------------------------
; Acc.ahk Standard Library
; by Sean
; https://github.com/ttnnkkrr/COM.AHK/blob/master/acc.ahk
; Updated by jethrow:
; 	Modified ComObjEnwrap params from (9,pacc) --> (9,pacc,1)
; 	Changed ComObjUnwrap to ComObjValue in order to avoid AddRef (thanks fincs)
; 	Added Acc_GetRoleText & Acc_GetStateText
; 	Added additional functions - commented below
; 	Removed original Acc_Children function
; last updated 2/19/2012
;---------------------------------------------------------------------

Acc_Init()
{
	Static	h := DllCall("LoadLibrary","Str","oleacc","Ptr")
}

Acc_ObjectFromEvent(ByRef _idChild_, hWnd, idObject, idChild)
{
	Acc_Init()
	if (DllCall("oleacc\AccessibleObjectFromEvent"
	          , "Ptr", hWnd
			  , "UInt", idObject
			  , "UInt", idChild
			  , "Ptr*", pacc
			  , "Ptr", VarSetCapacity(varChild, 8 + 2 * A_PtrSize, 0) * 0 + &varChild) = 0) {
		_idChild_:=NumGet(varChild,8,"UInt")
		return ComObjEnwrap(9,pacc,1)
	}
}

Acc_ObjectFromPoint(ByRef _idChild_ = "", x = "", y = "")
{
	Acc_Init()
	if (DllCall("oleacc\AccessibleObjectFromPoint"
			  , "Int64", x == ""||y==""
						 ? 0 * DllCall("GetCursorPos","Int64*",pt) + pt
						 : x & 0xFFFFFFFF | y << 32
			  , "Ptr*", pacc
			  , "Ptr", VarSetCapacity(varChild, 8 + 2 * A_PtrSize, 0) * 0 + &varChild) = 0) {
		_idChild_:=NumGet(varChild,8,"UInt")
		return ComObjEnwrap(9,pacc,1)
	}
}

Acc_ObjectFromWindow(hWnd, idObject = -4)
{
	Acc_Init()
	if (DllCall("oleacc\AccessibleObjectFromWindow"
			  , "Ptr", hWnd
			  , "UInt", idObject &= 0xFFFFFFFF
			  , "Ptr", -VarSetCapacity(IID,16)
			           + NumPut(idObject == 0xFFFFFFF0
							    ? 0x46000000000000C0
								: 0x719B3800AA000C81
								, NumPut(idObject == 0xFFFFFFF0
								? 0x0000000000020400
								: 0x11CF3C3D618736E0,IID,"Int64"),"Int64")
			  , "Ptr*", pacc) = 0)
		return ComObjEnwrap(9,pacc,1)
}

Acc_WindowFromObject(pacc)
{
	if (DllCall("oleacc\WindowFromAccessibleObject"
	          , "Ptr", IsObject(pacc) ? ComObjValue(pacc) : pacc
			  , "Ptr*", hWnd) = 0)
		return hWnd
}

Acc_GetRoleText(nRole)
{
	nSize := DllCall("oleacc\GetRoleText"
	               , "Uint", nRole
				   , "Ptr", 0
				   , "Uint", 0)
	VarSetCapacity(sRole, (A_IsUnicode ? 2 : 1) * nSize)
	DllCall("oleacc\GetRoleText"
	      , "Uint", nRole
		  , "str", sRole
		  , "Uint", nSize+1)
	return sRole
}

Acc_GetStateText(nState)
{
	nSize := DllCall("oleacc\GetStateText"
	               , "Uint", nState
				   , "Ptr", 0
				   , "Uint", 0)
	VarSetCapacity(sState, (A_IsUnicode ? 2 : 1) * nSize)
	DllCall("oleacc\GetStateText"
	      , "Uint", nState
		  , "str", sState
		  , "Uint", nSize+1)
	return sState
}

; Written by jethrow
Acc_Role(Acc, ChildId=0) {
	try return ComObjType(Acc,"Name") = "IAccessible"
	           ? Acc_GetRoleText(Acc.accRole(ChildId))
			   : "invalid object"
}

Acc_State(Acc, ChildId=0) {
	try return ComObjType(Acc,"Name") = "IAccessible"
	           ? Acc_GetStateText(Acc.accState(ChildId))
			   : "invalid object"
}

Acc_Children(Acc) {
	Acc_Init()
	cChildren := Acc.accChildCount
	Children:=[]
	if (DllCall("oleacc\AccessibleChildren"
	          , "Ptr", ComObjValue(Acc)
			  , "Int", 0
			  , "Int", cChildren
			  , "Ptr", VarSetCapacity(varChildren, cChildren * (8 + 2 * A_PtrSize), 0) * 0
			                                                 + &varChildren
			  , "Int*", cChildren) = 0) {
		Loop %cChildren% {
			i := (A_Index - 1) * (A_PtrSize * 2 + 8) + 8
			child:=NumGet(varChildren,i)
			Children.Insert(NumGet(varChildren, i - 8) = 3
					        ? child
							: Acc_Query(child))
			ObjRelease(child)
		}
		return Children
	}
	error := Exception("", -1)
	MsgBox 262420
	     , Acc_Children Failed
		 , % "File:  " error.file "`nLine: " error.line "`n`nContinue Script?"
	IfMsgBox, No
		ExitApp
}

Acc_Location(Acc, ChildId=0) { ; adapted from Sean's code
	try Acc.accLocation(ComObj(0x4003, & x := 0)
	                  , ComObj(0x4003,&y:=0)
					  , ComObj(0x4003,&w:=0)
					  , ComObj(0x4003,&h:=0)
					  , ChildId)
	catch
		return
	return { x:NumGet(x,0,"int")
	       , y:NumGet(y,0,"int")
		   , w:NumGet(w,0,"int")
		   , h:NumGet(h,0,"int")
		   , pos:"x" NumGet(x,0,"int")
		      . " y" NumGet(y,0,"int")
			  . " w" NumGet(w,0,"int")
			  . " h" NumGet(h,0,"int") }
}

Acc_Parent(Acc) { 
	try parent := Acc.accParent
	return parent ? Acc_Query(parent) :
}

Acc_Child(Acc, ChildId=0) {
	try child := Acc.accChild(ChildId)
	return child ? Acc_Query(child) :
}

; thanks Lexikos - www.autohotkey.com/forum/viewtopic.php?t=81731&p=509530#509530
Acc_Query(Acc) { 
	try return ComObj(9, ComObjQuery(Acc, "{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}

Acc_GetChild(Acc_or_Hwnd, child_path) {
   Acc := WinExist("ahk_id" Acc_or_Hwnd)? Acc_ObjectFromWindow(Acc_or_Hwnd):Acc_or_Hwnd
   if ComObjType(Acc,"Name") = "IAccessible" {
      Loop Parse, child_path, csv
         Acc := A_LoopField="P"? Acc_Parent(Acc):Acc_Children(Acc)[A_LoopField]
      return Acc
   }
}
