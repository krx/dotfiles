#!/usr/bin/env python2
# encoding: utf-8
import sh

paused = True
try:
    paused = 'Paused' in sh.spotifyctl('status').stdout
except:
    pass

b_prev = '%{A1:spotifyctl prev:}%{A}'
b_toggle = '%{{A1:spotifyctl toggle:}}{}%{{A}}'.format(
    '' if paused else ''
)
b_next = '%{A1:spotifyctl next:}%{A}'

print b_prev, b_toggle, b_next

# testing ipc method
# import sys
# 'spotifyctl toggle; polybar-msg -p {} hook spotifyctl 1'.format(sys.argv[1]),
# print '%{{B#32302f F#a89984}}{} {} {}'.format(b_prev, b_toggle, b_next)
