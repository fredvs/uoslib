import static java.lang.System.out;

public class deviceinfos {
   
   ///////////////// The main application /////////////////////////  
  public static void main(String[] args) 
  {
	   System.loadLibrary("uos");
	   
	  	   
   String pa = System.getProperty("user.dir");
   String os = System.getProperty( "os.name" ).toLowerCase();
   
   /////////// checking what system is used and load library (here only PortAudio)...
   
   if( os.indexOf( "win" ) >= 0 )
		{
       uos.loadlib(pa + "/lib/Windows/32bit/LibPortaudio-32.dll", "", "", "", "", "") ;
       }
          else
	   {
			if( System.getProperty( "os.arch" ).contains( "64" ) )
			{
       uos.loadlib(pa + "/lib/Linux/64bit/LibPortaudio-64.so", "", "", "", "", "") ;
       }
          else
       {
   
       uos.loadlib(pa + "/lib/Linux/32bit/LibPortaudio-32.so", "", "", "", "", "") ; 
     	}
		}		
        
   /////////// OK, libraries are loaded, here we go...
   out.println();  
   out.println("uos and PortAudio are loaded...");
   out.println();  
   
   String id  =  uos.getinfodevicestr();
   
   out.println("Device infos = " + id);
   
   uos.free() ;

   out.println();  
   out.println("uos and PortAudio are unloaded...");
   out.println();  
 
  }
     
} 

 
