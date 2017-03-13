#!/usr/bin/env python2
import dzcommon as dz
import subprocess as sp
import os
import sys
import time

# icons
space = ' '
sptfy = os.path.join(dz.DIR, 'spotify.sh')

i_msc = dz.icon('music')
i_vol = dz.icon('vol')
i_ply = dz.click(1, sptfy + ' toggle', dz.icon('play'))
i_pau = dz.click(1, sptfy + ' toggle', dz.icon('pause'))
i_nxt = dz.click(1, sptfy + ' next', dz.icon('fwd'))
i_prv = dz.click(1, sptfy + ' prev', dz.icon('rwd'))
i_mr2 = dz.icon('mr2')


def get_info():
    data = {
        'status': sp.check_output([sptfy, 'status']).strip(),
        'artist': sp.check_output([sptfy, 'artist']).strip(),
        'song': sp.check_output([sptfy, 'song']).strip(),
        'volume': sp.check_output(['pamixer', '--get-volume']).strip(),
        'mute': True,
    }

    try:
        sp.check_output(['pamixer', '--get-mute'])
    except:
        data['mute'] = False

    return data


def vol_bar(val, mute):
    if mute:
        val = 0
    gdbar.stdin.write('{}\n'.format(val))
    bar = gdbar.stdout.readline().strip()
    return dz.click(4, 'volctl -i 1', dz.click(5, 'volctl -d 1', bar))


# Start gdbar
gdbar_cmd = map(str, [
    'gdbar',
    '-bg', dz.col_dark4,
    '-fg', dz.col_info,
    '-h', 3,
    '-w', 80
])
gdbar = sp.Popen(gdbar_cmd, stdin=sp.PIPE, stdout=sp.PIPE)

# Start dzen
dz_w = 1000
dzen_cmd = map(str, dz.dzen_cmd + [
    '-dock',
    '-ta', 'r',
    '-w', dz_w,
    '-x', dz.scr_w - dz_w,
    '-y', dz.scr_h - dz.dzen_h
])
dzen = sp.Popen(dzen_cmd, stdin=sp.PIPE)
sys.stdout = dzen.stdin  # Print right into dzen

while True:
    try:
        # Grap the next set of info
        data = get_info()

        # Gather hardware related info
        song_info = dz.col(dz.col_info, dz.col_corner) + space + space.join([
            i_msc,
            data['artist'],
            '-',
            data['song']
        ]) + space

        # Player controls
        player = dz.col(dz.col_dark2, dz.col_info) + space + space.join([
            i_prv,
            i_ply if data['status'] != 'Playing' else i_pau,
            i_nxt
        ])

        # Gather date/time info
        vol_info = dz.col(dz.col_corner, dz.col_info) + space.join([
            i_vol, vol_bar(data['volume'], data['mute'])
        ]) + space

        # Put it all together and send it to dzen
        dzen_str = ''.join([
            dz.col(dz.col_blank, dz.col_info), i_mr2,
            song_info,
            dz.col(dz.col_info, dz.col_dark2), i_mr2,
            player,
            dz.col(dz.col_dark2, dz.col_corner), i_mr2,
            vol_info,
            ''
        ])

        print dzen_str
        time.sleep(1)
    except:
        pass
