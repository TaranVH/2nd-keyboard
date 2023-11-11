#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;
; Midi.ahk
; Add MIDI input event handling to your AutoHotkey scripts
;
; Danny Warren <danny@dannywarren.com>
; https://github.com/dannywarren/AutoHotkey-Midi
;


; Always use gui mode when using the midi library, since we need something to
; attach midi events to
Gui, +LastFound

; Defines the string size of midi devices returned by windows (see mmsystem.h)
Global MIDI_DEVICE_NAME_LENGTH := 32

; Defines the size of a midi input struct MIDIINCAPS (see mmsystem.h)
Global MIDI_DEVICE_IN_STRUCT_LENGTH  := 44

; Defines for midi event callbacks (see mmsystem.h)
Global MIDI_CALLBACK_WINDOW   := 0x10000
Global MIDI_CALLBACK_TASK     := 0x20000
Global MIDI_CALLBACK_FUNCTION := 0x30000

; Defines for midi event types (see mmsystem.h)
Global MIDI_OPEN      := 0x3C1
Global MIDI_CLOSE     := 0x3C2
Global MIDI_DATA      := 0x3C3
Global MIDI_LONGDATA  := 0x3C4
Global MIDI_ERROR     := 0x3C5
Global MIDI_LONGERROR := 0x3C6
Global MIDI_MOREDATA  := 0x3CC

; Defines the size of the standard chromatic scale
Global MIDI_NOTE_SIZE := 12

; Defines the midi notes 
Global MIDI_NOTES     := [ "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" ]

; Defines the octaves for midi notes
Global MIDI_OCTAVES   := [ -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8 ]


; This is where we will keep the most recent midi in event data so that it can
; be accessed via the Midi object, since we cannot store it in the object due
; to how events work
; We will store the last event by the handle used to open the midi device, so
; at least we won't clobber midi events from other devices if the user wants 
; to fetch them specifically
Global __midiInEvent        := {}
Global __midiInHandleEvent  := {}

; List of all midi input devices on the system
Global __midiInDevices := {}

; List of midi input devices to listen to messages for, we do this globally
; since only one instance of the class can listen to a device anyhow
Global __midiInOpenHandles := {}

; Count of open handles, since ahk doesn't have a method to actually count the
; members of an array (it instead just returns the highest index, which isn't
; the same thing)
Global __midiInOpenHandlesCount := 0

; Holds a refence to the system wide midi dll, so we don't have to open it
; multiple times
Global __midiDll := 0

; The window to attach the midi callback listener to, which will default to
; our gui window
Global __midiInCallbackWindow := WinExist()


; Default label prefix
Global midiLabelPrefix := "Midi"

; Enable or disable label event handling
Global midiLabelCallbacks := True

; Enable or disable lazy midi in event debugging via tooltips
Global midiEventTooltips  := False


; Midi class interface
Class Midi
{

  ; Instance creation
  __New()
  {

    ; Initialize midi environment
    this.LoadMidi()
    this.QueryMidiInDevices()
    this.SetupDeviceMenus()

  }

  ; Instance destruction
  __Delete()
  {

    ; Close all midi in devices and then unload the midi environment
    this.CloseMidiIns()
    this.UnloadMidi()

  }


  ; Load midi dlls
  LoadMidi()
  {
    
    __midiDll := DllCall( "LoadLibrary", "Str", "winmm.dll", "Ptr" )
    
    If ( ! __midiDll )
    {
      MsgBox, Missing system midi library winmm.dll
      ExitApp
    }

  }


  ; Unload midi dlls
  UnloadMidi()
  {

    If ( __midiDll )
    {
      DllCall( "FreeLibrary", "Ptr", __midiDll )
    }

  }


  ; Open midi in device and start listening
  OpenMidiIn( midiInDeviceId )
  {

    __OpenMidiIn( midiInDeviceId )
  
  }


  ; Close midi in device and stop listening
  CloseMidiIn( midiInDeviceId )
  {

    __CLoseMidiIn( midiInDeviceId )
    
  }


  ; Close all currently open midi in devices
  CloseMidiIns()
  {

    If ( ! __midiInOpenHandlesCount )
    {
      Return
    }

    ; We have to store the handles we are going to close in advance, because
    ; autohotkey gets confused if we are removing things from an array while
    ; iterative over it
    deviceIdsToClose := {}

    ; Iterate once to get a list of ids to close
    For midiInDeviceId In __midiInOpenHandles
    {
      deviceIdsToClose.Insert( midiInDeviceId )
    }

    ; Iterate again to actually close them
    For index, midiInDeviceId In deviceIdsToClose
    {
      this.CloseMidiIn( midiInDeviceId )
    }

  }


  ; Query the system for a list of active midi input devices
  QueryMidiInDevices()
  {

    midiInDevices := []

    deviceCount := DllCall( "winmm.dll\midiOutGetNumDevs" ) - 1

    Loop %deviceCount% 
    {

      midiInDevice := {}

      deviceNumber := A_Index - 1

      VarSetCapacity( midiInStruct, MIDI_DEVICE_IN_STRUCT_LENGTH, 0 )

      midiQueryResult := DllCall( "winmm.dll\midiInGetDevCapsA", UINT, deviceNumber, PTR, &midiInStruct, UINT, MIDI_DEVICE_IN_STRUCT_LENGTH )

      ; Error handling
      If ( midiQueryResult )
      {
        MsgBox, Failed to query midi devices
        Return
      }

      manufacturerId := NumGet( midiInStruct, 0, "USHORT" )
      productId      := NumGet( midiInStruct, 2, "USHORT" )
      driverVersion  := NumGet( midiInStruct, 4, "UINT" )
      deviceName     := StrGet( &midiInStruct + 8, MIDI_DEVICE_NAME_LENGTH, "CP0" )
      support        := NumGet( midiInStruct, 4, "UINT" )

      midiInDevice.deviceNumber   := deviceNumber
      midiInDevice.deviceName     := deviceName
      midiInDevice.productID      := productID
      midiInDevice.manufacturerID := manufacturerID
      midiInDevice.driverVersion  := ( driverVersion & 0xF0 ) . "." . ( driverVersion & 0x0F )

      __MidiEventDebug( midiInDevice )

      midiInDevices.Insert( deviceNumber, midiInDevice )

    }

    __midiInDevices := midiInDevices

  }


  ; Set up device selection menus
  SetupDeviceMenus()
  {

    For key, value In __midiInDevices
    {
      menuName := value.deviceName
      Menu, __MidInDevices, Add, %menuName%, __SelectMidiInDevice
    }

    Menu, Tray, Add
    Menu, Tray, Add, MIDI Input Devices, :__MidInDevices

    Return

    __SelectMidiInDevice:

      midiInDeviceId := A_ThisMenuItemPos - 1

      if ( __midiInOpenHandles[midiInDeviceId] > 0 )
      {
        __CloseMidiIn( midiInDeviceId )
      }
      else
      {
        __OpenMidiIn( midiInDeviceId )        
      }

      Return

  }


  ; Returns the last midi in event values
  MidiIn()
  {
    Return __MidiInEvent
  }

}


; Open a handle to a midi device and start listening for messages
__OpenMidiIn( midiInDeviceId )
{

  ; Look this device up in our device list
  device := __midiInDevices[midiInDeviceId]

  ; Create variable to store the handle the dll open will give us
  ; NOTE: Creating variables this way doesn't work with class variables, so
  ; we have to create it locally and then store it in the class later after
  VarSetCapacity( midiInHandle, 4, 0 )

  ; Open the midi device and attach event callbacks
  midiInOpenResult := DllCall( "winmm.dll\midiInOpen", UINT, &midiInHandle, UINT, midiInDeviceId, UINT, __midiInCallbackWindow, UINT, 0, UINT, MIDI_CALLBACK_WINDOW )

  ; Error handling
  If ( midiInOpenResult || ! midiInHandle )
  {
    MsgBox, Failed to open midi in device
    Return
  }

  ; Fetch the actual handle value from the pointer
  midiInHandle := NumGet( midiInHandle, UINT )

  ; Start monitoring midi signals
  midiInStartResult := DllCall( "winmm.dll\midiInStart", UINT, midiInHandle )

  ; Error handling
  If ( midiInStartResult )
  {
    MsgBox, Failed to start midi in device
    Return
  }

  ; Create a spot in our global event storage for this midi input handle
  __MidiInHandleEvent[midiInHandle] := {}

  ; Register a callback for each midi event
  ; We only need to do this once for all devices, so only do it if we are
  ; the first device to be opened
  if ( ! __midiInOpenHandlesCount )
  {
    OnMessage( MIDI_OPEN,      "__MidiInCallback" )
    OnMessage( MIDI_CLOSE,     "__MidiInCallback" )
    OnMessage( MIDI_DATA,      "__MidiInCallback" )
    OnMessage( MIDI_LONGDATA,  "__MidiInCallback" )
    OnMessage( MIDI_ERROR,     "__MidiInCallback" )
    OnMessage( MIDI_LONGERROR, "__MidiInCallback" )
    OnMessage( MIDI_MOREDATA,  "__MidiInCallback" ) 
  }

  ; Add this device handle to our list of open devices
  __midiInOpenHandles.Insert( midiInDeviceId, midiInHandle )

  ; Increase the tally for the number of open handles we have
  __midiInOpenHandlesCount++

  ; Check this device as enabled in the menu
  menuDeviceName := device.deviceName
  Menu __MidInDevices, Check, %menuDeviceName%

}


__CloseMidiIn( midiInDeviceId )
{
 
  ; Look this device up in our device list
  device := __midiInDevices[midiInDeviceId]

  ; Unregister callbacks if we are the last open handle
  if ( __midiInOpenHandlesCount <= 1 )
  {
     OnMessage( MIDI_OPEN,      "" )
     OnMessage( MIDI_CLOSE,     "" )
     OnMessage( MIDI_DATA,      "" )
     OnMessage( MIDI_LONGDATA,  "" )
     OnMessage( MIDI_ERROR,     "" )
     OnMessage( MIDI_LONGERROR, "" )
     OnMessage( MIDI_MOREDATA,  "" )
   }

  ; Destroy any midi in events that might be left over
  __MidiInHandleEvent[midiInHandle] := {}

  ; Stop monitoring midi
  midiInStopResult := DllCall( "winmm.dll\midiInStop", UINT, __midiInOpenHandles[midiInDeviceId] )

  ; Error handling
  If ( midiInStartResult )
  {
    MsgBox, Failed to stop midi in device
    Return
  }

  ; Close the midi handle
  midiInStopResult := DllCall( "winmm.dll\midiInClose", UINT, __midiInOpenHandles[midiInDeviceId] )

  ; Error handling
  If ( midiInStartResult )
  {
    MsgBox, Failed to close midi in device
    Return
  }

  ; Finally, remove the handle from the array
  __midiInOpenHandles.Remove( midiInDeviceId )

  ; Decrease the tally for the number of open handles we have
  __midiInOpenHandlesCount--

  ; Check this device as enabled in the menu
  menuDeviceName := device.deviceName
  Menu __MidInDevices, Uncheck, %menuDeviceName%

}


; Event callback for midi input event
; Note that since this is a callback method, it has no concept of "this" and
; can't access class members
__MidiInCallback( wParam, lParam, msg )
{

  ; Will hold the midi event object we are building for this event
  midiEvent := {}

  ; Will hold the labels we call so the user can capture this midi event, we
  ; always start with a generic ":Midi" label so it always gets called first
  labelCallbacks := [ midiLabel ]

  ; Grab the raw midi bytes
  rawBytes := lParam

  ; Split up the raw midi bytes as per the midi spec
  highByte  := lParam & 0xF0 
  lowByte   := lParam & 0x0F
  data1     := (lParam >> 8) & 0xFF
  data2     := (lParam >> 16) & 0xFF

  ; Determine the friendly name of the midi event based on the status byte
  if ( highByte == 0x80 )
  {
    midiEvent.status := "NoteOff"
  }
  else if ( highByte == 0x90 )
  {
    midiEvent.status := "NoteOn"
  }
  else if ( highByte == 0xA0 )
  {
    midiEvent.status := "Aftertouch"
  }
  else if ( highByte == 0xB0 )
  {
    midiEvent.status := "ControlChange"
  }
  else if ( highByte == 0xC0 )
  {
    midiEvent.status := "ProgramChange"
  }
  else if ( highByte == 0xD0 )
  {
    midiEvent.status := "ChannelPressure"
  }
  else if ( highByte == 0xE0 )
  {
    midiEvent.status := "PitchWheel"
  }
  else if ( highByte == 0xF0 )
  {
    midiEvent.status := "Sysex"
  }
  else
  {
    Return
  }

  ; Add a label callback for the status, ie ":MidiNoteOn"
  labelCallbacks.Insert( midiLabelPrefix . midiEvent.status )

  ; Determine how to handle the one or two data bytes sent along with the event
  ; based on what type of status event was seen
  if ( midiEvent.status == "NoteOff" || midiEvent.status == "NoteOn" || midiEvent.status == "AfterTouch" )
  {

    ; Store the raw note number and velocity data
    midiEvent.noteNumber  := data1
    midiEvent.velocity    := data2

    ; Figure out which chromatic note this note number represents
    noteScaleNumber := Mod( midiEvent.noteNumber, MIDI_NOTE_SIZE )

    ; Look up the name of the note in the scale
    midiEvent.note := MIDI_NOTES[ noteScaleNumber + 1 ]

    ; Determine the octave of the note in the scale 
    noteOctaveNumber := Floor( midiEvent.noteNumber / MIDI_NOTE_SIZE )

    ; Look up the octave for the note
    midiEvent.octave := MIDI_OCTAVES[ noteOctaveNumber + 1 ]

    ; Create a friendly name for the note and octave, ie: "C4"
    midiEvent.noteName := midiEvent.note . midiEvent.octave

    ; Add label callbacks for notes, ie ":MidiNoteOnA", ":MidiNoteOnA5", ":MidiNoteOn97"
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.status . midiEvent.note )
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.status . midiEvent.noteName )
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.status . midiEvent.noteNumber )

  }
  else if ( midiEvent.status == "ControlChange" )
  {

    ; Store controller number and value change
    midiEvent.controller := data1
    midiEvent.value      := data2

    ; Add label callback for this controller change, ie ":MidiControlChange12"
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.status . midiEvent.controller )

  }
  else if ( midiEvent.status == "ProgramChange" )
  {

    ; Store program number change
    midiEvent.program := data1

    ; Add label callback for this program change, ie ":MidiProgramChange2"
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.status . midiEvent.program )

  }
  else if ( midiEvent.status == "ChannelPressure" )
  {
    
    ; Store pressure change value
    midiEvent.pressure := data1

  }
  else if ( midiEvent.status == "PitchWheel" )
  {

    ; Store pitchwheel change, which is a combination of both data bytes 
    midiEvent.pitch := ( data2 << 7 ) + data1

  }
  else if ( midiEvent.status == "Sysex" )
  {

    ; Sysex messages have another status byte that indicates which type of sysex
    ; message it is (the high byte, which is normally used for the midi channel,
    ; is used for this instead)
    if ( lowByte == 0x0 )
    {
      midiEvent.sysex := "SysexData"
      midiEvent.data  := byte1
    }
    if ( lowByte == 0x1 )
    {
      midiEvent.sysex := "Timecode"
    }
    if ( lowByte == 0x2 )
    {
      midiEvent.sysex     := "SongPositionPointer"
      midiEvent.position  := ( data2 << 7 ) + data1
    }
    if ( lowByte == 0x3 )
    {
      midiEvent.sysex   := "SongSelect"
      midiEvent.number  := data1
    }
    if ( lowByte == 0x6 )
    {
      midiEvent.sysex := "TuneRequest"
    }
    if ( lowByte == 0x8 )
    {
      midiEvent.sysex := "Clock"
    }
    if ( lowByte == 0x9 )
    {
      midiEvent.sysex := "Tick"
    }
    if ( lowByte == 0xA )
    {
      midiEvent.sysex := "Start"
    }
    if ( lowByte == 0xB )
    {
      midiEvent.sysex := "Continue"
    }
    if ( lowByte == 0xC )
    {
      midiEvent.sysex := "Stop"
    }
    if ( lowByte == 0xE )
    {
      midiEvent.sysex := "ActiveSense"
    }
    if ( lowByte == 0xF )
    {
      midiEvent.sysex := "Reset"
    }
    
    ; Add label callback for sysex event, ie: ":MidiClock" or ":MidiStop"
    labelCallbacks.Insert( midiLabelPrefix . midiEvent.sysex )

  }

  ; Channel is always handled the same way for all midi events except sysex
  if ( midiEvent.status != "Sysex" )
  {
    midiEvent.channel := lowByte + 1
  }

  ; Always include the raw midi data, just in case someone wants it
  midiEvent.rawBytes  := rawBytes
  midiEvent.highByte  := highByte
  midiEvent.lowByte   := lowByte
  midiEvent.data1     := data1
  midiEvent.data2     := data2

  ; Store this midi in event in our global array of midi messages, so that the
  ; appropriate midi class an access it later
  __MidiInEvent               := midiEvent
  __MidiInHandleEvent[wParam] := midiEvent

  ; Iterate over all the label callbacks we built during this event and jump
  ; to them now (if they exist elsewhere in the code)
  If ( midiLabelCallbacks )
  {
    For labelIndex, labelName In labelCallbacks
    {
      If IsLabel( labelName )
        Gosub %labelName%
    }   
  }

  ; Call debugging if enabled
  __MidiEventDebug( midiEvent )

}


; Send event information to a listening debugger
__MidiEventDebug( midiEvent )
{

  debugStr := ""

  For key, value In midiEvent
    debugStr .= key . ":" . value . "`n"

  debugStr .= "---`n"

  ; Always output event debug to any listening debugger
  OutputDebug, % debugStr 

  ; If lazy tooltip debugging is enabled, do that too
  if midiEventTooltips
    ToolTip, % debugStr

}


