#file uos-testwin.py
import string 
import os,sys
di = sys.path[0] 
from ctypes import*
dll = cdll.LoadLibrary(di + "/uoslib.dll")
print 'ok'
dll.uos_loadlib(di +'/lib/Windows/32bit/LibPortaudio-32.dll', di + '/lib/Windows/32bit/LibSndFile-32.dll', di +'/lib/Windows/32bit/LibMpg123-32.dll' ,'') 
print 'ok'
dll.uos_createplayer(0)
print 'ok'
dll.uos_addfromfiledef(0, di + '/sound/test.mp3')
print 'ok'
dll.uos_addintodevoutdef(0)
print 'ok'
dll.uos_play(0)
print 'ok'
raw_input('Press any key to exit...')
dll.uos_unloadlib()


