#!/usr/bin/env python
import dzcommon as dz
import subprocess as sp
import os
import re
import sys
from yaml import safe_load

# icons
i_cpu = dz.icon('cpu')
i_mem = dz.icon('mem')
i_clk = dz.icon('clock')
i_upt = dz.icon('uptime')
i_mt2 = dz.icon('mt2')
i_mr2 = dz.icon('mr2')
i_bat = dz.icon('bat')

space = ' '


def read_conky(f):
    lines = []
    while True:
        l = f.readline()
        if 'EOF' in l:
            break
        lines.append(l)
    return safe_load(''.join(lines))


def get_bat(status):
    val = 100 if 'charged' in status else int(re.search(r'(\d+)%', status).group(1))

    fg = ''
    if 'discharging' not in status:
        # We're charging/charged now
        fg = dz.fg(dz.col_neutral_green)
    elif val <= 50:
        # Discharging, medium battery
        fg = dz.fg(dz.col_faded_yellow)
    elif val <= 25:
        # Discharging, low battery
        fg = dz.fg(dz.col_faded_red)
    # Note the original fg is kept otherwise

    return fg + i_bat + dz.fg(dz.col_corner) + ' {}%'.format(val)


# Start conky
cfg = os.path.join(dz.DIR, 'dz_comp_info.conkyrc')
conky = sp.Popen(['conky', '-c', cfg], stdout=sp.PIPE)

# Start dzen
dz_w = 1000
dzen_cmd = map(str, dz.dzen_cmd + [
    '-dock',
    '-ta', 'r',
    '-w', dz_w,
    '-x', dz.scr_w - dz_w
])
print ' '.join(dzen_cmd)
dzen = sp.Popen(dzen_cmd, stdin=sp.PIPE)
sys.stdout = dzen.stdin  # Print right into dzen

while True:
    try:
        # Grap the next set of info
        data = read_conky(conky.stdout)

        # Gather hardware related info
        comp_info = dz.col(dz.col_info, dz.col_corner) + space.join([
            # CPU info
            i_cpu, '|'.join('{}%'.format(v).rjust(3, ' ') for v in data['cpus']),

            # RAM
            space, i_mem, data['mem'],

            # Current uptime
            space, i_upt, data['uptime'],

            # Battery
            space, get_bat(data['battery'])
        ]) + space

        # Gather date/time info
        time_info = dz.col(dz.col_corner, dz.col_info) + space.join([
            i_clk, data['clock']
        ]) + space

        # Put it all together and send it to dzen
        dzen_str = ''.join([
            dz.col(dz.col_blank, dz.col_info), i_mt2,
            comp_info,
            dz.col(dz.col_info, dz.col_corner), i_mt2,
            time_info,
            ''
        ])

        print dzen_str
    except:
        print dz.fg(dz.col_corner) + 'Initializing...'
