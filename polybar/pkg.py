#!/usr/bin/env python3
# encoding: utf-8
import subprocess as sp


def cnt(cmd):
    stdout = sp.run(cmd, capture_output=True).stdout.decode().strip()
    return len(stdout.split('\n')) if len(stdout) > 0 else 0


print('{} %{{T4}}%{{F#b16286}}%{{F-}}%{{T-}} {}'.format(
    cnt(['checkupdates']),
    cnt(['yay', '-Qua'])
))
