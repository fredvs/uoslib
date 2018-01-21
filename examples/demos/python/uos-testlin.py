#file uos-testlin.py
import string 
import os,sys
from ctypes import*
print 'This is a demo of uos with Python...'
di = sys.path[0]
dll = cdll.LoadLibrary(di + "/libuoslib.so")
print 'ok load uos library'
dll.uos_loadlib(di + '/lib/Linux/64bit/LibPortaudio-64.so', di + '/lib/Linux/64bit/LibSndFile-64.so', di + '/lib/Linux/64bit/LibMpg123-64.so' ,'' ,'' ,'') 
print 'ok load all other libraries'
dll.uos_createplayer(0)
print 'ok CreatePlayer'
dll.uos_addfromfiledef(0, di + '/sound/test.ogg')
print 'ok AddFromFile'
dll.uos_addintodevoutdef(0)
print 'ok AddIntoDevOut'
dll.uos_play(0)
print 'ok Play'
raw_input('Press any key to exit...')
dll.uos_unloadlib()

