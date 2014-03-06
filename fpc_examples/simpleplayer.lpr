program simpleplayer;

{$mode objfpc}{$H+}
 {$DEFINE UseCThreads}

uses
  //  cmem,    // uncoment it if uoslib was compiled with cmem
  {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads,
  cwstring, {$ENDIF} {$ENDIF}
  Interfaces,
  Forms,
  main_sp;

{$R *.res}

begin
  Application.Title := 'SimplePlayer';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


