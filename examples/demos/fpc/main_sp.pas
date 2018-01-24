
/////////////////// demo how to use library united openlib of sound ////////////////////

unit main_sp;

{$mode objfpc}{$h+}

interface

uses
  uoslib_h, forms, dialogs, sysutils, graphics, ctypes,
  stdctrls, comctrls, extctrls, classes, controls;

type
  { tform1 }
  tform1 = class(tform)
    button1: tbutton;
    button2: tbutton;
    button3: tbutton;
    button4: tbutton;
    button5: tbutton;
    button6: tbutton;
    button7: tbutton;
    checkbox2: tcheckbox;
    edit1: tedit;
    edit2: tedit;
    edit3: tedit;
    edit4: tedit;
    edit5: tedit;
    label1: tlabel;
    label2: tlabel;
    label3: tlabel;
    label4: tlabel;
    label5: tlabel;
    label6: tlabel;
    label7: tlabel;
    label9: tlabel;
    llength: tlabel;
    lposition: tlabel;
    label8: tlabel;
    opendialog1: topendialog;
    paintbox1: tpaintbox;
    radiobutton1: tradiobutton;
    radiobutton2: tradiobutton;
    radiobutton3: tradiobutton;
    radiogroup1: tradiogroup;
    shape1: tshape;
    shaperight: tshape;
    shapeleft: tshape;
    timer1: ttimer;
    trackbar2: ttrackbar;
    trackbar1: ttrackbar;
    trackbar3: ttrackbar;
    trackbar4: ttrackbar;
    trackbar5: ttrackbar;
    procedure button1click(sender: tobject);
    procedure button2click(sender: tobject);
    procedure button3click(sender: tobject);
    procedure button4click(sender: tobject);
    procedure button5click(sender: tobject);
    procedure button6click(sender: tobject);
    procedure formactivate(sender: tobject);
    procedure formclosequery(sender: tobject; var canclose: boolean);
    procedure formcreate(sender: tobject);
    procedure paintbox1paint(sender: tobject);
    procedure timer1timer(sender: tobject);
    procedure trackbar1change(sender: tobject);
    procedure trackbar2mousedown(sender: tobject; button: tmousebutton;
      shift: tshiftstate; x, y: integer);
    procedure trackbar2mouseup(sender: tobject; button: tmousebutton;
      shift: tshiftstate; x, y: integer);
    procedure closeplayer1;
    procedure loopprocplayer1;
    procedure showposition;
    procedure showlevel;
    procedure changeplugset(sender: tobject);
    procedure resetplugclick(sender: tobject);
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure uos_logo();

var
  form1: tform1;
  bufferbmp: tbitmap;
  playerindex1: integer;
  out1index, in1index, dsp1index, plugin1index: integer;
  uoslibfilename : string ;

implementation

{$r *.lfm}

{ tform1 }

procedure tform1.changeplugset(sender: tobject);
var
  tempo, rate: cfloat;
begin

  if (2 * (trackbar4.position / 100)) < 0.3 then
    tempo := 0.3
  else
    tempo := (2 * (trackbar4.position / 100));
  if (2 * (trackbar5.position / 100)) < 0.3 then
    rate := 0.3
  else
    rate := (2 * (trackbar5.position / 100));

  label7.caption := 'tempo: ' + floattostrf(tempo, fffixed, 15, 1);
  label9.caption := 'rate: ' + floattostrf(rate, fffixed, 15, 1);

  if radiogroup1.enabled = false then   /// player1 was created
  begin
    uos_setpluginsoundtouch(playerindex1, plugin1index, tempo, rate, checkbox2.checked);
  end;
end;

procedure tform1.resetplugclick(sender: tobject);
begin
  trackbar4.position := 50;
  trackbar5.position := 50;
  if radiogroup1.enabled = false then   /// player1 was created
  begin
    uos_setpluginsoundtouch(playerindex1, plugin1index, 1, 1, checkbox2.checked);
  end;
end;

procedure tform1.closeplayer1;
begin
  form1.button3.enabled := true;
  form1.button4.enabled := false;
  form1.button5.enabled := false;
  form1.button6.enabled := false;
  form1.trackbar2.enabled := false;
  form1.radiogroup1.enabled := true;
  form1.trackbar2.position := 0;
  form1.shapeleft.height := 0;
  form1.shaperight.height := 0;
  form1.shapeleft.top := 280;
  form1.shaperight.top := 280;
  form1.lposition.caption := '00:00:00.000';
    application.processmessages;
end;

procedure tform1.formactivate(sender: tobject);
var
 ordir: string;
{$ifdef darwin}
  opath: string;
{$endif}
begin
  ordir := application.location;
  uos_logo();
             {$ifdef windows}
     {$if defined(cpu64)}
  uoslibfilename  := ordir + 'uoslib.dll';
  edit1.text := ordir + 'lib\windows\64bit\LibPortaudio-64.dll';
  edit2.text := ordir + 'lib\windows\64bit\libsndfile-64.dll';
  edit3.text := ordir + 'lib\windows\64bit\libmpg123-64.dll';
  edit5.text := ordir + 'lib\windows\64bit\plugin\libsoundtouch-64.dll';
{$else}
   uoslibfilename  := ordir + 'uoslib.dll';
  edit1.text := ordir + 'lib\windows\32bit\LibPortaudio-32.dll';
  edit2.text := ordir + 'lib\windows\32bit\libsndfile-32.dll';
  edit3.text := ordir + 'lib\windows\32bit\libmpg123-32.dll';
  edit5.text := ordir + 'lib\windows\32bit\plugin\libsoundtouch-32.dll';
   {$endif}
  edit4.text := ordir + 'sound\test.mp3';
 {$endif}

  {$ifdef darwin}
  opath := ordir;
  opath := copy(opath, 1, pos('/uos', opath) - 1);
  uoslibfilename  := opath + '/lib/mac/32bit/libuos-32.dylib';
  edit1.text := opath + '/lib/mac/32bit/libportaudio-32.dylib';
  edit2.text := opath + '/lib/mac/32bit/libsndfile-32.dylib';
  edit3.text := opath + '/lib/mac/32bit/libmpg123-32.dylib';
  edit5.text := opath + '/lib/mac/32bit/plugin/libsoundtouch-32.dylib';
  edit4.text := opath + 'sound/test.mp3';
            {$endif}

   {$ifdef linux}
    {$if defined(cpu64)}
    uoslibfilename  := ordir + 'libuos.so';
     Edit1.Text := ordir + 'lib/Linux/64bit/LibPortaudio-64.so';
     Edit2.Text := ordir + 'lib/Linux/64bit/LibSndFile-64.so';
     Edit3.Text := ordir + 'lib/Linux/64bit/LibMpg123-64.so';
 Edit5.Text := ordir + 'lib/Linux/64bit/plugin/LibSoundTouch-64.so';
{$else}
  uoslibfilename  := ordir + 'libuos.so';
  edit1.text := ordir + 'lib/linux/32bit/LibPortaudio-32.so';
  edit2.text := ordir + 'lib/linux/32bit/LibSndFile-32.so';
  edit3.text := ordir + 'lib/linux/32bit/LibMpg123-32.so';
  edit5.text := ordir + 'lib/linux/32bit/plugin/LibSoundTouch-32.so';
{$endif}
  edit4.text := ordir + 'sound/test.mp3';
            {$endif}

  opendialog1.initialdir := application.location + 'sound';

end;

procedure tform1.formclosequery(sender: tobject; var canclose: boolean);
begin
   timer1.enabled:=false;
   sleep(100);
   if button1.enabled = false then
    uos_unloadlibs();
   canclose := true;
end;

procedure tform1.paintbox1paint(sender: tobject);
begin
  paintbox1.canvas.draw(0, 0, bufferbmp);
end;

procedure tform1.timer1timer(sender: tobject);
begin
  timer1.enabled:=false;

   uos_checksynchro() ;

 if uos_getstatus(playerindex1) = 1 then
   begin
 loopprocplayer1;
 timer1.enabled:=true;
   end else  application.ProcessMessages;
end;

procedure tform1.trackbar1change(sender: tobject);
begin
  if (button3.enabled = false) then
    uos_inputsetdspvolume(playerindex1, in1index, trackbar1.position / 100,
      trackbar3.position / 100, true);
end;

procedure tform1.trackbar2mousedown(sender: tobject; button: tmousebutton;
  shift: tshiftstate; x, y: integer);
begin
  trackbar2.tag := 1;
end;

procedure tform1.trackbar2mouseup(sender: tobject; button: tmousebutton;
  shift: tshiftstate; x, y: integer);
begin
  timer1.enabled:=false;
  uos_inputseek(playerindex1, in1index, trackbar2.position);
  timer1.enabled:=true;
  trackbar2.tag := 0;
end;

procedure tform1.button1click(sender: tobject);
begin
  // load the libraries
  // function uos_loadlib(portaudiofilename: string; sndfilefilename: string; mpg123filename: string; soundtouchfilename: string) : integer;
  // you may load one or more libraries . when you want... :
if (uos_loadlibs(pchar(uoslibfilename), pchar(edit1.text), pchar(edit2.text), pchar(edit3.text),
 nil, nil,nil))
  and (uos_loadplugin('soundtouch', pchar(edit5.text)) > -1 )
  then
  begin
    hide;
    button1.caption :=
      'uos, portaudio, sndfile, mpg123 and soundtouch ibraries are loaded...';
    button1.enabled := false;
    edit1.readonly := true;
    edit2.readonly := true;
    edit3.readonly := true;
    edit5.readonly := true;
    height := 418;
    position := poscreencenter;
    caption := 'simple player.    uos version ' + inttostr(uos_getversion());
    show;
  end else MessageDlg('A Library does not load...', mtWarning, [mbYes], 0);
end;

procedure tform1.button5click(sender: tobject);
begin
  timer1.enabled:=false;
  uos_pause(playerindex1);
  button4.enabled := true;
  button5.enabled := false;
  form1.shapeleft.height := 0;
  form1.shaperight.height := 0;
  form1.shapeleft.top := 280;
  form1.shaperight.top := 280;
end;

procedure tform1.button4click(sender: tobject);
begin
  button4.enabled := false;
  button5.enabled := true;
  button6.enabled := true;
  application.processmessages;
  uos_replay(playerindex1);
   timer1.enabled:=true;
end;

procedure tform1.button3click(sender: tobject);
var
  samformat: shortint;
  temptime: ttime;
  ho, mi, se, ms: word;
begin

  if fileexists(edit4.text) then
  begin

    playerindex1 := 0;
    // playerindex : from 0 to what your computer can do ! (depends of ram, cpu, ...)
    // if playerindex exists already, it will be overwritten...

    if radiobutton1.checked = true then
      samformat := 0;
    if radiobutton2.checked = true then
      samformat := 1;
    if radiobutton3.checked = true then
      samformat := 2;

    radiogroup1.enabled := false;

    uos_createplayer(PlayerIndex1);
       //// create the player.
    //// playerindex : from 0 to what your computer can do !
    //// if playerindex exists already, it will be overwriten...

   in1index := uos_addfromfile(playerindex1, pchar(edit4.text), -1, samformat, -1);
        //// add input from audio file with custom parameters
    ////////// filename : filename of audio file
    //////////// playerindex : index of a existing player
    ////////// outputindex : outputindex of existing output // -1 : all output, -2: no output, other integer : existing output)
    ////////// sampleformat : -1 default : int16 : (0: float32, 1:int32, 2:int16) sampleformat of input can be <= sampleformat float of output
    //////////// framescount : default : -1 (65536)
    //  result : -1 nothing created, otherwise input index in array

   Out1Index := uos_AddIntoDevOut(PlayerIndex1, -1, -1, uos_InputGetSampleRate(PlayerIndex1, In1Index), -1, samformat, -1);
       //// add a output into device with custom parameters
    //////////// playerindex : index of a existing player
    //////////// device ( -1 is default output device )
    //////////// latency  ( -1 is latency suggested ) )
    //////////// samplerate : delault : -1 (44100)
    //////////// channels : delault : -1 (2:stereo) (0: no channels, 1:mono, 2:stereo, ...)
    //////////// sampleformat : -1 default : int16 : (0: float32, 1:int32, 2:int16)
    //////////// framescount : default : -1 (65536)
    //  result : -1 nothing created, otherwise output index in array

     uos_inputsetlevelenable(PlayerIndex1, in1index, 2) ;
    ///// set calculation of level/volume to true (usefull for showvolume procedure)

       uos_inputsetpositionenable(PlayerIndex1, in1index, 1) ;

          uos_inputadddspvolume(PlayerIndex1, in1index, 1, 1);
    ///// dsp volume changer
    ////////// playerindex1 : index of a existing player
    ////////// in1index : inputindex of a existing input
    ////////// volleft : left volume  ( from 0 to 1 => gain > 1 )
    ////////// volright : right volume

       uos_inputsetdspvolume(playerindex1, in1index, trackbar1.position / 100,
      trackbar3.position / 100, true); /// set volume
    ////////// playerindex1 : index of a existing player
    ////////// in1index : inputindex of a existing input
    ////////// volleft : left volume
    ////////// volright : right volume
    ////////// enable : enabled

   plugin1index := uos_addplugin(playerindex1, 'soundtouch', -1, -1);
    ///// add soundtouch plugin with default samplerate(44100) / channels(2 = stereo)


    changeplugset(self); //// change plugin settings

    trackbar2.max := uos_inputlength(playerindex1, in1index);
    ////// length of input in samples

    temptime := uos_inputlengthtime(playerindex1, in1index);
    ////// length of input in time

    decodetime(temptime, ho, mi, se, ms);

    llength.caption := format('%d:%d:%d.%d', [ho, mi, se, ms]);

    trackbar2.position := 0;
    trackbar2.enabled := true;
   button3.enabled := false;
   button4.enabled := false;
    button6.enabled := true;
    button5.enabled := true;

    /////// procedure to execute when stream is terminated
    uos_EndProc(PlayerIndex1, @ClosePlayer1);

     application.processmessages;

    uos_play(playerindex1);  /////// everything is ready, here we are, lets play it...
    timer1.enabled:=true;
  end
  else
    messagedlg(edit4.text + ' does not exist...', mtwarning, [mbyes], 0);

end;

procedure tform1.button6click(sender: tobject);
begin
   timer1.enabled:=false;
  uos_stop(playerindex1);
  closeplayer1;
end;

procedure tform1.button2click(sender: tobject);
begin
  if opendialog1.execute then
    edit4.text := opendialog1.filename;
end;

procedure uos_logo();
var
  xpos, ypos: integer;
  ratio: double;
begin
  xpos := 0;
  ypos := 0;
  ratio := 1;
  bufferbmp := tbitmap.create;
  with form1 do
  begin
    form1.paintbox1.parent.doublebuffered := true;
    paintbox1.height := round(ratio * 116);
    paintbox1.width := round(ratio * 100);
    bufferbmp.height := paintbox1.height;
    bufferbmp.width := paintbox1.width;
    bufferbmp.canvas.antialiasingmode := amon;
    bufferbmp.canvas.pen.width := round(ratio * 6);
    bufferbmp.canvas.brush.color := clmoneygreen;
    bufferbmp.canvas.fillrect(0, 0, paintbox1.width, paintbox1.height);
    bufferbmp.canvas.pen.color := clblack;
    bufferbmp.canvas.brush.color := $70ff70;
    bufferbmp.canvas.ellipse(round(ratio * (22) + xpos),
      round(ratio * (30) + ypos), round(ratio * (72) + xpos),
      round(ratio * (80) + ypos));
    bufferbmp.canvas.brush.color := clmoneygreen;
    bufferbmp.canvas.arc(round(ratio * (34) + xpos), round(ratio * (8) + ypos),
      round(ratio * (58) + xpos), round(ratio * (32) + ypos), round(ratio * (58) + xpos),
      round(ratio * (20) + ypos), round(ratio * (46) + xpos),
      round(ratio * (32) + xpos));
    bufferbmp.canvas.arc(round(ratio * (34) + xpos), round(ratio * (32) + ypos),
      round(ratio * (58) + xpos), round(ratio * (60) + ypos), round(ratio * (34) + xpos),
      round(ratio * (48) + ypos), round(ratio * (46) + xpos),
      round(ratio * (32) + ypos));
    bufferbmp.canvas.arc(round(ratio * (-28) + xpos), round(ratio * (18) + ypos),
      round(ratio * (23) + xpos), round(ratio * (80) + ypos), round(ratio * (20) + xpos),
      round(ratio * (50) + ypos), round(ratio * (3) + xpos), round(ratio * (38) + ypos));
    bufferbmp.canvas.arc(round(ratio * (70) + xpos), round(ratio * (18) + ypos),
      round(ratio * (122) + xpos), round(ratio * (80) + ypos),
      round(ratio * (90 - xpos)),
      round(ratio * (38) + ypos), round(ratio * (72) + xpos),
      round(ratio * (50) + ypos));
    bufferbmp.canvas.font.name := 'arial';
    bufferbmp.canvas.font.size := round(ratio * 10);
    bufferbmp.canvas.textout(round(ratio * (4) + xpos),
      round(ratio * (83) + ypos), 'united openlib');
    bufferbmp.canvas.font.size := round(ratio * 7);
    bufferbmp.canvas.textout(round(ratio * (20) + xpos),
      round(ratio * (101) + ypos), 'of');
    bufferbmp.canvas.font.size := round(ratio * 10);
    bufferbmp.canvas.textout(round(ratio * (32) + xpos),
      round(ratio * (98) + ypos), 'sound');
  end;
end;

procedure tform1.showposition;
var
  temptime: ttime;
  ho, mi, se, ms: word;
begin
  if form1.trackbar2.tag = 0 then
  begin
    form1.trackbar2.position := uos_inputposition(playerindex1, in1index);
    temptime := uos_inputpositiontime(playerindex1, in1index);
    ////// length of input in time
    decodetime(temptime, ho, mi, se, ms);
    form1.lposition.caption := format('%.2d:%.2d:%.2d.%.3d', [ho, mi, se, ms]);
  end;
 end;

procedure tform1.showlevel;
begin
  shapeleft.height := round(uos_inputgetlevelleft(playerindex1, in1index) * 146);
  shaperight.height := round(uos_inputgetlevelright(playerindex1, in1index) * 146);
  shapeleft.top := 354 - shapeleft.height;
  shaperight.top := 354 - shaperight.height;
end;

procedure tform1.loopprocplayer1;
begin
 showposition;
 showlevel ;
end;

procedure tform1.formcreate(sender: tobject);
begin
  form1.height := 193;
  shapeleft.height := 0;
  shaperight.height := 0;
end;

end.
