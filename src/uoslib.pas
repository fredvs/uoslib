library uoslib ;

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//    uoslib (United Open-libraries of Sound) audio processing library       //
//           That library unify the best audio libraries :                   //
//              PortAudio, Sndfile, Mpg123, SoundTouch.                      //
//                                                                           //
//          Many thanks to Sandro Cumerlato and Tomas Hajny                  //
//                 Fred van Stappen / fiens@hotmail.com                      //
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

uses
 // cmem,            // uncomment it if your programs use cmem...
 {$IFDEF UNIX}
 cthreads,
 cwstring, {$ENDIF}
  ctypes, uos;
 /////////// General public procedure/function

function uos_loadlib(PortAudioFileName: String; SndFileFileName: String; Mpg123FileName: String; SoundTouchFileName: String) : integer; cdecl;
////// load libraries... if libraryfilename = '' =>  do not load it...
begin
 result := uos.uos_loadlib(PortAudioFileName , SndFileFileName, Mpg123FileName, SoundTouchFileName) ;
end;

procedure uos_unloadlib(); cdecl;
////// Unload all libraries and free everything... Do not forget to call it before close application...
begin
  uos.uos_unloadlib();
end;

procedure uos_unloadlibCust(PortAudio : boolean; SndFile: boolean; Mpg123: boolean; SoundTouch: boolean); cdecl;
 ////// Custom Unload libraries... if true, then delete the library. You may unload what and when you want...
begin
uos.uos_unloadlibCust(PortAudio, SndFile, Mpg123, SoundTouch);
end;

function uos_GetInfoDeviceStr() : String ; cdecl;
begin
result :=  uos.uos_GetInfoDeviceStr();
end;

procedure uos_CreatePlayer(PlayerIndex: cardinal) ; cdecl;
        //// PlayerIndex : from 0 to what your computer can do ! (depends of ram, cpu, soundcard, ...)
        //// If PlayerIndex already exists, it will be overwriten...
begin
uos.uos_CreatePlayer(PlayerIndex);
end;

function uos_AddIntoDevOut(PlayerIndex: Cardinal; Device: integer; Latency: CDouble;
            SampleRate: integer; Channels: integer; SampleFormat: shortint ; FramesCount: integer ): cardinal;  cdecl;
          ////// Add a Output into Device Output with default parameters
          //////////// PlayerIndex : Index of a existing Player
          //////////// Device ( -1 is default device )
          //////////// Latency  ( -1 is latency suggested ) )
          //////////// SampleRate : delault : -1 (44100)
          //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
          //////////// SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
          //////////// FramesCount : default : -1 (= 65536)
          /// example : OutputIndex1 := uos_AddIntoDevOut(0,-1,-1,-1,-1,-1);
begin
 result :=  uos.uos_AddIntoDevOut(PlayerIndex, Device, Latency, SampleRate, Channels, SampleFormat, FramesCount) ;
end;

function uos_AddIntoDevOutDef(PlayerIndex: Cardinal): cardinal; cdecl;
          ////// Add a Output into Device Output with default parameters
          //////////// PlayerIndex : Index of a existing Player
begin
 result :=  uos.uos_AddIntoDevOut(PlayerIndex);
end;

function uos_AddFromFile(PlayerIndex: Cardinal; Filename: string; OutputIndex: cardinal;
              SampleFormat: shortint ; FramesCount: integer): cardinal;  cdecl;
            /////// Add a input from audio file with default parameters
            //////////// PlayerIndex : Index of a existing Player
            ////////// FileName : filename of audio file
            ////////// OutputIndex : Output index of used output// -1: all output, -2: no output, other integer refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
            //////////// SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
            //////////// FramesCount : default : -1 (65536)
            //  result : Input Index in array
begin
 result :=  uos.uos_AddFromFile(PlayerIndex, Filename, OutputIndex, SampleFormat, FramesCount);
end;

function uos_AddFromFileDef(PlayerIndex: Cardinal; Filename: string): cardinal; cdecl;
            /////// Add a input from audio file with default parameters
            //////////// PlayerIndex : Index of a existing Player
            ////////// FileName : filename of audio file
            //  result :  Input Index in array
begin
 result :=  uos.uos_AddFromFile(PlayerIndex, Filename);
end;

function uos_AddIntoFile(PlayerIndex: Cardinal; Filename: string; SampleRate: integer;
                 Channels: integer; SampleFormat: shortint ; FramesCount: integer): cardinal; cdecl;
               /////// Add a Output into audio wav file with custom parameters
               //////////// PlayerIndex : Index of a existing Player
               ////////// FileName : filename of saved audio wav file
               //////////// SampleRate : delault : -1 (44100)
               //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
               //////////// SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
               //////////// FramesCount : default : -1 (= 65536)
               //  result :  Output Index in array
               //////////// example : OutputIndex1 := uos_AddIntoFile(0,edit5.Text,-1,-1, 0, -1);
begin
 result :=  uos.uos_AddIntoFile(PlayerIndex, Filename, SampleRate, Channels, SampleFormat, FramesCount);
end;

function uos_AddIntoFileDef(PlayerIndex: Cardinal; Filename: String): cardinal; cdecl;
               /////// Add a Output into audio wav file with Default parameters
              //////////// PlayerIndex : Index of a existing Player
              ////////// FileName : filename of saved audio wav file
              //  result : -1 nothing created, otherwise Output Index in array
begin
 result :=  uos.uos_AddIntoFile(PlayerIndex, Filename) ;
end;

function uos_AddFromDevIn(PlayerIndex: Cardinal; Device: integer; Latency: CDouble;
             SampleRate: integer; Channels: integer; OutputIndex: integer;
             SampleFormat: shortint; FramesCount : integer): cardinal; cdecl;
              ////// Add a Input from Device Input with custom parameters
              //////////// PlayerIndex : Index of a existing Player
               //////////// Device ( -1 is default Input device )
               //////////// Latency  ( -1 is latency suggested ) )
               //////////// SampleRate : delault : -1 (44100)
               //////////// Channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
               //////////// OutputIndex : Output index of used output// -1: all output, -2: no output, other integer refer to a existing OutputIndex  (if multi-output then OutName = name of each output separeted by ';')
               //////////// SampleFormat : default : -1 (1:Int16) (0: Float32, 1:Int32, 2:Int16)
               //////////// FramesCount : default : -1 (65536)
               //  result : Output Index in array
               /// example : OutputIndex1 := uos_AddFromDevIn(-1,-1,-1,-1,-1,-1);
begin
 result :=  uos.uos_AddFromDevIn(PlayerIndex, Device, Latency, SampleRate, Channels, OutputIndex,
               SampleFormat, FramesCount);
end;

function uos_InputGetSampleRate(PlayerIndex: Cardinal; InputIndex: cardinal): integer; cdecl;
                   ////////// InputIndex : InputIndex of existing input
                  ////// result : default sample rate
begin
 result :=  uos.uos_InputGetSampleRate(PlayerIndex, InputIndex) ;
end;

function uos_AddFromDevInDef(PlayerIndex: Cardinal): cardinal ; cdecl;
              ////// Add a Input from Device Input with default parameters
              ///////// PlayerIndex : Index of a existing Player
 begin
  result :=  uos.uos_AddFromDevIn(PlayerIndex);
 end;

procedure uos_AddDSPVolumeIn(PlayerIndex: Cardinal; InputIndex: Cardinal; VolLeft: double;
                VolRight: double); cdecl;
               ///// DSP Volume changer
               //////////// PlayerIndex : Index of a existing Player
               ////////// InputIndex : InputIndex of a existing Input
               ////////// VolLeft : Left volume
               ////////// VolRight : Right volume
               ////////// example  DSPIndex1 := uos_AddDSPVolumeIn(0,InputIndex1,1,1);
begin
uos.uos_AddDSPVolumeIn(PlayerIndex, InputIndex, VolLeft, VolRight) ;
end;

procedure uos_AddDSPVolumeOut(PlayerIndex: Cardinal; OutputIndex: Cardinal; VolLeft: double;
                 VolRight: double); cdecl;
               ///// DSP Volume changer
               //////////// PlayerIndex : Index of a existing Player
               ////////// OutputIndex : OutputIndex of a existing Output
               ////////// VolLeft : Left volume
               ////////// VolRight : Right volume
              ////////// example  DSPIndex1 := uos_AddDSPVolumeOut(0,InputIndex1,1,1);
begin
uos.uos_AddDSPVolumeOut(PlayerIndex, OutputIndex, VolLeft, VolRight) ;
end;

procedure uos_SetDSPVolumeIn(PlayerIndex: Cardinal; InputIndex: cardinal;
                 VolLeft: double; VolRight: double; Enable: boolean); cdecl;
               ////////// InputIndex : InputIndex of a existing Input
               //////////// PlayerIndex : Index of a existing Player
               ////////// VolLeft : Left volume
               ////////// VolRight : Right volume
               ////////// Enable : Enabled
               ////////// example  uos_SetDSPVolumeIn(0,InputIndex1, 1,0.8,True);
begin
uos.uos_SetDSPVolumeIn(PlayerIndex, InputIndex, VolLeft, VolRight, Enable) ;
end;

procedure uos_SetDSPVolumeOut(PlayerIndex: Cardinal; OutputIndex: cardinal;
                 VolLeft: double; VolRight: double; Enable: boolean); cdecl;
               ////////// OutputIndex : OutputIndex of a existing Output
               //////////// PlayerIndex : Index of a existing Player
               ////////// VolLeft : Left volume
               ////////// VolRight : Right volume
               ////////// Enable : Enabled
               ////////// example  uos_SetDSPVolumeOut(0,InputIndex1,1,0.8,True);
begin
uos.uos_SetDSPVolumeOut(PlayerIndex, OutputIndex, VolLeft, VolRight, Enable) ;
end;

{   TODO
procedure uos_BeginProc(PlayerIndex: Cardinal; Proc: TProc); cdecl;
            ///// Assign the procedure of object to execute  at begining, before loop
            //////////// PlayerIndex : Index of a existing Player
            //////////// InIndex : Index of a existing Input
begin
 uos.uos_BeginProc(PlayerIndex, Proc);
end;

procedure uos_EndProc(PlayerIndex: Cardinal; Proc: TProc); cdecl;
            ///// Assign the procedure of object to execute  at end, after loop
            //////////// PlayerIndex : Index of a existing Player
            //////////// InIndex : Index of a existing Input
begin
 uos.uos_EndProc(PlayerIndex, Proc);
end;

procedure uos_LoopProcIn(PlayerIndex: Cardinal; InIndex: Cardinal; Proc: TProc); cdecl;
            ///// Assign the procedure of object to execute inside the loop
            //////////// PlayerIndex : Index of a existing Player
            //////////// InIndex : Index of a existing Input
begin
 uos.uos_LoopProcIn(PlayerIndex, InIndex, Proc);
end;

procedure uos_LoopProcOut(PlayerIndex: Cardinal; OutIndex: Cardinal; Proc: TProc); cdecl;
              ///// Assign the procedure of object to execute inside the loop
            //////////// PlayerIndex : Index of a existing Player
            //////////// OutIndex : Index of a existing Output
begin
 uos.uos_LoopProcOut(PlayerIndex, OutIndex, Proc);
end;

function uos_AddDSPin(PlayerIndex: Cardinal; InputIndex: cardinal; BeforeProc: TFunc;
                    AfterProc: TFunc; LoopProc: TProc): integer ; cdecl;
                  ///// add a DSP procedure for input
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// InputIndex : Input Index of a existing input
                  ////////// BeforeProc : procedure to do before the buffer is filled
                  ////////// AfterProc : procedure to do after the buffer is filled
                  ////////// LoopProc : external procedure to do after the buffer is filled
                  //  result : -1 nothing created, otherwise index of DSPin in array  (DSPinIndex)
                  ////////// example : DSPinIndex1 := uos_AddDSPin(0,InputIndex1,@beforereverse,@afterreverse,nil);
begin
result := uos.uos_AddDSPin(PlayerIndex, InputIndex, BeforeProc, AfterProc, LoopProc);
end;

procedure uos_SetDSPin(PlayerIndex: Cardinal; InputIndex: cardinal; DSPinIndex: cardinal; Enable: boolean); cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// InputIndex : Input Index of a existing input
                  ////////// DSPIndexIn : DSP Index of a existing DSP In
                  ////////// Enable :  DSP enabled
                  ////////// example : uos_SetDSPin(0,InputIndex1,DSPinIndex1,True);
begin
uos.uos_SetDSPin(PlayerIndex, InputIndex, DSPinIndex, Enable);
end;

function uos_AddDSPout(PlayerIndex: Cardinal; OutputIndex: cardinal; BeforeProc: TFunc;
                    AfterProc: TFunc; LoopProc: TProc): integer; cdecl;    //// usefull if multi output
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// OutputIndex : OutputIndex of a existing Output
                  ////////// BeforeProc : procedure to do before the buffer is filled
                  ////////// AfterProc : procedure to do after the buffer is filled just before to give to output
                  ////////// LoopProc : external procedure to do after the buffer is filled
                  //  result : -1 nothing created, otherwise index of DSPout in array
                  ////////// example :DSPoutIndex1 := uos_AddDSPout(0,OutputIndex1,@volumeproc,nil,nil);
begin
result := uos.uos_AddDSPout(PlayerIndex, OutputIndex, BeforeProc, AfterProc, LoopProc);
end;

procedure uos_SetDSPout(PlayerIndex: Cardinal; OutputIndex: cardinal; DSPoutIndex: cardinal; Enable: boolean); cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// OutputIndex : OutputIndex of a existing Output
                  ////////// DSPoutIndex : DSPoutIndex of existing DSPout
                  ////////// Enable :  DSP enabled
                  ////////// example : SetDSPIn(0,OutputIndex1,DSPoutIndex1,True);
begin
uos.uos_SetDSPin(PlayerIndex, OutputIndex, DSPOutIndex, Enable);
end;
}

function uos_AddFilterIn(PlayerIndex: Cardinal; InputIndex: cardinal; LowFrequency: integer;
                    HighFrequency: integer; Gain: cfloat; TypeFilter: integer;
                    AlsoBuf: boolean; LoopProc: TProc): cardinal;  cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// InputIndex : InputIndex of a existing Input
                  ////////// LowFrequency : Lowest frequency of filter
                  ////////// HighFrequency : Highest frequency of filter
                  ////////// Gain : gain to apply to filter
                  ////////// TypeFilter: Type of filter : default = -1 = fBandSelect (fBandAll = 0, fBandSelect = 1, fBandReject = 2
                  /////////////////////////// fBandPass = 3, fHighPass = 4, fLowPass = 5)
                  ////////// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
                  ////////// LoopProc : External procedure to execute after DSP done
                  //  result : index of DSPIn in array
                  ////////// example :FilterInIndex1 := uos_AddFilterIn(0,InputIndex1,6000,16000,1,2,true,nil);
begin
result := uos.uos_AddFilterIn(PlayerIndex, InputIndex, LowFrequency, HighFrequency, Gain, TypeFilter, AlsoBuf, LoopProc);
end;

procedure uos_SetFilterIn(PlayerIndex: Cardinal; InputIndex: cardinal; FilterIndex: cardinal;
                    LowFrequency: integer; HighFrequency: integer; Gain: cfloat;
                    TypeFilter: integer; AlsoBuf: boolean; Enable: boolean; LoopProc: TProc);  cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// InputIndex : InputIndex of a existing Input
                  ////////// DSPInIndex : DSPInIndex of existing DSPIn
                  ////////// LowFrequency : Lowest frequency of filter ( -1 : current LowFrequency )
                  ////////// HighFrequency : Highest frequency of filter ( -1 : current HighFrequency )
                  ////////// Gain : gain to apply to filter
                  ////////// TypeFilter: Type of filter : ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
                  /////////////////////////// fBandPass = 3, fHighPass = 4, fLowPass = 5)
                  ////////// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
                  ////////// LoopProc : External procedure to execute after DSP done
                  ////////// Enable :  Filter enabled
                  ////////// example : SetFilterIn(0,InputIndex1,FilterInIndex1,-1,-1,-1,False,True,nil);
begin
uos.uos_SetFilterIn(PlayerIndex, InputIndex, FilterIndex, LowFrequency, HighFrequency, Gain, TypeFilter, AlsoBuf, enable, LoopProc);
end;

function uos_AddFilterOut(PlayerIndex: Cardinal; OutputIndex: cardinal; LowFrequency: integer;
                    HighFrequency: integer; Gain: cfloat; TypeFilter: integer;
                    AlsoBuf: boolean; LoopProc: TProc): cardinal;  cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// OutputIndex : OutputIndex of a existing Output
                  ////////// LowFrequency : Lowest frequency of filter
                  ////////// HighFrequency : Highest frequency of filter
                  ////////// Gain : gain to apply to filter
                  ////////// TypeFilter: Type of filter : default = -1 = fBandSelect (fBandAll = 0, fBandSelect = 1, fBandReject = 2
                  /////////////////////////// fBandPass = 3, fHighPass = 4, fLowPass = 5)
                  ////////// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
                  ////////// LoopProc : External procedure to execute after DSP done
                  //  result :index of DSPOut in array
                  ////////// example :FilterOutIndex1 := uos_AddFilterOut(0,OutputIndex1,6000,16000,1,true,nil);
begin
result := uos.uos_AddFilterOut(PlayerIndex, OutputIndex, LowFrequency, HighFrequency, Gain, TypeFilter, AlsoBuf, LoopProc);
end;

procedure uos_SetFilterOut(PlayerIndex: Cardinal; OutputIndex: cardinal; FilterIndex: cardinal;
                    LowFrequency: integer; HighFrequency: integer; Gain: cfloat;
                    TypeFilter: integer; AlsoBuf: boolean; Enable: boolean; LoopProc: TProc);  cdecl;
                  //////////// PlayerIndex : Index of a existing Player
                  ////////// OutputIndex : OutputIndex of a existing Output
                  ////////// FilterIndex : DSPOutIndex of existing DSPOut
                  ////////// LowFrequency : Lowest frequency of filter ( -1 : current LowFrequency )
                  ////////// HighFrequency : Highest frequency of filter ( -1 : current HighFrequency )
                  ////////// Gain : gain to apply to filter
                  ////////// TypeFilter: Type of filter : ( -1 = current filter ) (fBandAll = 0, fBandSelect = 1, fBandReject = 2
                  /// fBandPass = 3, fHighPass = 4, fLowPass = 5)
                  ////////// AlsoBuf : The filter alter buffer aswell ( otherwise, only result is filled in fft.data )
                  ////////// Enable :  Filter enabled
                  ////////// LoopProc : External procedure to execute after DSP done
                  ////////// example : SetFilterOut(0,OutputIndex1,FilterOutIndex1,1000,1500,-1,True,True,nil);
begin
uos.uos_SetFilterOut(PlayerIndex, OutputIndex, FilterIndex, LowFrequency, HighFrequency, Gain, TypeFilter, AlsoBuf, enable, LoopProc);
end;

function uos_AddPlugin(PlayerIndex: Cardinal; PlugName: string; SampleRate: integer;
                       Channels: integer): cardinal;  cdecl;
                     /////// Add a plugin , result is PluginIndex
                     //////////// PlayerIndex : Index of a existing Player
                     //////////// SampleRate : delault : -1 (44100)
                     //////////// Channels : delault : -1 (2:stereo) (1:mono, 2:stereo, ...)
                     ////// Till now, only 'soundtouch' PlugName is registred.
begin
result := uos.uos_AddPlugin(PlayerIndex, PlugName, SampleRate, Channels);
end;

procedure uos_SetPluginSoundTouch(PlayerIndex: Cardinal; PluginIndex: cardinal; Tempo: cfloat;
                       Pitch: cfloat; Enable: boolean);  cdecl;
                     ////////// PluginIndex : PluginIndex Index of a existing Plugin.
                     //////////// PlayerIndex : Index of a existing Player
begin
uos.uos_SetPluginSoundTouch(PlayerIndex, PluginIndex, Tempo, Pitch, Enable);
end;

function uos_GetStatus(PlayerIndex: Cardinal) : integer; cdecl;
             /////// Get the status of the player :-1 => error,  0 => has stopped, 1 => is running, 2 => is paused.
begin
uos.uos_GetStatus(PlayerIndex);
end;

procedure uos_Seek(PlayerIndex: Cardinal; InputIndex: cardinal; pos: {$if defined(cpu64)} cint64 {$else} longint {$endif}); cdecl;
                     //// change position in sample
begin
uos.uos_Seek(PlayerIndex, InputIndex, pos);
end;

procedure uos_SeekSeconds(PlayerIndex: Cardinal; InputIndex: cardinal; pos: cfloat); cdecl;
                     //// change position in seconds
begin
uos.uos_SeekSeconds(PlayerIndex, InputIndex, pos);
end;

procedure uos_SeekTime(PlayerIndex: Cardinal; InputIndex: cardinal; pos: TTime); cdecl;
                     //// change position in time format
begin
uos.uos_SeekTime(PlayerIndex, InputIndex, pos);
end;

function uos_InputLength(PlayerIndex: Cardinal; InputIndex: cardinal): {$if defined(cpu64)} cint64 {$else} longint {$endif};  cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ///////  result : Length of Input in samples
begin
result := uos.uos_InputLength(PlayerIndex, InputIndex);
end;

function uos_InputLengthSeconds(PlayerIndex: Cardinal; InputIndex: cardinal): cfloat;  cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ///////  result : Length of Input in seconds
begin
result := uos.uos_InputLengthSeconds(PlayerIndex, InputIndex);
end;

function uos_InputLengthTime(PlayerIndex: Cardinal; InputIndex: cardinal): TTime; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ///////  result : Length of Input in time format
begin
result := uos.uos_InputLengthTime(PlayerIndex, InputIndex);
end;

function uos_InputPosition(PlayerIndex: Cardinal; InputIndex: cardinal): longint; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ////// result : current postion in sample
begin
result := uos.uos_InputPosition(PlayerIndex, InputIndex);
end;

procedure uos_InputSetLevelEnable(PlayerIndex: Cardinal; InputIndex: cardinal ; enable : boolean);  cdecl;
                     ///////// enable/disable level calculation (default is false/disable)
begin
uos.uos_InputSetLevelEnable(PlayerIndex, InputIndex, enable);
end;

function uos_InputGetLevelLeft(PlayerIndex: Cardinal; InputIndex: cardinal): double; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ////// result : left volume from 0 to 1
begin
result := uos.uos_InputGetLevelLeft(PlayerIndex, InputIndex);
end;

function uos_InputGetLevelRight(PlayerIndex: Cardinal; InputIndex: cardinal): double; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ////// result : right volume from 0 to 1
begin
result := uos.uos_InputGetLevelRight(PlayerIndex, InputIndex);
end;

function uos_InputPositionSeconds(PlayerIndex: Cardinal; InputIndex: cardinal): cfloat; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ///////  result : current postion of Input in seconds
begin
result := uos.uos_InputPositionSeconds(PlayerIndex, InputIndex);
end;

function uos_InputPositionTime(PlayerIndex: Cardinal; InputIndex: cardinal): TTime; cdecl;
                     ////////// InputIndex : InputIndex of existing input
                     ///////  result : current postion of Input in time format
begin
result := uos.uos_InputPositionTime(PlayerIndex, InputIndex);
end;

procedure uos_Play(PlayerIndex: Cardinal); cdecl;         ///// Start playing
begin
uos.uos_Play(PlayerIndex) ;
end;

procedure uos_RePlay(PlayerIndex: Cardinal); cdecl;                 ///// Resume playing after pause
begin
uos.uos_RePlay(PlayerIndex) ;
end;

procedure uos_Stop(PlayerIndex: Cardinal); cdecl;                   ///// Stop playing and free thread
begin
uos.uos_Stop(PlayerIndex) ;
end;

procedure uos_Pause(PlayerIndex: Cardinal); cdecl;                  ///// Pause playing
begin
uos.uos_Pause(PlayerIndex) ;
end;


exports
uos_loadlib name  'uos_loadlib',
uos_unloadlib name 'uos_unloadlib',
uos_unloadlibcust name 'uos_unloadlibcust',
uos_GetInfoDeviceStr name 'uos_GetInfoDeviceStr',
uos_CreatePlayer name 'uos_CreatePlayer',
uos_AddIntoDevOut name 'uos_AddIntoDevOut',
uos_AddIntoDevOutDef name 'uos_AddIntoDevOutDef',
uos_AddFromFile name 'uos_AddFromFile',
uos_AddFromFileDef name 'uos_AddFromFileDef',
uos_AddIntoFile name 'uos_AddIntoFile',
uos_AddIntoFileDef name 'uos_AddIntoFileDef',
uos_AddFromDevIn name 'uos_AddFromDevIn',
uos_AddFromDevInDef name 'uos_AddFromDevInDef',
uos_BeginProc name 'uos_BeginProc',
uos_EndProc name 'uos_EndProc',
uos_LoopProcIn name 'uos_LoopProcIn',
uos_LoopProcOut name 'uos_LoopProcOut',
uos_AddDSPVolumeIn name 'uos_AddDSPVolumeIn',
uos_AddDSPVolumeOut name 'uos_AddDSPVolumeOut',
uos_SetDSPVolumeIn name 'uos_SetDSPVolumeIn',
uos_SetDSPVolumeOut name 'uos_SetDSPVolumeOut',

{ TODO
uos_AddDSPin name 'uos_AddDSPIn',
uos_AddDSPOut name 'uos_AddDSPOut',
uos_SetDSPin name 'uos_SetDSPIn',
uos_SetDSPOut name 'uos_SetDSPOut',
}
uos_AddFilterIn name 'uos_AddFilterIn',
uos_AddFilterOut name 'uos_AddFilterOut',
uos_SetFilterIn name 'uos_SetFilterIn',
uos_SetFilterOut name 'uos_SetFilterOut',
uos_AddPlugin name 'uos_AddPlugin',
uos_SetPluginSoundTouch name 'uos_SetPluginSoundTouch',
uos_Seek name 'uos_Seek',
uos_SeekSeconds name 'uos_SeekSeconds',
uos_GetStatus name 'uos_GetStatus',
uos_SeekTime name 'uos_SeekTime',
uos_InputLength name 'uos_InputLength',
uos_InputLengthSeconds name 'uos_InputLengthSeconds',
uos_InputLengthTime name 'uos_InputLengthTime',
uos_InputPosition name 'uos_InputPosition',
uos_InputSetLevelEnable name 'uos_InputSetLevelEnable',
uos_InputGetLevelLeft name 'uos_InputGetLevelLeft',
uos_InputGetLevelRight name 'uos_InputGetLevelRight',
uos_InputPositionSeconds name 'uos_InputPositionSeconds',
uos_InputPositionTime name 'uos_InputPositionTime',
uos_InputGetSampleRate name 'uos_InputGetSampleRate',
uos_Play name 'uos_Play',
uos_RePlay name 'uos_RePlay',
uos_Stop name 'uos_Stop',
uos_Pause name 'uos_Pause';

begin
end.
