#!/usr/bin/env python2
import sh

song = artist = status = ''
try:
    song   = sh.spotifyctl('song').stdout.strip()
    artist = sh.spotifyctl('artist').stdout.strip()
    status = sh.spotifyctl('status').stdout.strip()
except:
    pass

print u'{}%{{T4}}%{{F#b8bb26}}\uf1bc%{{F-}}%{{T-}} {} - {}'.format(
    '%{u#b8bb26}' if 'Playing' in status else  # Playing: green
    '%{u#fe8019}' if 'Paused' in status else   # Paused: orange
    '%{u#fb4934}',                             # Not running: red
    artist,
    song
).encode('utf-8')
