#!/usr/bin/env python3
# encoding: utf-8
import subprocess as sp

def cnt(cmd):
    p = sp.Popen(cmd, stdout=sp.PIPE, stderr=sp.PIPE)
    stdout = p.communicate()[0].decode().strip()
    return len(stdout.split('\n')) if len(stdout) > 0 else 0


print('{} %{{T4}}%{{F#b16286}}%{{F-}}%{{T-}} {}'.format(
    cnt(['checkupdates']),
    cnt(['yay', '-Qua'])
))
