#!/usr/bin/env python2
# encoding: utf-8
import sh

def cnt(cmd):
    try:
        return int(sh.wc(cmd(_ok_code=xrange(256)), '-l').stdout)
    except:
        return 0

print '{} %{{T5}}%{{F#b16286}}%{{F-}}%{{T-}} {}'.format(
    cnt(sh.checkupdates),
    cnt(sh.cower.bake('-u'))
)

