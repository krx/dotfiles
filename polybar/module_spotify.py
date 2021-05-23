#!/usr/bin/env python3
import sh

song = artist = status = ''
try:
    sh.pgrep('spotify')
    song   = sh.spotifyctl('song', '-f').stdout.strip().decode()
    artist = sh.spotifyctl('artist', '-f').stdout.strip().decode()
    status = sh.spotifyctl('status').stdout.strip().decode()
except:
    pass

col = (
    '#b8bb26' if 'Playing' in status else  # Playing: green
    '#fe8019' if 'Paused' in status else   # Paused: orange
    '#fb4934'                              # Not running: red
)

print(f'%{{u{col}}}%{{T4}}%{{F#b8bb26}}\uf1bc%{{F-}}%{{T-}} {artist} - {song}')
