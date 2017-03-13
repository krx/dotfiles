#!/usr/bin/env python2
import dzcommon as dz
import subprocess as sp
import sys
from collections import OrderedDict
import time

# Build up the dzen menu
menu_options = OrderedDict([
    ('Browser', 'google-chrome-stable'),
    ('Files', 'thunar'),
    ('Wallpaper', 'nitrogen'),
    ('Power', 'oblogout')
])


dzactions = [
    'onstart=unstick,uncollapse',
    'entertitle=uncollapse',
    'leaveslave=collapse',
    'button1=menuprint',
    'button3=',
]

# Launch dzen
menu_w = 100
cmd = map(str, dz.dzen_cmd + [
    '-e', "'{}'".format(';'.join(dzactions)),
    '-y', dz.scr_h - dz.dzen_h,
    '-tw', menu_w,
    '-w', 100,
    '-l', len(menu_options),
    '-m',
    '-bg', dz.col_corner,
    '-fg', dz.col_info,
])

space = '  '
title = 'Menu'

dzen = sp.Popen(cmd, stdin=sp.PIPE, stdout=sp.PIPE)  # Pipe whatever we print to dzen
sys.stdout = dzen.stdin

print '{}{}{}{}'.format(space, dz.icon('menu'), space, title)
print '\n'.join([space + name for name in menu_options])

# Start up stalonetray next to the menu
st_cmd = map(str, [
    'stalonetray',
    '-bg', dz.col_dark2,
    '--icon-size', 20,
    '-geometry', '8x1+{}-0'.format(menu_w + 30)
])
stray = sp.Popen(st_cmd)

# Really hacky fix, start any stalonetray stuff now
sp.call('sleep 2; autorun-stray {}'.format(dz.col_dark2[1:]), shell=True)

while dzen.poll() is None:
    time.sleep(0.1)
    cmd = dzen.stdout.readline().strip()
    if cmd in menu_options:
        sp.Popen(menu_options[cmd], shell=True)
