
unit uoslib_h;

{This is the Dynamic loading version of uos library wrapper.
Load uos library and friends (PortAudio, SndFile, Mpg123, AAC, Opus, BS2B, SoundTouch)
with uos_loadlibs() and release it with uos_unloadlibs().

With reference counter too...
}
 
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
  uos_getinfodevicestr: function() : pansichar ; cdecl;

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

  uos_addintodevoutdef: function(playerindex: longint): longint; cdecl;

  uos_addfromfile: function(playerindex: longint; filename: pchar;
  outputindex: longint; sampleformat: shortint; framescount: longint): longint; cdecl;

   uos_addfromurl: function(playerindex: longint; URL: PChar; OutputIndex: LongInt;
   SampleFormat: LongInt ; FramesCount: LongInt): LongInt; cdecl;

   uos_addfromurldef: function(playerindex: longint; URL: PChar): LongInt; cdecl;
  
    uos_addfromfiledef: function(playerindex: longint; filename: pchar): longint; cdecl;

  uos_addintofile: function(playerindex: longint; filename: pchar; samplerate: longint;
        channels: longint; sampleformat: shortint ; framescount: longint): longint; cdecl;

  uos_addintofiledef: function(playerindex: longint; filename: pchar): longint; cdecl;

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

  uos_addplugin: function(playerindex: longint; plugname: pchar; samplerate: longint;
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
  uos_loadlib: function(portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, OpusFileName: pchar): longint; cdecl;

  uos_loadplugin: function(PluginName, PluginFilename: pchar): longint; cdecl;

  uos_unloadlib: procedure(); cdecl;

  uos_free: procedure(); cdecl;

  uos_unloadPlugin: procedure(PluginName: pchar); cdecl;
  ////////////////////////

  uos_getversion:  function(): longint ; cdecl;    /// uos version

  libhandle: tlibhandle = dynlibs.nilhandle; // this will hold our handle for the uoslib
  referencecounter: longint = 0;  // reference counter

function uos_isloaded: boolean; inline;
function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, OpusFileName: pchar): boolean;
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

function uos_loadlibs(const uoslibfilename, portaudiofilename, sndfilefilename, mpg123filename,  Mp4ffFileName, FaadFileName, opusFileName: pchar): boolean;
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
        pointer(uos_checksynchro) :=
          getprocaddress(libhandle, 'uos_checksynchro');

        pointer(uos_loadlib) :=
          getprocaddress(libhandle, 'uos_loadlib');

        pointer(uos_free) :=
          getprocaddress(libhandle, 'uos_free');

        pointer(uos_unloadlib) :=
          getprocaddress(libhandle, 'uos_unloadlib');

        pointer(uos_loadplugin) :=
          getprocaddress(libhandle, 'uos_loadplugin');

        pointer(uos_unloadplugin) :=
          getprocaddress(libhandle, 'uos_unloadplugin');

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

        pointer(uos_addfromurl) :=
          getprocaddress(libhandle, 'uos_addfromurl');

        pointer(uos_addfromurldef) :=
          getprocaddress(libhandle, 'uos_addfromurldef');
        
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

          pointer(uos_inputadddspvolume) :=
       getprocaddress(libhandle, 'uos_inputadddspvolume');

         pointer(uos_inputsetdspvolume) :=
          getprocaddress(libhandle, 'uos_inputsetdspvolume');

          pointer(uos_outputadddspvolume) :=
          getprocaddress(libhandle, 'uos_outputadddspvolume');

         pointer(uos_outputsetdspvolume) :=
          getprocaddress(libhandle, 'uos_outputsetdspvolume');

        pointer(uos_inputaddfilter) :=
          getprocaddress(libhandle, 'uos_inputaddfilter');

        pointer(uos_outputaddfilter) :=
          getprocaddress(libhandle, 'uos_outputaddfilter');

        pointer(uos_inputsetfilter) :=
          getprocaddress(libhandle, 'uos_inputsetfilter');

        pointer(uos_outputsetfilter) :=
          getprocaddress(libhandle, 'uos_outputsetfilter');

        pointer(uos_addplugin) :=
          getprocaddress(libhandle, 'uos_addplugin');

        pointer(uos_setpluginsoundtouch) :=
          getprocaddress(libhandle, 'uos_setpluginsoundtouch');

        pointer(uos_getstatus) :=
          getprocaddress(libhandle, 'uos_getstatus');

         pointer(uos_inputseek) :=
          getprocaddress(libhandle, 'uos_inputseek');

        pointer(uos_inputseekseconds) :=
          getprocaddress(libhandle, 'uos_inputseekseconds');

        pointer(uos_inputseektime) :=
          getprocaddress(libhandle, 'uos_inputseektime');

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

        pointer(uos_inputsetlevelarrayenable) :=
          getprocaddress(libhandle, 'uos_inputsetlevelarrayenable');

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
       uos_loadlib(pchar(portaudiofilename), pchar(sndfilefilename), pchar(mpg123filename),  pchar(Mp4ffFileName), pchar(FaadFileName), pchar(opusFileName));

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
