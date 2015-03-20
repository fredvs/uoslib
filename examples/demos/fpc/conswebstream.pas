{$IF DEFINED(Windows)}
WARNING => only for unix systems...
{$ENDIF} 

program conswebstream;

///WARNING : needs FPC version > 2.7.1 

{$mode objfpc}{$H+}
   {$DEFINE UseCThreads}
uses
 {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  ctypes,
  SysUtils,
  CustApp,
  uoslib_h;  //// the uoslib header...

type

  { TUOSConsole }

  TuosConsole = class(TCustomApplication)
  private
    procedure ConsolePlay;
  protected
    procedure doRun; override;
  public
    procedure Consoleclose;
    constructor Create(TheOwner: TComponent); override;
  end;


var
  res: integer;
  ordir, opath, uoslib_filename, PA_FileName, MP_FileName: string;
  PlayerIndex1: cardinal;

 // AHandleStream : THandleStream ;

  { TuosConsole }

  procedure TuosConsole.ConsolePlay;
  begin
      ordir := (ExtractFilePath(ParamStr(0)));

          {$IFDEF Windows}
     {$if defined(cpu64)}
     uoslib_FileName := ordir + 'libuos.dll';
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    MP_FileName := ordir + 'lib\Windows\64bit\LibMpg123-64.dll';
{$else}
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    MP_FileName := ordir + 'lib\Windows\32bit\LibMpg123-32.dll';
   {$endif}
  {$ENDIF}

 {$IFDEF linux}
    {$if defined(cpu64)}
      uoslib_FileName := ordir + 'libuoslib.so';
    PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
    MP_FileName := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
    {$else}
      uoslib_FileName := ordir + 'libuoslib.so';
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    MP_FileName := ordir + 'lib/Linux/32bit/LibMpg123-32.so';
{$endif}
  {$ENDIF}

            {$IFDEF Darwin}
   uoslib_FileName := ordir + 'libuoslib.dylib';
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    PA_FileName := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
    MP_FileName := opath + '/lib/Mac/32bit/LibMpg123-32.dylib';
                {$ENDIF}
  
    // Load the libraries
    // function uos_LoadLib(PortAudioFileName: Pchar; SndFileFileName: Pchar; Mpg123FileName: Pchar; SoundTouchFileName: Pchar) : integer;
    // for web streaming => Mpg123 is needed

  if uos_loadlibs(PChar(uoslib_FileName), PChar(PA_FileName), nil, PChar(MP_FileName), nil) then
    writeln('Libraries are loaded...')
    else
      writeln('Libraries do not load...');

     PlayerIndex1 := 0;
      uos_CreatePlayer(PlayerIndex1); //// Create the player
     writeln('ok uos_CreatePlayer');

     // uos_AddFromURL(PlayerIndex1,'http://www.hubharp.com/web_sound/BachGavotteShort.mp3') ;
     uos_AddFromURL(PlayerIndex1,'http://www.jerryradio.com/downloads/BMB-64-03-06-MP3/jg1964-03-06t01.mp3',-1,-1,-1) ;
     writeln('ok uos_AddFromURL');

      //// add a Output  => change framecount => 1024
     uos_AddIntoDevOut(PlayerIndex1, -1, -1, -1, -1, -1, 1024);
     writeln('ok uos_AddIntoDevOut');

     uos_Play(PlayerIndex1);
        end;

  procedure TuosConsole.doRun;
  begin
    ConsolePlay;
    writeln('Press a key to exit...');
      readln;
      uos_unloadLibs();
      Terminate;
    end;

  procedure TuosConsole.ConsoleClose;
  begin
    Terminate;
  end;

  constructor TuosConsole.Create(TheOwner: TComponent);
  begin
    inherited Create(TheOwner);
    StopOnException := True;
  end;

var
  Application: TUOSConsole;
begin
  Application := TUOSConsole.Create(nil);
  Application.Title := 'Console Player';
    Application.Run;
  Application.Free;
end.
