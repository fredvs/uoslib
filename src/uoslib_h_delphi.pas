
unit uoslib_h_delphi;

/// This is a uoaslib_h variant for Delphi >= 2009
///  adapted to latest version of uos (2180729)
/// - PAnsiChar instead of PChar (to match single byte strings of uos)
/// - stubs replacements for dynlibs and ctypes

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
   Windows;

const
   LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = 4096;
   LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = 256;

type
TProc = procedure of object ;
cint32 = LongInt;
cdouble = Double;
cfloat = Single;
tlibhandle = THandle;

const nilhandle : tlibhandle  = 0;

type
   DynLibs = class
  public
      class function loadlibrary(aDllName : PAnsiChar): tlibhandle;
      class procedure UnloadLibrary(aLibHandle : tlibhandle);
  end;

var
  uos_getinfodevicestr: function() : pPAnsiChar ; cdecl;

  uos_createplayer: procedure(playerindex: longint); cdecl;

  uos_beginproc: procedure(playerindex: cint32; proc: tproc); cdecl;

  uos_endproc: procedure(playerindex: cint32; proc: tproc); cdecl;

  uos_loopprocin: procedure(playerindex: cint32; inindex: cint32; proc: tproc); cdecl;

  uos_loopprocout: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_loopbeginproc: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_loopendproc: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_addintodevout: function(playerindex: longint; device: longint;
  latency: cdouble; samplerate: longint; channels: longint;
  sampleformat: shortint; framescount: longint; chunkcount: longint): longint; cdecl;

  uos_addintodevoutdef: function(playerindex: cint32): cint32; cdecl;

  uos_addfromfile: function(playerindex: longint; filename: PAnsiChar;
  outputindex: longint; sampleformat: shortint; framescount: longint): longint; cdecl;

  uos_addfromurl: function(playerindex: longint; URL: PAnsiChar; OutputIndex: LongInt;
   SampleFormat: LongInt ; FramesCount: LongInt): LongInt; cdecl;

   uos_addfromurldef: function(playerindex: longint; URL: PAnsiChar): LongInt; cdecl;

    uos_addfromfiledef: function(playerindex: longint; filename: PAnsiChar): longint; cdecl;

  uos_addintofile: function(playerindex: longint; filename: PAnsiChar; samplerate: longint;
        channels: longint; sampleformat: shortint ; framescount: longint): longint; cdecl;

  uos_addintofiledef: function(playerindex: longint; filename: PAnsiChar): longint; cdecl;

  uos_addfromdevin: function(playerindex: longint; device: longint; latency: cdouble;
             samplerate: longint; outputindex: longint;
             sampleformat: shortint; framescount : longint; chunkcount: longint): longint; cdecl;

  uos_addfromdevindef: function(playerindex: longint): longint; cdecl;

  uos_inputadddspvolume: procedure(playerindex: longint; inputindex: longint; volleft: double;
                volright: double); cdecl;

  uos_outputadddspvolume: procedure(playerindex: longint; outputindex: longint; volleft: double;
                 volright: double); cdecl;

  uos_inputsetdspvolume: procedure(playerindex: longint; inputindex: longint;
                 volleft: double; volright: double; enable: boolean); cdecl;

  uos_outputsetdspvolume: procedure(playerindex: longint; outputindex: longint;
                 volleft: double; volright: double; enable: boolean); cdecl;

  uos_inputaddfilter: function(playerindex: longint; inputindex: longint; lowfrequency: longint;
                    highfrequency: longint; gain: cfloat; typefilter: longint;
                    alsobuf: boolean; loopproc: tproc): longint; cdecl;

  uos_inputsetfilter: procedure(playerindex: longint; inputindex: longint; filterindex: longint;
                    lowfrequency: longint; highfrequency: longint; gain: cfloat;
                    typefilter: longint; alsobuf: boolean; enable: boolean; loopproc: tproc); cdecl;

  uos_outputaddfilter: function(playerindex: longint; outputindex: longint; lowfrequency: longint;
                    highfrequency: longint; gain: cfloat; typefilter: longint;
                    alsobuf: boolean; loopproc: tproc): longint; cdecl;

  uos_outputsetfilter: procedure(playerindex: longint; outputindex: longint; filterindex: longint;
                    lowfrequency: longint; highfrequency: longint; gain: cfloat;
                    typefilter: longint; alsobuf: boolean; enable: boolean; loopproc: tproc); cdecl;

  uos_addplugin: function(playerindex: longint; plugname: PAnsiChar; samplerate: longint;
                       channels: longint): longint; cdecl;

  uos_setpluginsoundtouch: procedure(playerindex: longint; pluginindex: longint; tempo: cfloat;
                       pitch: cfloat; enable: boolean); cdecl;

  uos_getstatus: function(playerindex: longint) : longint; cdecl;

  uos_inputseek: procedure(playerindex: longint; inputindex: longint; pos: {$if defined(cpu64)} cint64 {$else} cint32 {$endif}); cdecl;

  uos_inputseekseconds: procedure(playerindex: longint; inputindex: longint; pos: cfloat); cdecl;

  uos_inputseektime: procedure(playerindex: longint; inputindex: longint; pos: ttime); cdecl;

  uos_inputlength: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputlengthseconds: function(playerindex: longint; inputindex: longint): cfloat; cdecl;

  uos_inputlengthtime: function(playerindex: longint; inputindex: longint): ttime; cdecl;

  uos_inputposition: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputpositionseconds: function(playerindex: longint; inputindex: longint): cfloat; cdecl;

  uos_inputpositiontime: function(playerindex: longint; inputindex: longint): ttime; cdecl;

  uos_inputsetlevelenable: procedure(playerindex: longint; inputindex: longint; enable: longint); cdecl;

   uos_inputsetlevelarrayenable: procedure(playerindex: longint; inputindex: longint; enable: longint); cdecl;
  uos_inputsetpositionenable: procedure(playerindex: longint; inputindex: longint; enable: longint); cdecl;

  // todo => function uos_inputgetarraylevel(playerindex: cint32; inputindex: longint) : tdarfloat;

  uos_inputgetlevelleft: function(playerindex: longint; inputindex: longint): double; cdecl;

  uos_inputgetlevelright: function(playerindex: longint; inputindex: longint): double; cdecl;

  uos_inputgetsamplerate: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputgetchannels: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_play: procedure(playerindex: longint); cdecl;

  uos_replay: procedure(playerindex: longint); cdecl;

  uos_stop: procedure(playerindex: longint); cdecl;

  uos_pause: procedure(playerindex:  longint); cdecl;

  uos_checksynchro: procedure(); cdecl;

  uos_unloadlibcust: procedure(portaudio : boolean; sndfile: boolean; mpg123: boolean;  Mp4ffFileName: boolean; FaadFileName: boolean ; OpusFileName: boolean); cdecl;

  ///// this functions should not be used, use uos_loadlibs and uos_unloadlibs instead...
  uos_loadlib: function(portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, OpusFileName: PAnsiChar): longint; cdecl;

  uos_loadplugin: function(PluginName, PluginFilename: PAnsiChar): longint; cdecl;

  uos_unloadlib: procedure(); cdecl;

  uos_free: procedure(); cdecl;

  uos_unloadPlugin: procedure(PluginName: PAnsiChar); cdecl;
  ////////////////////////

  uos_getversion:  function(): longint ; cdecl;    /// uos version

  libhandle: tlibhandle = 0; // this will hold our handle for the uoslib
  referencecounter: longint = 0;  // reference counter

function uos_isloaded: boolean; inline;
function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, OpusFileName: PAnsiChar): boolean;
// load the all the libraries (if filename = '' => do not load that library)

procedure uos_unloadlibs();
// unload and frees the lib from memory : do not forget to call it before close application.

{ todo ...
  uos_beginproc: procedure(playerindex: longint; proc: tproc); cdecl;

  uos_endproc: procedure(playerindex: longint; proc: tproc); cdecl;

  uos_loopprocin: procedure(playerindex: longint; inindex: longint; proc: tproc);  cdecl;

  uos_loopprocout: procedure(playerindex: longint; outindex: longint; proc: tproc); cdecl;

  uos_adddspin: function(playerindex: longint; inputindex: longint; beforeproc: tfunc;
                  afterproc: tfunc; loopproc: tproc): longint; cdecl;

  uos_setdspin: procedure(playerindex: longint; inputindex: longint; dspinindex: longint; enable: boolean); cdecl;

  uos_adddspout: function(playerindex: longint; outputindex: longint; beforeproc: tfunc;
                   afterproc: tfunc; loopproc: tproc): longint; cdecl;

  uos_setdspout: procedure(playerindex: longint; outputindex: longint; dspoutindex: longint; enable: boolean); cdecl;
}

implementation

function uos_isloaded: boolean;
begin
  result := (libhandle <> 0);
end;

function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, opusFileName: PAnsiChar): boolean;
var
  loadresult : Integer;
begin
  result := false;
  if libhandle <> 0 then
  begin
    inc(referencecounter);
    result := true;
  end
  else
  begin
    if length(uoslibfilename) = 0 then exit;
    libhandle := dynlibs.loadlibrary(uoslibfilename); // obtain the handle we want
    if libhandle <> nilhandle then
    begin
      try
        @uos_checksynchro := getprocaddress(libhandle, 'uos_checksynchro');

        @uos_loadlib := getprocaddress(libhandle, 'uos_loadlib');

        @uos_free :=
          getprocaddress(libhandle, 'uos_free');

        @uos_unloadlib :=
          getprocaddress(libhandle, 'uos_unloadlib');

        @uos_loadplugin :=
          getprocaddress(libhandle, 'uos_loadplugin');

        @uos_unloadplugin :=
          getprocaddress(libhandle, 'uos_unloadplugin');

        @uos_unloadlibcust :=
          getprocaddress(libhandle, 'uos_unloadlibcust');

        @uos_getinfodevicestr :=
          getprocaddress(libhandle, 'uos_getinfodevicestr');

        @uos_createplayer :=
          getprocaddress(libhandle, 'uos_createplayer');

        @uos_addintodevout :=
          getprocaddress(libhandle, 'uos_addintodevout');

        @uos_addintodevoutdef :=
          getprocaddress(libhandle, 'uos_addintodevoutdef');

        @uos_addfromfiledef :=
          getprocaddress(libhandle, 'uos_addfromfiledef');
        // FIXME
        @uos_addfromurl :=
          getprocaddress(libhandle, 'uos_addfromurl');

        // FIXME
        @uos_addfromurldef :=
          getprocaddress(libhandle, 'uos_addfromurldef');
        
        @uos_addfromfile :=
          getprocaddress(libhandle, 'uos_addfromfile');

        @uos_addintofile :=
          getprocaddress(libhandle, 'uos_addintofile');

        @uos_addintofiledef :=
          getprocaddress(libhandle, 'uos_addintofiledef');

        @uos_addfromdevin :=
          getprocaddress(libhandle, 'uos_addfromdevin');

        @uos_addfromdevindef :=
         getprocaddress(libhandle, 'uos_addfromdevindef');

          @uos_inputadddspvolume :=
       getprocaddress(libhandle, 'uos_inputadddspvolume');

         @uos_inputsetdspvolume :=
          getprocaddress(libhandle, 'uos_inputsetdspvolume');

          @uos_outputadddspvolume :=
          getprocaddress(libhandle, 'uos_outputadddspvolume');

         @uos_outputsetdspvolume :=
          getprocaddress(libhandle, 'uos_outputsetdspvolume');

        @uos_inputaddfilter :=
          getprocaddress(libhandle, 'uos_inputaddfilter');

        @uos_outputaddfilter :=
          getprocaddress(libhandle, 'uos_outputaddfilter');

        @uos_inputsetfilter :=
          getprocaddress(libhandle, 'uos_inputsetfilter');

        @uos_outputsetfilter :=
          getprocaddress(libhandle, 'uos_outputsetfilter');

        @uos_addplugin :=
          getprocaddress(libhandle, 'uos_addplugin');

        @uos_setpluginsoundtouch :=
          getprocaddress(libhandle, 'uos_setpluginsoundtouch');

        @uos_getstatus :=
          getprocaddress(libhandle, 'uos_getstatus');

         @uos_inputseek :=
          getprocaddress(libhandle, 'uos_inputseek');

        @uos_inputseekseconds :=
          getprocaddress(libhandle, 'uos_inputseekseconds');

        @uos_inputseektime :=
          getprocaddress(libhandle, 'uos_inputseektime');

        @uos_inputlength :=
          getprocaddress(libhandle, 'uos_inputlength');

        @uos_inputlengthseconds :=
          getprocaddress(libhandle, 'uos_inputlengthseconds');

        @uos_inputlengthtime :=
          getprocaddress(libhandle, 'uos_inputlengthtime');

        @uos_inputposition :=
          getprocaddress(libhandle, 'uos_inputposition');

        @uos_inputsetlevelenable :=
          getprocaddress(libhandle, 'uos_inputsetlevelenable');

        @uos_inputsetlevelarrayenable :=
          getprocaddress(libhandle, 'uos_inputsetlevelarrayenable');

         @uos_inputsetpositionenable :=
          getprocaddress(libhandle, 'uos_inputsetpositionenable');

        @uos_inputgetlevelleft :=
          getprocaddress(libhandle, 'uos_inputgetlevelleft');

        @uos_inputgetlevelright :=
          getprocaddress(libhandle, 'uos_inputgetlevelright');

        @uos_inputpositionseconds :=
          getprocaddress(libhandle, 'uos_inputpositionseconds');

        @uos_inputpositiontime :=
          getprocaddress(libhandle, 'uos_inputpositiontime');

        @uos_inputgetsamplerate :=
          getprocaddress(libhandle, 'uos_inputgetsamplerate');

       @uos_inputgetchannels :=
          getprocaddress(libhandle, 'uos_inputgetchannels');

       @uos_play :=
          getprocaddress(libhandle, 'uos_play');

        @uos_replay :=
          getprocaddress(libhandle, 'uos_replay');

        @uos_stop :=
          getprocaddress(libhandle, 'uos_stop');

        @uos_pause :=
          getprocaddress(libhandle, 'uos_pause');

        @uos_getversion :=
          getprocaddress(libhandle, 'uos_getversion');

       @uos_beginproc :=
          getprocaddress(libhandle, 'uos_beginproc');

        @uos_endproc :=
          getprocaddress(libhandle, 'uos_endproc');

        @uos_loopprocin :=
          getprocaddress(libhandle, 'uos_loopprocin');

        @uos_loopprocout :=
          getprocaddress(libhandle, 'uos_loopprocout');

          @uos_loopbeginproc :=
          getprocaddress(libhandle, 'uos_loopbeginproc');

        @uos_loopendproc :=
          getprocaddress(libhandle, 'uos_loopendproc');

         { todo ...
        @uos_adddspin :=
          getprocaddress(libhandle, 'uos_adddspin');

        @uos_adddspout :=
          getprocaddress(libhandle, 'uos_adddspout');

        @uos_setdspin :=
          getprocaddress(libhandle, 'uos_setdspin');

        @uos_setdspout :=
          getprocaddress(libhandle, 'uos_setdspout');
       }

        referencecounter := 1;

        ///// load the audio libraries
       loadresult:= uos_loadlib(portaudiofilename, sndfilefilename, nil,  nil, nil, nil);

        result := uos_isloaded;
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
   if LibHandle <> 0 then
  begin
    DynLibs.UnloadLibrary(LibHandle);
    LibHandle := 0;
  end;
end;

{ DynLibs }



class function DynLibs.loadlibrary(aDllName: PAnsiChar): tlibhandle;
var
   dllName : string;
begin
   dllName := aDllName;
   Result:= LoadLibraryExW(PWideChar(dllName),
         0,
         LOAD_LIBRARY_SEARCH_DEFAULT_DIRS or LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR);
end;


class procedure DynLibs.UnloadLibrary(aLibHandle: tlibhandle);
begin
   FreeLibrary(aLibHandle);
end;

end.
