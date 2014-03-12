program deviceinfos_fpGUI;

 {$mode objfpc}{$H+}
  {$DEFINE UseCThreads}

uses
 //  cmem,    // uncomment it if uoslib was compiled with cmem
 {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads,
  cwstring, {$ENDIF} {$ENDIF}
  fpg_base,
  ctypes,
  SysUtils,
  uoslib_h,
  Classes,
  fpg_button,
  fpg_memo,
  fpg_widget,
  fpg_label,
  fpg_Editbtn,
  fpg_main,
  fpg_form { you can add units after this };

type

  TDevicesInfos = class(TfpgForm)
    procedure UOS_logo(Sender: TObject);
  private
    {@VFD_HEAD_BEGIN: DevicesInfos}

    Custom1: TfpgWidget;
    Labelport: TfpgLabel;
    btnLoad: TfpgButton;
    FilenameEdit1: TfpgFileNameEdit;
    btnReLoad: TfpgButton;
    Memo1: TfpgMemo;

        {@VFD_HEAD_END: DevicesInfos}
  public
    procedure AfterCreate; override;

    procedure btnLoadClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure btnReLoadClick(Sender: TObject);
    procedure CheckInfos();
  end;

   {@VFD_NEWFORM_DECL}

  {@VFD_NEWFORM_IMPL}
var
   ordir: string;
    uoslibFilename : string ;


  procedure TDevicesInfos.CheckInfos();
  begin
  memo1.Text := uos_GetInfoDeviceStr();
  end;

  procedure TDevicesInfos.CloseClick(Sender: TObject);
  begin
    if btnLoad.Enabled = False then
      uos_UnloadLibs();
  end;

  procedure TDevicesInfos.btnLoadClick(Sender: TObject);
   begin
      // Load the library
  // function uos_LoadLib(uoslibFileName: Pchar; PortAudioFileName: Pchar; SndFileFileName: Pchar; Mpg123FileName: Pchar; SoundTouchFileName: Pchar) : integer;
   if uos_LoadLibs(Pchar(uoslibFilename), Pchar(FilenameEdit1.FileName), nil, nil, nil) then
      begin
      hide;
      Height := 385;
      btnReLoad.Enabled := True;
      btnLoad.Enabled := False;
      FilenameEdit1.ReadOnly := True;
      UpdateWindowPosition;
      btnLoad.Text := 'PortAudio library is loaded...';
      CheckInfos();
      WindowPosition := wpScreenCenter;
      Show;
    end;
  end;

  procedure TDevicesInfos.btnReLoadClick(Sender: TObject);

  begin
    CheckInfos();
  end;


  procedure TDevicesInfos.AfterCreate;
  begin
  {%region 'Auto-generated GUI code' -fold}

   {@VFD_BODY_BEGIN: DevicesInfos}

   Name := 'DevicesInfos';
   SetPosition(32, 96, 972, 385);
   WindowTitle := 'Devices Infos ';
   Hint := '';
   WindowPosition := wpScreenCenter;
   BackgroundColor := clmoneygreen;
   Ondestroy := @CloseClick;

   Custom1 := TfpgWidget.Create(self);
   with Custom1 do
   begin
     Name := 'Custom1';
     SetPosition(10, 8, 115, 115);
     OnPaint := @UOS_logo;
   end;

   Labelport := TfpgLabel.Create(self);
   with Labelport do
   begin
     Name := 'Labelport';
     SetPosition(332, 28, 320, 15);
     Alignment := taCenter;
     FontDesc := '#Label1';
     Hint := '';
     Text := 'Folder + filename of PortAudio Library';
   end;

   btnLoad := TfpgButton.Create(self);
   with btnLoad do
   begin
     Name := 'btnLoad';
     SetPosition(252, 104, 470, 23);
     Text := 'Load that library';
     FontDesc := '#Label1';
     Hint := '';
     ImageName := '';
     TabOrder := 0;
     onclick := @btnLoadClick;
   end;

   FilenameEdit1 := TfpgFileNameEdit.Create(self);
   with FilenameEdit1 do
   begin
     Name := 'FilenameEdit1';
     SetPosition(324, 52, 356, 24);
     ExtraHint := '';
     FileName := '';
     Filter := '';
     InitialDir := '';
     TabOrder := 3;
   end;

   btnReLoad := TfpgButton.Create(self);
   with btnReLoad do
   begin
     Name := 'btnReLoad';
     SetPosition(430, 357, 60, 23);
     Text := 'Re-load';
     Enabled := False;
     FontDesc := '#Label1';
     Hint := '';
     ImageName := '';
     TabOrder := 6;
     onclick := @btnReLoadClick;
   end;

   Memo1 := TfpgMemo.Create(self);
   with Memo1 do
   begin
     Name := 'Memo1';
     SetPosition(8, 140, 952, 205);
     FontDesc := '#Edit1';
     Hint := '';
     TabOrder := 6;
   end;

   {@VFD_BODY_END: DevicesInfos}
   {%endregion}
    ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
    Height := 157;
             {$IFDEF Windows}
     {$if defined(cpu64)}
      uoslibfilename  := ordir + 'lib\Windows\64bit\Libuos-64.dll';
    FilenameEdit1.FileName := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
{$else}
   uoslibfilename  := ordir + 'lib\Windows\32bit\Libuos-32.dll';
    FilenameEdit1.FileName := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
   {$endif}

 {$ENDIF}

  {$IFDEF Darwin}
    opath := ordir;
    opath := copy(opath, 1, Pos('/UOS', opath) - 1);
    FilenameEdit1.FileName := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
      uoslibfilename  := opath + '/lib/Mac/32bit/Libuos-32.dylib';
            {$ENDIF}

   {$IFDEF linux}
    {$if defined(cpu64)}
      uoslibfilename  := ordir + 'lib/Linux/64bit/libuos-64.so';
    FilenameEdit1.FileName := ordir + '/lib/Linux/64bit/LibPortaudio-64.so';
{$else}
     uoslibfilename  := ordir + 'lib/Linux/32bit/libuos-32.so';
    FilenameEdit1.FileName := ordir + '/lib/Linux/32bit/LibPortaudio-32.so';
{$endif}

            {$ENDIF}
    //////////////////////////////////////////////////////////////////////////

    FilenameEdit1.Initialdir := ordir + 'lib';

   end;

  procedure TDevicesInfos.UOS_logo(Sender: TObject);
  var
    xpos, ypos, pbwidth, pbheight: integer;
    ratio: double;
  begin
    xpos := 0;
    ypos := 0;
    ratio := 1;
    pbwidth := 115;
    pbheight := 115;
    with Custom1 do
    begin
      Canvas.GradientFill(GetClientRect, clgreen, clBlack, gdVertical);
      Canvas.TextColor := clWhite;
      Canvas.DrawText(60, 20, 'UOS');
    end;
  end;

  procedure MainProc;
  var
    frm: TDevicesInfos;
  begin
    fpgApplication.Initialize;
    frm := TDevicesInfos.Create(nil);
    try
      frm.Show;
      fpgApplication.Run;
    finally
      frm.Free;
    end;
  end;

begin
    MainProc;
end.
