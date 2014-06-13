program libconsoleplay;

{$mode objfpc}{$H+}
   {$DEFINE UseCThreads}
uses {$IFDEF UNIX}
  cthreads,
  cwstring, {$ENDIF}

  uoslib_h,  //// the uoslib header...

  Classes,
  SysUtils,
  CustApp,
  ctypes { you can add units after this };

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
  ordir, sndfilename, uoslib_filename, PA_FileName, SF_FileName: string;
  PlayerIndex1: cardinal;

  { TuosConsole }

  procedure TuosConsole.ConsolePlay;
  begin
    ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

          {$IFDEF Windows}
     {$if defined(cpu64)}
    uoslib_FileName := ordir + 'libuos.dll';
    PA_FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    SF_FileName := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
{$else}
   uoslib_FileName := ordir + 'libuos.dll';
    PA_FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    SF_FileName := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
   {$endif}
    sndfilename := ordir + 'sound\test.flac';
 {$ENDIF}

 {$IFDEF linux}
    {$if defined(cpu64)}
     uoslib_FileName := ordir + 'libuoslib.so';
    PA_FileName := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
    SF_FileName := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
    {$else}
    uoslib_FileName := ordir + 'libuoslib.so';
    PA_FileName := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    SF_FileName := ordir + 'lib/Linux/32bit/LibSndFile-32.so';
{$endif}
    sndfilename := ordir + 'sound/test.flac';
 {$ENDIF}

            {$IFDEF Darwin}
    ordir := copy(ordir, 1, Pos('/uos', ordir) - 1);
    PA_FileName := ordir + 'lib/Mac/32bit/libuos-32.dylib';
    PA_FileName := ordir + '/lib/Mac/32bit/LibSndFile-32.dylib';
    SF_FileName := ordir + '/lib/Mac/32bit/LibSndFile-32.dylib';
    sndfilename := ordir + '/sound/test.flac';
             {$ENDIF}

    //////////////////////////////////////////////////////////////////////////

    writeln('Here we go...');
    // Load the libraries
    if uos_loadlibs(PChar(uoslib_FileName), PChar(PA_FileName), PChar(SF_FileName), nil, nil) then

      writeln('Libraries are loaded...')
    else
      writeln('Libraries do not load...');

    PlayerIndex1 := 0;
    uos_CreatePlayer(PlayerIndex1);
    writeln('Player created...');

    uos_AddFromFileDef(PlayerIndex1, PChar(sndfilename));
    writeln('uos_AddFromFileDef : ok');

    uos_AddIntoDevOutDef(PlayerIndex1);
    writeln('uos_AddIntoDevOutDef : ok');
    writeln('');
    writeln('Yep, say it...');
    writeln('');
    uos_Play(PlayerIndex1);

  end;

  procedure TuosConsole.doRun;
  begin
    ConsolePlay;
    writeln('Press a key to exit...');
    readln;

    uos_unloadlibs();

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
  Application.Title := 'Library Console Player';
  Application.Run;
  Application.Free;
end.
