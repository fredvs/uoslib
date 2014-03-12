
/////////////////// Demo how to use Library United Openlib of Sound ////////////////////


unit main_di;

{$mode objfpc}{$H+}

interface

uses
  uoslib_h, Forms, Dialogs, SysUtils, Graphics,
  StdCtrls, ExtCtrls, Classes;

type
  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    PaintBox1: TPaintBox;
    Shape1: TShape;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure CheckInfos();
  private
    { private declarations }
  public
    { public declarations }
  end;


procedure uos_logo();

var
  Form1: TForm1;
  BufferBMP: TBitmap;
  uoslibFilename : string ;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormActivate(Sender: TObject);
{$IFDEF Darwin}
var
  opath: string;
            {$ENDIF}
begin
  uos_logo();
      {$IFDEF Windows}
     {$if defined(cpu64)}
      uoslibfilename  := application.Location + 'lib\Windows\64bit\Libuos-64.dll';
  edit1.Text := application.Location + 'lib\Windows\64bit\LibPortaudio-64.dll';
{$else}
    uoslibfilename  := application.Location + 'lib\Windows\32bit\Libuos-32.dll';
  edit1.Text := application.Location + 'lib\Windows\32bit\LibPortaudio-32.dll';
   {$endif}
 {$ENDIF}

  {$IFDEF Darwin}
  opath := application.Location;
  opath := copy(opath, 1, Pos('/uos', opath) - 1);
  edit1.Text := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
   uoslibfilename  := opath + '/lib/Mac/32bit/Libuos-32.dylib';
            {$ENDIF}

   {$IFDEF linux}
    {$if defined(cpu64)}
     uoslibfilename  := application.Location + 'lib/Linux/64bit/libuos-64.so';
  edit1.Text := application.Location + 'lib/Linux/64bit/LibPortaudio-64.so';
{$else}
   uoslibfilename  := application.Location + 'lib/Linux/32bit/libuos-32.so';
  edit1.Text := application.Location + 'lib/Linux/32bit/LibPortaudio-32.so';
{$endif}

            {$ENDIF}
  //////////////////////////////////////////////////////////////////////////

end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.Draw(0, 0, BufferBMP);
end;

procedure TForm1.CheckInfos();
begin
memo1.Text := uos_GetInfoDeviceStr();    ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Load the library
  // function uos_LoadLibs(uoslibFileName: Pchar; PortAudioFileName: Pchar; SndFileFileName: Pchar; Mpg123FileName: Pchar; SoundTouchFileName: Pchar) : integer;

  if uos_LoadLibs(Pchar(uoslibFilename), Pchar(edit1.Text), nil, nil, nil)  then
  begin
    form1.hide;
    button1.Caption := 'uos and PortAudio are loaded...';
    button1.Enabled := False;
    edit1.ReadOnly := True;

    CheckInfos();
    form1.Height := 388;
    form1.Position := poScreenCenter;
    button2.Show;
    form1.Show;
  end
  else MessageDlg('A library do not load...', mtWarning, [mbYes], 0);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CheckInfos();
end;


procedure uos_logo();
var
  xpos, ypos: integer;
  ratio: double;
begin
  xpos := 0;
  ypos := 0;
  ratio := 1;
  BufferBMP := TBitmap.Create;
  with form1 do
  begin
    form1.PaintBox1.Parent.DoubleBuffered := True;
    PaintBox1.Height := round(ratio * 116);
    PaintBox1.Width := round(ratio * 100);
    BufferBMP.Height := PaintBox1.Height;
    BufferBMP.Width := PaintBox1.Width;
    BufferBMP.Canvas.AntialiasingMode := amOn;
    BufferBMP.Canvas.Pen.Width := round(ratio * 6);
    BufferBMP.Canvas.brush.Color := clmoneygreen;
    BufferBMP.Canvas.FillRect(0, 0, PaintBox1.Width, PaintBox1.Height);
    BufferBMP.Canvas.Pen.Color := clblack;
    BufferBMP.Canvas.brush.Color := $70FF70;
    BufferBMP.Canvas.Ellipse(round(ratio * (22) + xpos),
      round(ratio * (30) + ypos), round(ratio * (72) + xpos),
      round(ratio * (80) + ypos));
    BufferBMP.Canvas.brush.Color := clmoneygreen;
    BufferBMP.Canvas.Arc(round(ratio * (34) + xpos), round(ratio * (8) + ypos),
      round(ratio * (58) + xpos), round(ratio * (32) + ypos), round(ratio * (58) + xpos),
      round(ratio * (20) + ypos), round(ratio * (46) + xpos),
      round(ratio * (32) + xpos));
    BufferBMP.Canvas.Arc(round(ratio * (34) + xpos), round(ratio * (32) + ypos),
      round(ratio * (58) + xpos), round(ratio * (60) + ypos), round(ratio * (34) + xpos),
      round(ratio * (48) + ypos), round(ratio * (46) + xpos),
      round(ratio * (32) + ypos));
    BufferBMP.Canvas.Arc(round(ratio * (-28) + xpos), round(ratio * (18) + ypos),
      round(ratio * (23) + xpos), round(ratio * (80) + ypos), round(ratio * (20) + xpos),
      round(ratio * (50) + ypos), round(ratio * (3) + xpos), round(ratio * (38) + ypos));
    BufferBMP.Canvas.Arc(round(ratio * (70) + xpos), round(ratio * (18) + ypos),
      round(ratio * (122) + xpos), round(ratio * (80) + ypos),
      round(ratio * (90 - xpos)),
      round(ratio * (38) + ypos), round(ratio * (72) + xpos),
      round(ratio * (50) + ypos));
    BufferBMP.Canvas.Font.Name := 'Arial';
    BufferBMP.Canvas.Font.Size := round(ratio * 10);
    BufferBMP.Canvas.TextOut(round(ratio * (4) + xpos),
      round(ratio * (83) + ypos), 'United Openlib');
    BufferBMP.Canvas.Font.Size := round(ratio * 7);
    BufferBMP.Canvas.TextOut(round(ratio * (20) + xpos),
      round(ratio * (101) + ypos), 'of');
    BufferBMP.Canvas.Font.Size := round(ratio * 10);
    BufferBMP.Canvas.TextOut(round(ratio * (32) + xpos),
      round(ratio * (98) + ypos), 'Sound');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  Form1.Height := 150;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if button1.Enabled = False then
    uos_UnloadLibs();
end;

end.
