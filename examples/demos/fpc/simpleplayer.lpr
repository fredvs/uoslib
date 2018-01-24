program simpleplayer;

{$mode objfpc}{$h+}
 {$define usecthreads}

uses
 // cmem,    // uncoment it if uoslib was compiled with cmem
  {$ifdef unix} {$ifdef usecthreads}
  cthreads,
  cwstring, {$endif} {$endif}
  interfaces,
  forms,
  main_sp;

begin
  Application.Title:='SimplePlayer';
  application.initialize;
  application.createform(tform1, form1);
  application.run;
end.


