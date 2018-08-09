#!/usr/bin/env python2
# encoding: utf-8
import sh

song = artist = status = ''
try:
    song   = sh.gplayctl('song').stdout.strip()
    artist = sh.gplayctl('artist').stdout.strip()
    status = sh.gplayctl('status').stdout.strip()
except:
    pass

# Special case when nothing is playing
if song == artist == 'None':
    song = artist = ''
    status = 'Stopped'

print u'{}%{{T4}}%{{F#b8bb26}}\ue247%{{F-}}%{{T-}} {} - {}'.format(
    '%{u#b8bb26}' if 'Playing' in status else  # Playing: green
    '%{u#fe8019}' if 'Paused' in status else   # Paused: orange
    '%{u#fb4934}',                             # Not running: red
    artist,
    song
).encode('utf-8')
