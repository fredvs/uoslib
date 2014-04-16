
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
TProc = procedure ;

var

 // function uos_getinfodevicestr(infos:pchar) : longint ;    cdecl;
  uos_getinfodevicestr: function() : pchar ; cdecl;

  uos_createplayer: procedure(playerindex: longint); cdecl;

  uos_beginproc: procedure(playerindex: cint32; proc: tproc); cdecl;

  uos_endproc: procedure(playerindex: cint32; proc: tproc); cdecl;

  uos_loopprocin: procedure(playerindex: cint32; inindex: cint32; proc: tproc); cdecl;

  uos_loopprocout: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_loopbeginproc: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_loopendproc: procedure(playerindex: cint32; outindex: cint32; proc: tproc); cdecl;

  uos_addintodevout: function(playerindex: longint; device: longint;
  latency: cdouble; samplerate: longint; channels: longint;
  sampleformat: shortint; framescount: longint): longint; cdecl;

  uos_addintodevoutdef: function(playerindex: longint): longint; cdecl;

  uos_addfromfile: function(playerindex: longint; filename: pchar;
  outputindex: longint; sampleformat: shortint; framescount: longint): longint; cdecl;

  uos_addfromfiledef: function(playerindex: longint; filename: pchar): longint; cdecl;

  uos_addintofile: function(playerindex: longint; filename: pchar; samplerate: longint;
        channels: longint; sampleformat: shortint ; framescount: longint): longint; cdecl;

  uos_addintofiledef: function(playerindex: longint; filename: pchar): longint; cdecl;

  uos_addfromdevin: function(playerindex: longint; device: longint; latency: cdouble;
             samplerate: longint; channels: longint; outputindex: longint;
             sampleformat: shortint; framescount : longint): longint; cdecl;

  uos_addfromdevindef: function(playerindex: longint): longint; cdecl;

  uos_adddspvolumein: procedure(playerindex: longint; inputindex: longint; volleft: double;
                volright: double); cdecl;

  uos_adddspvolumeout: procedure(playerindex: longint; outputindex: longint; volleft: double;
                 volright: double); cdecl;

  uos_setdspvolumein: procedure(playerindex: longint; inputindex: longint;
                 volleft: double; volright: double; enable: boolean); cdecl;

  uos_setdspvolumeout: procedure(playerindex: longint; outputindex: longint;
                 volleft: double; volright: double; enable: boolean); cdecl;

  uos_addfilterin: function(playerindex: longint; inputindex: longint; lowfrequency: longint;
                    highfrequency: longint; gain: cfloat; typefilter: longint;
                    alsobuf: boolean; loopproc: tproc): longint; cdecl;

  uos_setfilterin: procedure(playerindex: longint; inputindex: longint; filterindex: longint;
                    lowfrequency: longint; highfrequency: longint; gain: cfloat;
                    typefilter: longint; alsobuf: boolean; enable: boolean; loopproc: tproc); cdecl;

  uos_addfilterout: function(playerindex: longint; outputindex: longint; lowfrequency: longint;
                    highfrequency: longint; gain: cfloat; typefilter: longint;
                    alsobuf: boolean; loopproc: tproc): longint; cdecl;

  uos_setfilterout: procedure(playerindex: longint; outputindex: longint; filterindex: longint;
                    lowfrequency: longint; highfrequency: longint; gain: cfloat;
                    typefilter: longint; alsobuf: boolean; enable: boolean; loopproc: tproc); cdecl;

  uos_addplugin: function(playerindex: longint; plugname: pchar; samplerate: longint;
                       channels: longint): longint; cdecl;

  uos_setpluginsoundtouch: procedure(playerindex: longint; pluginindex: longint; tempo: cfloat;
                       pitch: cfloat; enable: boolean); cdecl;

  uos_getstatus: function(playerindex: longint) : longint; cdecl;

  uos_seek: procedure(playerindex: longint; inputindex: longint; pos: {$if defined(cpu64)} cint64 {$else} cint32 {$endif}); cdecl;

  uos_seekseconds: procedure(playerindex: longint; inputindex: longint; pos: cfloat); cdecl;

  uos_seektime: procedure(playerindex: longint; inputindex: longint; pos: ttime); cdecl;

  uos_inputlength: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputlengthseconds: function(playerindex: longint; inputindex: longint): cfloat; cdecl;

  uos_inputlengthtime: function(playerindex: longint; inputindex: longint): ttime; cdecl;

  uos_inputposition: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputpositionseconds: function(playerindex: longint; inputindex: longint): cfloat; cdecl;

  uos_inputpositiontime: function(playerindex: longint; inputindex: longint): ttime; cdecl;

  uos_inputsetlevelenable: procedure(playerindex: longint; inputindex: longint; enable: cint32); cdecl;

  uos_inputsetpositionenable: procedure(playerindex: longint; inputindex: longint; enable: cint32); cdecl;

  uos_inputsetarraylevelenable: procedure(playerindex: longint; inputindex: longint; levelcalc : cint32); cdecl;

  // todo => function uos_inputgetarraylevel(playerindex: cint32; inputindex: longint) : tdarfloat;


  uos_inputgetlevelleft: function(playerindex: longint; inputindex: longint): double; cdecl;

  uos_inputgetlevelright: function(playerindex: longint; inputindex: longint): double; cdecl;

  uos_inputgetsamplerate: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_inputgetchannels: function(playerindex: longint; inputindex: longint): longint; cdecl;

  uos_play: procedure(playerindex: longint); cdecl;

  uos_replay: procedure(playerindex: longint); cdecl;

  uos_stop: procedure(playerindex: longint); cdecl;

  uos_pause: procedure(playerindex:  longint); cdecl;

  uos_unloadlibcust: procedure(portaudio : boolean; sndfile: boolean; mpg123: boolean; soundtouch: boolean); cdecl;

  ///// this functions should not be used, use uos_loadlibs and uos_unloadlibs instead...
  uos_loadlib: function(portaudiofilename, sndfilefilename, mpg123filename, soundtouchfilename: pchar): longint; cdecl;
  uos_unloadlib: procedure(); cdecl;
  ////////////////////////

  uos_getversion:  function(): longint ; cdecl;    /// uos version

  libhandle: tlibhandle = dynlibs.nilhandle; // this will hold our handle for the uoslib
  referencecounter: longint = 0;  // reference counter


function uos_isloaded: boolean; inline;
function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename, soundtouchfilename: pchar): boolean;
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
  result := (libhandle <> dynlibs.nilhandle);
end;

function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename, soundtouchfilename: pchar): boolean;
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
    if libhandle <> dynlibs.nilhandle then
    begin
      try
        pointer(uos_loadlib) :=
          getprocaddress(libhandle, 'uos_loadlib');

        pointer(uos_unloadlib) :=
          getprocaddress(libhandle, 'uos_unloadlib');

        pointer(uos_unloadlibcust) :=
          getprocaddress(libhandle, 'uos_unloadlibcust');

        pointer(uos_getinfodevicestr) :=
          getprocaddress(libhandle, 'uos_getinfodevicestr');

        pointer(uos_createplayer) :=
          getprocaddress(libhandle, 'uos_createplayer');

        pointer(uos_addintodevout) :=
          getprocaddress(libhandle, 'uos_addintodevout');

        pointer(uos_addintodevoutdef) :=
          getprocaddress(libhandle, 'uos_addintodevoutdef');

        pointer(uos_addfromfiledef) :=
          getprocaddress(libhandle, 'uos_addfromfiledef');

        pointer(uos_addfromfile) :=
          getprocaddress(libhandle, 'uos_addfromfile');

        pointer(uos_addintofile) :=
          getprocaddress(libhandle, 'uos_addintofile');

        pointer(uos_addintofiledef) :=
          getprocaddress(libhandle, 'uos_addintofiledef');

        pointer(uos_addfromdevin) :=
          getprocaddress(libhandle, 'uos_addfromdevin');

        pointer(uos_addfromdevindef) :=
         getprocaddress(libhandle, 'uos_addfromdevindef');

          pointer(uos_adddspvolumein) :=
       getprocaddress(libhandle, 'uos_adddspvolumein');

         pointer(uos_setdspvolumein) :=
          getprocaddress(libhandle, 'uos_setdspvolumein');

          pointer(uos_adddspvolumeout) :=
          getprocaddress(libhandle, 'uos_adddspvolumeout');

         pointer(uos_setdspvolumeout) :=
          getprocaddress(libhandle, 'uos_setdspvolumeout');

        pointer(uos_addfilterin) :=
          getprocaddress(libhandle, 'uos_addfilterin');

        pointer(uos_addfilterout) :=
          getprocaddress(libhandle, 'uos_addfilterout');

        pointer(uos_setfilterin) :=
          getprocaddress(libhandle, 'uos_setfilterin');

        pointer(uos_setfilterout) :=
          getprocaddress(libhandle, 'uos_setfilterout');

        pointer(uos_addplugin) :=
          getprocaddress(libhandle, 'uos_addplugin');

        pointer(uos_setpluginsoundtouch) :=
          getprocaddress(libhandle, 'uos_setpluginsoundtouch');

        pointer(uos_getstatus) :=
          getprocaddress(libhandle, 'uos_getstatus');

         pointer(uos_seek) :=
          getprocaddress(libhandle, 'uos_seek');

        pointer(uos_seekseconds) :=
          getprocaddress(libhandle, 'uos_seekseconds');

        pointer(uos_seektime) :=
          getprocaddress(libhandle, 'uos_seektime');

        pointer(uos_inputlength) :=
          getprocaddress(libhandle, 'uos_inputlength');

        pointer(uos_inputlengthseconds) :=
          getprocaddress(libhandle, 'uos_inputlengthseconds');

        pointer(uos_inputlengthtime) :=
          getprocaddress(libhandle, 'uos_inputlengthtime');

        pointer(uos_inputposition) :=
          getprocaddress(libhandle, 'uos_inputposition');

        pointer(uos_inputsetlevelenable) :=
          getprocaddress(libhandle, 'uos_inputsetlevelenable');

         pointer(uos_inputsetpositionenable) :=
          getprocaddress(libhandle, 'uos_inputsetpositionenable');

        pointer(uos_inputgetlevelleft) :=
          getprocaddress(libhandle, 'uos_inputgetlevelleft');

        pointer(uos_inputgetlevelright) :=
          getprocaddress(libhandle, 'uos_inputgetlevelright');

        pointer(uos_inputpositionseconds) :=
          getprocaddress(libhandle, 'uos_inputpositionseconds');

        pointer(uos_inputpositiontime) :=
          getprocaddress(libhandle, 'uos_inputpositiontime');

        pointer(uos_inputgetsamplerate) :=
          getprocaddress(libhandle, 'uos_inputgetsamplerate');

       pointer(uos_inputgetchannels) :=
          getprocaddress(libhandle, 'uos_inputgetchannels');

       pointer(uos_play) :=
          getprocaddress(libhandle, 'uos_play');

        pointer(uos_replay) :=
          getprocaddress(libhandle, 'uos_replay');

        pointer(uos_stop) :=
          getprocaddress(libhandle, 'uos_stop');

        pointer(uos_pause) :=
          getprocaddress(libhandle, 'uos_pause');

        pointer(uos_getversion) :=
          getprocaddress(libhandle, 'uos_getversion');

       pointer(uos_beginproc) :=
          getprocaddress(libhandle, 'uos_beginproc');

        pointer(uos_endproc) :=
          getprocaddress(libhandle, 'uos_endproc');

        pointer(uos_loopprocin) :=
          getprocaddress(libhandle, 'uos_loopprocin');

        pointer(uos_loopprocout) :=
          getprocaddress(libhandle, 'uos_loopprocout');

          pointer(uos_loopbeginproc) :=
          getprocaddress(libhandle, 'uos_loopbeginproc');

        pointer(uos_loopendproc) :=
          getprocaddress(libhandle, 'uos_loopendproc');

         { todo ...
        pointer(uos_adddspin) :=
          getprocaddress(libhandle, 'uos_adddspin');

        pointer(uos_adddspout) :=
          getprocaddress(libhandle, 'uos_adddspout');

        pointer(uos_setdspin) :=
          getprocaddress(libhandle, 'uos_setdspin');

        pointer(uos_setdspout) :=
          getprocaddress(libhandle, 'uos_setdspout');
       }

        referencecounter := 1;

        ///// load the audio libraries
        uos_loadlib(pchar(portaudiofilename), pchar(sndfilefilename), pchar(mpg123filename), pchar(soundtouchfilename));

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
   if LibHandle <> DynLibs.NilHandle then
  begin
    DynLibs.UnloadLibrary(LibHandle);
    LibHandle := DynLibs.NilHandle;
  end;
end;

end.
