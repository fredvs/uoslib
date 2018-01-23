public class uos {
/////////////////////// the uos library declarations ///////////////	
  public static native int loadlib(String pad, String sfile, String mpfile, String mp4, String faad, String opus);
  
  public static native void createplayer(int pl);

  public static native int addfromfiledef(int pl, String fn);
  public static native int addfromfile(int pl, String fn, int oi, int sf, int fc);
  public static native int addfromdevindef(int pl);
  public static native int addfromdevin(int pl, int de, float la, int sr, int ch, int oi, int sf, int fc );
  public static native int addfromurldef(int pl, String sturl);
  public static native int addfromurl(int pl, String sturl, int outind, int spf, int frc, int auf, int icy);
  public static native int addfromsynth(int pl, float freq, float vol, float vor, int dur, int oui, int saf, int sar, int frc);
  public static native int addfromendlessmuted(int pl, int cha, int frc);
   
  public static native int addintofiledef(int pl, String fn);
  public static native int addintofile(int pl, String fn, int sr, int ch, int sf, int fc);
  public static native int addintodevoutdef(int pl);
  public static native int addintodevout(int pl, int de, float la, int sr, int ch, int sf, int fc );
  
  public static native void inputsetsynth(int pl, int in, float freq, float vol, float vor, int dur, boolean en);
    
  public static native int inputgetsamplerate(int pl, int in);
  public static native int inputgetchannels(int pl, int in);
  public static native String inputgettagtitle(int pl, int in);
  public static native String inputgettagartist(int pl, int in);
  public static native String inputgettagalbum(int pl, int in);
  public static native String inputgettagdate(int pl, int in);
  public static native String inputgettagcomment(int pl, int in);
  public static native String inputgettagtag(int pl, int in);
  
  public static native void inputseek(int pl, int in, int pos);
  public static native void inputseekseconds(int pl, int in, float sec);
  public static native int inputlength(int pl, int in);
  public static native float inputlengthseconds(int pl, int in);
  public static native int inputposition(int pl, int in);
  public static native float inputpositionseconds(int pl, int in);
  public static native float inputgetlevelleft(int pl, int in);
  public static native float inputgetlevelright(int pl, int in);
  
  public static native void inputsetlevelenable(int pl, int in, int en);
  public static native void inputsetarraylevelenable(int pl, int in, int en);
  public static native void inputsetpositionenable(int pl, int in, int en);
         
  public static native int inputadddspvolume(int pl, int in, float vl, float vr);
  public static native int outputadddspvolume(int pl, int in, float vl, float vr);
 
  public static native void inputsetdspvolume(int pl, int in, float vl, float vr, boolean en);
  public static native void outputsetdspvolume(int pl, int in, float vl, float vr, boolean en);
 
  public static native void beginproc(int pl, String pr);
  public static native void endproc(int pl, String pr);
  public static native void loopbeginproc(int pl, String pr);
  public static native void loopendproc(int pl, String pr);
  
  public static native void loopprocin(int pl, int in, String pr);
  public static native void loopprocout(int pl, int ou, String pr);
 
  public static native int inputaddfilter(int pl, int in, int lf, int hf, float ga, int tf, boolean ab, String pr);
  public static native int outputaddfilter(int pl, int ou, int lf, int hf, float ga, int tf, boolean ab, String pr);
  public static native int inputsetfilter(int pl, int in, int lf, int hf, float ga, int tf, boolean ab, boolean en, String pr);
  public static native int outputsetfilter(int pl, int ou, int lf, int hf, float ga, int tf, boolean ab, boolean en, String pr);
  
  public static native int getstatus(int pl);  
  public static native void play(int i);
  public static native void replay(int i);
  public static native void stop(int i);
  public static native void pause(int i);
  
  public static native void unloadlib();
  public static native void free();
  public static native void checksynchro();
  
  public static native void initclass(String cl);
  public static native int getversion();
  public static native String getinfodevicestr();
 
 }
