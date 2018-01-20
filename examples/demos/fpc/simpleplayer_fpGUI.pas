program simpleplayer_fpgui;  /// library version

{$mode objfpc}{$h+}
  {$define usecthreads}

uses
 // cmem,    // uncoment it if uoslib was compiled with cmem
   {$ifdef unix} {$ifdef usecthreads}
  cthreads,
  cwstring, {$endif} {$endif}
  sysutils,
  uoslib_h,
  ctypes,
  classes,
  fpg_button,
  fpg_widget,
  fpg_label,
  fpg_editbtn,
  fpg_radiobutton,
  fpg_trackbar,
  fpg_checkbox,
  fpg_panel,
  fpg_base,
  fpg_main,
  fpg_form { you can add units after this };

type
  tsimpleplayer = class(tfpgform)
    procedure uos_logo(sender: tobject);
  private
    {@vfd_head_begin: simpleplayer}
    custom1: tfpgwidget;
    labelport: tfpglabel;
    btnload: tfpgbutton;
    filenameedit1: tfpgfilenameedit;
    filenameedit2: tfpgfilenameedit;
    filenameedit4: tfpgfilenameedit;
    btnstart: tfpgbutton;
    btnstop: tfpgbutton;
    lposition: tfpglabel;
    labelsnf: tfpglabel;
    labelmpg: tfpglabel;
    labelst: tfpglabel;
    filenameedit3: tfpgfilenameedit;
    filenameedit5: tfpgfilenameedit;
    label1: tfpglabel;
    llength: tfpglabel;
    btnpause: tfpgbutton;
    btnresume: tfpgbutton;
    timersynchro: tfpgtimer;
    radiobutton1: tfpgradiobutton;
    radiobutton2: tfpgradiobutton;
    radiobutton3: tfpgradiobutton;
    label2: tfpglabel;
    trackbar1: tfpgtrackbar;
    trackbar2: tfpgtrackbar;
    trackbar3: tfpgtrackbar;
    label3: tfpglabel;
    label4: tfpglabel;
    label5: tfpglabel;
    vuleft: tfpgpanel;
    vuright: tfpgpanel;
    checkbox2: tfpgcheckbox;
    label6: tfpglabel;
    label7: tfpglabel;
    trackbar4: tfpgtrackbar;
    trackbar5: tfpgtrackbar;
    button1: tfpgbutton;
    {@vfd_head_end: simpleplayer}
  public
    procedure aftercreate; override;
    // constructor create(aowner: tcomponent);
    procedure btnloadclick(sender: tobject);
    procedure btncloseclick(sender: tobject;var closeit :tcloseaction);
    procedure btnstartclick(sender: tobject);
    procedure btnstopclick(sender: tobject);
    procedure btnpauseclick(sender: tobject);
    procedure btnresumeclick(sender: tobject);
    procedure btntrackonclick(sender: tobject; button: tmousebutton;
      shift: tshiftstate; const pos: tpoint);
    procedure btntrackoffclick(sender: tobject; button: tmousebutton;
      shift: tshiftstate; const pos: tpoint);
     procedure loopprocplayer1(sender: tobject);
    procedure showposition;
    procedure showlevel;
    procedure closeplayer1;
    procedure volumechange(sender: tobject; pos: integer);
    procedure changeplugset(sender: tobject);
    procedure trackchangeplugset(sender: tobject; pos: integer);
    procedure resetplugclick(sender: tobject);
  end;

  {@vfd_newform_decl}

  {@vfd_newform_impl}

var
  frm: tsimpleplayer;
  playerindex1: cardinal;

  ordir, opath: string;
  out1index, in1index, plugin1index: cardinal;
  uoslibfilename : string ;

  procedure tsimpleplayer.btntrackonclick(sender: tobject; button: tmousebutton;
    shift: tshiftstate; const pos: tpoint);
  begin
    trackbar1.tag := 1;
  end;

  procedure tsimpleplayer.changeplugset(sender: tobject);
  var
    tempo, rate: cfloat;
  begin
    if 2 - (2 * (trackbar4.position / 100)) < 0.3 then
      tempo := 0.3
    else
      tempo := 2 - (2 * (trackbar4.position / 100));
    if 2 - (2 * (trackbar5.position / 100)) < 0.3 then
      rate := 0.3
    else
      rate := 2 - (2 * (trackbar5.position / 100));

    label6.text := 'tempo: ' + floattostrf(tempo, fffixed, 15, 1);
    label7.text := 'rate: ' + floattostrf(rate, fffixed, 15, 1);

    if radiobutton1.enabled = false then   /// player1 was created
    begin
      uos_setpluginsoundtouch(playerindex1, plugin1index, tempo, rate, checkbox2.checked);
    end;
  end;

  procedure tsimpleplayer.resetplugclick(sender: tobject);
  begin
    trackbar4.position := 50;
    trackbar5.position := 50;
    if radiobutton1.enabled = false then   /// player1 was created
    begin
      uos_setpluginsoundtouch(playerindex1, plugin1index, 1, 1, checkbox2.checked);
    end;
  end;

  procedure tsimpleplayer.trackchangeplugset(sender: tobject; pos: integer);
  begin
    changeplugset(sender);
  end;

  procedure tsimpleplayer.btntrackoffclick(sender: tobject;
    button: tmousebutton; shift: tshiftstate; const pos: tpoint);
  begin
    timersynchro.enabled := false;
    uos_seek(playerindex1, in1index, trackbar1.position);
   timersynchro.enabled := true;
    trackbar1.tag := 0;
  end;

  procedure tsimpleplayer.btnresumeclick(sender: tobject);
  begin
    uos_replay(playerindex1);
    btnstart.enabled := false;
    btnstop.enabled := true;
    btnpause.enabled := true;
    btnresume.enabled := false;
    timersynchro.enabled:=true;
  end;

  procedure tsimpleplayer.btnpauseclick(sender: tobject);
  begin
     timersynchro.enabled:=false;
    uos_pause(playerindex1);
    btnstart.enabled := false;
    btnstop.enabled := true;
    btnpause.enabled := false;
    btnresume.enabled := true;
    vuleft.visible := false;
    vuright.visible := false;
    vuright.height := 0;
    vuleft.height := 0;
    vuright.updatewindowposition;
    vuleft.updatewindowposition;
  end;

 procedure tsimpleplayer.volumechange(sender: tobject; pos: integer);
  begin
    if (btnstart.enabled = false) then
      uos_setdspvolumein(playerindex1, in1index,
        (100 - trackbar2.position) / 100,
        (100 - trackbar3.position) / 100, true);
  end;

 procedure tsimpleplayer.showlevel;
  begin
    vuleft.visible := true;
    vuright.visible := true;
    if round(uos_inputgetlevelleft(playerindex1, in1index) * 128) >= 0 then
      vuleft.height := round(uos_inputgetlevelleft(playerindex1, in1index) * 128);
    if round(uos_inputgetlevelright(playerindex1, in1index) * 128) >= 0 then
      vuright.height := round(uos_inputgetlevelright(playerindex1, in1index) * 128);
    vuleft.top := 348 - vuleft.height;
    vuright.top := 348 - vuright.height;
    vuright.updatewindowposition;
    vuleft.updatewindowposition;
  end;

procedure tsimpleplayer.btncloseclick(sender: tobject; var closeit :tcloseaction);
  begin
     timersynchro.enabled:=false;
     timersynchro.free;
       sleep(100);
    if btnload.enabled = false then
      uos_unloadlibs();
      closeit := cafree;
  end;

  procedure tsimpleplayer.btnloadclick(sender: tobject);
  var
    str: string;
  begin
    // load the libraries
    // function uos_loadlib(portaudiofilename: string; sndfilefilename: string; mpg123filename: string; aacfilename ; aac2filename: string) : integer;


if (uos_loadlibs(pchar(uoslibfilename), pchar(filenameedit1.filename), pchar(filenameedit2.filename), pchar(filenameedit3.filename), nil, nil)) and
(uos_loadplugin('soundtouch', pchar(filenameedit5.filename)) > -1 ) then

   begin

      height := 403;
      btnstart.enabled := true;
      btnload.enabled := false;
      filenameedit1.readonly := true;
      filenameedit2.readonly := true;
      filenameedit3.readonly := true;
      filenameedit5.readonly := true;
      updatewindowposition;
      btnload.text :=
        'uos, portaudio, sndfile, mpg123 and soundtouch libraries are loaded...';

       windowtitle := 'simple player.    uos version ' + inttostr(uos_getversion());
       windowposition := wpscreencenter;
      show;
    end;
  end;

  procedure tsimpleplayer.closeplayer1;
  begin
    with frm do begin
  timersynchro.enabled:=false;
 // sleep(150);
    trackbar1.visible := false;
    lposition.visible := false;

      btnstart.visible := false;
    btnstop.visible := false;
    btnpause.visible := false;
    btnresume.visible := false;

     radiobutton1.visible := false;
    radiobutton2.visible := false;
    radiobutton3.visible := false;

    radiobutton1.enabled := true;
    radiobutton2.enabled := true;
    radiobutton3.enabled := true;
    vuleft.visible := false;
    vuright.visible := false;
    vuright.height := 0;
    vuleft.height := 0;
    vuright.updatewindowposition;
    vuleft.updatewindowposition;
    btnstart.enabled := true;
    btnstop.enabled := false;
    btnpause.enabled := false;
    btnresume.enabled := false;
    trackbar1.position := 0;
    lposition.text := '00:00:00.000';

       btnstart.visible := true;
    btnstop.visible := true;
    btnpause.visible := true;
    btnresume.visible := true;

     radiobutton1.visible := true;
    radiobutton2.visible := true;
    radiobutton3.visible := true;

    trackbar1.visible := true;
    lposition.visible := true;
    frm.show;

    end;
  end;

  procedure tsimpleplayer.btnstopclick(sender: tobject);
  begin
    timersynchro.enabled:=false;
    uos_stop(playerindex1);
    closeplayer1;
  end;

  procedure tsimpleplayer.btnstartclick(sender: tobject);
  var
    samformat: shortint;
    temptime: ttime;
    ho, mi, se, ms: word;
  begin

    if radiobutton1.checked = true then
      samformat := 0;
    if radiobutton2.checked = true then
      samformat := 1;
    if radiobutton3.checked = true then
      samformat := 2;

    radiobutton1.enabled := false;
    radiobutton2.enabled := false;
    radiobutton3.enabled := false;

    playerindex1 := 0;
    // playerindex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // if playerindex exists already, it will be overwritten...

    uos_createplayer(playerindex1);
    //// create the player.
    //// playerindex : from 0 to what your computer can do !
    //// if playerindex exists already, it will be overwriten...

    // in1index := uos_addfromfile(playerindex1, edit4.text);
    //// add input from audio file with default parameters
    in1index := uos_addfromfile(playerindex1, pchar(filenameedit4.filename), -1, samformat, -1);
    //// add input from audio file with custom parameters
    ////////// filename : filename of audio file
    //////////// playerindex : index of a existing player
    ////////// outputindex : outputindex of existing output // -1 : all output, -2: no output, other integer : existing output)
    ////////// sampleformat : -1 default : int16 : (0: float32, 1:int32, 2:int16) sampleformat of input can be <= sampleformat float of output
    //////////// framescount : default : -1 (65536)
    //  result : -1 nothing created, otherwise input index in array


    // out1index := uos_addintodevout(playerindex1) ;
    //// add a output into device with default parameters
    out1index := uos_addintodevout(playerindex1, -1, -1,  uos_inputgetsamplerate(playerindex1,in1index) , -1, samformat, -1);
    //// add a output into device with custom parameters
    //////////// playerindex : index of a existing player
    //////////// device ( -1 is default output device )
    //////////// latency  ( -1 is latency suggested ) )
    //////////// samplerate : delault : -1 (44100)
    //////////// channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
    //////////// sampleformat : -1 default : int16 : (0: float32, 1:int32, 2:int16)
    //////////// framescount : default : -1 (65536)
    //  result : -1 nothing created, otherwise output index in array

    uos_inputsetlevelenable(playerindex1, in1index, 2) ;
    ///// set calculation of level/volume to true (usefull for showvolume procedure)

     uos_inputsetpositionenable(playerindex1, in1index, 1) ;
    ///// set calculation of level/volume to true (usefull for showvolume procedure)


    uos_adddspvolumein(playerindex1, in1index, 1, 1);
    ///// dsp volume changer
    ////////// playerindex1 : index of a existing player
    ////////// in1index : inputindex of a existing input
    ////////// volleft : left volume
    ////////// volright : right volume

    uos_setdspvolumein(playerindex1, in1index,
      (100 - trackbar2.position) / 100,
      (100 - trackbar3.position) / 100, true);
    /// set volume
    ////////// playerindex1 : index of a existing player
    ////////// in1index : inputindex of a existing input
    ////////// volleft : left volume
    ////////// volright : right volume
    ////////// enable : enabled

    plugin1index := uos_addplugin(playerindex1, 'soundtouch', -1, -1);
    ///// add soundtouch plugin with default samplerate(44100) / channels(2 = stereo)

    changeplugset(self); //// custom procedure to change plugin settings

    trackbar1.max := uos_inputlength(playerindex1, in1index);
    ////// length of input in samples

    temptime := uos_inputlengthtime(playerindex1, in1index);
    ////// length of input in time

    decodetime(temptime, ho, mi, se, ms);

    llength.text := format('%d:%d:%d.%d', [ho, mi, se, ms]);

    trackbar1.position := 0;
    trackbar1.enabled := true;
    btnstart.enabled := false;
    btnstop.enabled := true;
    btnpause.enabled := true;
    btnresume.enabled := false;

    uos_endproc(playerindex1,@closeplayer1);

    uos_play(playerindex1);  /////// everything is ready, here we are, lets play it...
   timersynchro.enabled := true;

  end;

  procedure tsimpleplayer.showposition;
  var
    temptime: ttime;
    ho, mi, se, ms: word;
  begin
    if (trackbar1.tag = 0) then
    begin
      if uos_inputposition(playerindex1, in1index) > 0 then
      begin
        trackbar1.position := uos_inputposition(playerindex1, in1index);
        temptime := uos_inputpositiontime(playerindex1, in1index);
        ////// length of input in time
        decodetime(temptime, ho, mi, se, ms);
        lposition.text := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
      end;
    end;
  end;

procedure tsimpleplayer.loopprocplayer1(sender: tobject);
begin
  timersynchro.enabled:=false;

  uos_checksynchro() ;

  if uos_getstatus(playerindex1) = 1 then
   begin
     showposition;
     showlevel;
 timersynchro.enabled:=true;
   end else  fpgapplication.ProcessMessages;
end;

  procedure tsimpleplayer.aftercreate;
  begin
    {%region 'auto-generated gui code' -fold}

    {@vfd_body_begin: simpleplayer}
  name := 'simpleplayer';
  setposition(467, 0, 502, 403);
  windowtitle := 'simple player ';
  hint := '';
  windowposition := wpscreencenter;
  backgroundcolor := clmoneygreen;
  onclose := @btncloseclick;

  custom1 := tfpgwidget.create(self);
  with custom1 do
  begin
    name := 'custom1';
    setposition(10, 8, 115, 155);
    onpaint := @uos_logo;
  end;

  labelport := tfpglabel.create(self);
  with labelport do
  begin
    name := 'labelport';
    setposition(136, 0, 320, 15);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'folder + filename of portaudio library';
  end;

  btnload := tfpgbutton.create(self);
  with btnload do
  begin
    name := 'btnload';
    setposition(16, 168, 476, 23);
    text := 'load that libraries';
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 0;
    onclick := @btnloadclick;
  end;

  filenameedit1 := tfpgfilenameedit.create(self);
  with filenameedit1 do
  begin
    name := 'filenameedit1';
    setposition(136, 16, 356, 24);
    extrahint := '';
    filename := '';
    filter := '';
    initialdir := '';
    taborder := 3;
  end;

  filenameedit2 := tfpgfilenameedit.create(self);
  with filenameedit2 do
  begin
    name := 'filenameedit2';
    setposition(136, 56, 356, 24);
    extrahint := '';
    filename := '';
    filter := '';
    initialdir := '';
    taborder := 4;
  end;

  filenameedit4 := tfpgfilenameedit.create(self);
  with filenameedit4 do
  begin
    name := 'filenameedit4';
    setposition(132, 200, 360, 24);
    extrahint := '';
    filename := '';
    filter := '';
    initialdir := '';
    taborder := 5;
  end;

  btnstart := tfpgbutton.create(self);
  with btnstart do
  begin
    name := 'btnstart';
    setposition(136, 372, 44, 23);
    text := 'play';
    enabled := false;
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 6;
    onclick := @btnstartclick;
  end;

  btnstop := tfpgbutton.create(self);
  with btnstop do
  begin
    name := 'btnstop';
    setposition(360, 372, 80, 23);
    text := 'stop';
    enabled := false;
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 7;
    onclick := @btnstopclick;
  end;

  lposition := tfpglabel.create(self);
  with lposition do
  begin
    name := 'lposition';
    setposition(224, 265, 84, 19);
    alignment := tacenter;
    fontdesc := '#label2';
    hint := '';
    text := '00:00:00.000';
  end;

  labelsnf := tfpglabel.create(self);
  with labelsnf do
  begin
    name := 'labelsnf';
    setposition(140, 40, 316, 15);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'folder + filename of sndfile library';
  end;

  labelmpg := tfpglabel.create(self);
  with labelmpg do
  begin
    name := 'labelmpg';
    setposition(136, 80, 316, 15);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'folder + filename of mpg123 library';
  end;

  labelst := tfpglabel.create(self);
  with labelst do
  begin
    name := 'labelst';
    setposition(136, 120, 316, 15);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'folder + filename of soundtouch library';
  end;

  filenameedit3 := tfpgfilenameedit.create(self);
  with filenameedit3 do
  begin
    name := 'filenameedit3';
    setposition(136, 96, 356, 24);
    extrahint := '';
    filename := '';
    filter := '';
    initialdir := '';
    taborder := 12;
  end;

  filenameedit5 := tfpgfilenameedit.create(self);
  with filenameedit5 do
  begin
    name := 'filenameedit5';
    setposition(136, 136, 356, 24);
    extrahint := '';
    filename := '';
    filter := '';
    initialdir := '';
    taborder := 12;
  end;

  label1 := tfpglabel.create(self);
  with label1 do
  begin
    name := 'label1';
    setposition(308, 265, 12, 15);
    fontdesc := '#label1';
    hint := '';
    text := '/';
  end;

  llength := tfpglabel.create(self);
  with llength do
  begin
    name := 'llength';
    setposition(316, 265, 80, 15);
    fontdesc := '#label2';
    hint := '';
    text := '00:00:00.000';
  end;

  btnpause := tfpgbutton.create(self);
  with btnpause do
  begin
    name := 'btnpause';
    setposition(200, 372, 52, 23);
    text := 'pause';
    enabled := false;
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 15;
    onclick := @btnpauseclick;
  end;

  btnresume := tfpgbutton.create(self);
  with btnresume do
  begin
    name := 'btnresume';
    setposition(272, 372, 64, 23);
    text := 'resume';
    enabled := false;
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 16;
    onclick := @btnresumeclick;
  end;

  radiobutton1 := tfpgradiobutton.create(self);
  with radiobutton1 do
  begin
    name := 'radiobutton1';
    setposition(128, 300, 96, 19);
    checked := true;
    fontdesc := '#label1';
    groupindex := 0;
    hint := '';
    taborder := 18;
    text := 'float 32 bit';
  end;

  radiobutton2 := tfpgradiobutton.create(self);
  with radiobutton2 do
  begin
    name := 'radiobutton2';
    setposition(128, 316, 100, 19);
    fontdesc := '#label1';
    groupindex := 0;
    hint := '';
    taborder := 19;
    text := 'int 32 bit';
  end;

  radiobutton3 := tfpgradiobutton.create(self);
  with radiobutton3 do
  begin
    name := 'radiobutton3';
    setposition(128, 334, 100, 19);
    fontdesc := '#label1';
    groupindex := 0;
    hint := '';
    taborder := 20;
    text := 'int 16 bit';
  end;

  label2 := tfpglabel.create(self);
  with label2 do
  begin
    name := 'label2';
    setposition(116, 284, 104, 15);
    fontdesc := '#label2';
    hint := '';
    text := 'sample format';
  end;

  trackbar1 := tfpgtrackbar.create(self);
  with trackbar1 do
  begin
    name := 'trackbar1';
    setposition(132, 232, 356, 30);
    hint := '';
    taborder := 22;
    trackbar1.onmousedown := @btntrackonclick;
    trackbar1.onmouseup := @btntrackoffclick;
  end;

  trackbar2 := tfpgtrackbar.create(self);
  with trackbar2 do
  begin
    name := 'trackbar2';
    setposition(4, 216, 32, 134);
    hint := '';
    orientation := orvertical;
    taborder := 23;
    onchange := @volumechange;
  end;

  trackbar3 := tfpgtrackbar.create(self);
  with trackbar3 do
  begin
    name := 'trackbar3';
    setposition(72, 216, 28, 134);
    hint := '';
    orientation := orvertical;
    taborder := 24;
    onchange := @volumechange;
  end;

  label3 := tfpglabel.create(self);
  with label3 do
  begin
    name := 'label3';
    setposition(12, 196, 84, 15);
    alignment := tacenter;
    fontdesc := '#label2';
    hint := '';
    text := 'volume';
  end;

  label4 := tfpglabel.create(self);
  with label4 do
  begin
    name := 'label4';
    setposition(0, 348, 40, 15);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'left';
  end;

  label5 := tfpglabel.create(self);
  with label5 do
  begin
    name := 'label5';
    setposition(68, 348, 36, 19);
    alignment := tacenter;
    fontdesc := '#label1';
    hint := '';
    text := 'right';
  end;

  vuleft := tfpgpanel.create(self);
  with vuleft do
  begin
    name := 'vuleft';
    setposition(40, 220, 8, 128);
    backgroundcolor := tfpgcolor($00d51d);
    fontdesc := '#label1';
    hint := '';
    style := bsflat;
    text := '';
  end;

  vuright := tfpgpanel.create(self);
  with vuright do
  begin
    name := 'vuright';
    setposition(60, 220, 8, 128);
    backgroundcolor := tfpgcolor($1dd523);
    fontdesc := '#label1';
    hint := '';
    style := bsflat;
    text := '';
  end;

  checkbox2 := tfpgcheckbox.create(self);
  with checkbox2 do
  begin
    name := 'checkbox2';
    setposition(268, 284, 184, 19);
    fontdesc := '#label1';
    hint := '';
    taborder := 32;
    text := 'enable soundtouch plugin';
    onchange := @changeplugset;
  end;

  label6 := tfpglabel.create(self);
  with label6 do
  begin
    name := 'label6';
    setposition(272, 312, 80, 19);
    fontdesc := '#label1';
    hint := '';
    text := 'tempo: 1.0';
  end;

  label7 := tfpglabel.create(self);
  with label7 do
  begin
    name := 'label7';
    setposition(380, 312, 80, 15);
    fontdesc := '#label1';
    hint := '';
    text := 'rate: 1.0';
  end;

  trackbar4 := tfpgtrackbar.create(self);
  with trackbar4 do
  begin
    name := 'trackbar4';
    setposition(344, 308, 28, 54);
    hint := '';
    orientation := orvertical;
    position := 50;
    position := 50;
    taborder := 35;
    onchange := @trackchangeplugset;
  end;

  trackbar5 := tfpgtrackbar.create(self);
  with trackbar5 do
  begin
    name := 'trackbar5';
    setposition(440, 308, 28, 54);
    hint := '';
    orientation := orvertical;
    position := 50;
    position := 50;
    taborder := 36;
    onchange := @trackchangeplugset;
  end;

  button1 := tfpgbutton.create(self);
  with button1 do
  begin
    name := 'button1';
    setposition(260, 336, 60, 23);
    text := 'reset';
    fontdesc := '#label1';
    hint := '';
    imagename := '';
    taborder := 37;
    onclick := @resetplugclick;
  end;

  {@vfd_body_end: simpleplayer}
    {%endregion}

    //////////////////////

    ordir := includetrailingbackslash(extractfilepath(paramstr(0)));
    radiobutton1.checked := true;
    height := 197;
     timersynchro := tfpgtimer.create(50000);
     timersynchro.enabled := false;
     timersynchro.ontimer := @loopprocplayer1;
     timersynchro.interval := 100;

             {$ifdef windows}
     {$if defined(cpu64)}
       uoslibfilename  := ordir + 'uoslib.dll';
    filenameedit1.filename := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
    filenameedit2.filename := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
    filenameedit3.filename := ordir + 'lib\Windows\64bit\LibMpg123-64.dll';
    filenameedit5.filename := ordir + 'lib\Windows\64bit\libSoundTouch-64.dll';
{$else}
        uoslibfilename  := ordir + 'uoslib.dll';
    filenameedit1.filename := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
    filenameedit2.filename := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
    filenameedit3.filename := ordir + 'lib\Windows\32bit\LibMpg123-32.dll';
    filenameedit5.filename := ordir + 'lib\Windows\32bit\libSoundTouch-32.dll';
   {$endif}
    filenameedit4.filename := ordir + 'sound\test.mp3';
 {$endif}

  {$ifdef darwin}
    opath := ordir;
    opath := copy(opath, 1, pos('/uos', opath) - 1);
    uoslibfilename  := opath + '/lib/mac/32bit/libuos-32.dylib';
    filenameedit1.filename := opath + '/lib/Mac/32bit/LibPortaudio-32.dylib';
    filenameedit2.filename := opath + '/lib/Mac/32bit/LibSndFile-32.dylib';
    filenameedit3.filename := opath + '/lib/Mac/32bit/LibMpg123-32.dylib';
    filenameedit5.filename := opath + '/lib/Mac/32bit/libSoundTouch-32.dylib';
    filenameedit4.filename := opath + 'sound/test.mp3';
            {$endif}

   {$ifdef linux}
    {$if defined(cpu64)}
    uoslibfilename  := ordir + 'libuoslib.so';
    filenameedit1.filename := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
    filenameedit2.filename := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
    filenameedit3.filename := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
    filenameedit5.filename := ordir + 'lib/Linux/64bit/libSoundTouch-64.so';

{$else}
    uoslibfilename  := ordir + 'libuoslib.so';
    filenameedit1.filename := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
    filenameedit2.filename := ordir + 'lib/Linux/32bit/LibSndFile-32.so';
    filenameedit3.filename := ordir + 'lib/Linux/32bit/LibMpg123-32.so';
    filenameedit5.filename := ordir + 'lib/Linux/32bit/libSoundTouch-32.so';
{$endif}
    filenameedit4.filename := ordir + 'sound/test.mp3';
            {$endif}

    filenameedit4.initialdir := ordir + 'sound';
    filenameedit1.initialdir := ordir + 'lib';
    filenameedit2.initialdir := ordir + 'lib';
    filenameedit3.initialdir := ordir + 'lib';
    filenameedit5.initialdir := ordir + 'lib';

    vuleft.visible := false;
    vuright.visible := false;
    vuleft.height := 0;
    vuright.height := 0;
    vuright.updatewindowposition;
    vuleft.updatewindowposition;
  end;

  procedure tsimpleplayer.uos_logo(sender: tobject);
  var
    xpos, ypos, pbwidth, pbheight: integer;
    ratio: double;
  begin
    xpos := 0;
    ypos := 0;
    ratio := 1;
    pbwidth := 115;
    pbheight := 115;
    with custom1 do
    begin
      canvas.gradientfill(getclientrect, clgreen, clblack, gdvertical);
      canvas.textcolor := clwhite;
      canvas.drawtext(60, 20, 'uos');
    end;
  end;

  procedure mainproc;

  begin
    fpgapplication.initialize;
    frm := tsimpleplayer.create(nil);
    try
      frm.show;
      fpgapplication.run;
    finally
      frm.free;
    end;
  end;

begin
  mainproc;
end.
