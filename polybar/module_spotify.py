#!/usr/bin/env python3
import subprocess as sp

TIMEOUT = 2
song = artist = status = ''

try:
    sp.check_output(['pgrep', 'spotify'])
    song = sp.run(['spotifyctl', 'song', '-f'],
                  timeout=TIMEOUT,
                  capture_output=True).stdout.strip().decode()
    artist = sp.run(['spotifyctl', 'artist', '-f'],
                    timeout=TIMEOUT,
                    capture_output=True).stdout.strip().decode()
    status = sp.run(['spotifyctl', 'status'],
                    timeout=TIMEOUT,
                    capture_output=True).stdout.strip().decode()
except (sp.CalledProcessError, sp.TimeoutExpired):
    pass

col = (
    '#b8bb26' if 'Playing' in status else  # Playing: green
    '#fe8019' if 'Paused' in status else   # Paused: orange
    '#fb4934'                              # Not running: red
)

print(f'%{{u{col}}}%{{+u}}%{{T4}}%{{F#b8bb26}}\uf1bc%{{F-}}%{{T-}} {artist} - {song}')
