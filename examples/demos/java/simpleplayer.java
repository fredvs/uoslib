import static java.lang.System.out;
import javax.swing.JOptionPane;

public class simpleplayer {
   
   /// the callback	End procedure
   public static void endproc0()
 { 
 out.println("This is Endproc method (executed at end of sound) ...");
}
 	
 ///////////////// The main application /////////////////////////  
  public static void main(String[] args) 
  {
	   System.loadLibrary("uos");

    String pa = System.getProperty("user.dir");
   String os = System.getProperty( "os.name" ).toLowerCase();

   /////////// checking what system is used and load libraries...
   
   if( os.indexOf( "win" ) >= 0 )
		{
       uos.loadlib(pa + "/lib/Windows/32bit/LibPortaudio-32.dll",
	               pa + "/lib/Windows/32bit/LibSndFile-32.dll",
                   pa + "/lib/Windows/32bit/LibMpg123-32.dll", "","","") ;
       }
          else
	   {
			if( System.getProperty( "os.arch" ).contains( "64" ) )
			{
       uos.loadlib(pa + "/lib/Linux/64bit/LibPortaudio-64.so",
	               pa + "/lib/Linux/64bit/LibSndFile-64.so",
                   pa + "/lib/Linux/64bit/LibMpg123-64.so", "","","") ;
       }
          else
       {
   
       uos.loadlib(pa + "/lib/Linux/32bit/LibPortaudio-32.so",
	            pa + "/lib/Linux/32bit/LibSndFile-32.so",
                pa + "/lib/Linux/32bit/LibMpg123-64.so", "","","") ;
      	}
		}		
   
    /////////// OK, libraries are loaded, here we go...
   out.println();   
   out.println("Libraries are loaded...");
   out.println();
 
   uos.createplayer(0) ;
  
   uos.addfromfiledef(0, pa + "/sound/test.ogg");
   
   String ar = uos.inputgettagartist(0,0) ;
   
   out.println("Artist = " + ar);
   
   String ti = uos.inputgettagtitle(0,0) ;
   
   out.println("Title = " + ti);
   
   int sp = uos.inputgetsamplerate(0,0) ;
   
   out.println("Input sample rate = " + sp);
    
   int ch  = uos.inputgetchannels(0,0) ;
   
   out.println("Input channels = " + ch);

   uos.addintodevoutdef(0);
  
   uos.initclass("simpleplayer");
 
   uos.endproc(0, "endproc0");

   uos.play(0);
 
   out.println();  
 
   JOptionPane.showMessageDialog
(null, "Click to quit (or press Enter) ...");
  uos.checksynchro();   
  uos.free() ;
    out.println();
   out.println("uos unloaded...");
 
  }
     
} 
 
