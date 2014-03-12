
unit uoslib_h;

{This is the Dynamic loading version of uos library wrapper.
Load uos library and friends (PortAudio, SndFile, Mpg123, SoundTouch)
with uos_loadlibs() and release it with uos_unloadlibs().

With reference counter too...

 Fred van Stappen / fiens@hotmail.com
}
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//           uos pascal wrapper for accessing routines from FPC              //
//                                                                           //
//            Many thanks to Sandro Cumerlato and Tomas Hajny                //
//                                                                           //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
// License :

//  uos audio processing library
//  Copyright (c) Fred van Stappen

//  This library is free software; you can redistribute it and/or
//  modify it under the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either
//  version 2.1 of the License, or (at your option) any later version.

//  This library is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//  Lesser General Public License for more details.

//  You should have received a copy of the GNU Lesser General Public
//  License along with this library; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

////////////////////////////////////////////////////////////////////////////////

interface
//{$MODE objfpc}
uses
   {$IFDEF UNIX}
  cthreads,
  cwstring, {$ENDIF}
  DynLibs, ctypes;

type
TProc = procedure of object ;

var

 // function uos_GetInfoDeviceStr(infos:PChar) : Longint ;    cdecl;
  uos_GetInfoDeviceStr: function() : PChar ; cdecl;

  uos_CreatePlayer: procedure(PlayerIndex: LongInt); cdecl;

  uos_AddIntoDevOut: function(PlayerIndex: LongInt; Device: LongInt;
  Latency: CDouble; SampleRate: LongInt; Channels: LongInt;
  SampleFormat: shortint; FramesCount: LongInt): LongInt; cdecl;

  uos_AddIntoDevOutDef: function(PlayerIndex: LongInt): LongInt; cdecl;

  uos_AddFromFile: function(PlayerIndex: LongInt; Filename: Pchar;
  OutputIndex: LongInt; SampleFormat: shortint; FramesCount: LongInt): LongInt; cdecl;

  uos_AddFromFileDef: function(PlayerIndex: LongInt; Filename: Pchar): LongInt; cdecl;

  uos_AddIntoFile: function(PlayerIndex: LongInt; Filename: Pchar; SampleRate: LongInt;
        Channels: LongInt; SampleFormat: shortint ; FramesCount: LongInt): LongInt; cdecl;

  uos_AddIntoFileDef: function(PlayerIndex: LongInt; Filename: PChar): LongInt; cdecl;

  uos_AddFromDevIn: function(PlayerIndex: LongInt; Device: LongInt; Latency: CDouble;
             SampleRate: LongInt; Channels: LongInt; OutputIndex: LongInt;
             SampleFormat: shortint; FramesCount : LongInt): LongInt; cdecl;

  uos_AddFromDevInDef: function(PlayerIndex: LongInt): LongInt; cdecl;

  uos_AddDSPVolumeIn: procedure(PlayerIndex: LongInt; InputIndex: LongInt; VolLeft: double;
                VolRight: double); cdecl;

  uos_AddDSPVolumeOut: procedure(PlayerIndex: LongInt; OutputIndex: LongInt; VolLeft: double;
                 VolRight: double); cdecl;

  uos_SetDSPVolumeIn: procedure(PlayerIndex: LongInt; InputIndex: LongInt;
                 VolLeft: double; VolRight: double; Enable: boolean); cdecl;

  uos_SetDSPVolumeOut: procedure(PlayerIndex: LongInt; OutputIndex: LongInt;
                 VolLeft: double; VolRight: double; Enable: boolean); cdecl;

  uos_AddFilterIn: function(PlayerIndex: LongInt; InputIndex: LongInt; LowFrequency: LongInt;
                    HighFrequency: LongInt; Gain: cfloat; TypeFilter: LongInt;
                    AlsoBuf: boolean; LoopProc: TProc): LongInt; cdecl;

  uos_SetFilterIn: procedure(PlayerIndex: LongInt; InputIndex: LongInt; FilterIndex: LongInt;
                    LowFrequency: LongInt; HighFrequency: LongInt; Gain: cfloat;
                    TypeFilter: LongInt; AlsoBuf: boolean; Enable: boolean; LoopProc: TProc); cdecl;

  uos_AddFilterOut: function(PlayerIndex: LongInt; OutputIndex: LongInt; LowFrequency: LongInt;
                    HighFrequency: LongInt; Gain: cfloat; TypeFilter: LongInt;
                    AlsoBuf: boolean; LoopProc: TProc): LongInt; cdecl;

  uos_SetFilterOut: procedure(PlayerIndex: LongInt; OutputIndex: LongInt; FilterIndex: LongInt;
                    LowFrequency: LongInt; HighFrequency: LongInt; Gain: cfloat;
                    TypeFilter: LongInt; AlsoBuf: boolean; Enable: boolean; LoopProc: TProc); cdecl;

  uos_AddPlugin: function(PlayerIndex: LongInt; PlugName: PChar; SampleRate: LongInt;
                       Channels: LongInt): LongInt; cdecl;

  uos_SetPluginSoundTouch: procedure(PlayerIndex: LongInt; PluginIndex: LongInt; Tempo: cfloat;
                       Pitch: cfloat; Enable: boolean); cdecl;

  uos_GetStatus: function(PlayerIndex: LongInt) : LongInt; cdecl;

  uos_Seek: procedure(PlayerIndex: LongInt; InputIndex: LongInt; pos: {$if defined(cpu64)} cint64 {$else} cint32 {$endif}); cdecl;

  uos_SeekSeconds: procedure(PlayerIndex: LongInt; InputIndex: LongInt; pos: cfloat); cdecl;

  uos_SeekTime: procedure(PlayerIndex: LongInt; InputIndex: LongInt; pos: TTime); cdecl;

  uos_InputLength: function(PlayerIndex: LongInt; InputIndex: LongInt): longint; cdecl;

  uos_InputLengthSeconds: function(PlayerIndex: LongInt; InputIndex: LongInt): cfloat; cdecl;

  uos_InputLengthTime: function(PlayerIndex: LongInt; InputIndex: LongInt): TTime; cdecl;

  uos_InputPosition: function(PlayerIndex: LongInt; InputIndex: LongInt): longint; cdecl;

  uos_InputPositionSeconds: function(PlayerIndex: LongInt; InputIndex: LongInt): cfloat; cdecl;

  uos_InputPositionTime: function(PlayerIndex: LongInt; InputIndex: LongInt): TTime; cdecl;

  uos_InputSetLevelEnable: procedure(PlayerIndex: LongInt; InputIndex: LongInt; Enable: boolean); cdecl;

  uos_InputGetLevelLeft: function(PlayerIndex: LongInt; InputIndex: LongInt): double; cdecl;

  uos_InputGetLevelRight: function(PlayerIndex: LongInt; InputIndex: LongInt): double; cdecl;

  uos_InputGetSampleRate: function(PlayerIndex: LongInt; InputIndex: LongInt): LongInt; cdecl;
 
  uos_InputGetChannels: function(PlayerIndex: LongInt; InputIndex: LongInt): LongInt; cdecl;

  uos_Play: procedure(PlayerIndex: LongInt); cdecl;

  uos_RePlay: procedure(PlayerIndex: LongInt); cdecl;

  uos_Stop: procedure(PlayerIndex: LongInt); cdecl;

  uos_Pause: procedure(PlayerIndex:  LongInt); cdecl;

  uos_unloadlibCust: procedure(PortAudio : boolean; SndFile: boolean; Mpg123: boolean; SoundTouch: boolean); cdecl;

  ///// This functions should not be used, use uos_loadlibs and uos_unloadlibs instead...
  uos_loadlib: function(PortAudioFileName, SndFileFileName, Mpg123FileName, SoundTouchFileName: PChar): LongInt; cdecl;
  uos_unloadlib: procedure(); cdecl;
  ////////////////////////

  uos_GetVersion:  function(): LongInt ; cdecl;  /// uos version

  LibHandle: TLibHandle = dynlibs.NilHandle; // this will hold our handle for the uoslib
  ReferenceCounter: LongInt = 0;  // Reference counter


function uos_IsLoaded: boolean; inline;
function uos_loadlibs(const uoslibfilename, PortAudioFileName, SndFileFileName, Mpg123FileName, SoundTouchFileName: PChar): boolean;
// load the all the libraries (If filename = '' => do not load that library)

procedure uos_unloadlibs();
// unload and frees the lib from memory : do not forget to call it before close application.

{ TODO ...
  uos_BeginProc: procedure(PlayerIndex: LongInt; Proc: TProc); cdecl;

  uos_EndProc: procedure(PlayerIndex: LongInt; Proc: TProc); cdecl;

  uos_LoopProcIn: procedure(PlayerIndex: LongInt; InIndex: LongInt; Proc: TProc);  cdecl;

  uos_LoopProcOut: procedure(PlayerIndex: LongInt; OutIndex: LongInt; Proc: TProc); cdecl;

  uos_AddDSPin: function(PlayerIndex: LongInt; InputIndex: LongInt; BeforeProc: TFunc;
                  AfterProc: TFunc; LoopProc: TProc): LongInt; cdecl;

  uos_SetDSPin: procedure(PlayerIndex: LongInt; InputIndex: LongInt; DSPinIndex: LongInt; Enable: boolean); cdecl;

  uos_AddDSPout: function(PlayerIndex: LongInt; OutputIndex: LongInt; BeforeProc: TFunc;
                   AfterProc: TFunc; LoopProc: TProc): LongInt; cdecl;

  uos_SetDSPout: procedure(PlayerIndex: LongInt; OutputIndex: LongInt; DSPoutIndex: LongInt; Enable: boolean); cdecl;
}

implementation

function uos_IsLoaded: boolean;
begin
  Result := (LibHandle <> dynlibs.NilHandle);
end;

function uos_loadlibs(const uoslibfilename, PortAudioFileName, SndFileFileName, Mpg123FileName, SoundTouchFileName: PChar): boolean;
begin
  Result := False;
  if LibHandle <> 0 then
  begin
    Inc(ReferenceCounter);
    Result := True;
  end
  else
  begin
    if Length(uoslibfilename) = 0 then exit;
    LibHandle := DynLibs.LoadLibrary(uoslibfilename); // obtain the handle we want
    if LibHandle <> DynLibs.NilHandle then
    begin
      try
        Pointer(uos_loadlib) :=
          GetProcAddress(LibHandle, 'uos_loadlib');

        Pointer(uos_unloadlib) :=
          GetProcAddress(LibHandle, 'uos_unloadlib');

        Pointer(uos_unloadlibCust) :=
          GetProcAddress(LibHandle, 'uos_unloadlibCust');

        Pointer(uos_GetInfoDeviceStr) :=
          GetProcAddress(LibHandle, 'uos_GetInfoDeviceStr');

        Pointer(uos_CreatePlayer) :=
          GetProcAddress(LibHandle, 'uos_CreatePlayer');

        Pointer(uos_AddIntoDevOut) :=
          GetProcAddress(LibHandle, 'uos_AddIntoDevOut');

        Pointer(uos_AddIntoDevOutDef) :=
          GetProcAddress(LibHandle, 'uos_AddIntoDevOutDef');

        Pointer(uos_AddFromFileDef) :=
          GetProcAddress(LibHandle, 'uos_AddFromFileDef');

        Pointer(uos_AddFromFile) :=
          GetProcAddress(LibHandle, 'uos_AddFromFile');

        Pointer(uos_AddIntoFile) :=
          GetProcAddress(LibHandle, 'uos_AddIntoFile');

        Pointer(uos_AddIntoFileDef) :=
          GetProcAddress(LibHandle, 'uos_AddIntoFileDef');

        Pointer(uos_AddFromDevIn) :=
          GetProcAddress(LibHandle, 'uos_AddFromDevIn');

        Pointer(uos_AddFromDevInDef) :=
         GetProcAddress(LibHandle, 'uos_AddFromDevInDef');

          Pointer(uos_AddDSPVolumeIn) :=
       GetProcAddress(LibHandle, 'uos_AddDSPVolumeIn');

         Pointer(uos_SetDSPVolumeIn) :=
          GetProcAddress(LibHandle, 'uos_SetDSPVolumeIn');

          Pointer(uos_AddDSPVolumeOut) :=
          GetProcAddress(LibHandle, 'uos_AddDSPVolumeOut');

         Pointer(uos_SetDSPVolumeOut) :=
          GetProcAddress(LibHandle, 'uos_SetDSPVolumeOut');

        Pointer(uos_AddFilterIn) :=
          GetProcAddress(LibHandle, 'uos_AddFilterIn');

        Pointer(uos_AddFilterOut) :=
          GetProcAddress(LibHandle, 'uos_AddFilterOut');

        Pointer(uos_SetFilterIn) :=
          GetProcAddress(LibHandle, 'uos_SetFilterIn');

        Pointer(uos_SetFilterOut) :=
          GetProcAddress(LibHandle, 'uos_SetFilterOut');

        Pointer(uos_AddPlugin) :=
          GetProcAddress(LibHandle, 'uos_AddPlugin');

        Pointer(uos_SetPluginSoundTouch) :=
          GetProcAddress(LibHandle, 'uos_SetPluginSoundTouch');

        Pointer(uos_GetStatus) :=
          GetProcAddress(LibHandle, 'uos_GetStatus');

         Pointer(uos_Seek) :=
          GetProcAddress(LibHandle, 'uos_Seek');

        Pointer(uos_SeekSeconds) :=
          GetProcAddress(LibHandle, 'uos_SeekSeconds');

        Pointer(uos_SeekTime) :=
          GetProcAddress(LibHandle, 'uos_SeekTime');

        Pointer(uos_InputLength) :=
          GetProcAddress(LibHandle, 'uos_InputLength');

        Pointer(uos_InputLengthSeconds) :=
          GetProcAddress(LibHandle, 'uos_InputLengthSeconds');

        Pointer(uos_InputLengthTime) :=
          GetProcAddress(LibHandle, 'uos_InputLengthTime');

        Pointer(uos_InputPosition) :=
          GetProcAddress(LibHandle, 'uos_InputPosition');

        Pointer(uos_InputSetLevelEnable) :=
          GetProcAddress(LibHandle, 'uos_InputSetLevelEnable');

        Pointer(uos_InputGetLevelLeft) :=
          GetProcAddress(LibHandle, 'uos_InputGetLevelLeft');

        Pointer(uos_InputGetLevelRight) :=
          GetProcAddress(LibHandle, 'uos_InputGetLevelRight');

        Pointer(uos_InputPositionSeconds) :=
          GetProcAddress(LibHandle, 'uos_InputPositionSeconds');

        Pointer(uos_InputPositionTime) :=
          GetProcAddress(LibHandle, 'uos_InputPositionTime');

        Pointer(uos_InputGetSampleRate) :=
          GetProcAddress(LibHandle, 'uos_InputGetSampleRate');

       Pointer(uos_InputGetChannels) :=
          GetProcAddress(LibHandle, 'uos_InputGetChannels');

       Pointer(uos_Play) :=
          GetProcAddress(LibHandle, 'uos_Play');

        Pointer(uos_RePlay) :=
          GetProcAddress(LibHandle, 'uos_RePlay');

        Pointer(uos_Stop) :=
          GetProcAddress(LibHandle, 'uos_Stop');

        Pointer(uos_Pause) :=
          GetProcAddress(LibHandle, 'uos_Pause');

        Pointer(uos_GetVersion) :=
          GetProcAddress(LibHandle, 'uos_GetVersion');


        { TODO ...
        Pointer(uos_BeginProc) :=
          GetProcAddress(LibHandle, 'uos_BeginProc');

        Pointer(uos_EndProc) :=
          GetProcAddress(LibHandle, 'uos_EndProc');

        Pointer(uos_LoopProcIn) :=
          GetProcAddress(LibHandle, 'uos_LoopProcIn');

        Pointer(uos_LoopProcOut) :=
          GetProcAddress(LibHandle, 'uos_LoopProcOut');

        Pointer(uos_AddDSPIn) :=
          GetProcAddress(LibHandle, 'uos_AddDSPIn');

        Pointer(uos_AddDSPOut) :=
          GetProcAddress(LibHandle, 'uos_AddDSPOut');

        Pointer(uos_SetDSPin) :=
          GetProcAddress(LibHandle, 'uos_SetDSPin');

        Pointer(uos_SetDSPOut) :=
          GetProcAddress(LibHandle, 'uos_SetDSPOut');
       }

        ReferenceCounter := 1;

        ///// load the audio libraries
        uos_loadlib(pchar(PortAudioFileName), pchar(SndFileFileName), pchar(Mpg123FileName), pchar(SoundTouchFileName));

        Result := uos_IsLoaded;
      except
        uos_unloadlibs();
      end;
    end;
  end;
end;

procedure uos_unloadlibs();
begin

  // < Reference counting
  if ReferenceCounter > 0 then
    Dec(ReferenceCounter);
  if ReferenceCounter > 0 then
    exit;
  // >
  uos_unloadlib();
   if LibHandle <> DynLibs.NilHandle then
  begin
    DynLibs.UnloadLibrary(LibHandle);
    LibHandle := DynLibs.NilHandle;
  end;
end;

end.
